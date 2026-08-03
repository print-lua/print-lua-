local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer

if LocalPlayer.UserId ~= 3450787935 then
    return
end

TextChatService.OnIncomingMessage = function(message)
    if not message.TextSource then
        return
    end

    if message.TextSource.UserId == LocalPlayer.UserId then
        local properties = Instance.new("TextChatMessageProperties")
        properties.PrefixText = string.format(
            "<gradient color='#000000' offset='0' color='#FFFFFF' offset='1'>[print("lua") Creator]</gradient> %s",
            message.PrefixText
        )
        return properties
    end
end