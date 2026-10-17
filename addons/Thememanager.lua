-- ==========================================
-- STANDALONE THEME MANAGER
-- ==========================================
local ThemeManager = {}
ThemeManager.Folder = "milenium/themes/"
ThemeManager.Library = nil
ThemeManager.Presets = {
    ["Default (Purple)"] = Color3.fromRGB(155, 150, 219),
    ["Blood Red"] = Color3.fromRGB(255, 65, 65),
    ["Ocean Blue"] = Color3.fromRGB(65, 150, 255),
    ["Matrix Green"] = Color3.fromRGB(65, 255, 120),
    ["Cyberpunk Yellow"] = Color3.fromRGB(255, 220, 65),
    ["Clean White"] = Color3.fromRGB(255, 255, 255),
}

local function safe_writefile(p, d) return pcall(writefile, p, d) end
local function safe_listfiles(p) local ok, res = pcall(listfiles, p); return ok and res or {} end
local function safe_readfile(p) local ok, res = pcall(readfile, p); return ok and res or nil end
local function safe_delfile(p) pcall(delfile, p) end
local function safe_isfile(p) local ok, res = pcall(isfile, p); return ok and res or false end
local function safe_makefolder(p) pcall(makefolder, p) end

-- Ensure the themes folder exists
safe_makefolder(ThemeManager.Folder)

function ThemeManager.GetList()
    local list = {}
    for _, file in next, safe_listfiles(ThemeManager.Folder) do
        local name = file:gsub("\\", "/"):match("([^/]+)%.theme$")
        if name then
            table.insert(list, name)
        end
    end
    table.sort(list)
    return list
end

function ThemeManager.ApplyColor(color)
    if not ThemeManager.Library then return end
    ThemeManager.Library:update_theme("accent", color)
end

function ThemeManager.SaveTheme(name)
    if not name or name == "" or name == "None" then return false end
    local path = ThemeManager.Folder .. name .. ".theme"
    local currentColor = ThemeManager.Library.theme_color or ThemeManager.Library.preset.accent
    if not currentColor then return false end
    
    -- Convert Color3 to Hex string to save
    local hex = string.format("#%02X%02X%02X", currentColor.R * 255, currentColor.G * 255, currentColor.B * 255)
    return safe_writefile(path, hex)
end

function ThemeManager.LoadTheme(name)
    if not name or name == "" or name == "None" then return false end
    local path = ThemeManager.Folder .. name .. ".theme"
    if not safe_isfile(path) then return false end
    
    local hex = safe_readfile(path)
    if hex and hex:match("^#%x%x%x%x%x%x$") then
        local r = tonumber(hex:sub(2, 3), 16)
        local g = tonumber(hex:sub(4, 5), 16)
        local b = tonumber(hex:sub(6, 7), 16)
        ThemeManager.ApplyColor(Color3.fromRGB(r, g, b))
        return true
    end
    return false
end

function ThemeManager.DeleteTheme(name)
    if not name or name == "" or name == "None" then return false end
    local path = ThemeManager.Folder .. name .. ".theme"
    safe_delfile(path)
    return true
end

-- Builds the UI inside the library
function ThemeManager.Init(window, library)
    ThemeManager.Library = library
    local ui_theme = library.themes or { preset = { accent = Color3.fromRGB(155, 150, 219) } }
    
    local tab = window:tab({name = "themes", tabs = {"Main"}})
    
    -- Left Column (Presets & Picker)
    local colLeft = tab:column({})
    local secLeft = colLeft:section({name = "Themes", size = 1, default = true, icon = "rbxassetid://6034767608"})
    
    -- Preset Dropdown
    local presetNames = {}
    for name, _ in pairs(ThemeManager.Presets) do
        table.insert(presetNames, name)
    end
    
    secLeft:dropdown({
        name = "Presets",
        items = presetNames,
        default = "Default (Purple)",
        multi = false,
        callback = function(selected)
            local color = ThemeManager.Presets[selected]
            if color then
                ThemeManager.ApplyColor(color)
            end
        end
    })
    
    -- Custom Color Picker
    secLeft:colorpicker({
        name = "Custom Accent Color",
        color = library.themes and library.themes.preset.accent or Color3.fromRGB(155, 150, 219),
        callback = function(color, alpha)
            ThemeManager.ApplyColor(color)
        end
    })

    -- Right Column (Save/Load)
    local colRight = tab:column({})
    local secRight = colRight:section({name = "Saved Themes", size = 1, default = true, icon = "rbxassetid://129380150574313"})
    
    secRight:textbox({name = "Theme Name:", flag = "theme_name_text", placeholder = "Enter theme name..."})
    
    local themeList = secRight:dropdown({
        name = "Saved Themes:",
        items = ThemeManager.GetList(),
        multi = false,
        default = "None",
        flag = "theme_list_dropdown"
    })

    secRight:button({
        name = "Save Custom Theme", 
        callback = function()
            local name = library.flags["theme_name_text"]
            if name and name ~= "" then
                local success = ThemeManager.SaveTheme(name)
                if success then
                    themeList.refresh_options(ThemeManager.GetList())
                    library.notifications:create_notification({
                        name = "Theme Saved",
                        info = "Saved theme: " .. name
                    })
                else
                    library.notifications:create_notification({name = "Error", info = "Failed to save theme."})
                end
            else
                library.notifications:create_notification({name = "Error", info = "Please enter a theme name."})
            end
        end
    })

    secRight:button({
        name = "Load Theme", 
        callback = function()
            local name = library.flags["theme_list_dropdown"]
            if name and name ~= "None" then
                local success = ThemeManager.LoadTheme(name)
                library.notifications:create_notification({
                    name = success and "Theme Loaded" or "Error",
                    info = success and ("Loaded: " .. name) or "Failed to load theme."
                })
            else
                library.notifications:create_notification({name = "Error", info = "Please select a theme."})
            end
        end
    })

    secRight:button({
        name = "Delete Theme", 
        callback = function()
            local name = library.flags["theme_list_dropdown"]
            if name and name ~= "None" then
                ThemeManager.DeleteTheme(name)
                themeList.refresh_options(ThemeManager.GetList())
                library.notifications:create_notification({name = "Theme Deleted", info = "Deleted: " .. name})
            else
                library.notifications:create_notification({name = "Error", info = "Please select a theme."})
            end
        end
    })
end

return ThemeManager