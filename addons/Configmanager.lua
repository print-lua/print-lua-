-- ==========================================
-- STANDALONE CONFIG MANAGER
-- ==========================================
local ConfigManager = {}
ConfigManager.Folder = "milenium/configs/"
ConfigManager.ActiveConfig = "None"
ConfigManager.ListUI = nil
ConfigManager.Library = nil

-- Safe wrappers to prevent crashes in Rivals/Byfron
local function safe_writefile(p, d) return pcall(writefile, p, d) end
local function safe_listfiles(p) local ok, res = pcall(listfiles, p); return ok and res or {} end
local function safe_readfile(p) local ok, res = pcall(readfile, p); return ok and res or nil end
local function safe_delfile(p) pcall(delfile, p) end
local function safe_isfile(p) local ok, res = pcall(isfile, p); return ok and res or false end

function ConfigManager.GetList()
    local list = {}
    for _, file in next, safe_listfiles(ConfigManager.Folder) do
        local name = file:gsub("\\", "/"):match("([^/]+)%.cfg$")
        if name then
            table.insert(list, name)
        end
    end
    table.sort(list)
    return list
end

function ConfigManager.Save(name)
    if not name or name == "" or name == "None" then return false end
    local path = ConfigManager.Folder .. name .. ".cfg"
    local configData = ConfigManager.Library:get_config()
    local ok = safe_writefile(path, configData)
    if ok then
        ConfigManager.ActiveConfig = name
        return true
    end
    return false
end

function ConfigManager.Load(name)
    if not name or name == "" or name == "None" then return false end
    local path = ConfigManager.Folder .. name .. ".cfg"
    if not safe_isfile(path) then return false end
    
    local data = safe_readfile(path)
    if data then
        ConfigManager.Library:load_config(data)
        ConfigManager.ActiveConfig = name
        return true
    end
    return false
end

function ConfigManager.Delete(name)
    if not name or name == "" or name == "None" then return false end
    local path = ConfigManager.Folder .. name .. ".cfg"
    safe_delfile(path)
    if ConfigManager.ActiveConfig == name then ConfigManager.ActiveConfig = "None" end
    return true
end

function ConfigManager.RefreshList()
    if ConfigManager.ListUI and ConfigManager.ListUI.refresh_options then
        ConfigManager.ListUI.refresh_options(ConfigManager.GetList())
    end
end

-- Builds the UI inside the library
function ConfigManager.Init(window, library)
    ConfigManager.Library = library
    
    -- Create the Configs Tab
    local tab = window:tab({name = "configs", tabs = {"Main"}})
    
    -- Left Column (Save/Load)
    local colLeft = tab:column({})
    local secLeft = colLeft:section({name = "Config Manager", size = 1, default = true, icon = "rbxassetid://139628202576511"})
    
    secLeft:textbox({name = "File Name:", flag = "config_name_text", placeholder = "Enter config name..."})
    
    ConfigManager.ListUI = secLeft:dropdown({
        name = "Saved Configs:",
        items = ConfigManager.GetList(),
        multi = false,
        default = "None",
        flag = "config_list_dropdown",
        callback = function(selected)
            ConfigManager.ActiveConfig = selected
            -- Auto-fill the textbox when a config is selected
            if library.flags["config_name_text"] ~= nil and selected ~= "None" then
                library.flags["config_name_text"] = selected
            end
        end
    })

    -- Right Column (Actions)
    local colRight = tab:column({})
    local secRight = colRight:section({name = "Actions", size = 1, default = true, icon = "rbxassetid://129380150574313"})
    
    secRight:button({
        name = "Save Current Settings", 
        callback = function()
            local name = library.flags["config_name_text"]
            if name and name ~= "" and name ~= "None" then
                local success = ConfigManager.Save(name)
                ConfigManager.RefreshList()
                library.notifications:create_notification({
                    name = success and "Config Saved" or "Error",
                    info = success and ("Saved: " .. name) or "Failed to save config."
                })
            else
                library.notifications:create_notification({name = "Error", info = "Please enter a valid name."})
            end
        end
    })

    secRight:button({
        name = "Load Selected Config", 
        callback = function()
            local name = library.flags["config_list_dropdown"]
            if name and name ~= "None" then
                local success = ConfigManager.Load(name)
                library.notifications:create_notification({
                    name = success and "Config Loaded" or "Error",
                    info = success and ("Loaded: " .. name) or "Failed to load config."
                })
            else
                library.notifications:create_notification({name = "Error", info = "Please select a config."})
            end
        end
    })

    secRight:button({
        name = "Delete Selected Config", 
        callback = function()
            local name = library.flags["config_list_dropdown"]
            if name and name ~= "None" then
                ConfigManager.Delete(name)
                ConfigManager.RefreshList()
                library.notifications:create_notification({name = "Config Deleted", info = "Deleted: " .. name})
            else
                library.notifications:create_notification({name = "Error", info = "Please select a config."})
            end
        end
    })

    secRight:toggle({
        name = "Autoload on Inject",
        flag = "config_autoload",
        default = false,
        callback = function(bool)
            if bool and library.flags["config_list_dropdown"] ~= "None" then
                ConfigManager.Load(library.flags["config_list_dropdown"])
            end
        end
    })
end

return ConfigManager