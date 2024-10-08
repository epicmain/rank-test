local HttpService = game:GetService("HttpService")

-- GitHub API parameters
local owner = "zhen2004ming"   -- Your GitHub username
local repo = "rank-test"     -- Your repository name
local filePath = "ps99 lua test.lua" -- Path to the file in your repo
local branch = "main"                   -- The branch to update (usually 'main')
local token = "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"       -- Your GitHub Personal Access Token

-- New content for the file
local newContent = "This is the new content for the file."

-- Function to update the file on GitHub
local function updateFile()
    local url = "https://api.github.com/repos/" .. owner .. "/" .. repo .. "/contents/" .. filePath

    -- The body for the request
    local body = {
        message = "Updating file content from Roblox Lua script",
        content = HttpService:Base64Encode(newContent),
        branch = branch
    }

    -- Prepare headers
    local headers = {
        ["Authorization"] = "token " .. token,
        ["Content-Type"] = "application/json",
        ["Accept"] = "application/vnd.github.v3+json"
    }

    -- Make the request to GitHub API
    local response = HttpService:RequestAsync({
        Url = url,
        Method = "PUT",
        Headers = headers,
        Body = HttpService:JSONEncode(body)
    })

    print(response.StatusCode, response.StatusMessage)
end

-- Call the function to update the file
updateFile()
