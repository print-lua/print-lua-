-- Milenium UI Library — Full Menu
-- Runtime: Roblox Executor

local library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/modded.lua"
))()

getgenv().library = library
_G.library = library

-- ════════════════════════════════════════
--  WINDOW
-- ════════════════════════════════════════
local win = library:window({
    name      = "syrex",
    suffix    = ".lol",
    game_name = "Universal Script — Full",
})

getgenv().window = win
_G.window = win

-- Store references to elements that use the "Risky" color
local risky_buttons = {}

-- ════════════════════════════════════════
--  TABS
-- ════════════════════════════════════════
local vis_main, vis_misc = win:tab({
    name = "Main",
    icon = "http://www.roblox.com/asset/?id=6031068421",
    tabs = { "Main", "Misc." },
})

local combat_main, combat_misc = win:tab({
    name = "Visuals",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    tabs = { "Aimbot", "Triggerbot" },
})

local esp_main = win:tab({
    name = "Esp",
    icon = "http://www.roblox.com/asset/?id=6022668898",
    tabs = { "General" },
})

local misc_general, misc_exploits = win:tab({
    name = "Misc",
    icon = "http://www.roblox.com/asset/?id=6031068421",
    tabs = { "General", "Exploits" },
})

local char_movement, char_appearance, char_combat = win:tab({
    name = "Character",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    tabs = { "Movement", "Appearance", "Combat" },
})

local settings_configs, settings_themes, settings_interface, settings_about = win:tab({
    name = "Settings",
    icon = "http://www.roblox.com/asset/?id=6023426926",
    tabs = { "Configs", "Themes", "Interface", "About" },
})

-- ════════════════════════════════════════
--  MAIN → Main sub-tab  (ESP)
-- ════════════════════════════════════════
local vis_col_left  = vis_main:column({ size = 1 })
local vis_col_right = vis_main:column({ size = 1 })

local esp_section = vis_col_left:section({
    name    = "ESP",
    icon    = "http://www.roblox.com/asset/?id=6031068421",
    fading  = true,
    default = false,
})

esp_section:toggle({ name = "Enable ESP", flag = "esp_enabled", default = false })
esp_section:toggle({ name = "Boxes", flag = "esp_boxes", default = false })
esp_section:toggle({ name = "Skeleton", flag = "esp_skeleton", default = false })
esp_section:toggle({ name = "Tracelines", flag = "esp_tracelines", default = false })
esp_section:toggle({ name = "Health Bar", flag = "esp_healthbar", default = false })
esp_section:toggle({ name = "Name Tag", flag = "esp_names", default = false })
esp_section:toggle({ name = "Distance Text", flag = "esp_distance_text", default = false })

esp_section:slider({ name = "Max Distance", flag = "esp_distance", min = 50, max = 2000, default = 500, suffix = "m" })
esp_section:colorpicker({ name = "Box Color", flag = "esp_box_color", color = Color3.fromRGB(155, 150, 219), alpha = 0 })
esp_section:colorpicker({ name = "Name Color", flag = "esp_name_color", color = Color3.fromRGB(255, 255, 255), alpha = 0 })

local radar_section = vis_col_right:section({
    name    = "Radar",
    icon    = "http://www.roblox.com/asset/?id=6022668898",
    fading  = true,
    default = false,
})

radar_section:toggle({ name = "Enable Radar", flag = "radar_enabled", default = false })
radar_section:slider({ name = "Radar Size", flag = "radar_size", min = 100, max = 400, default = 200, suffix = "px" })
radar_section:slider({ name = "Radar Range", flag = "radar_range", min = 50, max = 1000, default = 300, suffix = "m" })
radar_section:colorpicker({ name = "Enemy Dot Color", flag = "radar_enemy_color", color = Color3.fromRGB(220, 50, 50), alpha = 0 })
radar_section:colorpicker({ name = "Friendly Dot Color", flag = "radar_friend_color", color = Color3.fromRGB(50, 200, 100), alpha = 0 })
radar_section:toggle({ name = "Show Names on Radar", flag = "radar_names", default = false })

-- ════════════════════════════════════════
--  MAIN → Misc. sub-tab
-- ════════════════════════════════════════
local vis_misc_col = vis_misc:column({ size = 1 })

local crosshair_section = vis_misc_col:section({ name = "Crosshair", icon = "http://www.roblox.com/asset/?id=6031071355", fading = true, default = false })
crosshair_section:toggle({ name = "Custom Crosshair", flag = "crosshair_enabled", default = false })
crosshair_section:dropdown({ name = "Crosshair Style", flag = "crosshair_style", items = { "Cross", "Dot", "Circle", "T-Shape", "X" }, default = "Cross" })
crosshair_section:slider({ name = "Size", flag = "crosshair_size", min = 2, max = 30, default = 8, suffix = "px" })
crosshair_section:slider({ name = "Thickness", flag = "crosshair_thickness", min = 1, max = 5, default = 1, suffix = "px" })
crosshair_section:colorpicker({ name = "Crosshair Color", flag = "crosshair_color", color = Color3.fromRGB(255, 255, 255), alpha = 0 })

local fov_section = vis_misc_col:section({ name = "FOV Circle", fading = true, default = false })
fov_section:toggle({ name = "Show FOV Circle", flag = "fov_circle_enabled", default = false })
fov_section:slider({ name = "FOV Circle Radius", flag = "fov_circle_radius", min = 10, max = 400, default = 90, suffix = "px" })
fov_section:colorpicker({ name = "FOV Circle Color", flag = "fov_circle_color", color = Color3.fromRGB(255, 255, 255), alpha = 0.5 })

-- ════════════════════════════════════════
--  VISUALS → Aimbot sub-tab
-- ════════════════════════════════════════
local aim_col = combat_main:column({ size = 1 })
local aimbot_section = aim_col:section({ name = "Aimbot", icon = "http://www.roblox.com/asset/?id=6031071355", fading = true, default = false })

aimbot_section:toggle({ name = "Enable Aimbot", flag = "aim_enabled", default = false })
aimbot_section:dropdown({ name = "Target Part", flag = "aim_part", items = { "Head", "HumanoidRootPart", "Torso", "UpperTorso" }, default = "Head" })
aimbot_section:dropdown({ name = "Target Priority", flag = "aim_priority", items = { "Closest to Crosshair", "Closest Distance", "Lowest Health" }, default = "Closest to Crosshair" })
aimbot_section:slider({ name = "FOV", flag = "aim_fov", min = 1, max = 360, default = 90, suffix = "°" })
aimbot_section:slider({ name = "Smoothness", flag = "aim_smooth", min = 1, max = 50, default = 10 })
aimbot_section:toggle({ name = "Visible Check", flag = "aim_vischeck", default = true })
aimbot_section:toggle({ name = "Team Check", flag = "aim_teamcheck", default = true })
aimbot_section:toggle({ name = "Prediction", flag = "aim_prediction", default = false })
aimbot_section:slider({ name = "Prediction Strength", flag = "aim_pred_strength", min = 1, max = 20, default = 5 })
aimbot_section:keybind({ name = "Aimbot Key", flag = "aim_key", key = Enum.UserInputType.MouseButton2, mode = "Hold" })

-- ════════════════════════════════════════
--  VISUALS → Triggerbot sub-tab
-- ════════════════════════════════════════
local trig_col = combat_misc:column({ size = 1 })
local trigger_section = trig_col:section({ name = "Triggerbot", icon = "http://www.roblox.com/asset/?id=6031071355", fading = true, default = false })

trigger_section:toggle({ name = "Enable Triggerbot", flag = "trigger_enabled", default = false })
trigger_section:slider({ name = "Delay (ms)", flag = "trigger_delay", min = 0, max = 500, default = 50, suffix = "ms" })
trigger_section:slider({ name = "Release Delay (ms)", flag = "trigger_release", min = 0, max = 300, default = 30, suffix = "ms" })
trigger_section:toggle({ name = "Team Check", flag = "trigger_teamcheck", default = true })
trigger_section:dropdown({ name = "Target Parts", flag = "trigger_parts", items = { "All", "Head Only", "Body Only", "Head + Torso" }, default = "All" })
trigger_section:keybind({ name = "Trigger Key", flag = "trigger_key", key = Enum.KeyCode.CapsLock, mode = "Hold" })

-- ════════════════════════════════════════
--  ESP → General sub-tab
-- ════════════════════════════════════════
local esp_col_left  = esp_main:column({ size = 1 })
local esp_col_right = esp_main:column({ size = 1 })

local item_esp = esp_col_left:section({ name = "Item ESP", icon = "http://www.roblox.com/asset/?id=6022668898", fading = true, default = false })
item_esp:toggle({ name = "Enable Item ESP", flag = "item_esp_enabled", default = false })
item_esp:toggle({ name = "Show Item Name", flag = "item_esp_name", default = true })
item_esp:toggle({ name = "Show Item Distance", flag = "item_esp_dist", default = true })
item_esp:slider({ name = "Max Item Distance", flag = "item_esp_maxdist", min = 10, max = 1000, default = 300, suffix = "m" })
item_esp:colorpicker({ name = "Item Color", flag = "item_esp_color", color = Color3.fromRGB(255, 200, 50), alpha = 0 })

local hitbox_section = esp_col_right:section({ name = "Hitbox Expander", fading = true, default = false })
hitbox_section:toggle({ name = "Enable Hitbox", flag = "hitbox_enabled", default = false })
hitbox_section:slider({ name = "Hitbox Size", flag = "hitbox_size", min = 1, max = 20, default = 4 })
hitbox_section:toggle({ name = "Visible Hitbox", flag = "hitbox_visible", default = false })
hitbox_section:colorpicker({ name = "Hitbox Color", flag = "hitbox_color", color = Color3.fromRGB(255, 0, 100), alpha = 0.5 })

-- ════════════════════════════════════════
--  MISC → General sub-tab
-- ════════════════════════════════════════
local misc_gen_col_l = misc_general:column({ size = 1 })
local misc_gen_col_r = misc_general:column({ size = 1 })

local qol_section = misc_gen_col_l:section({ name = "Quality of Life", icon = "http://www.roblox.com/asset/?id=6022668898", fading = true, default = true })

qol_section:toggle({ name = "Infinite Jump", flag = "misc_infjump", default = false, callback = function(val)
    if val then
        getgenv().InfJump = game:GetService("UserInputService").JumpRequest:Connect(function()
            local lp = game.Players.LocalPlayer
            if lp and lp.Character then
                local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if getgenv().InfJump then getgenv().InfJump:Disconnect() getgenv().InfJump = nil end
    end
end })

qol_section:toggle({ name = "Anti-AFK", flag = "misc_antiafk", default = false, callback = function(val)
    if val then
        getgenv().AntiAFK = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    else
        if getgenv().AntiAFK then getgenv().AntiAFK:Disconnect() getgenv().AntiAFK = nil end
    end
end })

qol_section:toggle({ name = "No Clip", flag = "misc_noclip", default = false, callback = function(val)
    getgenv().NoClip = val
    if val and not getgenv().NoClipConn then
        getgenv().NoClipConn = game:GetService("RunService").Stepped:Connect(function()
            if getgenv().NoClip then
                local lp = game.Players.LocalPlayer
                if lp and lp.Character then
                    for _, part in ipairs(lp.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end
        end)
    elseif not val and getgenv().NoClipConn then
        getgenv().NoClipConn:Disconnect()
        getgenv().NoClipConn = nil
    end
end })

qol_section:toggle({ name = "No Fall Damage", flag = "misc_nofalldmg", default = false, callback = function(val)
    if val then
        getgenv().NoFallDmg = game:GetService("RunService").Heartbeat:Connect(function()
            local lp = game.Players.LocalPlayer
            if lp and lp.Character then
                local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false) end
            end
        end)
    else
        if getgenv().NoFallDmg then getgenv().NoFallDmg:Disconnect() getgenv().NoFallDmg = nil end
    end
end })

qol_section:button({ name = "Rejoin Server", callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end })

qol_section:button({ name = "Reset Character", callback = function()
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
end })

qol_section:textbox({ name = "Custom Tag", flag = "misc_tag", placeholder = "enter tag...", default = "" })

local server_section = misc_gen_col_r:section({ name = "Server Utils", fading = true, default = false })

server_section:button({ name = "Copy Server ID", callback = function() setclipboard(game.JobId) end })
server_section:button({ name = "List All Players", callback = function()
    for _, p in ipairs(game.Players:GetPlayers()) do print(p.Name, "| UserID:", p.UserId) end
end })

server_section:toggle({ name = "Show FPS Counter", flag = "misc_fps", default = false, callback = function(val)
    if val then
        local fps_label = Instance.new("TextLabel")
        fps_label.Name = "FPS_Counter"
        fps_label.Size = UDim2.new(0, 80, 0, 20)
        fps_label.Position = UDim2.new(0, 5, 0, 5)
        fps_label.BackgroundTransparency = 1
        fps_label.TextColor3 = Color3.fromRGB(255, 255, 255)
        fps_label.TextStrokeTransparency = 0
        fps_label.Font = Enum.Font.Code
        fps_label.TextSize = 14
        fps_label.TextXAlignment = Enum.TextXAlignment.Left
        fps_label.Parent = game:GetService("CoreGui")

        getgenv().FPSConn = game:GetService("RunService").RenderStepped:Connect(function(dt)
            fps_label.Text = string.format("FPS: %d", math.floor(1 / dt))
        end)
    else
        local existing = game:GetService("CoreGui"):FindFirstChild("FPS_Counter")
        if existing then existing:Destroy() end
        if getgenv().FPSConn then getgenv().FPSConn:Disconnect() getgenv().FPSConn = nil end
    end
end })

server_section:toggle({ name = "Fullbright", flag = "misc_fullbright", default = false, callback = function(val)
    local lighting = game:GetService("Lighting")
    if val then
        getgenv().FB_Orig = { brightness = lighting.Brightness, ambient = lighting.Ambient, outambient = lighting.OutdoorAmbient, clocktime = lighting.ClockTime }
        lighting.Brightness = 2
        lighting.Ambient = Color3.fromRGB(178, 178, 178)
        lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
        lighting.ClockTime = 14
    else
        if getgenv().FB_Orig then
            lighting.Brightness = getgenv().FB_Orig.brightness
            lighting.Ambient = getgenv().FB_Orig.ambient
            lighting.OutdoorAmbient = getgenv().FB_Orig.outambient
            lighting.ClockTime = getgenv().FB_Orig.clocktime
        end
    end
end })

-- ════════════════════════════════════════
--  MISC → Exploits sub-tab
-- ════════════════════════════════════════
local exp_col_l = misc_exploits:column({ size = 1 })
local exp_col_r = misc_exploits:column({ size = 1 })

local remote_section = exp_col_l:section({ name = "Remote Spy", fading = true, default = false })
remote_section:toggle({ name = "Log RemoteEvents", flag = "rspy_events", default = false, callback = function(val)
    if val then
        getgenv().RSpy_hook = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" or method == "InvokeServer" then print("[RemoteSpy]", self:GetFullName(), ...) end
            return getgenv().RSpy_hook(self, ...)
        end)
    end
end })

remote_section:toggle({ name = "Log RemoteFunctions", flag = "rspy_functions", default = false })
remote_section:button({ name = "Dump Remotes to Console", callback = function()
    local function scan(obj)
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then print(child.ClassName, child:GetFullName()) end
            scan(child)
        end
    end
    scan(game)
end })

local tp_section = exp_col_r:section({ name = "Teleport", fading = true, default = false })
tp_section:textbox({ name = "Target Player", flag = "tp_target_name", placeholder = "Player username", default = "" })

tp_section:button({ name = "Teleport to Player", callback = function()
    local target = game.Players:FindFirstChild(library.flags["tp_target_name"])
    local lp = game.Players.LocalPlayer
    if target and target.Character and lp.Character then
        local root = lp.Character:FindFirstChild("HumanoidRootPart")
        local troot = target.Character:FindFirstChild("HumanoidRootPart")
        if root and troot then root.CFrame = troot.CFrame + Vector3.new(2, 0, 0) end
    end
end })

tp_section:button({ name = "Bring Player to Me", callback = function()
    local target = game.Players:FindFirstChild(library.flags["tp_target_name"])
    local lp = game.Players.LocalPlayer
    if target and target.Character and lp.Character then
        local troot = target.Character:FindFirstChild("HumanoidRootPart")
        local myroot = lp.Character:FindFirstChild("HumanoidRootPart")
        if troot and myroot then troot.CFrame = myroot.CFrame + Vector3.new(2, 0, 0) end
    end
end })

tp_section:toggle({ name = "Loop Teleport", flag = "tp_loop", default = false, callback = function(val)
    if val then
        getgenv().LoopTP = game:GetService("RunService").Heartbeat:Connect(function()
            local target = game.Players:FindFirstChild(library.flags["tp_target_name"])
            local lp = game.Players.LocalPlayer
            if target and target.Character and lp.Character then
                local root = lp.Character:FindFirstChild("HumanoidRootPart")
                local troot = target.Character:FindFirstChild("HumanoidRootPart")
                if root and troot then root.CFrame = troot.CFrame + Vector3.new(2, 0, 0) end
            end
        end)
    else
        if getgenv().LoopTP then getgenv().LoopTP:Disconnect() getgenv().LoopTP = nil end
    end
end })

-- ════════════════════════════════════════
--  CHARACTER → Movement sub-tab
-- ════════════════════════════════════════
local move_col_l = char_movement:column({ size = 1 })
local move_col_r = char_movement:column({ size = 1 })

local speed_section = move_col_l:section({ name = "Speed & Jump", fading = true, default = true })
speed_section:slider({ name = "Walk Speed", flag = "char_walkspeed", min = 16, max = 300, default = 16, callback = function(val)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
end })

speed_section:slider({ name = "Jump Power", flag = "char_jumppower", min = 7, max = 200, default = 7, callback = function(val)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = val end
    end
end })

speed_section:toggle({ name = "Speed Boost", flag = "char_speedboost", default = false, callback = function(val)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val and 60 or library.flags["char_walkspeed"] end
    end
end })

speed_section:toggle({ name = "Fly", flag = "char_fly", default = false, callback = function(val)
    local lp = game.Players.LocalPlayer
    if not (lp and lp.Character) then return end
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local hum  = lp.Character:FindFirstChildOfClass("Humanoid")
    if not (root and hum) then return end

    if val then
        hum.PlatformStand = true
        local bg = Instance.new("BodyGyro", root) bg.Name = "FlyGyro" bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) bg.D = 50
        local bv = Instance.new("BodyVelocity", root) bv.Name = "FlyVelocity" bv.Velocity = Vector3.zero bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        getgenv().FlyConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not library.flags["char_fly"] then return end
            local cam = workspace.CurrentCamera
            local spd = library.flags["char_fly_speed"] or 50
            local dir = Vector3.zero
            local uis = game:GetService("UserInputService")
            if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.yAxis end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.yAxis end
            bv.Velocity = dir.Magnitude > 0 and dir.Unit * spd or Vector3.zero
            bg.CFrame = cam.CFrame
        end)
    else
        hum.PlatformStand = false
        local bg = root:FindFirstChild("FlyGyro") local bv = root:FindFirstChild("FlyVelocity")
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
        if getgenv().FlyConn then getgenv().FlyConn:Disconnect() getgenv().FlyConn = nil end
    end
end })

speed_section:slider({ name = "Fly Speed", flag = "char_fly_speed", min = 10, max = 300, default = 50 })

local gravity_section = move_col_r:section({ name = "Gravity & Physics", fading = true, default = false })
gravity_section:slider({ name = "Gravity", flag = "char_gravity", min = 0, max = 200, default = 196, callback = function(val) workspace.Gravity = val end })
gravity_section:button({ name = "Reset Gravity", callback = function() workspace.Gravity = 196.2 end })
gravity_section:toggle({ name = "Low Gravity", flag = "char_lowgrav", default = false, callback = function(val) workspace.Gravity = val and 40 or 196.2 end })
gravity_section:toggle({ name = "Zero Gravity", flag = "char_zerograv", default = false, callback = function(val) workspace.Gravity = val and 0 or 196.2 end })

-- ════════════════════════════════════════
--  CHARACTER → Appearance sub-tab
-- ════════════════════════════════════════
local appear_col_l = char_appearance:column({ size = 1 })
local appear_col_r = char_appearance:column({ size = 1 })

local body_section = appear_col_l:section({ name = "Body Modifiers", fading = true, default = false })
body_section:slider({ name = "Head Scale", flag = "char_head_scale", min = 10, max = 300, default = 100, suffix = "%", callback = function(val)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local head = lp.Character:FindFirstChild("Head")
        if head then head.Size = Vector3.new(1, 1, 1) * (val / 100) end
    end
end })

body_section:slider({ name = "Body Scale", flag = "char_body_scale", min = 10, max = 300, default = 100, suffix = "%", callback = function(val)
    local lp = game.Players.LocalPlayer
    local chr = lp and lp.Character
    if chr then
        local hum = chr:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.BodyDepthScale.Value = val / 100
            hum.BodyWidthScale.Value = val / 100
            hum.BodyHeightScale.Value = val / 100
        end
    end
end })

body_section:toggle({ name = "Invisible Character", flag = "char_invisible", default = false, callback = function(val)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        for _, part in ipairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = val and 1 or 0 end
        end
    end
end })

body_section:colorpicker({ name = "Character Color", flag = "char_color", color = Color3.fromRGB(255, 255, 255), alpha = 0, callback = function(col, t)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        for _, part in ipairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.Color = col end
        end
    end
end })

local name_section = appear_col_r:section({ name = "Name & Chat", fading = true, default = false })
name_section:textbox({ name = "Display Name Override", flag = "char_displayname", placeholder = "New display name", default = "" })
name_section:toggle({ name = "Hide Own Name", flag = "char_hidename", default = false, callback = function(val)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local head = lp.Character:FindFirstChild("Head")
        if head then
            for _, obj in ipairs(head:GetChildren()) do
                if obj:IsA("BillboardGui") then obj.Enabled = not val end
            end
        end
    end
end })

name_section:dropdown({ name = "Chat Style", flag = "char_chatstyle", items = { "Default", "Classic", "Bubble Only", "Disabled" }, default = "Default" })

-- ════════════════════════════════════════
--  CHARACTER → Combat sub-tab
-- ════════════════════════════════════════
local charcombat_col_l = char_combat:column({ size = 1 })
local charcombat_col_r = char_combat:column({ size = 1 })

local selfheal_section = charcombat_col_l:section({ name = "Self Preservation", fading = true, default = false })
selfheal_section:toggle({ name = "God Mode", flag = "char_godmode", default = false, callback = function(val)
    if val then
        getgenv().GodConn = game:GetService("RunService").Heartbeat:Connect(function()
            local lp = game.Players.LocalPlayer
            if lp and lp.Character then
                local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.Health = hum.MaxHealth end
            end
        end)
    else
        if getgenv().GodConn then getgenv().GodConn:Disconnect() getgenv().GodConn = nil end
    end
end })

selfheal_section:slider({ name = "Auto-Heal Threshold", flag = "char_heal_threshold", min = 0, max = 100, default = 30, suffix = "%" })
selfheal_section:toggle({ name = "Anti-Ragdoll", flag = "char_antiragdoll", default = false, callback = function(val)
    if val then
        getgenv().AntiRagdoll = game:GetService("RunService").Heartbeat:Connect(function()
            local lp = game.Players.LocalPlayer
            if lp and lp.Character then
                local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                end
            end
        end)
    else
        if getgenv().AntiRagdoll then getgenv().AntiRagdoll:Disconnect() getgenv().AntiRagdoll = nil end
    end
end })

local damage_section = charcombat_col_r:section({ name = "Damage Modifiers", fading = true, default = false })
damage_section:toggle({ name = "Silent Aim", flag = "char_silentaim", default = false })
damage_section:dropdown({ name = "Silent Aim Part", flag = "char_silentaim_part", items = { "Head", "HumanoidRootPart", "UpperTorso" }, default = "Head" })
damage_section:toggle({ name = "Fake Lag", flag = "char_fakelag", default = false, callback = function(val)
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local root = lp.Character:FindFirstChild("HumanoidRootPart")
        if root then root.Anchored = val end
    end
end })
damage_section:slider({ name = "Fake Lag Interval (ms)", flag = "char_fakelag_interval", min = 50, max = 1000, default = 200, suffix = "ms" })


-- ════════════════════════════════════════
--  SETTINGS → Configs sub-tab
-- ════════════════════════════════════════
local cfg_col = settings_configs:column({ size = 1 })
local cfg_sec = cfg_col:section({ name = "Config Manager", size = 1, default = true, icon = "http://www.roblox.com/asset/?id=6022668898" })

local autoload_path = library.directory .. "/autoload.txt"

cfg_sec:textbox({ name = "Config Name:", flag = "cfg_name_input", placeholder = "my_config", default = "" })

local cfg_dd = cfg_sec:dropdown({
    name = "Saved Configs:", flag = "cfg_list_dropdown", items = {}, default = "None",
    callback = function(val)
        if val and val ~= "None" then library.flags["cfg_name_input"] = val end
    end
})
library.config_holder = cfg_dd

local function refresh_configs()
    local success, files = pcall(listfiles, library.directory .. "/configs/")
    local list = {}
    if success and files then
        for _, file in ipairs(files) do
            local name = file:match("([^/\\]+)%.cfg$")
            if name then table.insert(list, name) end
        end
    end
    cfg_dd.refresh_options(list)
end

task.defer(function() pcall(function() refresh_configs() end) end)

cfg_sec:button({ name = "Save Config", callback = function()
    local name = library.flags["cfg_name_input"]
    if name == "" or name == "None" then name = "default" end
    local ok = pcall(writefile, library.directory .. "/configs/" .. name .. ".cfg", library:get_config())
    if ok then
        refresh_configs()
        library.notifications:create_notification({name = "Configs", info = "Saved config:\n" .. name})
    end
end })

cfg_sec:button({ name = "Load Config", callback = function()
    local selected = library.flags["cfg_list_dropdown"]
    if selected and selected ~= "None" then
        local ok, data = pcall(readfile, library.directory .. "/configs/" .. selected .. ".cfg")
        if ok and data then
            library:load_config(data)
            library.notifications:create_notification({name = "Configs", info = "Loaded config:\n" .. selected})
        end
    end
end })

local del_btn = cfg_sec:button({ name = "Delete Config", callback = function()
    local selected = library.flags["cfg_list_dropdown"]
    if selected and selected ~= "None" then
        pcall(delfile, library.directory .. "/configs/" .. selected .. ".cfg")
        refresh_configs()
        library.notifications:create_notification({name = "Configs", info = "Deleted config:\n" .. selected})
    end
end })
table.insert(risky_buttons, del_btn.items.button)

cfg_sec:button({ name = "Set Autoload Config", callback = function()
    local selected = library.flags["cfg_list_dropdown"]
    if selected and selected ~= "None" then
        pcall(writefile, autoload_path, selected)
        library.notifications:create_notification({name = "Configs", info = "Autoload set to:\n" .. selected})
    end
end })

cfg_sec:button({ name = "Remove Autoload Config", callback = function()
    pcall(delfile, autoload_path)
    library.notifications:create_notification({name = "Configs", info = "Autoload removed."})
end })

cfg_sec:button({ name = "Reset All Flags", callback = function()
    if library.reset_config then library:reset_config() end
    library.notifications:create_notification({name = "Configs", info = "Reset all settings."})
end })

-- ════════════════════════════════════════
--  SETTINGS → Themes sub-tab (FIXED COLORS)
-- ════════════════════════════════════════
local theme_col = settings_themes:column({ size = 1 })
local theme_sec = theme_col:section({ name = "Theme Manager", size = 1, default = true, icon = "http://www.roblox.com/asset/?id=6031071355" })

local presetColors = {
    ["Default (Purple)"] = Color3.fromRGB(155, 150, 219),
    ["Blood Red"] = Color3.fromRGB(255, 65, 65),
    ["Ocean Blue"] = Color3.fromRGB(65, 150, 255),
    ["Matrix Green"] = Color3.fromRGB(65, 255, 120),
    ["Cyberpunk Yellow"] = Color3.fromRGB(255, 220, 65),
    ["Clean White"] = Color3.fromRGB(255, 255, 255),
}

local accent_picker, bg_picker, text_picker, risky_picker

-- ACCENT COLOR
theme_sec:dropdown({
    name = "Presets (Accent)", items = {"Default (Purple)", "Blood Red", "Ocean Blue", "Matrix Green", "Cyberpunk Yellow", "Clean White"}, default = "Default (Purple)",
    callback = function(val)
        if presetColors[val] then
            library:update_theme("accent", presetColors[val])
            if accent_picker then accent_picker:Set(presetColors[val]) end
        end
    end,
})

accent_picker = theme_sec:colorpicker({ name = "Accent Color", flag = "theme_accent_color", color = Color3.fromRGB(155, 150, 219), alpha = 0,
    callback = function(col, t) library:update_theme("accent", col) end
})

-- BACKGROUND COLOR
bg_picker = theme_sec:colorpicker({ name = "Background Color", flag = "theme_bg_color", color = Color3.fromRGB(14, 14, 16), alpha = 0,
    callback = function(col, t)
        library:update_theme("bg", col)
        -- Manually apply to all dark background frames
        if win.items and win.items.main then
            win.items.main.BackgroundColor3 = col
            if win.items.side_frame then win.items.side_frame.BackgroundColor3 = col end
            for _, desc in ipairs(win.items.main:GetDescendants()) do
                if desc:IsA("Frame") and (desc.BackgroundColor3 == Color3.fromRGB(14, 14, 16) or desc.BackgroundColor3 == Color3.fromRGB(22, 22, 24)) then
                    desc.BackgroundColor3 = col
                end
            end
        end
    end
})

-- TEXT COLOR
text_picker = theme_sec:colorpicker({ name = "Text Color", flag = "theme_text_color", color = Color3.fromRGB(255, 255, 255), alpha = 0,
    callback = function(col, t)
        library:update_theme("text", col)
        -- Manually apply to all standard text
        if win.items and win.items.main then
            for _, desc in ipairs(win.items.main:GetDescendants()) do
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    -- Don't overwrite the accent color
                    if desc.TextColor3 == Color3.fromRGB(255, 255, 255) or desc.TextColor3 == Color3.fromRGB(245, 245, 245) or desc.TextColor3 == Color3.fromRGB(72, 72, 73) then
                        desc.TextColor3 = col
                    end
                end
            end
        end
    end
})

-- RISKY (WARNING) COLOR
risky_picker = theme_sec:colorpicker({ name = "Risky (Warning) Color", flag = "theme_risky_color", color = Color3.fromRGB(255, 65, 65), alpha = 0,
    callback = function(col, t)
        library:update_theme("risky", col)
        -- Manually apply to designated risky buttons
        for _, btn in ipairs(risky_buttons) do
            if btn and btn.Parent then
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = col
                end
            end
        end
    end
})

-- ════════════════════════════════════════
--  SETTINGS → Interface sub-tab
-- ════════════════════════════════════════
local ui_col = settings_interface:column({ size = 1 })
local ui_section = ui_col:section({ name = "UI Settings", fading = true, default = true })

ui_section:keybind({ name = "Toggle Menu Keybind", flag = "ui_menu_key", key = Enum.KeyCode.Insert, mode = "Toggle",
    callback = function(active) win.toggle_menu(active) end
})

-- ════════════════════════════════════════
--  SETTINGS → About / Unload sub-tab
-- ════════════════════════════════════════
local about_col = settings_about:column({ size = 1 })
local about_section = about_col:section({ name = "Information", fading = true, default = true })

about_section:label({ name = "Script: Universal Script — Full" })
about_section:label({ name = "Version: 1.0.7" })
about_section:label({ name = "UI Library: Milenium UI" })

local unload_btn = about_section:button({
    name = "Unload Script",
    callback = function()
        for _, connName in ipairs({"InfJump", "AntiAFK", "NoClipConn", "NoFallDmg", "GodConn", "AntiRagdoll", "FlyConn", "FPSConn", "LoopTP"}) do
            if getgenv()[connName] then pcall(function() getgenv()[connName]:Disconnect() end) getgenv()[connName] = nil end
        end
        
        pcall(function() library:unload_menu() end)
        
        for _, parent in ipairs({game:GetService("CoreGui"), game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")}) do
            if parent then
                for _, gui in ipairs(parent:GetChildren()) do
                    if gui.Name == "\0" then pcall(function() gui:Destroy() end) end
                end
            end
        end
        
        getgenv().library = nil _G.library = nil getgenv().window = nil _G.window = nil
        print("[syrex.lol] Successfully unloaded.")
    end
})
table.insert(risky_buttons, unload_btn.items.button)

-- ════════════════════════════════════════
--  AUTOLOAD LOGIC ON STARTUP
-- ════════════════════════════════════════
task.defer(function()
    if pcall(isfile, autoload_path) then
        local ok, config_name = pcall(readfile, autoload_path)
        if ok and config_name and config_name ~= "" then
            local path = library.directory .. "/configs/" .. config_name .. ".cfg"
            local ok2, data = pcall(readfile, path)
            if ok2 and data then
                library:load_config(data)
                library.notifications:create_notification({name = "Configs", info = "Autoloaded config:\n" .. config_name})
            end
        end
    end
end)

print("[syrex.lol] menu loaded — INSERT to toggle")