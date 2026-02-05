-- Wireshark Dissector for SimBus FlatBuffers Schema (Streaming Format)
-- Copyright 2026 Robert Bosch GmbH
-- SPDX-License-Identifier: Apache-2.0

-- Protocol definition
local simbus_proto = Proto("SimBus", "SimBus Protocol")

-- Protocol fields
local fields = simbus_proto.fields

-- Stream fields
fields.packet_length = ProtoField.uint32("simbus.packet_length", "Packet Length", base.DEC)
fields.packet_number = ProtoField.uint32("simbus.packet_number", "Packet Number", base.DEC)

-- Root fields
fields.file_identifier = ProtoField.string("simbus.file_identifier", "File Identifier")
fields.root_offset = ProtoField.uint32("simbus.root_offset", "Root Offset", base.DEC)

-- NotifyMessage fields
fields.model_time = ProtoField.double("simbus.model_time", "Model Time")
fields.notify_time = ProtoField.double("simbus.notify_time", "Notify Time")
fields.schedule_time = ProtoField.double("simbus.schedule_time", "Schedule Time")
fields.bench_notify_time_ns = ProtoField.uint64("simbus.bench_notify_time_ns", "Bench Notify Time (ns)")
fields.bench_model_time_ns = ProtoField.uint64("simbus.bench_model_time_ns", "Bench Model Time (ns)")
fields.token = ProtoField.int32("simbus.token", "Token")
fields.rc = ProtoField.int32("simbus.rc", "Return Code")
fields.response = ProtoField.string("simbus.response", "Response")
fields.channel_name = ProtoField.string("simbus.channel_name", "Channel Name")

-- ModelRegister fields
fields.step_size = ProtoField.double("simbus.model_register.step_size", "Step Size")
fields.model_uid_single = ProtoField.uint32("simbus.model_register.model_uid", "Model UID")
fields.notify_uid = ProtoField.uint32("simbus.model_register.notify_uid", "Notify UID")

-- SignalIndex fields
fields.signal_lookup_count = ProtoField.uint32("simbus.signal_index.count", "Signal Count")
fields.signal_lookup_uid = ProtoField.uint32("simbus.signal_lookup.uid", "Signal UID")
fields.signal_lookup_name = ProtoField.string("simbus.signal_lookup.name", "Signal Name")

-- SignalVector fields
fields.signal_vector_name = ProtoField.string("simbus.signal_vector.name", "Signal Vector Name")
fields.signal_vector_model_uid = ProtoField.uint32("simbus.signal_vector.model_uid", "Model UID")
fields.signal_count = ProtoField.uint32("simbus.signal_vector.signal_count", "Signal Count")
fields.binary_signal_count = ProtoField.uint32("simbus.signal_vector.binary_signal_count", "Binary Signal Count")

-- Signal fields
fields.signal_uid = ProtoField.uint32("simbus.signal.uid", "Signal UID")
fields.signal_value = ProtoField.double("simbus.signal.value", "Signal Value")

-- BinarySignal fields
fields.binary_signal_uid = ProtoField.uint32("simbus.binary_signal.uid", "Binary Signal UID")
fields.binary_signal_data_len = ProtoField.uint32("simbus.binary_signal.data_len", "Data Length")
fields.binary_signal_data = ProtoField.bytes("simbus.binary_signal.data", "Data")

-- Model UID array
fields.model_uid_array = ProtoField.uint32("simbus.model_uid", "Model UID")

-- Error/Warning fields
fields.error = ProtoField.string("simbus.error", "Parse Error")

-- Helper functions for FlatBuffers parsing with bounds checking
local function safe_read_uint32_le(buffer, offset)
    if offset + 4 > buffer:len() then
        return nil, "Buffer too small for uint32 at offset " .. offset
    end
    return buffer(offset, 4):le_uint(), nil
end

local function safe_read_int32_le(buffer, offset)
    if offset + 4 > buffer:len() then
        return nil, "Buffer too small for int32 at offset " .. offset
    end
    return buffer(offset, 4):le_int(), nil
end

local function safe_read_uint64_le(buffer, offset)
    if offset + 8 > buffer:len() then
        return nil, "Buffer too small for uint64 at offset " .. offset
    end
    return buffer(offset, 8):le_uint64(), nil
end

local function safe_read_double_le(buffer, offset)
    if offset + 8 > buffer:len() then
        return nil, "Buffer too small for double at offset " .. offset
    end
    return buffer(offset, 8):le_float(), nil
end

local function safe_read_uint16_le(buffer, offset)
    if offset + 2 > buffer:len() then
        return nil, "Buffer too small for uint16 at offset " .. offset
    end
    return buffer(offset, 2):le_uint(), nil
end

local function safe_read_string(buffer, offset)
    local str_offset_rel, err = safe_read_int32_le(buffer, offset)
    if not str_offset_rel then
        return nil, err
    end

    local str_offset = offset + str_offset_rel
    if str_offset < 0 or str_offset >= buffer:len() then
        return nil, "String offset out of bounds"
    end

    local str_len, err = safe_read_uint32_le(buffer, str_offset)
    if not str_len then
        return nil, err
    end

    if str_len > 10000 then
        return nil, "String too long: " .. str_len
    end

    if str_offset + 4 + str_len > buffer:len() then
        return nil, "String data out of bounds"
    end

    if str_len > 0 then
        return buffer(str_offset + 4, str_len):string(), nil
    else
        return "", nil
    end
end

local function safe_read_vector_len(buffer, offset)
    local vec_offset_rel, err = safe_read_int32_le(buffer, offset)
    if not vec_offset_rel then
        return nil, nil, err
    end

    local vec_offset = offset + vec_offset_rel
    if vec_offset < 0 or vec_offset >= buffer:len() then
        return nil, nil, "Vector offset out of bounds"
    end

    local vec_len, err = safe_read_uint32_le(buffer, vec_offset)
    if not vec_len then
        return nil, nil, err
    end

    return vec_len, vec_offset + 4, nil
end

local function get_table_field_offset(buffer, table_offset, vtable_field_id)
    if table_offset < 0 or table_offset + 4 > buffer:len() then
        return nil, "Table offset out of bounds"
    end

    local vtable_offset_rel, err = safe_read_int32_le(buffer, table_offset)
    if not vtable_offset_rel then
        return nil, err
    end

    local vtable_offset = table_offset - vtable_offset_rel
    if vtable_offset < 0 or vtable_offset + 2 > buffer:len() then
        return nil, "VTable offset out of bounds"
    end

    local vtable_size, err = safe_read_uint16_le(buffer, vtable_offset)
    if not vtable_size then
        return nil, err
    end

    local field_vtable_pos = vtable_offset + 4 + (vtable_field_id * 2)

    if field_vtable_pos + 2 > vtable_offset + vtable_size then
        return nil, nil
    end

    if field_vtable_pos + 2 > buffer:len() then
        return nil, "VTable field offset out of bounds"
    end

    local field_offset_in_table, err = safe_read_uint16_le(buffer, field_vtable_pos)
    if not field_offset_in_table then
        return nil, err
    end

    if field_offset_in_table == 0 then
        return nil, nil
    end

    local field_offset = table_offset + field_offset_in_table
    if field_offset >= buffer:len() then
        return nil, "Field data offset out of bounds"
    end

    return field_offset, nil
end

local function parse_signal(buffer, offset, tree)
    if offset + 12 > buffer:len() then
        return offset, "Signal data out of bounds"
    end

    local signal_tree = tree:add(simbus_proto, buffer(offset, 12), "Signal")

    local uid, err = safe_read_uint32_le(buffer, offset)
    if not uid then
        signal_tree:add(fields.error, err)
        return offset + 12, err
    end

    local value, err = safe_read_double_le(buffer, offset + 4)
    if not value then
        signal_tree:add(fields.error, err)
        return offset + 12, err
    end

    signal_tree:add(fields.signal_uid, buffer(offset, 4), uid)
    signal_tree:add(fields.signal_value, buffer(offset + 4, 8), value)

    return offset + 12, nil
end

local function parse_binary_signal(buffer, offset, tree)
    local binary_signal_tree = tree:add(simbus_proto, buffer(offset, 0), "Binary Signal")

    local uid_offset, err = get_table_field_offset(buffer, offset, 0)
    if err then
        binary_signal_tree:add(fields.error, err)
        return err
    end

    if uid_offset then
        local uid, err = safe_read_uint32_le(buffer, uid_offset)
        if uid then
            binary_signal_tree:add(fields.binary_signal_uid, buffer(uid_offset, 4), uid)
        else
            binary_signal_tree:add(fields.error, err)
        end
    end

    local data_offset, err = get_table_field_offset(buffer, offset, 1)
    if err then
        binary_signal_tree:add(fields.error, err)
        return err
    end

    if data_offset then
        local data_len, data_start, err = safe_read_vector_len(buffer, data_offset)
        if not data_len then
            binary_signal_tree:add(fields.error, err)
            return err
        end

        binary_signal_tree:add(fields.binary_signal_data_len, data_len)
        if data_len > 0 and data_start + data_len <= buffer:len() then
            binary_signal_tree:add(fields.binary_signal_data, buffer(data_start, data_len))
        end
    end

    return nil
end

local function parse_signal_vector(buffer, offset, tree)
    local sv_tree = tree:add(simbus_proto, buffer(offset, 0), "Signal Vector")

    local name_offset, err = get_table_field_offset(buffer, offset, 0)
    if err then
        sv_tree:add(fields.error, err)
        return err
    end

    if name_offset then
        local name, err = safe_read_string(buffer, name_offset)
        if name then
            sv_tree:add(fields.signal_vector_name, name)
            sv_tree:append_text(": " .. name)
        else
            sv_tree:add(fields.error, err)
        end
    end

    local model_uid_offset, err = get_table_field_offset(buffer, offset, 1)
    if err then
        sv_tree:add(fields.error, err)
        return err
    end

    if model_uid_offset then
        local model_uid, err = safe_read_uint32_le(buffer, model_uid_offset)
        if model_uid then
            sv_tree:add(fields.signal_vector_model_uid, buffer(model_uid_offset, 4), model_uid)
        else
            sv_tree:add(fields.error, err)
        end
    end

    local signal_offset, err = get_table_field_offset(buffer, offset, 3)
    if err then
        sv_tree:add(fields.error, err)
        return err
    end

    if signal_offset then
        local signal_count, signal_data_start, err = safe_read_vector_len(buffer, signal_offset)
        if not signal_count then
            sv_tree:add(fields.error, err)
            return err
        end

        sv_tree:add(fields.signal_count, signal_count)

        if signal_count > 0 and signal_data_start + (signal_count * 12) <= buffer:len() then
            local sig_tree = sv_tree:add(simbus_proto, buffer(signal_data_start, signal_count * 12),
                                          string.format("Signals (%d)", signal_count))

            for i = 0, signal_count - 1 do
                local next_offset, err = parse_signal(buffer, signal_data_start + (i * 12), sig_tree)
                if err then
                    sig_tree:add(fields.error, "Signal " .. i .. ": " .. err)
                end
            end
        end
    end

    local binary_signal_offset, err = get_table_field_offset(buffer, offset, 4)
    if err then
        sv_tree:add(fields.error, err)
        return err
    end

    if binary_signal_offset then
        local binary_count, binary_data_start, err = safe_read_vector_len(buffer, binary_signal_offset)
        if not binary_count then
            sv_tree:add(fields.error, err)
            return err
        end

        sv_tree:add(fields.binary_signal_count, binary_count)

        if binary_count > 0 then
            local bin_tree = sv_tree:add(simbus_proto, buffer(binary_data_start, 0),
                                          string.format("Binary Signals (%d)", binary_count))

            for i = 0, binary_count - 1 do
                local table_offset_pos = binary_data_start + (i * 4)
                if table_offset_pos + 4 <= buffer:len() then
                    local table_offset_rel, err = safe_read_int32_le(buffer, table_offset_pos)
                    if table_offset_rel then
                        local table_offset = table_offset_pos + table_offset_rel
                        if table_offset >= 0 and table_offset < buffer:len() then
                            local err = parse_binary_signal(buffer, table_offset, bin_tree)
                            if err then
                                bin_tree:add(fields.error, "Binary Signal " .. i .. ": " .. err)
                            end
                        end
                    end
                end
            end
        end
    end

    return nil
end

local function parse_model_register(buffer, offset, tree)
    local mr_tree = tree:add(simbus_proto, buffer(offset, 0), "Model Register")

    local step_size_offset, err = get_table_field_offset(buffer, offset, 0)
    if err then
        mr_tree:add(fields.error, err)
        return err
    end

    if step_size_offset then
        local step_size, err = safe_read_double_le(buffer, step_size_offset)
        if step_size then
            mr_tree:add(fields.step_size, buffer(step_size_offset, 8), step_size)
        else
            mr_tree:add(fields.error, err)
        end
    end

    local model_uid_offset, err = get_table_field_offset(buffer, offset, 1)
    if err then
        mr_tree:add(fields.error, err)
        return err
    end

    if model_uid_offset then
        local model_uid, err = safe_read_uint32_le(buffer, model_uid_offset)
        if model_uid then
            mr_tree:add(fields.model_uid_single, buffer(model_uid_offset, 4), model_uid)
        else
            mr_tree:add(fields.error, err)
        end
    end

    local notify_uid_offset, err = get_table_field_offset(buffer, offset, 2)
    if err then
        mr_tree:add(fields.error, err)
        return err
    end

    if notify_uid_offset then
        local notify_uid, err = safe_read_uint32_le(buffer, notify_uid_offset)
        if notify_uid then
            mr_tree:add(fields.notify_uid, buffer(notify_uid_offset, 4), notify_uid)
        else
            mr_tree:add(fields.error, err)
        end
    end

    return nil
end

local function parse_signal_index(buffer, offset, tree)
    local si_tree = tree:add(simbus_proto, buffer(offset, 0), "Signal Index")

    local indexes_offset, err = get_table_field_offset(buffer, offset, 0)
    if err then
        si_tree:add(fields.error, err)
        return err
    end

    if indexes_offset then
        local count, data_start, err = safe_read_vector_len(buffer, indexes_offset)
        if not count then
            si_tree:add(fields.error, err)
            return err
        end

        si_tree:add(fields.signal_lookup_count, count)

        for i = 0, count - 1 do
            local lookup_offset_pos = data_start + (i * 4)
            if lookup_offset_pos + 4 <= buffer:len() then
                local lookup_offset_rel, err = safe_read_int32_le(buffer, lookup_offset_pos)
                if lookup_offset_rel then
                    local lookup_offset = lookup_offset_pos + lookup_offset_rel

                    if lookup_offset >= 0 and lookup_offset < buffer:len() then
                        local lookup_tree = si_tree:add(simbus_proto, buffer(lookup_offset, 0),
                                                        string.format("Signal Lookup [%d]", i))

                        local uid_offset, err = get_table_field_offset(buffer, lookup_offset, 0)
                        if uid_offset then
                            local uid, err = safe_read_uint32_le(buffer, uid_offset)
                            if uid then
                                lookup_tree:add(fields.signal_lookup_uid, buffer(uid_offset, 4), uid)
                            end
                        end

                        local name_offset, err = get_table_field_offset(buffer, lookup_offset, 1)
                        if name_offset then
                            local name, err = safe_read_string(buffer, name_offset)
                            if name then
                                lookup_tree:add(fields.signal_lookup_name, name)
                                lookup_tree:append_text(": " .. name)
                            end
                        end
                    end
                end
            end
        end
    end

    return nil
end

-- Parse a single FlatBuffer message
local function parse_flatbuffer(buffer, tree, packet_num)
    local length = buffer:len()
    if length < 8 then
        tree:add(fields.error, "FlatBuffer too small")
        return
    end

    -- Parse FlatBuffers header
    local root_offset, err = safe_read_uint32_le(buffer, 0)
    if not root_offset then
        tree:add(fields.error, err)
        return
    end
    tree:add(fields.root_offset, buffer(0, 4), root_offset)

    -- File identifier (optional, at offset 4-7)
    if length >= 8 then
        local file_id = buffer(4, 4):string()
        tree:add(fields.file_identifier, buffer(4, 4), file_id)
    end

    local root_table_offset = root_offset

    if root_table_offset >= buffer:len() then
        tree:add(fields.error, "Root table offset beyond buffer")
        return
    end

    -- Parse NotifyMessage table
    local notify_tree = tree:add(simbus_proto, buffer(root_table_offset, 0), "Notify Message")

    -- Field 0: signals (vector of SignalVector)
    local signals_offset, err = get_table_field_offset(buffer, root_table_offset, 0)
    if err then
        notify_tree:add(fields.error, "signals: " .. err)
    elseif signals_offset then
        local vec_count, vec_data_start, err = safe_read_vector_len(buffer, signals_offset)
        if not vec_count then
            notify_tree:add(fields.error, "signals vector: " .. err)
        else
            local signals_tree = notify_tree:add(simbus_proto, buffer(vec_data_start, 0),
                                                 string.format("Signal Vectors (%d)", vec_count))

            for i = 0, vec_count - 1 do
                local sv_offset_pos = vec_data_start + (i * 4)
                if sv_offset_pos + 4 <= buffer:len() then
                    local sv_offset_rel, err = safe_read_int32_le(buffer, sv_offset_pos)
                    if sv_offset_rel then
                        local sv_offset = sv_offset_pos + sv_offset_rel
                        if sv_offset >= 0 and sv_offset < buffer:len() then
                            local err = parse_signal_vector(buffer, sv_offset, signals_tree)
                            if err then
                                signals_tree:add(fields.error, "SignalVector " .. i .. ": " .. err)
                            end
                        end
                    end
                end
            end
        end
    end

    -- Field 1: model_time (double)
    local model_time_offset, err = get_table_field_offset(buffer, root_table_offset, 1)
    if err then
        notify_tree:add(fields.error, "model_time: " .. err)
    elseif model_time_offset then
        local model_time, err = safe_read_double_le(buffer, model_time_offset)
        if model_time then
            notify_tree:add(fields.model_time, buffer(model_time_offset, 8), model_time)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 2: notify_time (double)
    local notify_time_offset, err = get_table_field_offset(buffer, root_table_offset, 2)
    if err then
        notify_tree:add(fields.error, "notify_time: " .. err)
    elseif notify_time_offset then
        local notify_time, err = safe_read_double_le(buffer, notify_time_offset)
        if notify_time then
            notify_tree:add(fields.notify_time, buffer(notify_time_offset, 8), notify_time)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 3: schedule_time (double)
    local schedule_time_offset, err = get_table_field_offset(buffer, root_table_offset, 3)
    if err then
        notify_tree:add(fields.error, "schedule_time: " .. err)
    elseif schedule_time_offset then
        local schedule_time, err = safe_read_double_le(buffer, schedule_time_offset)
        if schedule_time then
            notify_tree:add(fields.schedule_time, buffer(schedule_time_offset, 8), schedule_time)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 4: model_uid (vector of uint)
    local model_uid_arr_offset, err = get_table_field_offset(buffer, root_table_offset, 4)
    if err then
        notify_tree:add(fields.error, "model_uid: " .. err)
    elseif model_uid_arr_offset then
        local uid_count, uid_data_start, err = safe_read_vector_len(buffer, model_uid_arr_offset)
        if not uid_count then
            notify_tree:add(fields.error, "model_uid vector: " .. err)
        elseif uid_count > 0 and uid_data_start + (uid_count * 4) <= buffer:len() then
            local uid_tree = notify_tree:add(simbus_proto, buffer(uid_data_start, uid_count * 4),
                                             string.format("Model UIDs (%d)", uid_count))

            for i = 0, uid_count - 1 do
                local uid, err = safe_read_uint32_le(buffer, uid_data_start + (i * 4))
                if uid then
                    uid_tree:add(fields.model_uid_array, buffer(uid_data_start + (i * 4), 4), uid)
                end
            end
        end
    end

    -- Field 5: bench_notify_time_ns (ulong)
    local bench_notify_offset, err = get_table_field_offset(buffer, root_table_offset, 5)
    if err then
        notify_tree:add(fields.error, "bench_notify_time_ns: " .. err)
    elseif bench_notify_offset then
        local bench_notify, err = safe_read_uint64_le(buffer, bench_notify_offset)
        if bench_notify then
            notify_tree:add(fields.bench_notify_time_ns, buffer(bench_notify_offset, 8), bench_notify)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 6: bench_model_time_ns (ulong)
    local bench_model_offset, err = get_table_field_offset(buffer, root_table_offset, 6)
    if err then
        notify_tree:add(fields.error, "bench_model_time_ns: " .. err)
    elseif bench_model_offset then
        local bench_model, err = safe_read_uint64_le(buffer, bench_model_offset)
        if bench_model then
            notify_tree:add(fields.bench_model_time_ns, buffer(bench_model_offset, 8), bench_model)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 7: token (int)
    local token_offset, err = get_table_field_offset(buffer, root_table_offset, 7)
    if err then
        notify_tree:add(fields.error, "token: " .. err)
    elseif token_offset then
        local token, err = safe_read_int32_le(buffer, token_offset)
        if token then
            notify_tree:add(fields.token, buffer(token_offset, 4), token)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 8: rc (int)
    local rc_offset, err = get_table_field_offset(buffer, root_table_offset, 8)
    if err then
        notify_tree:add(fields.error, "rc: " .. err)
    elseif rc_offset then
        local rc, err = safe_read_int32_le(buffer, rc_offset)
        if rc then
            notify_tree:add(fields.rc, buffer(rc_offset, 4), rc)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 9: response (string)
    local response_offset, err = get_table_field_offset(buffer, root_table_offset, 9)
    if err then
        notify_tree:add(fields.error, "response: " .. err)
    elseif response_offset then
        local response, err = safe_read_string(buffer, response_offset)
        if response then
            notify_tree:add(fields.response, response)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 10: channel_name (string)
    local channel_name_offset, err = get_table_field_offset(buffer, root_table_offset, 10)
    if err then
        notify_tree:add(fields.error, "channel_name: " .. err)
    elseif channel_name_offset then
        local channel_name, err = safe_read_string(buffer, channel_name_offset)
        if channel_name then
            notify_tree:add(fields.channel_name, channel_name)
        else
            notify_tree:add(fields.error, err)
        end
    end

    -- Field 11: model_register (ModelRegister)
    local model_register_offset, err = get_table_field_offset(buffer, root_table_offset, 11)
    if err then
        notify_tree:add(fields.error, "model_register: " .. err)
    elseif model_register_offset then
        local mr_table_offset_rel, err = safe_read_int32_le(buffer, model_register_offset)
        if mr_table_offset_rel then
            local mr_table_offset = model_register_offset + mr_table_offset_rel
            if mr_table_offset >= 0 and mr_table_offset < buffer:len() then
                local err = parse_model_register(buffer, mr_table_offset, notify_tree)
                if err then
                    notify_tree:add(fields.error, "ModelRegister: " .. err)
                end
            end
        end
    end

    -- Field 12: signal_index (SignalIndex)
    local signal_index_offset, err = get_table_field_offset(buffer, root_table_offset, 12)
    if err then
        notify_tree:add(fields.error, "signal_index: " .. err)
    elseif signal_index_offset then
        local si_table_offset_rel, err = safe_read_int32_le(buffer, signal_index_offset)
        if si_table_offset_rel then
            local si_table_offset = signal_index_offset + si_table_offset_rel
            if si_table_offset >= 0 and si_table_offset < buffer:len() then
                local err = parse_signal_index(buffer, si_table_offset, notify_tree)
                if err then
                    notify_tree:add(fields.error, "SignalIndex: " .. err)
                end
            end
        end
    end

    -- Field 13: model_exit (ModelExit)
    local model_exit_offset, err = get_table_field_offset(buffer, root_table_offset, 13)
    if err then
        notify_tree:add(fields.error, "model_exit: " .. err)
    elseif model_exit_offset then
        notify_tree:add(simbus_proto, buffer(model_exit_offset, 0), "Model Exit")
    end
end

-- Get the length of a PDU at the given offset
function get_pdu_length(buffer, offset)
    local msglen = buffer:len()
    if msglen - offset < 4 then
        -- Need more bytes to read length header
        return -1
    end

    -- Read 4-byte length header (little-endian)
    local length = buffer(offset, 4):le_uint()

    -- Total PDU length = 4 bytes (length header) + length (flatbuffer data)
    return 4 + length
end

-- Dissect a single PDU
function dissect_pdu(buffer, pinfo, tree, packet_num)
    local length = buffer:len()

    -- Read length header
    local flatbuffer_length = buffer(0, 4):le_uint()

    -- Create subtree for this packet
    local packet_tree = tree:add(simbus_proto, buffer(),
                                  string.format("SimBus Packet #%d", packet_num))

    packet_tree:add(fields.packet_number, packet_num)
    packet_tree:add(fields.packet_length, buffer(0, 4), flatbuffer_length)

    -- Parse the FlatBuffer data (skip 4-byte header)
    if length > 4 then
        local fb_buffer = buffer(4, flatbuffer_length):tvb()
        parse_flatbuffer(fb_buffer, packet_tree, packet_num)
    end
end

-- Main dissector function with TCP reassembly
function simbus_proto.dissector(buffer, pinfo, tree)
    local length = buffer:len()
    if length == 0 then return end

    pinfo.cols.protocol = simbus_proto.name

    local subtree = tree:add(simbus_proto, buffer(), "SimBus Stream")

    -- Process multiple packets in the buffer
    local offset = 0
    local packet_num = 1

    while offset < length do
        local pdu_length = get_pdu_length(buffer, offset)

        if pdu_length == -1 then
            -- Need more data
            pinfo.desegment_len = DESEGMENT_ONE_MORE_SEGMENT
            pinfo.desegment_offset = offset
            return
        end

        if offset + pdu_length > length then
            -- Need more data
            pinfo.desegment_len = offset + pdu_length - length
            pinfo.desegment_offset = offset
            return
        end

        -- Dissect this PDU
        local pdu_buffer = buffer(offset, pdu_length):tvb()
        dissect_pdu(pdu_buffer, pinfo, subtree, packet_num)

        offset = offset + pdu_length
        packet_num = packet_num + 1
    end

    -- Update info column with packet count
    if packet_num > 1 then
        pinfo.cols.info = string.format("SimBus (%d packets)", packet_num - 1)
    else
        pinfo.cols.info = "SimBus"
    end
end

-- Register the protocol
local udp_port = DissectorTable.get("udp.port")
udp_port:add(2159, simbus_proto)

local tcp_port = DissectorTable.get("tcp.port")
tcp_port:add(2159, simbus_proto)