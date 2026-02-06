-- Register this dissector as a subdissector for binary_signal.data payloads
function ab_pdu_dissector(buffer, pinfo, tree)
    -- Add your dissector code here
end

-- Call the registered subdissector from simbus_dissector
local function simbus_dissector(buffer, pinfo, tree)
    -- Existing simbus dissect code
    -- Call ab_pdu_dissector for binary_signal.data payloads
end