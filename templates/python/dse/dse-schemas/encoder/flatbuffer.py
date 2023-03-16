# Copyright 2023 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0

"""FlatBuffer Encoder.
"""
import os
import logging
import importlib
import inspect
from typing import Any
from dataclasses import dataclass, field
import flatbuffers


logger = logging.getLogger(os.path.basename(__file__))


def get_flatbuffer_length(buffer: bytearray):
    return flatbuffers.util.GetSizePrefix(buffer, 0) + 4


def encode_flatbuffer(root_table: Any, prefix: str, size_hint: int = 1024):
    builder = flatbuffers.Builder(size_hint)
    root_object = root_table.to_flatbuffer(builder)
    # TODO get prefix from FBS definition, rather than as parameter.
    builder.FinishSizePrefixed(root_object, file_identifier=prefix.encode())
    buffer = bytes(builder.Output())
    logger.debug("FlatBuffer encoded size is : %s", len(buffer))
    logger.debug("  buffer:\n%s", buffer)
    return buffer


def decode_flatbuffer(buffer: bytearray, fbs_class: str, dc_module: [str]):
    dc_module = dc_module if isinstance(dc_module, list) else [dc_module]

    length = flatbuffers.util.GetSizePrefix(buffer, 0)
    _, offset = flatbuffers.util.RemoveSizePrefix(buffer, 0)
    fbs_namespace = '.'.join(fbs_class.split('.')[0:-1])
    fbs_class_name = fbs_class.split('.')[-1]
    logger.debug("buffer  :  %s", buffer[0:32])
    logger.debug("    length       : %s", length)
    logger.debug("    offset       : %s", offset)

    root_class = getattr(importlib.import_module('.'+fbs_class_name, fbs_namespace), fbs_class_name)
    try:
        identifier_check_func = getattr(root_class, fbs_class_name+'BufferHasIdentifier')
    except AttributeError:
        identifier_check_func = None
    if identifier_check_func and not identifier_check_func(buffer, 0, size_prefixed=True):
        logger.warning("Wrong message identifier : %s", flatbuffers.util.GetBufferIdentifier(buffer, 0, size_prefixed=True))
        raise Exception("Wrong message identifier")

    # Get the offset to the root table
    offset += flatbuffers.encode.Get(flatbuffers.packer.uoffset, buffer, offset)
    logger.debug("    table_offset : %s", offset)

    # By convention the DataClass and FBS Class have the same name.
    data_class = None
    for _ in dc_module:
        try:
            data_class = getattr(importlib.import_module(_), fbs_class_name)
            break
        except AttributeError:
            continue
    dc = data_class()
    dc.from_flatbuffer(buffer, offset, dc_module)

    return dc


class UnknownFbsTypeError(Exception):
    def __init__(self, fbs_type: str, message: str):
        super().__init__(message)
        self.fbs_type = fbs_type
        self.message = message


class MissingFbsTypeError(Exception):
    def __init__(self, message: str):
        super().__init__(message)
        self.message = message


@dataclass
class FlatbufferTable():
    # pylint: disable=too-many-locals
    _fbs_table: type = field(default=None, init=False, repr=False, compare=False)

    def get_dataclass(self, table_class_name: str, dataclass_modules: [str] = None):
        if dataclass_modules is None:
            return getattr(importlib.import_module(self.__module__), table_class_name)
        for _ in dataclass_modules:
            try:
                return getattr(importlib.import_module(_), table_class_name)
            except AttributeError:
                continue
        raise Exception("Dataclass not found in dataclass_modules!")

    def from_flatbuffer(self, buffer, offset, dc_module: [str] = None):
        table_class_name = self._fbs_table.__name__.split('.')[-1]
        table_class = getattr(self._fbs_table, table_class_name)
        table = table_class()
        table.Init(buffer, offset)
        self.from_tableobject(table, dc_module)

    def from_tableobject(self, table, dc_module: [str] = None):
        # pylint: disable=too-many-branches
        # pylint: disable=too-many-statements
        class_map = {n: type(v) for n, v in self.__dict__.items()}
        logger.debug("Decoding Table : %s", self._fbs_table.__name__)

        def call_fbs_func(fbs_table, field_name: str, index: int = None):
            field_name = ''.join(field_name.title().split('_')) if field_name else ''
            func = f'{field_name}'
            if index is not None:
                value = getattr(fbs_table, func)(index)
            else:
                value = getattr(fbs_table, func)()
            logger.debug("  <= %s = %s (%s)", func, value, type(value))
            return value

        def get_union_table_class(union_class):
            index = call_fbs_func(table, n+'_type')
            if index == 0:
                return None
            u_attribs = inspect.getmembers(union_class(), lambda a: not inspect.isroutine(a) )
            u_class_map = {dx[1]: dx[0] for dx in u_attribs if not dx[0].startswith('__')}
            return u_class_map[index]

        for n in self.__dict__:
            n_table_class = None     # If this gets set then 'n' is a table.
            vector_length = None    # If this gets set then 'n' is a vector.
            field_type = None       # If this is set, then 'n' might need a type conversion.

            _dc_field = self.__dataclass_fields__[n]    # pylint: disable=no-member

            # Check if a vector ...
            if class_map[n] is list:
                vector_length = call_fbs_func(table, n+'_length')
                if vector_length == 0:
                    continue
            # Check if a union ...
            if 'fbs_union' in _dc_field.metadata:
                n_table_class = get_union_table_class(_dc_field.metadata['fbs_union'])
            # Check if a table ...
            if 'fbs_table' in _dc_field.metadata:
                n_table_class = _dc_field.metadata['fbs_table']
            # And the provided type ...
            if 'fbs_type' in _dc_field.metadata:
                field_type = _dc_field.metadata['fbs_type']

            # Decode the value.
            if n_table_class:
                # By convention the DataClass and FBS Class have the same name.
                if vector_length:
                    for i in range(vector_length):
                        n_table = call_fbs_func(table, n, i)
                        n_data_class = self.get_dataclass(n_table_class, dc_module)
                        dc = n_data_class()
                        dc.from_flatbuffer(n_table.Bytes, n_table.Pos, dc_module)
                        self.__getattribute__(n).append(dc)
                else:
                    n_table = call_fbs_func(table, n)
                    if n_table:
                        n_data_class = self.get_dataclass(n_table_class, dc_module)
                        dc = n_data_class()
                        if isinstance(n_table, flatbuffers.table.Table):
                            dc.from_flatbuffer(n_table.Bytes, n_table.Pos, dc_module)
                        else:
                            dc.from_tableobject(n_table, dc_module)
                        self.__setattr__(n, dc)
            else:
                # otherwise, a scalar
                if vector_length:
                    try:
                        _vector = call_fbs_func(table, n+'_As_Numpy')
                        try:
                            _vector = _vector.tolist()
                            if field_type == 'string':
                                _vector = [ x.decode() if x else x for x in _vector ]
                        except Exception:
                            pass
                    except Exception:
                        _vector = []
                        for i in range(vector_length):
                            _v = call_fbs_func(table, n, i)
                            if _v and field_type == 'string':
                                _v = _v.decode()
                            elif _v.__class__.__module__ != 'builtins':
                                # TODO need a list of modules to try.
                                n_table_class = _v.__class__.__name__
                                n_data_class = self.get_dataclass(n_table_class, dc_module)
                                dc = n_data_class()
                                dc.from_tableobject(_v)
                                _v = dc
                            else:
                                pass
                            _vector.append(_v)
                    self.__setattr__(n, _vector)
                else:
                    _v = call_fbs_func(table, n)
                    if _v and field_type == 'string':
                        _v = _v.decode()
                    self.__setattr__(n, _v)

        logger.debug("End of Table : %s", self._fbs_table.__name__)

    def to_flatbuffer(self, builder):
        # pylint: disable=too-many-branches
        # pylint: disable=too-many-statements
        # Build a class and (generated) object map.
        class_map = {}
        for n, v in self.__dict__.items():
            if v is None:
                class_map[n] = type(None)
                continue    # Will not be encoded, so don't take any type hints.
            if isinstance(v, list):
                class_map[n] = list
                continue
            # Use the fbs_type hint first.
            field_type = self.__dataclass_fields__[n].metadata.get('fbs_type')  # pylint: disable=no-member
            if field_type == 'string':
                class_map[n] = str
            else:
                # Fallback to the type of the provided data.
                class_map[n] = type(v)
        object_map = dict()
        union_map = dict()
        table_name = self._fbs_table.__name__.split('.')[-1]

        def call_fbs_func(builder, op: Any, field_name: str = None, value: Any = None):
            field_name = ''.join(field_name.title().split('_')) if field_name else ''
            if isinstance(op, list):
                func = f'{table_name}{op[0]}{field_name}{op[1]}'
            else:
                func = f'{table_name}{op}{field_name}'
            logger.debug("  => %s%s", func, ' (='+str(value)+')' if value else '')
            if value is not None:
                return getattr(self._fbs_table, func)(builder, value)
            return getattr(self._fbs_table, func)(builder)

        def call_fbs_prepend_func(builder, dataclass_field, value: Any = None):
            # pylint: disable=unused-variable
            try:
                fbs_type = dataclass_field.metadata['fbs_type']
            except Exception:
                raise MissingFbsTypeError("field.metadata['fbs_type'] required for vectors of scalar types") from None
            prepend_call_table = {
                'bool': builder.PrependBool,
                'byte': builder.PrependInt8,
                'short': builder.PrependInt16,
                'int': builder.PrependInt32,
                'long': builder.PrependInt64,
                'ubyte': builder.PrependUint8,
                'ushort': builder.PrependUint16,
                'uint': builder.PrependUint32,
                'ulong': builder.PrependUint64,
                'float': builder.PrependFloat32,
                'double': builder.PrependFloat64,
            }
            try:
                prepend_call_table[fbs_type](value)
            except KeyError:
                raise UnknownFbsTypeError(fbs_type, "FBS Type not found in prepend_call_table") from None
            except Exception as e:
                raise e

        def call_fbs_place_func(builder, dataclass_field, value: Any = None):
            # Place is faster than Prepend (which does alignment/allocation checks.)
            #   def PrependFloat32(self, x):
            #       self.Prepend(N.Float32Flags, x)
            #   def def Prepend(self, flags, off):
            #       self.Prep(flags.bytewidth, 0)
            #       self.Place(off, flags)              <=== call directly.
            # Only use for Vectors, where start vector has been called to do
            # the allocation and alignment checks.
            try:
                fbs_type = dataclass_field.metadata['fbs_type']
            except Exception:
                raise MissingFbsTypeError("field.metadata['fbs_type'] required for vectors of scalar types") from None
            place_type_table = {
                'bool': flatbuffers.number_types.BoolFlags,
                'byte': flatbuffers.number_types.Int8Flags,
                'short': flatbuffers.number_types.Int16Flags,
                'int': flatbuffers.number_types.Int32Flags,
                'long': flatbuffers.number_types.Int64Flags,
                'ubyte': flatbuffers.number_types.Uint8Flags,
                'ushort': flatbuffers.number_types.Uint16Flags,
                'uint': flatbuffers.number_types.Uint32Flags,
                'ulong': flatbuffers.number_types.Uint64Flags,
                'float': flatbuffers.number_types.Float32Flags,
                'double': flatbuffers.number_types.Float64Flags,
            }
            try:
                builder.Place(value, place_type_table[fbs_type])
            except KeyError:
                raise UnknownFbsTypeError(fbs_type, "FBS Type not found in place_type_table") from None
            except Exception as e:
                raise e

        # Encode strings
        for n, t in class_map.items():
            if t is str:
                object_map[n] = builder.CreateString(self.__dict__[n])
        # Encode nested tables ...
        for n, t in class_map.items():
            if not callable(getattr(t, 'to_flatbuffer', None)):
                continue
            object_map[n] = self.__dict__[n].to_flatbuffer(builder)
            # Check if table is in a union ...
            _dc_field = self.__dataclass_fields__[n]    # pylint: disable=no-member
            if 'fbs_union' in _dc_field.metadata:
                union_class = _dc_field.metadata['fbs_union']
                union_type = self.__dict__[n].__class__.__name__
                union_map[n] = union_class().__getattribute__(union_type)
        # Encode vectors
        for n, t in class_map.items():
            if t is list and len(self.__dict__[n]) > 0:
                _dc_field = self.__dataclass_fields__[n]    # pylint: disable=no-member
                if 'fbs_type' in _dc_field.metadata:
                    if _dc_field.metadata['fbs_type'] == 'string':
                        # Vector of strings.
                        object_list = []
                        for _ in reversed(self.__dict__[n]):
                            object_list.append(builder.CreateString(_))
                        object_count = len(object_list)
                        call_fbs_func(builder, ['Start', 'Vector'], n, object_count)
                        for _ in object_list:
                            builder.PrependUOffsetTRelative(_)  # TODO is this right call for string?
                        object_map[n] = builder.EndVector()
                    else:
                        # Vector of Scalar types.
                        vector_count = len(self.__dict__[n])
                        call_fbs_func(builder, ['Start', 'Vector'], n, vector_count)
                        for _ in reversed(self.__dict__[n]):
                            call_fbs_place_func(builder, _dc_field, _)
                        object_map[n] = builder.EndVector()
                # TODO support for structs is likely here.
                # elif 'fbs_struct' in _dc_field.metadata ... call_fbs_func(builder, 'create', n, _v, map={})
                else:
                    # Vector of Tables.
                    object_list = []
                    for _ in reversed(self.__dict__[n]):
                        object_list.append(_.to_flatbuffer(builder))
                    object_count = len(object_list)
                    call_fbs_func(builder, ['Start', 'Vector'], n, object_count)
                    for _ in object_list:
                        builder.PrependUOffsetTRelative(_)
                    object_map[n] = builder.EndVector()
        # Encode the table
        logger.debug("Encoding Table :  %s", table_name)
        call_fbs_func(builder, 'Start')
        for n, v in self.__dict__.items():
            if not v:
                continue
            _v = object_map[n] if n in object_map else v
            # TODO support for structs is likely here.
            # if 'fbs_struct' in _dc_field.metadata ... call_fbs_func(builder, 'create', n, _v, map={})
            call_fbs_func(builder, 'Add', n, _v)
            if n in union_map:
                call_fbs_func(builder, ['Add', 'Type'], n, union_map[n])
        return call_fbs_func(builder, 'End')
