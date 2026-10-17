-- Milenium UI Library — Sample Script
-- Runtime: Roblox Executor (Synapse X / Fluxus / KRNL)
-- Loadstring fetches library.lua then builds a full demo menu

local library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/modded.lua"
))()

-- ════════════════════════════════════════
--  WINDOW
-- ════════════════════════════════════════
local win = library:window({
    name    = "syrex",      -- accent-colored prefix
    suffix  = ".lol",         -- white suffix appended after name
    game_name = "Universal Script — Sample",
})

-- ════════════════════════════════════════
--  TABS  (each tab() call returns one page-table per sub-tab string)
-- ════════════════════════════════════════
local vis_main, vis_misc, vis_cfg = win:tab({
    name = "Visuals",
    icon = "http://www.roblox.com/asset/?id=6031068421",
    tabs = { "Main", "Misc.", "Config" },
})

local combat_main, combat_misc = win:tab({
    name = "Combat",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    tabs = { "Aimbot", "Triggerbot" },
})

local misc_main = win:tab({
    name = "Misc",
    icon = "http://www.roblox.com/asset/?id=6022668898",
    tabs = { "General" },
})

-- ════════════════════════════════════════
--  VISUALS  → Main sub-tab
-- ════════════════════════════════════════
-- columns lay out side by side inside a sub-tab
local vis_col_left  = vis_main:column({ size = 1 })   -- fills horizontal flex
local vis_col_right = vis_main:column({ size = 1 })

-- Left column — Sections
local esp_section = vis_col_left:section({
    name   = "ESP",
    icon   = "http://www.roblox.com/asset/?id=6031068421",
    fading = true,   -- toggle-able section header
    default = false,
})

-- Toggle — enable ESP
local esp_toggle = esp_section:toggle({
    name     = "Enable ESP",
    flag     = "esp_enabled",
    default  = false,
    callback = function(val)
        -- your ESP enable/disable logic here
        print("ESP:", val)
    end,
})

-- Toggle — boxes
esp_section:toggle({
    name    = "Boxes",
    flag    = "esp_boxes",
    default = false,
    callback = function(val)
        print("Boxes:", val)
    end,
})

-- Toggle — skeleton
esp_section:toggle({
    name    = "Skeleton",
    flag    = "esp_skeleton",
    default = false,
    callback = function(val)
        print("Skeleton:", val)
    end,
})

-- Toggle — tracelines
esp_section:toggle({
    name    = "Tracelines",
    flag    = "esp_tracelines",
    default = false,
    callback = function(val)
        print("Tracelines:", val)
    end,
})

-- Toggle — health bar
esp_section:toggle({
    name    = "Health Bar",
    flag    = "esp_healthbar",
    default = false,
    callback = function(val)
        print("Health Bar:", val)
    end,
})

-- Toggle — name tag
esp_section:toggle({
    name    = "Name Tag",
    flag    = "esp_names",
    default = false,
    callback = function(val)
        print("Name Tag:", val)
    end,
})

-- Slider — max ESP distance
esp_section:slider({
    name     = "Max Distance",
    flag     = "esp_distance",
    min      = 50,
    max      = 2000,
    default  = 500,
    suffix   = "m",
    callback = function(val)
        print("ESP Distance:", val)
    end,
})

-- Color picker — box color (attached directly to a section for inline placement)
esp_section:colorpicker({
    name     = "Box Color",
    flag     = "esp_box_color",
    color    = Color3.fromRGB(155, 150, 219),
    alpha    = 0,
    callback = function(col, transparency)
        print("Box color:", col, "alpha:", 1 - transparency)
    end,
})

-- Right column — Chams
local chams_section = vis_col_right:section({
    name    = "Chams",
    icon    = "http://www.roblox.com/asset/?id=6022668898",
    fading  = true,
    default = false,
})

chams_section:toggle({
    name    = "Enable Chams",
    flag    = "chams_enabled",
    default = false,
    callback = function(val)
        print("Chams:", val)
    end,
})

chams_section:dropdown({
    name    = "Cham Material",
    flag    = "chams_material",
    items   = { "Default", "Neon", "Glass", "ForceField", "SmoothPlastic" },
    default = "Neon",
    callback = function(val)
        print("Cham Material:", val)
    end,
})

chams_section:colorpicker({
    name     = "Visible Color",
    flag     = "chams_vis_color",
    color    = Color3.fromRGB(0, 200, 100),
    alpha    = 0,
    callback = function(col, t)
        print("Chams Visible:", col)
    end,
})

chams_section:colorpicker({
    name     = "Hidden Color",
    flag     = "chams_hid_color",
    color    = Color3.fromRGB(200, 50, 50),
    alpha    = 0,
    callback = function(col, t)
        print("Chams Hidden:", col)
    end,
})

-- ════════════════════════════════════════
--  COMBAT  → Aimbot sub-tab
-- ════════════════════════════════════════
local aim_col = combat_main:column({ size = 1 })

local aimbot_section = aim_col:section({
    name    = "Aimbot",
    icon    = "http://www.roblox.com/asset/?id=6031071355",
    fading  = true,
    default = false,
})

aimbot_section:toggle({
    name    = "Enable Aimbot",
    flag    = "aim_enabled",
    default = false,
    callback = function(val)
        print("Aimbot:", val)
    end,
})

aimbot_section:dropdown({
    name    = "Target Part",
    flag    = "aim_part",
    items   = { "Head", "HumanoidRootPart", "Torso", "UpperTorso" },
    default = "Head",
    callback = function(val)
        print("Target Part:", val)
    end,
})

aimbot_section:dropdown({
    name    = "Target Priority",
    flag    = "aim_priority",
    items   = { "Closest to Crosshair", "Closest Distance", "Lowest Health" },
    default = "Closest to Crosshair",
    callback = function(val)
        print("Priority:", val)
    end,
})

aimbot_section:slider({
    name     = "FOV",
    flag     = "aim_fov",
    min      = 1,
    max      = 360,
    default  = 90,
    suffix   = "°",
    callback = function(val)
        print("FOV:", val)
    end,
})

aimbot_section:slider({
    name     = "Smoothness",
    flag     = "aim_smooth",
    min      = 1,
    max      = 50,
    default  = 10,
    suffix   = "",
    callback = function(val)
        print("Smooth:", val)
    end,
})

aimbot_section:toggle({
    name    = "Visible Check",
    flag    = "aim_vischeck",
    default = true,
    callback = function(val)
        print("Vis Check:", val)
    end,
})

-- Keybind — aimbot hold key
aimbot_section:keybind({
    name     = "Aimbot Key",
    flag     = "aim_key",
    key      = Enum.UserInputType.MouseButton2,
    mode     = "Hold",
    callback = function(active)
        print("Aiming:", active)
    end,
})

-- ════════════════════════════════════════
--  COMBAT  → Triggerbot sub-tab
-- ════════════════════════════════════════
local trig_col = combat_misc:column({ size = 1 })

local trigger_section = trig_col:section({
    name    = "Triggerbot",
    icon    = "http://www.roblox.com/asset/?id=6031071355",
    fading  = true,
    default = false,
})

trigger_section:toggle({
    name    = "Enable Triggerbot",
    flag    = "trigger_enabled",
    default = false,
    callback = function(val)
        print("Trigger:", val)
    end,
})

trigger_section:slider({
    name     = "Delay (ms)",
    flag     = "trigger_delay",
    min      = 0,
    max      = 500,
    default  = 50,
    suffix   = "ms",
    callback = function(val)
        print("Trigger Delay:", val)
    end,
})

trigger_section:keybind({
    name     = "Trigger Key",
    flag     = "trigger_key",
    key      = Enum.KeyCode.CapsLock,
    mode     = "Hold",
    callback = function(active)
        print("Trigger active:", active)
    end,
})

-- ════════════════════════════════════════
--  MISC  → General sub-tab
-- ════════════════════════════════════════
local misc_col = misc_main:column({ size = 1 })

local misc_section = misc_col:section({
    name = "General",
    icon = "http://www.roblox.com/asset/?id=6022668898",
})

misc_section:toggle({
    name    = "Infinite Jump",
    flag    = "misc_infjump",
    default = false,
    callback = function(val)
        if val then
            getgenv().InfJump = game:GetService("UserInputService").JumpRequest:Connect(function()
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(
                        Enum.HumanoidStateType.Jumping
                    )
                end
            end)
        else
            if getgenv().InfJump then
                getgenv().InfJump:Disconnect()
                getgenv().InfJump = nil
            end
        end
    end,
})

misc_section:slider({
    name     = "Walk Speed",
    flag     = "misc_walkspeed",
    min      = 16,
    max      = 300,
    default  = 16,
    suffix   = "",
    callback = function(val)
        local lp = game.Players.LocalPlayer
        if lp and lp.Character then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = val end
        end
    end,
})

misc_section:slider({
    name     = "Jump Power",
    flag     = "misc_jumppower",
    min      = 7,
    max      = 200,
    default  = 7,
    suffix   = "",
    callback = function(val)
        local lp = game.Players.LocalPlayer
        if lp and lp.Character then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = val end
        end
    end,
})

misc_section:textbox({
    name        = "Custom Tag",
    flag        = "misc_tag",
    placeholder = "enter tag...",
    default     = "",
    callback    = function(text)
        print("Tag:", text)
    end,
})

misc_section:button({
    name     = "Rejoin Server",
    callback = function()
        local tp = game:GetService("TeleportService")
        tp:Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

misc_section:button({
    name     = "Reset Character",
    callback = function()
        local lp = game.Players.LocalPlayer
        if lp and lp.Character then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = 0 end
        end
    end,
})

-- ════════════════════════════════════════
--  VISUALS  → Config sub-tab
-- ════════════════════════════════════════
local cfg_col = vis_cfg:column({ size = 1 })

local config_section = cfg_col:section({
    name = "Config Manager",
    icon = "http://www.roblox.com/asset/?id=6022668898",
})

-- textbox for config name input
local config_name_tb = config_section:textbox({
    name        = "Config Name",
    flag        = "config_name_input",
    placeholder = "my_config",
    default     = "",
})

config_section:button({
    name     = "Save Config",
    callback = function()
        local name = library.flags["config_name_input"]
        if name == "" then name = "default" end
        local json = library:get_config()
        writefile(library.directory .. "/configs/" .. name .. ".cfg", json)
        library:update_config_list()
        print("Saved config:", name)
    end,
})

-- dropdown auto-populated by library:update_config_list()
local config_dd = config_section:dropdown({
    name    = "Load Config",
    flag    = "config_name_list",
    items   = {},
    callback = function(selected)
        if selected and selected ~= "" then
            local path = library.directory .. "/configs/" .. selected .. ".cfg"
            if isfile(path) then
                library:load_config(readfile(path))
                print("Loaded config:", selected)
            end
        end
    end,
})

-- expose config_holder reference so update_config_list() works
library.config_holder = config_dd

config_section:button({
    name     = "Delete Config",
    callback = function()
        local selected = library.flags["config_name_list"]
        if selected and selected ~= "" then
            local path = library.directory .. "/configs/" .. selected .. ".cfg"
            if isfile(path) then
                delfile(path)
                library:update_config_list()
                print("Deleted config:", selected)
            end
        end
    end,
})

-- ════════════════════════════════════════
--  TOGGLE MENU KEYBIND  (Insert)
-- ════════════════════════════════════════
game:GetService("UserInputService").InputBegan:Connect(function(input, game_event)
    if game_event then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        win.toggle_menu(library["items"].Enabled == false)
    end
end)

-- Populate config list on load
library:update_config_list()

print("[syrex.lol] menu loaded — INSERT to toggle")