

function addon.handleAddonMessage(...)
    local prefix, message, channel, sender = ...

    parsedMessage = parsedMessage(message)

    if prefix == addon.prefix then
        print("Received message:", message, "from", sender)
        print("Parsed message:", parsedMessage["STATUS"], " at x =", parsedMessage["POS_X"], " from", parsedMessage["NAME"])
    end
end

function parseMessage(message)
    local data = {}
    for _, pair in ipairs({ string.split(";", message) }) do
        local key, value = string.split(":", pair)
        data[key] = value
    end
    return data
end