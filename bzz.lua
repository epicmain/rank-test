local httpService = game:GetService("HttpService")

local webhookURL = "https://discord.com/api/webhooks/1293110746204340325/dZizvbUU4LtGv9P-1Qmywgdv7tWFNNXU9WxEsGwo9HDBcs7mKNnqdIOK9n69QcMFVJ5L" -- Replace with your Discord Webhook URL
local messageContent = {
    ["content"] = "Hello from Roblox Executor!", -- Your custom message
    ["username"] = "Roblox Bot", -- Optional username override
}

local jsonData = httpService:JSONEncode(messageContent)

-- Check if using Synapse, Krnl, or Fluxus and adapt the request method accordingly
local requestFunction = syn and syn.request or request or http_request or http and http.request

if requestFunction then
    local success, response = pcall(function()
        return requestFunction({
            Url = webhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
            },
            Body = jsonData,
        })
    end)

    if success then
        print("Message successfully sent to Discord!")
    else
        warn("Failed to send message: " .. response)
    end
else
    warn("Your executor does not support HTTP requests.")
end
