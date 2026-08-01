local DOORS_PLACE_IDS = {
    [6516141723] = true,
    [6839171747] = true
}

if DOORS_PLACE_IDS[game.PlaceId] then
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoaderUI"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 250)
    frame.Position = UDim2.new(0.5, -200, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    -- Corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "DOORS Loader"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 25)
    subtitle.Position = UDim2.new(0, 0, 0, 50)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Select which version to load:"
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    subtitle.TextSize = 16
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = frame
    
    -- Function to create buttons
    local function createButton(text, yPos, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.8, 0, 0, 40)
        button.Position = UDim2.new(0.1, 0, 0, yPos)
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 16
        button.Font = Enum.Font.Gotham
        button.Parent = frame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            callback()
            screenGui:Destroy()
        end)
        return button
    end
    
    -- Buttons
    createButton("Load Doors2 (Obsidian)", 100, function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/doors2.luau"))()
    end)
    
    createButton("Load Regular (Linoria)", 155, function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/doors.luau"))()
    end)
    
    createButton("Close", 210, function()
        -- Just close the UI
    end)
    
else
    warn("[Loader] Incorrect game. This script is intended for DOORS PS 67.")
end
