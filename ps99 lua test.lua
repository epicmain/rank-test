-- Enable HttpService
local HttpService = game:GetService("HttpService")

-- GitHub repository and file information
local owner = "zhen2004ming" -- Replace with your GitHub username
local repo = "zhen2004ming/rank-test" -- Replace with your repository name
local filePath = "ps99 lua test.lua" -- Path to the file in your repo
local branch = "main" -- Replace with your branch name (default is usually 'main')
local token = "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" -- Your GitHub Personal Access Token

-- Fetch file SHA (needed for updating the file)
local function getFileSHA()
    local url = "https://api.github.com/repos/"..owner.."/"..repo.."/contents/"..filePath.."?ref="..branch
    local headers = {
        ["Authorization"] = "token "..token,
        ["Accept"] = "application/vnd.github.v3+json"
    }

    local response = HttpService:GetAsync(url, false, headers)
    local jsonResponse = HttpService:JSONDecode(response)

    return jsonResponse.sha
end

-- Update the file content
local function updateFile(newContent)
    local url = "https://api.github.com/repos/"..owner.."/"..repo.."/contents/"..filePath
    local fileSHA = getFileSHA()

    local body = {
        message = "Updated file from Roblox",
        content = HttpService:Base64Encode(newContent),
        sha = fileSHA,
        branch = branch
    }

    local headers = {
        ["Authorization"] = "token "..token,
        ["Content-Type"] = "application/json",
        ["Accept"] = "application/vnd.github.v3+json"
    }

    local response = HttpService:RequestAsync({
        Url = url,
        Method = "PUT",
        Headers = headers,
        Body = HttpService:JSONEncode(body)
    })

    print(response.StatusCode, response.StatusMessage)
end

-- Example usage: Update the file with new content
updateFile("This is the new content of the file.")
