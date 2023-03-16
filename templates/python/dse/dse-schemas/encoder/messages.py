# Copyright 2023 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0

# pylint: disable=wrong-import-position
# pylint: disable=wrong-import-order
# pylint: disable=import-error
# pylint: disable=no-member
# pylint: disable=no-name-in-module

from __future__ import annotations
from typing import Any
from dataclasses import dataclass, field
from dse.schemas.encoder.flatbuffer import FlatbufferTable


import dse.schemas.fbs.channel.SignalLookup
import dse.schemas.fbs.channel.SignalIndex
import dse.schemas.fbs.channel.SignalWrite
import dse.schemas.fbs.channel.SignalRead
import dse.schemas.fbs.channel.SignalValue

import dse.schemas.fbs.channel.ModelRegister
import dse.schemas.fbs.channel.ModelReady
import dse.schemas.fbs.channel.ModelStart
import dse.schemas.fbs.channel.ModelExit

import dse.schemas.fbs.channel.MessageType
import dse.schemas.fbs.channel.ChannelMessage


@dataclass
class SignalLookup(FlatbufferTable):
    signal_uid: int = field(default=None, metadata={'fbs_type': 'uint'})
    name: str = field(default=None, metadata={'fbs_type': 'string'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.SignalLookup, init=False, repr=False, compare=False)


@dataclass
class SignalIndex(FlatbufferTable):
    indexes: [SignalLookup] = field(default_factory=list)
    _fbs_table: type = field(default=dse.schemas.fbs.channel.SignalIndex, init=False, repr=False, compare=False)


@dataclass
class SignalWrite(FlatbufferTable):
    data: [int] = field(default_factory=list, metadata={'fbs_type': 'ubyte'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.SignalWrite, init=False, repr=False, compare=False)


@dataclass
class SignalRead(FlatbufferTable):
    data: [int] = field(default_factory=list, metadata={'fbs_type': 'ubyte'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.SignalRead, init=False, repr=False, compare=False)


@dataclass
class SignalValue(FlatbufferTable):
    data: [int] = field(default_factory=list, metadata={'fbs_type': 'ubyte'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.SignalValue, init=False, repr=False, compare=False)


@dataclass
class ModelRegister(FlatbufferTable):
    step_size: float = field(default=None, metadata={'fbs_type': 'double'})
    capability: ModelCapability = field(default=None, metadata={'fbs_table': 'ModelCapability'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.ModelRegister, init=False, repr=False, compare=False)


@dataclass
class ModelReady(FlatbufferTable):
    model_time: float = field(default=None, metadata={'fbs_type': 'double'})
    signal_write: SignalWrite = field(default=None, metadata={'fbs_table': 'SignalWrite'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.ModelReady, init=False, repr=False, compare=False)


@dataclass
class ModelStart(FlatbufferTable):
    model_time: float = field(default=None, metadata={'fbs_type': 'double'})
    stop_time: float = field(default=None, metadata={'fbs_type': 'double'})
    signal_value: SignalValue = field(default=None, metadata={'fbs_table': 'SignalValue'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.ModelStart, init=False, repr=False, compare=False)


@dataclass
class ModelExit(FlatbufferTable):
    _fbs_table: type = field(default=dse.schemas.fbs.channel.ModelExit, init=False, repr=False, compare=False)


@dataclass
class ChannelMessage(FlatbufferTable):
    model_uid: int = field(default=None, metadata={'fbs_type': 'int'})
    message: Any = field(default=None, metadata={'fbs_union': dse.schemas.fbs.channel.MessageType.MessageType})
    token: int = field(default=None, metadata={'fbs_type': 'int'})
    rc: int = field(default=None, metadata={'fbs_type': 'int'})     # pylint: disable=invalid-name
    response: str = field(default=None, metadata={'fbs_type': 'string'})
    part_of: int = field(default=None, metadata={'fbs_type': 'int'})
    _fbs_table: type = field(default=dse.schemas.fbs.channel.ChannelMessage, init=False, repr=False, compare=False)
