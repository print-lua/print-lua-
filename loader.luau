-- ═══════════════════════════════════════════════════════════════════
--  Milenium UI Library — Main Script
--  Ported from Elisium v2 (paid)
--  Part 1: Setup + Window + Tabs + Silent Aim (complete)
-- ═══════════════════════════════════════════════════════════════════

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/modded.lua"))()

getgenv().library = library
_G.library = library

-- ════════════════════════════════════════
--  GLOBAL CONFIG STORE (mirrors Elisium structure)
-- ════════════════════════════════════════
getgenv().Elisium = getgenv().Elisium or {}
local E = getgenv().Elisium

E.Combat = E.Combat or {}

E.Misc = E.Misc or {}
E.Misc.UnlockAll         = E.Misc.UnlockAll or false
E.Misc.AutoLoadUnlockAll = E.Misc.AutoLoadUnlockAll or false

E.Misc.GunMods = E.Misc.GunMods or {
    NoMuzzleFlash = false, NoSpread = false, NoRecoil = false, RapidFire = false,
    FasterReload = false, NoWarhornCooldown = false, NoMeleeCooldown = false,
    ExplodeOnThrow = false, NoFuse = false, AutomaticWeapon = false,
}
E.Misc.StretchResolution = E.Misc.StretchResolution or { Enabled = false, Amount = 0.2 }
E.Misc.FFASettings       = E.Misc.FFASettings or { ["Grab Drops"] = false, ["Auto Respawn"] = false }
E.Misc.AutoQueue         = E.Misc.AutoQueue or { Enabled = false, InstantRequeue = true, Value = "1v1" }
E.Misc.AutoLoadout       = E.Misc.AutoLoadout or {
    Enabled = false, Finish = false,
    Value = { "Assault Rifle", "Handgun", "Fists", "Grenade" },
}
E.Misc.AutoBanWeapon     = E.Misc.AutoBanWeapon or { Enabled = false, Weapons = {} }
E.Misc.DeviceSpoofer     = E.Misc.DeviceSpoofer or {
    Enabled = false, Value = "MouseKeyboard", RandomInterval = 1,
    IconColorEnabled = false, IconColor = Color3.fromRGB(255, 255, 255),
}
E.Misc.SoundSpam    = E.Misc.SoundSpam or { Enabled = false, Value = "DoubleJump" }
E.Misc.DestroyTripmine = E.Misc.DestroyTripmine or { Enabled = false }
E.Misc.RemoveSmoke     = E.Misc.RemoveSmoke or { Enabled = false }
E.Misc.AntiFlash       = E.Misc.AntiFlash or { Enabled = false }
E.Misc.NoScopeOverlay  = E.Misc.NoScopeOverlay or { Enabled = false }
E.Misc.AutoReload      = E.Misc.AutoReload or { Enabled = false }
E.Misc.NoProjectileVisuals = E.Misc.NoProjectileVisuals or { Enabled = false }

E.Misc.Spoof = E.Misc.Spoof or {
    Name     = { Enabled = false, Value = "elisium" },
    Username = { Enabled = false, Value = "elisium" },
    Level    = { Enabled = false, Value = 9 },
    Streak   = { Enabled = false, Value = 99 },
    Status   = { Enabled = false, Value = "Prime" },
    Avatar   = { Enabled = false, Value = 10847193927 },
}
E.Misc.ModDetector = E.Misc.ModDetector or {
    Enabled = false,
    Moderators = { Notify = true, Kick = false, ["To Lobby"] = false },
    ModFriends = { Notify = true, Kick = false, ["To Lobby"] = false },
    Color = Color3.fromRGB(250, 195, 70),
}

E.HitSound = E.HitSound or {
    Enabled = false, ["Remove Default"] = false,
    Sound = "", ["Custom Sound"] = "", Volume = 1, Pitch = 1,
}
E.HitNotify = E.HitNotify or {
    Enabled = false, Message = "{target} | {damage} | {hitpart}", Duration = 1,
}
E.Visuals = E.Visuals or {}
E.Visuals["Hit Overlay"] = E.Visuals["Hit Overlay"] or {
    Enabled = false, Color = Color3.fromRGB(255, 60, 60),
    ["Headshot Color"] = Color3.fromRGB(255, 210, 90),
    Transparency = 0.55, Duration = 0.35,
}
E.Visuals["Hitmarker"] = E.Visuals["Hitmarker"] or {
    Enabled = false, Color = Color3.fromRGB(255, 255, 255),
    ["Headshot Color"] = Color3.fromRGB(255, 50, 50),
}
E.Visuals["Damage Numbers"] = E.Visuals["Damage Numbers"] or {
    Enabled = false, Color = Color3.fromRGB(255, 170, 0),
    ["Headshot Color"] = Color3.fromRGB(255, 220, 20),
    ["Disable Ingame"] = false,
}
E.Visuals["Ingame Damage Numbers"] = E.Visuals["Ingame Damage Numbers"] or {
    Enabled = false, Color = Color3.fromRGB(255, 255, 255),
    ["Headshot Color"] = Color3.fromRGB(255, 50, 50),
}

E.Character = E.Character or {}
E.Character["WalkSpeed Multiplier"] = E.Character["WalkSpeed Multiplier"] or { Enabled = false, Speed = 30 }
E.Character["JumpPower Multiplier"] = E.Character["JumpPower Multiplier"] or { Enabled = false, Speed = 30 }
E.Character["Infinite Jump"]        = E.Character["Infinite Jump"]        or false
E.Character.Noclip                  = E.Character.Noclip                  or false
E.Character.Fly                     = E.Character.Fly                     or { Enabled = false, Speed = 100 }
E.Character.Thirdperson             = E.Character.Thirdperson             or {
    Enabled = false, ["Unlock Mouse"] = false, X = 3, Y = 1.5, Z = 7.5,
}
E.Character.Spinbot = E.Character.Spinbot or { Enabled = false, Speed = 10 }
E.Character["GamingChair"] = E.Character["GamingChair"] or {
    Enabled = false, Color = Color3.fromRGB(180, 180, 255),
    BodyColor = Color3.fromRGB(21, 21, 21), Material = "SmoothPlastic",
    Transparency = 0, Scale = 1, Height = 24, Outline = true,
    OutlineTransparency = 0.2, Trails = false, Fan = true,
    FanSpeed = 1, TrailColor = Color3.new(), FastTrailColor = Color3.new(1, 0.5, 0),
    TrailLifetime = 20, SitAnimation = true, OutlineAbove = false,
}
E.Character.Sliding = E.Character.Sliding or {
    ["Slide Boost"] = { Enabled = false, Speed = 100 }, AutoSlide = false,
}
E.Character.AnimationPlayer = E.Character.AnimationPlayer or {
    Enabled = false, Selected = nil, Speed = 1,
}
E.Character.Aura = E.Character.Aura or {
    Enabled = false, Selected = { starlight = true },
    ["Color Override"] = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
}

E.Fly_Init = false  -- internal flag

-- ════════════════════════════════════════
--  AIMBOT CONFIG
-- ════════════════════════════════════════
E.Combat.Aimbot = E.Combat.Aimbot or {
    Enabled       = false,
    ClosestPart   = false,
    FollowGunpoint = false,
    Part          = "Head",
    OnScope       = "",
    ReactionTime  = 0,
    Smoothness    = 0.1,
    Checks        = { Shield = false, Katana = false, Wall = false },
    Fov           = {
        Enabled = false,
        Fill    = false,
        Radius  = 180,
        Lerp    = 1,
        Thickness = 2,
        Speed   = 90,
        Transparency = 0.2,
        FillTransparency = 0.6,
        Color1 = Color3.fromRGB(120, 81, 166),
        Color2 = Color3.fromRGB(255, 255, 255),
        Color3 = Color3.fromRGB(120, 81, 166),
        FillColor1 = Color3.fromRGB(120, 81, 166),
        FillColor2 = Color3.fromRGB(255, 255, 255),
        FillColor3 = Color3.fromRGB(120, 81, 166),
    },
}

-- ════════════════════════════════════════
--  TRIGGERBOT / RAGEBOT / REPOSITION / DODGE / ANTIAIM CONFIG
-- ════════════════════════════════════════
E.Combat.Triggerbot = E.Combat.Triggerbot or {
    Enabled = false,
    TeamCheck = false,
    DisableOnScope = false,
    ReactionTime = 0.05,
    ShootDelay = 0.1,
    Whitelist = {},
    Checks = { Shield = false, Katana = false, Wall = false, SniperScoped = false },
}

E.Combat.Ragebot = E.Combat.Ragebot or {
    Enabled = false,
    AntiKnife = false,
    VoidSpam = { Enabled = false, HideSeconds = 0.69, AttackSeconds = 0.01 },
    SwapWeaponOnEmpty = false,
    SwapWhen = "ammo reserve",
    PriorityWeapon = "primary",
    AutoCrouch = false,
    AttackMode = "gun",
    SafeMethod = "random pos",
    UndergroundDepth = 10,
    FFASmartTargeting = false,
    FFATargetPriority = { ["lowest health"] = true },
}

E.Combat.Reposition = E.Combat.Reposition or { Enabled = false, Offset = -5, Anti = true }

E.Combat.Dodge = E.Combat.Dodge or {
    Enabled = false,
    Method = "lay down",
    RangeBuffer = 3,
    Duration = 0.85,
    Height = 24,
}

E.AntiAim = E.AntiAim or {
    Enabled = false,
    PitchMode = "down",
    PitchOffset = 0,
    PitchAngle = 0,
    YawMode = "jitter",
    YawAngle = 180,
}

E.Combat.SilentAim = E.Combat.SilentAim or {
    Enabled = false,
    Weapons = {},
    Manipulation = { Enabled = false },
    ClosestPart = false,
    FollowGunpoint = false,
    FollowTarget = false,
    HitChance = 100,
    Part = "Head",
    Checks = { Shield = false, Katana = false, Wall = false },
    Fov = {
        Enabled = false,
        Fill = false,
        Radius = 180,
        Lerp = 1,
        Thickness = 2,
        Speed = 90,
        Transparency = 0.2,
        FillTransparency = 0.6,
        Color1 = Color3.fromRGB(120, 81, 166),
        Color2 = Color3.fromRGB(255, 255, 255),
        Color3 = Color3.fromRGB(120, 81, 166),
        FillColor1 = Color3.fromRGB(120, 81, 166),
        FillColor2 = Color3.fromRGB(255, 255, 255),
        FillColor3 = Color3.fromRGB(120, 81, 166),
    },
}

-- ════════════════════════════════════════
--  WINDOW
-- ════════════════════════════════════════
local win = library:window({
    name      = "syrex",
    suffix    = ".lol",
    game_name = "Universal Script",
    size      = UDim2.new(0, 680, 0, 520)
})

getgenv().window = win
local risky_buttons = {}

-- ════════════════════════════════════════
--  TABS
-- ════════════════════════════════════════
local tab_main = win:tab({
    name = "Main",
    icon = "http://www.roblox.com/asset/?id=6031068421",
    tabs = { "Main" },
})

local tab_world = win:tab({
    name = "World",
    icon = "http://www.roblox.com/asset/?id=6022668898",
    tabs = { "World" },
})

local tab_esp = win:tab({
    name = "ESP",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    tabs = { "ESP" },
})

local tab_visuals = win:tab({
    name = "Visuals",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    tabs = { "Visuals" },
})

local tab_misc = win:tab({
    name = "Misc",
    icon = "http://www.roblox.com/asset/?id=6022668898",
    tabs = { "Misc" },
})

local tab_character = win:tab({
    name = "Character",
    icon = "http://www.roblox.com/asset/?id=6031068421",
    tabs = { "Character" },
})

local tab_combat = win:tab({
    name = "Combat",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    tabs = { "Combat" },
})

-- ════════════════════════════════════════
--  MAIN TAB — Unlock All (unchanged)
-- ════════════════════════════════════════
local main_col = tab_main:column({ size = 1 })
local unlock_sec = main_col:section({
    name = "Unlock All",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = true
})

unlock_sec:toggle({
    name = "Unlock All Weapons & Cosmetics",
    flag = "unlock_all_enabled",
    default = false,
    callback = function(val)
        if val then
            task.spawn(function()
                local success, err = pcall(function()
                    if not game:IsLoaded() then game.Loaded:Wait() end
                    local Players = game:GetService("Players")
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local HttpService = game:GetService("HttpService")
                    local player = Players.LocalPlayer
                    while not player do
                        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
                        player = Players.LocalPlayer
                    end
                    local playerScripts = player:WaitForChild("PlayerScripts", 10)
                    if not playerScripts then return end
                    local controllers = playerScripts:WaitForChild("Controllers", 10)
                    if not controllers then return end

                    local UNLOCK_WEAPONS   = true
                    local OVERRIDE_FINISHERS = true

                    local okEnum, EnumLibrary = pcall(function() return require(ReplicatedStorage.Modules:WaitForChild("EnumLibrary", 10)) end)
                    if okEnum and EnumLibrary then pcall(function() EnumLibrary:WaitForEnumBuilder() end) end
                    local okCos, CosmeticLibrary = pcall(function() return require(ReplicatedStorage.Modules:WaitForChild("CosmeticLibrary", 10)) end)
                    if not okCos or not CosmeticLibrary then return end
                    local okItem, ItemLibrary = pcall(function() return require(ReplicatedStorage.Modules:WaitForChild("ItemLibrary", 10)) end)
                    if not okItem or not ItemLibrary then return end
                    local okData, DataController = pcall(function() return require(controllers:WaitForChild("PlayerDataController", 10)) end)
                    if not okData or not DataController then return end

                    local equipped, favorites  = {}, {}
                    local constructingWeapon, viewingProfile = nil, nil
                    local lastUsedWeapon = nil

                    local function cloneCosmetic(name, cosmeticType, options)
                        local base = CosmeticLibrary.Cosmetics[name]
                        if not base then return nil end
                        local data = {}
                        for key, value in pairs(base) do data[key] = value end
                        data.Name = name
                        data.Type = data.Type or cosmeticType
                        data.Seed = data.Seed or math.random(1, 1000000)
                        if EnumLibrary then
                            local success, enumId = pcall(EnumLibrary.ToEnum, EnumLibrary, name)
                            if success and enumId then data.Enum, data.ObjectID = enumId, data.ObjectID or enumId end
                        end
                        if options then
                            if options.inverted     ~= nil then data.Inverted       = options.inverted      end
                            if options.favoritesOnly ~= nil then data.OnlyUseFavorites = options.favoritesOnly end
                        end
                        return data
                    end

                    local saveFile = "unlockall/config.json"
                    local function saveConfig()
                        if not writefile then return end
                        pcall(function()
                            local config = { equipped = {}, favorites = favorites }
                            for weapon, cosmetics in pairs(equipped) do
                                config.equipped[weapon] = {}
                                for cosmeticType, cosmeticData in pairs(cosmetics) do
                                    if cosmeticData and cosmeticData.Name then
                                        config.equipped[weapon][cosmeticType] = {
                                            name = cosmeticData.Name,
                                            seed = cosmeticData.Seed,
                                            inverted = cosmeticData.Inverted
                                        }
                                    end
                                end
                            end
                            makefolder("unlockall")
                            writefile(saveFile, HttpService:JSONEncode(config))
                        end)
                    end

                    local function loadConfig()
                        if not readfile or not isfile or not isfile(saveFile) then return end
                        pcall(function()
                            local config = HttpService:JSONDecode(readfile(saveFile))
                            if config.equipped then
                                for weapon, cosmetics in pairs(config.equipped) do
                                    equipped[weapon] = {}
                                    for cosmeticType, cosmeticData in pairs(cosmetics) do
                                        local cloned = cloneCosmetic(cosmeticData.name, cosmeticType, { inverted = cosmeticData.inverted })
                                        if cloned then cloned.Seed = cosmeticData.seed equipped[weapon][cosmeticType] = cloned end
                                    end
                                end
                            end
                            favorites = config.favorites or {}
                        end)
                    end

                    local function isUnlockable(name, cosmetic)
                        if not cosmetic then return false end
                        local t = cosmetic.Type
                        if t == "Skin" or t == "Charm" or t == "Dance" or t == "Emote" or t == "Wrap" or t == "Wrapping" or t == "Finisher" then
                            return true
                        end
                        local n = name:lower()
                        return (n:find("charm") or n:find("dance") or n:find("emote") or n:find("wrap") or n:find("finisher")) ~= nil
                    end

                    local originalOwnsCosmetic = CosmeticLibrary.OwnsCosmetic
                    CosmeticLibrary.OwnsCosmetic = function(self, inventory, name, weapon)
                        if name:find("MISSING_") then return originalOwnsCosmetic(self, inventory, name, weapon) end
                        if isUnlockable(name, CosmeticLibrary.Cosmetics[name]) then return true end
                        return originalOwnsCosmetic(self, inventory, name, weapon)
                    end

                    for _, fnName in ipairs({ "OwnsCosmeticNormally", "OwnsCosmeticUniversally", "OwnsCosmeticForWeapon" }) do
                        local original = CosmeticLibrary[fnName]
                        CosmeticLibrary[fnName] = function(self, inventory, name, weapon)
                            if type(name) == "string" and not name:find("MISSING_") and isUnlockable(name, CosmeticLibrary.Cosmetics[name]) then
                                return true
                            end
                            if original then return original(self, inventory, name, weapon) end
                            return false
                        end
                    end

                    local function getItemTable()
                        return (type(ItemLibrary.Items) == "table" and ItemLibrary.Items)
                            or (type(ItemLibrary.Weapons) == "table" and ItemLibrary.Weapons)
                            or nil
                    end

                    local function isKnownWeapon(name)
                        local items = getItemTable()
                        return items ~= nil and items[name] ~= nil
                    end

                    local function stubWeapon(name)
                        return { Name = name, Level = 1, XP = 0, Experience = 0, Kills = 0 }
                    end

                    local invCache, invCacheFor, invCacheAt
                    local originalGet = DataController.Get
                    DataController.Get = function(self, key)
                        local data = originalGet(self, key)
                        if key == "CosmeticInventory" then
                            if invCache and invCacheFor == data and os.clock() - invCacheAt < 0.25 then
                                return invCache
                            end
                            local proxy = {}
                            local sample
                            if data then
                                for k, v in pairs(data) do
                                    if CosmeticLibrary.Cosmetics[k] then proxy[k] = v end
                                    if sample == nil then sample = v end
                                end
                            end
                            for name in pairs(CosmeticLibrary.Cosmetics) do
                                if proxy[name] == nil then
                                    if type(sample) == "number" then proxy[name] = 1
                                    elseif type(sample) == "table" then proxy[name] = {}
                                    else proxy[name] = true end
                                end
                            end
                            setmetatable(proxy, { __index = function(_, k)
                                if CosmeticLibrary.Cosmetics[k] then return true end
                                return nil
                            end })
                            invCache, invCacheFor, invCacheAt = proxy, data, os.clock()
                            return proxy
                        end
                        if key == "FavoritedCosmetics" then
                            local result = data and table.clone(data) or {}
                            for weapon, favs in pairs(favorites) do
                                result[weapon] = result[weapon] or {}
                                for name, isFav in pairs(favs) do
                                    result[weapon][name] = isFav
                                end
                            end
                            return result
                        end
                        if key == "WeaponInventory" and type(data) == "table" then
                            local result = table.clone(data)
                            local items = UNLOCK_WEAPONS and getItemTable()
                            if items then
                                for name in pairs(items) do
                                    if type(name) == "string" and result[name] == nil then
                                        result[name] = stubWeapon(name)
                                    end
                                end
                            end
                            for weaponName, cosmetics in pairs(equipped) do
                                local entry = result[weaponName]
                                if weaponName ~= "Dances" and type(entry) == "table" then
                                    local merged = table.clone(entry)
                                    for cosmeticType, cosmeticData in pairs(cosmetics) do
                                        merged[cosmeticType] = cosmeticData
                                    end
                                    result[weaponName] = merged
                                end
                            end
                            return result
                        end
                        return data
                    end

                    local function reallyOwns(cosmeticName, weaponName)
                        local ok, inventory = pcall(originalGet, DataController, "CosmeticInventory")
                        if not ok or not inventory then return false end
                        if rawget(inventory, cosmeticName) then return true end
                        local ok2, owned = pcall(originalOwnsCosmetic, CosmeticLibrary, inventory, cosmeticName, weaponName)
                        return ok2 and owned == true
                    end

                    local originalGetWeaponData = DataController.GetWeaponData
                    DataController.GetWeaponData = function(self, weaponName)
                        local data = originalGetWeaponData(self, weaponName)
                        if not data then
                            if UNLOCK_WEAPONS and isKnownWeapon(weaponName) then
                                data = stubWeapon(weaponName)
                            else
                                return nil
                            end
                        end
                        local merged = {}
                        for key, value in pairs(data) do merged[key] = value end
                        merged.Name = weaponName
                        if equipped[weaponName] then
                            for cosmeticType, cosmeticData in pairs(equipped[weaponName]) do
                                merged[cosmeticType] = cosmeticData
                            end
                        end
                        return merged
                    end

                    pcall(function()
                        local LootLibrary = require(ReplicatedStorage.Modules:WaitForChild("LootLibrary", 10))
                        local originalReward = LootLibrary.GetNextWeaponLevelReward
                        if originalReward then
                            LootLibrary.GetNextWeaponLevelReward = function(self, ...)
                                local ok, result = pcall(originalReward, self, ...)
                                if ok then return result end
                                return nil
                            end
                        end
                    end)

                    local FighterController
                    pcall(function() FighterController = require(controllers:WaitForChild("FighterController", 10)) end)

                    if hookmetamethod then
                        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                        local dataRemotes = remotes and remotes:FindFirstChild("Data")
                        local equipRemote = dataRemotes and dataRemotes:FindFirstChild("EquipCosmetic")
                        local favoriteRemote = dataRemotes and dataRemotes:FindFirstChild("FavoriteCosmetic")
                        local replicationRemotes = remotes and remotes:FindFirstChild("Replication")
                        local fighterRemotes = replicationRemotes and replicationRemotes:FindFirstChild("Fighter")
                        local useItemRemote = fighterRemotes and fighterRemotes:FindFirstChild("UseItem")
                        if not useItemRemote and remotes then
                            for _, d in ipairs(remotes:GetDescendants()) do
                                if d:IsA("BaseRemoteEvent") and d.Name:lower():find("useitem") then
                                    useItemRemote = d; break
                                end
                            end
                        end
                        local oldNamecall
                        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                            if getnamecallmethod() ~= "FireServer" then return oldNamecall(self, ...) end
                            local args = { ... }
                            if useItemRemote and self == useItemRemote then
                                local objectID = args[1]
                                if FighterController then
                                    pcall(function()
                                        local fighter = FighterController:GetFighter(player)
                                        if fighter and fighter.Items then
                                            for _, item in pairs(fighter.Items) do
                                                if item:Get("ObjectID") == objectID then
                                                    lastUsedWeapon = item.Name; break
                                                end
                                            end
                                        end
                                    end)
                                end
                            end
                            if self == equipRemote then
                                local weaponName, cosmeticType, cosmeticName, options = args[1], args[2], args[3], args[4] or {}
                                local isNone  = not cosmeticName or cosmeticName == "None" or cosmeticName == ""
                                local isDance = cosmeticType ~= "Finisher" and (cosmeticType == "Dance" or cosmeticType == "Emote" or (not isNone and (cosmeticName:lower():find("dance") or cosmeticName:lower():find("emote"))))
                                local overrideTable
                                if isDance then
                                    equipped.Dances = equipped.Dances or {}
                                    overrideTable = equipped.Dances
                                else
                                    equipped[weaponName] = equipped[weaponName] or {}
                                    overrideTable = equipped[weaponName]
                                end
                                if isNone then
                                    overrideTable[cosmeticType] = nil
                                    if isDance then
                                        if not next(equipped.Dances) then equipped.Dances = nil end
                                    elseif not next(equipped[weaponName]) then
                                        equipped[weaponName] = nil
                                    end
                                    task.defer(saveConfig)
                                    return oldNamecall(self, ...)
                                end
                                local owned  = reallyOwns(cosmeticName, weaponName)
                                local cloned = cloneCosmetic(cosmeticName, cosmeticType, { inverted = options.IsInverted, favoritesOnly = options.OnlyUseFavorites })
                                if cloned then overrideTable[cosmeticType] = cloned end
                                task.defer(function()
                                    pcall(function() DataController.CurrentData:Replicate(isDance and "CosmeticInventory" or "WeaponInventory") end)
                                    task.wait(0.1)
                                    saveConfig()
                                end)
                                if owned then return oldNamecall(self, ...) end
                                return
                            end
                            if self == favoriteRemote then
                                local wName, cName, isFav = args[1], args[2], args[3]
                                local cosmetic = CosmeticLibrary.Cosmetics[cName]
                                if cosmetic then
                                    favorites[wName] = favorites[wName] or {}
                                    favorites[wName][cName] = isFav or nil
                                    saveConfig()
                                    task.spawn(function() pcall(function() DataController.CurrentData:Replicate("FavoritedCosmetics") end) end)
                                end
                                return
                            end
                            return oldNamecall(self, ...)
                        end))
                    end

                    local ClientItem
                    pcall(function() ClientItem = require(player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem) end)
                    if ClientItem and ClientItem._CreateViewModel then
                        local originalCreateViewModel = ClientItem._CreateViewModel
                        ClientItem._CreateViewModel = function(self, viewmodelRef)
                            local weaponName = self.Name
                            local weaponPlayer = self.ClientFighter and self.ClientFighter.Player
                            constructingWeapon = (weaponPlayer == player) and weaponName or nil
                            if weaponPlayer == player and equipped[weaponName] and viewmodelRef then
                                local dataKey = self:ToEnum("Data")
                                local targetTable = viewmodelRef[dataKey] or viewmodelRef.Data
                                if targetTable then
                                    if equipped[weaponName].Skin then
                                        targetTable[self:ToEnum("Skin") or "Skin"] = equipped[weaponName].Skin
                                        targetTable[self:ToEnum("Name") or "Name"] = equipped[weaponName].Skin.Name
                                    end
                                    if equipped[weaponName].Charm then targetTable[self:ToEnum("Charm") or "Charm"] = equipped[weaponName].Charm end
                                    if equipped[weaponName].Wrap  then targetTable[self:ToEnum("Wrap")  or "Wrap"]  = equipped[weaponName].Wrap  end
                                end
                            end
                            local result = originalCreateViewModel(self, viewmodelRef)
                            constructingWeapon = nil
                            return result
                        end
                    end

                    local viewModelModule = player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem:FindFirstChild("ClientViewModel")
                    if viewModelModule then
                        local ClientViewModel = require(viewModelModule)
                        if ClientViewModel.GetCharm then
                            local originalGetCharmFunc = ClientViewModel.GetCharm
                            ClientViewModel.GetCharm = function(self)
                                local weaponName  = self.ClientItem and self.ClientItem.Name
                                local weaponPlayer = self.ClientItem and self.ClientItem.ClientFighter and self.ClientItem.ClientFighter.Player
                                if weaponName and weaponPlayer == player and equipped[weaponName] and equipped[weaponName].Charm then
                                    return equipped[weaponName].Charm
                                end
                                return originalGetCharmFunc(self)
                            end
                        end
                        if ClientViewModel.GetWrap then
                            local originalGetWrapFunc = ClientViewModel.GetWrap
                            ClientViewModel.GetWrap = function(self)
                                local weaponName  = self.ClientItem and self.ClientItem.Name
                                local weaponPlayer = self.ClientItem and self.ClientItem.ClientFighter and self.ClientItem.ClientFighter.Player
                                if weaponName and weaponPlayer == player and equipped[weaponName] and equipped[weaponName].Wrap then
                                    return equipped[weaponName].Wrap
                                end
                                return originalGetWrapFunc(self)
                            end
                        end
                        local originalNew = ClientViewModel.new
                        ClientViewModel.new = function(replicatedData, clientItem)
                            local weaponPlayer = clientItem.ClientFighter and clientItem.ClientFighter.Player
                            local weaponName  = constructingWeapon or clientItem.Name
                            if weaponPlayer == player and equipped[weaponName] then
                                local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass)
                                local dataKey = ReplicatedClass:ToEnum("Data")
                                replicatedData[dataKey] = replicatedData[dataKey] or {}
                                local cosmetics = equipped[weaponName]
                                if cosmetics.Skin  then replicatedData[dataKey][ReplicatedClass:ToEnum("Skin")]  = cosmetics.Skin  end
                                if cosmetics.Charm then replicatedData[dataKey][ReplicatedClass:ToEnum("Charm")] = cosmetics.Charm end
                                if cosmetics.Wrap  then replicatedData[dataKey][ReplicatedClass:ToEnum("Wrap")]  = cosmetics.Wrap  end
                            end
                            local result = originalNew(replicatedData, clientItem)
                            if weaponPlayer == player and equipped[weaponName] and equipped[weaponName].Wrap and result._UpdateWrap then
                                result:_UpdateWrap()
                                task.delay(0.1, function() if not result._destroyed then result:_UpdateWrap() end end)
                            end
                            return result
                        end
                    end

                    ItemLibrary.GetViewModelImageFromWeaponData = function(self, weaponData, highRes)
                        if not weaponData then return nil end
                        local weaponName = weaponData.Name
                        local shouldShowSkin = (weaponData.Skin and equipped[weaponName] and weaponData.Skin == equipped[weaponName].Skin) or (viewingProfile == player and equipped[weaponName] and equipped[weaponName].Skin)
                        if shouldShowSkin and equipped[weaponName] and equipped[weaponName].Skin then
                            local skinInfo = self.ViewModels[equipped[weaponName].Skin.Name]
                            if skinInfo then return skinInfo[highRes and "ImageHighResolution" or "Image"] or skinInfo.Image end
                        end
                        return nil
                    end

                    local EmoteController
                    pcall(function()
                        EmoteController = require(controllers:WaitForChild("EmoteController", 10))
                        if EmoteController and EmoteController.GetEmotes then
                            local originalGetEmotes = EmoteController.GetEmotes
                            EmoteController.GetEmotes = function(self)
                                local emotes = originalGetEmotes(self)
                                for name, cosmetic in pairs(CosmeticLibrary.Cosmetics) do
                                    if cosmetic and (cosmetic.Type == "Dance" or cosmetic.Type == "Emote" or name:lower():find("dance") or name:lower():find("emote")) then
                                        if not emotes[name] then
                                            emotes[name] = { Name = name, Type = cosmetic.Type, ObjectID = cosmetic.ObjectID, Enum = cosmetic.Enum }
                                        end
                                    end
                                end
                                return emotes
                            end
                        end
                    end)

                    pcall(function()
                        local ViewProfile = require(player.PlayerScripts.Modules.Pages.ViewProfile)
                        if ViewProfile and ViewProfile.Fetch then
                            local originalFetch = ViewProfile.Fetch
                            ViewProfile.Fetch = function(self, targetPlayer)
                                viewingProfile = targetPlayer
                                return originalFetch(self, targetPlayer)
                            end
                        end
                    end)

                    if OVERRIDE_FINISHERS then
                        task.spawn(function()
                            local finishersFolder = ReplicatedStorage.Modules:WaitForChild("Finishers", 10)
                            if not finishersFolder then return end
                            local originals = {}
                            local suppress = false
                            local function isLocalEliminator(eliminator)
                                if eliminator == nil then return false end
                                if eliminator == player then return true end
                                local character = player.Character
                                local t = typeof(eliminator)
                                if t == "Instance" then
                                    if character and (eliminator == character or eliminator:IsDescendantOf(character)) then return true end
                                    if eliminator:IsA("Player") then return eliminator == player end
                                    return false
                                end
                                if t == "number" then return eliminator == player.UserId end
                                if t == "string" then return eliminator == player.Name end
                                if t == "table" then
                                    if eliminator.Player == player then return true end
                                    local c = eliminator.Character
                                    return character ~= nil and c == character
                                end
                                return false
                            end
                            local function getHeldWeapon()
                                if not FighterController then return nil end
                                local ok, fighter = pcall(FighterController.GetFighter, FighterController, player)
                                if not ok or type(fighter) ~= "table" then return nil end
                                local function nameOf(item)
                                    if type(item) == "string" then return item end
                                    if type(item) == "table" or typeof(item) == "Instance" then
                                        local okName, itemName = pcall(function() return item.Name end)
                                        if okName and type(itemName) == "string" then return itemName end
                                    end
                                    return nil
                                end
                                for _, key in ipairs({ "EquippedItem", "CurrentItem", "ActiveItem", "SelectedItem", "HeldItem" }) do
                                    local okKey, item = pcall(function() return fighter[key] end)
                                    if okKey and item then local n = nameOf(item); if n then return n end end
                                end
                                for _, method in ipairs({ "GetEquippedItem", "GetCurrentItem", "GetActiveItem", "GetSelectedItem", "GetHeldItem" }) do
                                    local okMethod, item = pcall(function() return fighter[method](fighter) end)
                                    if okMethod and item then local n = nameOf(item); if n then return n end end
                                end
                                return nil
                            end
                            local function pickTarget()
                                local weapon = getHeldWeapon() or lastUsedWeapon
                                local finisher = weapon and equipped[weapon] and equipped[weapon].Finisher
                                if finisher and finisher.Name and originals[finisher.Name] then return finisher.Name end
                                return nil
                            end
                            local function build(name, ...)
                                if name == "Every Finisher Ever" then
                                    suppress = true
                                    local ok, result = pcall(originals[name], ...)
                                    suppress = false
                                    if not ok then error(result, 0) end
                                    return result
                                end
                                return originals[name](...)
                            end
                            for _, moduleScript in ipairs(finishersFolder:GetChildren()) do
                                if moduleScript:IsA("ModuleScript") then
                                    local name = moduleScript.Name
                                    local ok, class = pcall(require, moduleScript)
                                    if ok and type(class) == "table" and type(class.new) == "function" then
                                        originals[name] = class.new
                                        class.new = function(subject, isFinal, eliminator, ...)
                                            if suppress then return originals[name](subject, isFinal, eliminator, ...) end
                                            if isLocalEliminator(eliminator) then
                                                local target = pickTarget()
                                                if target and target ~= name then
                                                    local okBuild, object = pcall(build, target, subject, isFinal, eliminator, ...)
                                                    if okBuild and object then return object end
                                                end
                                            end
                                            return build(name, subject, isFinal, eliminator, ...)
                                        end
                                    end
                                end
                            end
                        end)
                    end

                    loadConfig()
                end)
                if not success then
                    library.notifications:create_notification({ name = "Error", info = "Unlock All failed." })
                    warn("[syrex.lol] Unlock All Error: " .. tostring(err))
                else
                    library.notifications:create_notification({ name = "Unlock All", info = "Unlocked!" })
                end
            end)
        end
    end
})

-- ════════════════════════════════════════
--  UNLOAD
-- ════════════════════════════════════════
local unload_sec = main_col:section({
    name = "Management",
    icon = "http://www.roblox.com/asset/?id=6022668898",
    fading = true,
    default = false
})
local unload_btn = unload_sec:button({
    name = "Unload Script",
    callback = function()
        pcall(function() library:unload_menu() end)
        for _, parent in ipairs({ game:GetService("CoreGui"), game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") }) do
            if parent then
                for _, gui in ipairs(parent:GetChildren()) do
                    if gui.Name == "\0" then pcall(function() gui:Destroy() end) end
                end
            end
        end
        getgenv().library = nil _G.library = nil
        getgenv().window = nil _G.window = nil
        print("[syrex.lol] Unloaded.")
    end
})
table.insert(risky_buttons, unload_btn.items.button)

-- ═══════════════════════════════════════════════════════════════════
--  COMBAT TAB — SILENT AIM (UI)
-- ═══════════════════════════════════════════════════════════════════
local combat_left  = tab_combat:column({ size = 1 })
local combat_right = tab_combat:column({ size = 1 })

local SA = E.Combat.SilentAim
local sa_hit_parts = {
    "HumanoidRootPart", "HitboxBody", "HitboxHead", "PhysicalHitboxHead",
    "HitboxHeadSmall", "Head", "UpperTorso", "LowerTorso",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperLeg", "RightLowerLeg", "RightFoot",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
}

-- ── Silent Aim section ───────────────────────────────────────
local sa_sec = combat_left:section({
    name = "Silent Aim",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = true,
})

sa_sec:toggle({
    name = "Enable Silent Aim",
    flag = "silent_aim_enable",
    default = false,
    callback = function(v) SA.Enabled = v end,
})

sa_sec:keybind({
    name = "Silent Aim Keybind",
    flag = "silent_aim_keybind",
    default = "None",
    mode = "Toggle",
    callback = function(v) SA.Enabled = v end,
})

sa_sec:toggle({
    name = "Manipulation",
    flag = "silent_aim_manipulation",
    default = false,
    callback = function(v) SA.Manipulation.Enabled = v end,
})

sa_sec:toggle({
    name = "Closest Part",
    flag = "silent_aim_closest_part",
    default = false,
    callback = function(v) SA.ClosestPart = v end,
})

sa_sec:dropdown({
    name = "Hit Part",
    flag = "silent_aim_hit_part",
    default = "Head",
    options = sa_hit_parts,
    callback = function(v) SA.Part = v end,
})

sa_sec:dropdown({
    name = "Checks",
    flag = "silent_aim_checks",
    default = {},
    options = { "Riot Shield", "Katana", "Wall" },
    multi = true,
    callback = function(v)
        SA.Checks.Shield = v["Riot Shield"] == true
        SA.Checks.Katana = v["Katana"] == true
        SA.Checks.Wall = v["Wall"] == true
    end,
})

sa_sec:slider({
    name = "Hit Chance (%)",
    flag = "silent_aim_hit_chance",
    default = 100, min = 1, max = 100,
    callback = function(v) SA.HitChance = v end,
})

sa_sec:toggle({
    name = "Follow Gunpoint",
    flag = "silent_aim_follow_gunpoint",
    default = false,
    callback = function(v) SA.FollowGunpoint = v end,
})

sa_sec:toggle({
    name = "Follow Target",
    flag = "silent_aim_follow_target",
    default = false,
    callback = function(v) SA.FollowTarget = v end,
})

-- ── FOV section ──────────────────────────────────────────────
local sa_fov_sec = combat_left:section({
    name = "Silent Aim FOV",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

sa_fov_sec:toggle({
    name = "Show FOV",
    flag = "show_fov_enable",
    default = false,
    callback = function(v) SA.Fov.Enabled = v end,
})

sa_fov_sec:toggle({
    name = "Show Fill",
    flag = "show_fill_enable",
    default = false,
    callback = function(v) SA.Fov.Fill = v end,
})

sa_fov_sec:colorpicker({
    name = "FOV Color 1", flag = "fov_color",
    default = Color3.fromRGB(120, 81, 166),
    callback = function(c) SA.Fov.Color1 = c end,
})
sa_fov_sec:colorpicker({
    name = "FOV Color 2", flag = "fov_color2",
    default = Color3.fromRGB(255, 255, 255),
    callback = function(c) SA.Fov.Color2 = c end,
})
sa_fov_sec:colorpicker({
    name = "FOV Color 3", flag = "fov_color3",
    default = Color3.fromRGB(120, 81, 166),
    callback = function(c) SA.Fov.Color3 = c end,
})
sa_fov_sec:colorpicker({
    name = "Fill Color 1", flag = "fill_color_primary",
    default = Color3.fromRGB(120, 81, 166),
    callback = function(c) SA.Fov.FillColor1 = c end,
})
sa_fov_sec:colorpicker({
    name = "Fill Color 2", flag = "fill_color_secondary",
    default = Color3.fromRGB(255, 255, 255),
    callback = function(c) SA.Fov.FillColor2 = c end,
})
sa_fov_sec:colorpicker({
    name = "Fill Color 3", flag = "fill_color_tertiary",
    default = Color3.fromRGB(120, 81, 166),
    callback = function(c) SA.Fov.FillColor3 = c end,
})

sa_fov_sec:slider({
    name = "Radius", flag = "silent_aim_fov_radius",
    default = 180, min = 1, max = 600,
    callback = function(v) SA.Fov.Radius = v end,
})
sa_fov_sec:slider({
    name = "Lerp", flag = "silent_aim_fov_lerp",
    default = 1, min = 0.1, max = 1,
    callback = function(v) SA.Fov.Lerp = v end,
})
sa_fov_sec:slider({
    name = "Fill Transparency", flag = "silent_aim_fill_transparency",
    default = 0.6, min = 0, max = 1,
    callback = function(v) SA.Fov.FillTransparency = v end,
})
sa_fov_sec:slider({
    name = "FOV Transparency", flag = "silent_aim_fov_transparency",
    default = 0.2, min = 0, max = 1,
    callback = function(v) SA.Fov.Transparency = v end,
})
sa_fov_sec:slider({
    name = "Thickness", flag = "silent_aim_fov_thickness",
    default = 2, min = 1, max = 10,
    callback = function(v) SA.Fov.Thickness = v end,
})
sa_fov_sec:slider({
    name = "Rotation Speed", flag = "silent_aim_rotation_speed",
    default = 90, min = 0, max = 360,
    callback = function(v) SA.Fov.Speed = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  WEAPON OVERRIDES (per-gun settings)
-- ════════════════════════════════════════════════════════════════
local weapon_override_sec = combat_right:section({
    name = "Weapon Overrides",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

-- Populate the weapon list from ItemLibrary
local weapon_names = {}
do
    local ok, ItemLib = pcall(function()
        return require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ItemLibrary"))
    end)
    if ok and ItemLib and ItemLib.Items then
        for k, v in pairs(ItemLib.Items) do
            if type(v) == "table" and v.Type == "Gun" and k ~= "MISSING_WEAPON" then
                weapon_names[#weapon_names + 1] = k
            end
        end
        table.sort(weapon_names)
    end
end

local selected_weapon = weapon_names[1] or "None"

-- Ensure per-weapon record exists
local function ensureWeaponRecord(name)
    SA.Weapons[name] = SA.Weapons[name] or {
        Enabled = false,
        Radius = SA.Fov.Radius,
        HitChance = SA.HitChance,
        Part = SA.Part,
        ClosestPart = SA.ClosestPart,
    }
    return SA.Weapons[name]
end

weapon_override_sec:dropdown({
    name = "Weapon",
    flag = "silent_aim_weapon_select",
    default = selected_weapon,
    options = weapon_names,
    callback = function(v)
        selected_weapon = v
        local rec = ensureWeaponRecord(v)
        if weapon_override_sec._weaponControls then
            local c = weapon_override_sec._weaponControls
            if c.enable  then c.enable:Set(rec.Enabled)      end
            if c.radius  then c.radius:Set(rec.Radius)       end
            if c.chance  then c.chance:Set(rec.HitChance)    end
            if c.part    then c.part:Set(rec.Part)           end
            if c.closest then c.closest:Set(rec.ClosestPart) end
        end
    end,
})

weapon_override_sec._weaponControls = {}

weapon_override_sec._weaponControls.enable = weapon_override_sec:toggle({
    name = "Use weapon override",
    flag = "silent_aim_weapon_enabled",
    default = false,
    callback = function(v)
        local rec = ensureWeaponRecord(selected_weapon)
        rec.Enabled = v
    end,
})

weapon_override_sec._weaponControls.radius = weapon_override_sec:slider({
    name = "FOV Radius", flag = "silent_aim_weapon_radius",
    default = SA.Fov.Radius, min = 1, max = 600,
    callback = function(v)
        local rec = ensureWeaponRecord(selected_weapon)
        rec.Radius = v
    end,
})

weapon_override_sec._weaponControls.chance = weapon_override_sec:slider({
    name = "Hit Chance", flag = "silent_aim_weapon_chance",
    default = 100, min = 1, max = 100,
    callback = function(v)
        local rec = ensureWeaponRecord(selected_weapon)
        rec.HitChance = v
    end,
})

weapon_override_sec._weaponControls.part = weapon_override_sec:dropdown({
    name = "Hit Part", flag = "silent_aim_weapon_part",
    default = "Head", options = sa_hit_parts,
    callback = function(v)
        local rec = ensureWeaponRecord(selected_weapon)
        rec.Part = v
    end,
})

weapon_override_sec._weaponControls.closest = weapon_override_sec:toggle({
    name = "Closest Part", flag = "silent_aim_weapon_closest",
    default = false,
    callback = function(v)
        local rec = ensureWeaponRecord(selected_weapon)
        rec.ClosestPart = v
    end,
})

-- ═══════════════════════════════════════════════════════════════════
--  AIMBOT — UI
-- ═══════════════════════════════════════════════════════════════════
local AB = E.Combat.Aimbot

local ab_sec = combat_right:section({
    name = "Aimbot",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

ab_sec:toggle({
    name = "Enable Aimbot",
    flag = "aimbot_enable",
    default = false,
    callback = function(v) AB.Enabled = v end,
})

ab_sec:keybind({
    name = "Aimbot Keybind",
    flag = "aimbot_keybind",
    default = "None",
    mode = "Toggle",
    callback = function(v) AB.Enabled = v end,
})

ab_sec:toggle({
    name = "Closest Part",
    flag = "aimbot_closest_part_enable",
    default = false,
    callback = function(v) AB.ClosestPart = v end,
})

ab_sec:dropdown({
    name = "Hit Part",
    flag = "aimbot_hit_part",
    default = "Head",
    options = {
        "HumanoidRootPart", "HitboxBody", "HitboxHead", "PhysicalHitboxHead",
        "HitboxHeadSmall", "Head", "UpperTorso", "LowerTorso",
        "RightUpperArm", "RightLowerArm", "RightHand",
        "LeftUpperArm", "LeftLowerArm", "LeftHand",
        "RightUpperLeg", "RightLowerLeg", "RightFoot",
        "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    },
    callback = function(v) AB.Part = v end,
})

ab_sec:dropdown({
    name = "Checks",
    flag = "aimbot_checks",
    default = {},
    options = { "Riot Shield", "Katana", "Wall" },
    multi = true,
    callback = function(v)
        AB.Checks.Shield = v["Riot Shield"] == true
        AB.Checks.Katana = v["Katana"] == true
        AB.Checks.Wall   = v["Wall"] == true
    end,
})

ab_sec:dropdown({
    name = "On Scope",
    flag = "aimbot_on_scope",
    default = "None",
    options = { "None", "Disable", "Enable" },
    callback = function(v)
        if v == "None" then AB.OnScope = "" else AB.OnScope = v:lower() end
    end,
})

ab_sec:toggle({
    name = "Follow Gunpoint",
    flag = "aimbot_follow_gunpoint",
    default = false,
    callback = function(v) AB.FollowGunpoint = v end,
})

ab_sec:slider({
    name = "Smoothing",
    flag = "aimbot_smoothing",
    default = 0.1,
    min = 0, max = 1,
    callback = function(v) AB.Smoothness = v end,
})

ab_sec:slider({
    name = "Reaction Time (s)",
    flag = "aimbot_reaction_time",
    default = 0,
    min = 0, max = 1,
    callback = function(v) AB.ReactionTime = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  AIMBOT — FOV UI
-- ═══════════════════════════════════════════════════════════════════
local ab_fov_sec = combat_right:section({
    name = "Aimbot FOV",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

ab_fov_sec:toggle({
    name = "Show FOV",
    flag = "aimbot_show_fov_enable",
    default = false,
    callback = function(v) AB.Fov.Enabled = v end,
})

ab_fov_sec:toggle({
    name = "Show Fill",
    flag = "aimbot_show_fill_enable",
    default = false,
    callback = function(v) AB.Fov.Fill = v end,
})

ab_fov_sec:colorpicker({
    name = "FOV Color 1", flag = "aimbot_fov_color",
    default = AB.Fov.Color1,
    callback = function(c) AB.Fov.Color1 = c end,
})
ab_fov_sec:colorpicker({
    name = "FOV Color 2", flag = "aimbot_fov_color2",
    default = AB.Fov.Color2,
    callback = function(c) AB.Fov.Color2 = c end,
})
ab_fov_sec:colorpicker({
    name = "FOV Color 3", flag = "aimbot_fov_color3",
    default = AB.Fov.Color3,
    callback = function(c) AB.Fov.Color3 = c end,
})
ab_fov_sec:colorpicker({
    name = "Fill Color 1", flag = "aimbot_fill_color_primary",
    default = AB.Fov.FillColor1,
    callback = function(c) AB.Fov.FillColor1 = c end,
})
ab_fov_sec:colorpicker({
    name = "Fill Color 2", flag = "aimbot_fill_color_secondary",
    default = AB.Fov.FillColor2,
    callback = function(c) AB.Fov.FillColor2 = c end,
})
ab_fov_sec:colorpicker({
    name = "Fill Color 3", flag = "aimbot_fill_color_tertiary",
    default = AB.Fov.FillColor3,
    callback = function(c) AB.Fov.FillColor3 = c end,
})

ab_fov_sec:slider({
    name = "Radius", flag = "aimbot_fov_radius",
    default = 180, min = 1, max = 600,
    callback = function(v) AB.Fov.Radius = v end,
})
ab_fov_sec:slider({
    name = "Lerp", flag = "aimbot_fov_lerp",
    default = 1, min = 0.1, max = 1,
    callback = function(v) AB.Fov.Lerp = v end,
})
ab_fov_sec:slider({
    name = "Fill Transparency", flag = "aimbot_fill_transparency",
    default = 0.6, min = 0, max = 1,
    callback = function(v) AB.Fov.FillTransparency = v end,
})
ab_fov_sec:slider({
    name = "FOV Transparency", flag = "aimbot_fov_transparency",
    default = 0.2, min = 0, max = 1,
    callback = function(v) AB.Fov.Transparency = v end,
})
ab_fov_sec:slider({
    name = "Thickness", flag = "aimbot_fov_thickness",
    default = 2, min = 1, max = 10,
    callback = function(v) AB.Fov.Thickness = v end,
})
ab_fov_sec:slider({
    name = "Rotation Speed", flag = "aimbot_rotation_speed",
    default = 90, min = 0, max = 360,
    callback = function(v) AB.Fov.Speed = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  TRIGGERBOT — UI
-- ═══════════════════════════════════════════════════════════════════
local TB = E.Combat.Triggerbot

local tb_sec = combat_left:section({
    name = "Triggerbot",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

tb_sec:toggle({
    name = "Enable Triggerbot",
    flag = "triggerbot_enable",
    default = false,
    callback = function(v) TB.Enabled = v end,
})

tb_sec:keybind({
    name = "Triggerbot Keybind",
    flag = "triggerbot_keybind",
    default = "None",
    mode = "Toggle",
    callback = function(v) TB.Enabled = v end,
})

tb_sec:toggle({
    name = "Team Check",
    flag = "triggerbot_team_check",
    default = false,
    callback = function(v) TB.TeamCheck = v end,
})

tb_sec:toggle({
    name = "Disable On Scope",
    flag = "triggerbot_disable_on_scope",
    default = false,
    callback = function(v) TB.DisableOnScope = v end,
})

tb_sec:dropdown({
    name = "Whitelist Part",
    flag = "triggerbot_whitelist_part",
    default = {},
    options = { "HitboxBody", "HitboxHead" },
    multi = true,
    callback = function(v)
        local list = {}
        for k, on in pairs(v) do
            if on then table.insert(list, k) end
        end
        TB.Whitelist = list
    end,
})

tb_sec:dropdown({
    name = "Checks",
    flag = "triggerbot_checks",
    default = {},
    options = { "Riot Shield", "Katana", "Wall", "Sniper Scoped" },
    multi = true,
    callback = function(v)
        TB.Checks.Shield       = v["Riot Shield"] == true
        TB.Checks.Katana       = v["Katana"]      == true
        TB.Checks.Wall         = v["Wall"]        == true
        TB.Checks.SniperScoped = v["Sniper Scoped"] == true
    end,
})

tb_sec:slider({
    name = "Reaction Time (s)",
    flag = "triggerbot_reaction_time",
    default = 0.05, min = 0, max = 1,
    callback = function(v) TB.ReactionTime = v end,
})

tb_sec:slider({
    name = "Shoot Delay (s)",
    flag = "triggerbot_shoot_delay",
    default = 0.1, min = 0, max = 1,
    callback = function(v) TB.ShootDelay = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  RAGEBOT — UI
-- ═══════════════════════════════════════════════════════════════════
local RB = E.Combat.Ragebot

local rb_sec = combat_right:section({
    name = "Ragebot",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

rb_sec:toggle({
    name = "Enable Ragebot",
    flag = "ragebot_enabled",
    default = false,
    callback = function(v) RB.Enabled = v end,
})

rb_sec:keybind({
    name = "Ragebot Keybind",
    flag = "ragebot_keybind",
    default = "None",
    mode = "Toggle",
    callback = function(v) RB.Enabled = v end,
})

rb_sec:toggle({
    name = "Anti Knife",
    flag = "ragebot_anti_knife",
    default = false,
    callback = function(v) RB.AntiKnife = v end,
})

rb_sec:toggle({
    name = "Void Spam",
    flag = "ragebot_void_spam",
    default = false,
    callback = function(v) RB.VoidSpam.Enabled = v end,
})

rb_sec:slider({
    name = "Void Hide (s)",
    flag = "ragebot_void_hide_amount",
    default = 0.69, min = 0.05, max = 5,
    callback = function(v) RB.VoidSpam.HideSeconds = v end,
})

rb_sec:slider({
    name = "Void Attack (s)",
    flag = "ragebot_void_attack_seconds",
    default = 0.01, min = 0.01, max = 2,
    callback = function(v) RB.VoidSpam.AttackSeconds = v end,
})

rb_sec:toggle({
    name = "Swap Weapon On Empty",
    flag = "swap_weapon_on_empty_enable",
    default = false,
    callback = function(v) RB.SwapWeaponOnEmpty = v end,
})

rb_sec:dropdown({
    name = "Priority Weapon",
    flag = "priority_weapon_rage",
    default = "primary",
    options = { "primary", "secondary" },
    callback = function(v) RB.PriorityWeapon = v end,
})

rb_sec:dropdown({
    name = "Safe Method",
    flag = "safe_method_rage",
    default = "random pos",
    options = { "void", "random pos", "underground" },
    callback = function(v) RB.SafeMethod = v end,
})

rb_sec:slider({
    name = "Underground Depth",
    flag = "ragebot_underground_depth",
    default = 10, min = 5, max = 14,
    callback = function(v) RB.UndergroundDepth = v end,
})

rb_sec:dropdown({
    name = "Attack Mode",
    flag = "attack_mode_rage",
    default = "gun",
    options = { "gun", "melee" },
    callback = function(v) RB.AttackMode = v end,
})

rb_sec:dropdown({
    name = "Swap When",
    flag = "swap_when_rage",
    default = "ammo reserve",
    options = { "ammo", "ammo reserve" },
    callback = function(v) RB.SwapWhen = v end,
})

rb_sec:toggle({
    name = "Auto Crouch",
    flag = "auto_crouch_yea",
    default = false,
    callback = function(v) RB.AutoCrouch = v end,
})

rb_sec:toggle({
    name = "FFA Smart Targeting",
    flag = "ragebot_ffa_smart_targeting",
    default = false,
    callback = function(v) RB.FFASmartTargeting = v end,
})

rb_sec:dropdown({
    name = "FFA Priorities",
    flag = "ragebot_ffa_target_priority",
    default = { "lowest health" },
    options = { "lowest health", "closest proximity" },
    multi = true,
    callback = function(v) RB.FFATargetPriority = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  REPOSITION — UI
-- ═══════════════════════════════════════════════════════════════════
local REP = E.Combat.Reposition

local rep_sec = combat_right:section({
    name = "Reposition",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

rep_sec:toggle({
    name = "Enable Reposition",
    flag = "reposition_enabled",
    default = false,
    callback = function(v) REP.Enabled = v end,
})

rep_sec:keybind({
    name = "Reposition Keybind",
    flag = "reposition_keybind",
    default = "None",
    mode = "Toggle",
    callback = function(v) REP.Enabled = v end,
})

rep_sec:slider({
    name = "Offset",
    flag = "reposition_offset",
    default = -5, min = -10, max = 10,
    callback = function(v) REP.Offset = v end,
})

rep_sec:toggle({
    name = "Anti Reposition",
    flag = "anti_reposition_enabled",
    default = true,
    callback = function(v) REP.Anti = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  ANTI-AIM — UI
-- ═══════════════════════════════════════════════════════════════════
local AA = E.AntiAim

local aa_sec = combat_right:section({
    name = "Anti Aim",
    icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true,
    default = false,
})

aa_sec:toggle({
    name = "Enable Anti Aim",
    flag = "anti_aim_enable",
    default = false,
    callback = function(v) AA.Enabled = v end,
})

aa_sec:dropdown({
    name = "Pitch",
    flag = "anti_aim_pitch_mode",
    default = "down",
    options = { "down", "custom", "random" },
    callback = function(v) AA.PitchMode = v end,
})

aa_sec:slider({
    name = "Pitch Offset",
    flag = "anti_aim_pitch_offset",
    default = 0, min = -200, max = 250,
    callback = function(v) AA.PitchOffset = v end,
})

aa_sec:slider({
    name = "Pitch Angle",
    flag = "anti_aim_pitch_angle",
    default = 0, min = -250, max = 180,
    callback = function(v) AA.PitchAngle = v end,
})

aa_sec:dropdown({
    name = "Yaw",
    flag = "anti_aim_yaw_mode",
    default = "jitter",
    options = { "jitter", "spin", "random" },
    callback = function(v) AA.YawMode = v end,
})

aa_sec:slider({
    name = "Yaw Angle",
    flag = "anti_aim_yaw_angle",
    default = 180, min = -180, max = 180,
    callback = function(v) AA.YawAngle = v end,
})

-- ═══════════════════════════════════════════════════════════════════
--  ANTI-AIM WRAPPER (patches Utility:EncodeCameraRotation)
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local RSModules = game:GetService("ReplicatedStorage"):WaitForChild("Modules")
    local Utility   = require(RSModules:WaitForChild("Utility"))
    local origEncode = Utility.EncodeCameraRotation
    Utility.EncodeCameraRotation = function(self, rotation, ...)
        if not AA.Enabled then
            return origEncode(self, rotation, ...)
        end
        local cam = workspace.CurrentCamera
        if not cam then return origEncode(self, rotation, ...) end
        local look = cam.CFrame.LookVector
        local jitter = AA._jitter or false
        local yaw
        if AA.YawMode == "spin" then
            yaw = tick() * 6 % (math.pi * 2)
        elseif AA.YawMode == "random" then
            yaw = math.random() * math.pi * 2
        else
            jitter = not jitter
            AA._jitter = jitter
            yaw = math.rad(jitter and AA.YawAngle or -AA.YawAngle)
        end
        local pitch
        if AA.PitchMode == "down" then
            pitch = AA.PitchOffset or 0
            local n = math.floor((math.atan2(-look.X, -look.Z) + yaw) % (math.pi * 2) / (math.pi * 2) * 256) % 256
            return utf8.char(512 + pitch) .. utf8.char(n)
        end
        if AA.PitchMode == "custom" then pitch = math.rad(AA.PitchAngle)
        elseif AA.PitchMode == "random" then pitch = math.random() * math.pi * 2 end
        local n = math.floor((math.atan2(-look.X, -look.Z) + yaw) % (math.pi * 2) / (math.pi * 2) * 256) % 256
        local p = math.floor((pitch or 0) / (math.pi * 2) * 256) % 256
        return utf8.char(p) .. utf8.char(n)
    end
    print("[syrex.lol] Anti-Aim installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  MISC TAB — UI
-- ═══════════════════════════════════════════════════════════════════
local misc_left  = tab_misc:column({ size = 1 })
local misc_right = tab_misc:column({ size = 1 })

-- ── GUN MODS ─────────────────────────────────────────────────────
local gm_sec = misc_left:section({
    name = "Gun Mods", icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true, default = true,
})
local GM = E.Misc.GunMods

gm_sec:toggle({ name = "Rapid Fire", flag = "rapid_fire_enable", default = false,
    callback = function(v) GM.RapidFire = v end })
gm_sec:toggle({ name = "No Muzzle Flash", flag = "no_muzzleflash", default = false,
    callback = function(v) GM.NoMuzzleFlash = v end })
gm_sec:toggle({ name = "No Spread", flag = "no_spread_enable", default = false,
    callback = function(v) GM.NoSpread = v end })
gm_sec:toggle({ name = "No Recoil", flag = "no_recoil_enable", default = false,
    callback = function(v) GM.NoRecoil = v end })
gm_sec:toggle({ name = "Faster Reload", flag = "faster_reload_enable", default = false,
    callback = function(v) GM.FasterReload = v end })
gm_sec:toggle({ name = "Automatic Weapon", flag = "automatic_weapon", default = false,
    callback = function(v) GM.AutomaticWeapon = v end })
gm_sec:toggle({ name = "Remove Melee Cooldown", flag = "no_melee_cooldown", default = false,
    callback = function(v) GM.NoMeleeCooldown = v end })
gm_sec:toggle({ name = "Remove Warhorn Cooldown", flag = "no_warhorn_cooldown", default = false,
    callback = function(v) GM.NoWarhornCooldown = v end })
gm_sec:dropdown({ name = "Throwables", flag = "throwable", default = {},
    options = { "Explode On Throw", "No Fuse" }, multi = true,
    callback = function(v)
        GM.ExplodeOnThrow = v["Explode On Throw"] == true
        GM.NoFuse         = v["No Fuse"]         == true
    end })

-- ── MISC REMOVALS ────────────────────────────────────────────────
local mr_sec = misc_left:section({
    name = "Removals", icon = "http://www.roblox.com/asset/?id=6022668898",
    fading = true, default = false,
})

mr_sec:toggle({ name = "Anti Flash", flag = "anti_flash", default = false,
    callback = function(v) E.Misc.AntiFlash.Enabled = v end })
mr_sec:toggle({ name = "Anti Smoke", flag = "anti_smoke", default = false,
    callback = function(v) E.Misc.RemoveSmoke.Enabled = v end })
mr_sec:toggle({ name = "No Scope Overlay", flag = "no_scope_overlay", default = false,
    callback = function(v) E.Misc.NoScopeOverlay.Enabled = v end })
mr_sec:toggle({ name = "No Projectile Visuals", flag = "no_projectile_visuals", default = false,
    callback = function(v) E.Misc.NoProjectileVisuals.Enabled = v end })
mr_sec:toggle({ name = "Auto Reload", flag = "auto_reload", default = false,
    callback = function(v) E.Misc.AutoReload.Enabled = v end })
mr_sec:toggle({ name = "Auto Destroy Tripmine", flag = "auto_destroy_tripmine", default = false,
    callback = function(v) E.Misc.DestroyTripmine.Enabled = v end })

-- ── FFA SETTINGS ─────────────────────────────────────────────────
local ffa_sec = misc_left:section({
    name = "FFA Settings", icon = "http://www.roblox.com/asset/?id=6022668898",
    fading = true, default = false,
})
ffa_sec:toggle({ name = "Grab Drops", flag = "ffa_grab_drops", default = false,
    callback = function(v) E.Misc.FFASettings["Grab Drops"] = v end })
ffa_sec:toggle({ name = "Auto Respawn", flag = "auto_respawn_enable", default = false,
    callback = function(v) E.Misc.FFASettings["Auto Respawn"] = v end })

-- ── STRETCH ──────────────────────────────────────────────────────
local st_sec = misc_left:section({
    name = "Stretch Resolution", icon = "http://www.roblox.com/asset/?id=6022668898",
    fading = true, default = false,
})
st_sec:toggle({ name = "Enable", flag = "stretch_enable", default = false,
    callback = function(v) E.Misc.StretchResolution.Enabled = v end })
st_sec:slider({ name = "Amount", flag = "stretch_amount", default = 0.2, min = 0, max = 5,
    callback = function(v) E.Misc.StretchResolution.Amount = v end })

-- ── SPOOF ────────────────────────────────────────────────────────
local sp_sec = misc_right:section({
    name = "Spoof", icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true, default = true,
})
local SP = E.Misc.Spoof

sp_sec:toggle({ name = "Level", flag = "level_spoof_enable", default = false,
    callback = function(v)
        SP.Level.Enabled = v
        if not v then
            local _t = (getgenv().Elisium and getgenv().Elisium._origLevel) or nil
            pcall(function() lp:SetAttribute("Level", _t) end)
        end
    end })
sp_sec:input({ name = "Level Value", flag = "level_spoof_text", default = "9", numeric = true, finished = true,
    callback = function(v) SP.Level.Value = tonumber(v) or 0 end })

sp_sec:toggle({ name = "Win Streak", flag = "streak_spoof_enable", default = false,
    callback = function(v) SP.Streak.Enabled = v end })
sp_sec:input({ name = "Streak Value", flag = "streak_spoof_text", default = "99", numeric = true, finished = true,
    callback = function(v) SP.Streak.Value = tonumber(v) or 0 end })

sp_sec:toggle({ name = "Status", flag = "status_spoof_enable", default = false,
    callback = function(v) SP.Status.Enabled = v end })
sp_sec:dropdown({ name = "Status Type", flag = "status_spoof_type", default = "Prime",
    options = { "Contraband", "Prime" },
    callback = function(v) SP.Status.Value = v end })

sp_sec:toggle({ name = "Name (chat)", flag = "name_spoof_enable", default = false,
    callback = function(v) SP.Name.Enabled = v end })
sp_sec:input({ name = "Name Value", flag = "name_spoof_text", default = "elisium", finished = true,
    callback = function(v) SP.Name.Value = v end })

sp_sec:toggle({ name = "Username", flag = "username_spoof_enable", default = false,
    callback = function(v) SP.Username.Enabled = v; genv:RefreshUsernames() end })
sp_sec:input({ name = "Username Value", flag = "username_spoof_text", default = "elisium", finished = true,
    callback = function(v) SP.Username.Value = v; genv:RefreshUsernames() end })

-- ── MOD DETECTOR ─────────────────────────────────────────────────
local md_sec = misc_right:section({
    name = "Mod Detector", icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true, default = false,
})
local MD = E.Misc.ModDetector
md_sec:toggle({ name = "Enable", flag = "mod_detector_enabled", default = false,
    callback = function(v) MD.Enabled = v end })
md_sec:colorpicker({ name = "Notify Color", flag = "mod_detector_color", default = MD.Color,
    callback = function(c) MD.Color = c end })
md_sec:dropdown({ name = "Moderator Actions", flag = "mod_detector_moderator_actions", default = { "Notify" },
    options = { "Notify", "Kick", "To Lobby" }, multi = true,
    callback = function(v)
        MD.Moderators.Notify    = v["Notify"]    == true
        MD.Moderators.Kick      = v["Kick"]      == true
        MD.Moderators["To Lobby"] = v["To Lobby"] == true
    end })
md_sec:dropdown({ name = "Mod Friend Actions", flag = "mod_detector_friend_actions", default = { "Notify" },
    options = { "Notify", "Kick", "To Lobby" }, multi = true,
    callback = function(v)
        MD.ModFriends.Notify    = v["Notify"]    == true
        MD.ModFriends.Kick      = v["Kick"]      == true
        MD.ModFriends["To Lobby"] = v["To Lobby"] == true
    end })

-- ── HIT SOUND ────────────────────────────────────────────────────
local hs_sec = misc_right:section({
    name = "Hit Sound", icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true, default = false,
})
local HS = E.HitSound
hs_sec:toggle({ name = "Enable", flag = "hit_sound_enable", default = false,
    callback = function(v) HS.Enabled = v end })
hs_sec:toggle({ name = "Remove Default", flag = "hit_sound_remove_default", default = false,
    callback = function(v) HS["Remove Default"] = v end })
hs_sec:input({ name = "Custom Asset / URL", flag = "hit_sound_custom", default = "", finished = true,
    callback = function(v) HS["Custom Sound"] = v end })
hs_sec:slider({ name = "Volume", flag = "hit_sound_volume", default = 1, min = 0, max = 5,
    callback = function(v) HS.Volume = v end })
hs_sec:slider({ name = "Pitch", flag = "hit_sound_pitch", default = 1, min = 0.5, max = 3,
    callback = function(v) HS.Pitch = v end })

-- ── HIT NOTIFY ───────────────────────────────────────────────────
local hn_sec = misc_right:section({
    name = "Hit Notify", icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true, default = false,
})
local HN = E.HitNotify
hn_sec:toggle({ name = "Enable", flag = "hit_notify_enable", default = false,
    callback = function(v) HN.Enabled = v end })
hn_sec:input({ name = "Message", flag = "hit_notify_message", default = "{target} | {damage} | {hitpart}", finished = true,
    callback = function(v) HN.Message = v end })
hn_sec:slider({ name = "Duration", flag = "hit_notify_duration", default = 1, min = 0.1, max = 5,
    callback = function(v) HN.Duration = v end })

-- ── HITMARKER / DAMAGE NUMBERS / HIT OVERLAY ───────────────────
local hm_sec = misc_right:section({
    name = "Damage Feedback", icon = "http://www.roblox.com/asset/?id=6031071355",
    fading = true, default = false,
})

local HMK = E.Visuals["Hitmarker"]
hm_sec:toggle({ name = "Custom Hitmarker", flag = "hitmarker_enabled", default = false,
    callback = function(v) HMK.Enabled = v end })
hm_sec:colorpicker({ name = "Hitmarker Color", flag = "hitmarker_color", default = HMK.Color,
    callback = function(c) HMK.Color = c end })
hm_sec:colorpicker({ name = "Headshot Color", flag = "hitmarker_headshot_color", default = HMK["Headshot Color"],
    callback = function(c) HMK["Headshot Color"] = c end })

local HOV = E.Visuals["Hit Overlay"]
hm_sec:toggle({ name = "Hit Overlay", flag = "hit_overlay_enabled", default = false,
    callback = function(v) HOV.Enabled = v end })
hm_sec:colorpicker({ name = "Overlay Color", flag = "hit_overlay_color", default = HOV.Color,
    callback = function(c) HOV.Color = c end })
hm_sec:colorpicker({ name = "Overlay Headshot Color", flag = "hit_overlay_headshot_color", default = HOV["Headshot Color"],
    callback = function(c) HOV["Headshot Color"] = c end })
hm_sec:slider({ name = "Overlay Transparency", flag = "hit_overlay_transparency", default = 0.55, min = 0, max = 1,
    callback = function(v) HOV.Transparency = v end })
hm_sec:slider({ name = "Overlay Duration", flag = "hit_overlay_duration", default = 0.35, min = 0.05, max = 2,
    callback = function(v) HOV.Duration = v end })

local IDN = E.Visuals["Ingame Damage Numbers"]
hm_sec:toggle({ name = "Recolor Ingame Damage", flag = "ingame_damage_numbers", default = false,
    callback = function(v) IDN.Enabled = v end })
hm_sec:colorpicker({ name = "Ingame DMG Color", flag = "ingame_damage_color", default = IDN.Color,
    callback = function(c) IDN.Color = c end })
hm_sec:colorpicker({ name = "Ingame DMG Headshot", flag = "ingame_damage_headshot_color", default = IDN["Headshot Color"],
    callback = function(c) IDN["Headshot Color"] = c end })

-- ═══════════════════════════════════════════════════════════════════
--  CHARACTER TAB — UI
-- ═══════════════════════════════════════════════════════════════════
local char_left  = tab_character:column({ size = 1 })
local char_right = tab_character:column({ size = 1 })

local mv_sec = char_left:section({
    name = "Movement", icon = "http://www.roblox.com/asset/?id=6031068421",
    fading = true, default = true,
})
local CH = E.Character

mv_sec:toggle({ name = "WalkSpeed Multiplier", flag = "walkspeed_enabled", default = false,
    callback = function(v) CH["WalkSpeed Multiplier"].Enabled = v end })
mv_sec:slider({ name = "WalkSpeed", flag = "walkspeed_speed", default = 30, min = 16, max = 200,
    callback = function(v) CH["WalkSpeed Multiplier"].Speed = v end })

mv_sec:toggle({ name = "JumpPower Multiplier", flag = "jumppower_enabled", default = false,
    callback = function(v) CH["JumpPower Multiplier"].Enabled = v end })
mv_sec:slider({ name = "JumpPower", flag = "jumppower_speed", default = 30, min = 10, max = 200,
    callback = function(v) CH["JumpPower Multiplier"].Speed = v end })

mv_sec:toggle({ name = "Infinite Jump", flag = "infinite_jump_enabled", default = false,
    callback = function(v) CH["Infinite Jump"] = v end })

mv_sec:toggle({ name = "Noclip", flag = "noclip_enabled", default = false,
    callback = function(v) CH.Noclip = v end })
mv_sec:keybind({ name = "Noclip Keybind", flag = "noclip_keybind", default = "None", mode = "Toggle",
    callback = function(v) CH.Noclip = v end })

mv_sec:toggle({ name = "Fly", flag = "fly_enabled", default = false,
    callback = function(v) CH.Fly.Enabled = v end })
mv_sec:keybind({ name = "Fly Keybind", flag = "fly_keybind", default = "None", mode = "Toggle",
    callback = function(v) CH.Fly.Enabled = v end })
mv_sec:slider({ name = "Fly Speed", flag = "fly_speed", default = 100, min = 10, max = 500,
    callback = function(v) CH.Fly.Speed = v end })

mv_sec:toggle({ name = "Thirdperson", flag = "thirdperson_enabled", default = false,
    callback = function(v) CH.Thirdperson.Enabled = v end })
mv_sec:keybind({ name = "Thirdperson Keybind", flag = "thirdperson_keybind", default = "None", mode = "Toggle",
    callback = function(v) CH.Thirdperson.Enabled = v end })
mv_sec:toggle({ name = "Thirdperson Unlock Mouse", flag = "thirdperson_unlock_mouse", default = false,
    callback = function(v) CH.Thirdperson["Unlock Mouse"] = v end })

mv_sec:toggle({ name = "Spinbot", flag = "spinbot_enabled", default = false,
    callback = function(v) CH.Spinbot.Enabled = v end })
mv_sec:keybind({ name = "Spinbot Keybind", flag = "spinbot_keybind", default = "None", mode = "Toggle",
    callback = function(v) CH.Spinbot.Enabled = v end })
mv_sec:slider({ name = "Spinbot Speed", flag = "spinbot_speed", default = 10, min = 1, max = 90,
    callback = function(v) CH.Spinbot.Speed = v end })

-- ── SLIDING / ANIMATION / AURA ───────────────────────────────────
local an_sec = char_right:section({
    name = "Animation & Aura", icon = "http://www.roblox.com/asset/?id=6031068421",
    fading = true, default = false,
})

an_sec:toggle({ name = "Slide Boost", flag = "slide_boost_enabled", default = false,
    callback = function(v) CH.Sliding["Slide Boost"].Enabled = v end })
an_sec:slider({ name = "Slide Boost Speed", flag = "slide_boost_speed", default = 100, min = 100, max = 300,
    callback = function(v) CH.Sliding["Slide Boost"].Speed = v end })
an_sec:toggle({ name = "Auto Slide", flag = "auto_slide_enable", default = false,
    callback = function(v) CH.Sliding.AutoSlide = v end })

an_sec:toggle({ name = "Animation Player", flag = "animationplayer_enabled", default = false,
    callback = function(v) CH.AnimationPlayer.Enabled = v end })
an_sec:dropdown({ name = "Animation", flag = "animationplayer_selected", default = "dance break",
    options = {
        "bodybuilder","crawling in a circle","dolphin dance","dance break","french confidence",
        "floss","frosty flair","full wiggle","ghost floating","gun","gangnam style","hip bounce",
        "hype dance","kicking feet","line dance","lay floating","lets drive","long legs","rock out",
        "samba","still standing","spiral","solar system","twirl","take me under","the worm",
        "take the l","zesty sturdy",
    },
    callback = function(v) CH.AnimationPlayer.Selected = v end })
an_sec:slider({ name = "Animation Speed", flag = "animationplayer_speed", default = 1, min = 0.1, max = 5,
    callback = function(v) CH.AnimationPlayer.Speed = v end })

an_sec:toggle({ name = "Character Aura", flag = "character_aura_enabled", default = false,
    callback = function(v) CH.Aura.Enabled = v; genv:RefreshAura() end })
an_sec:dropdown({ name = "Aura", flag = "character_aura_selected", default = { "sakura" },
    options = { "starlight","heavenly","sakura","angel","wind","flow","star" }, multi = true,
    callback = function(v) CH.Aura.Selected = v; genv:RefreshAura() end })
an_sec:toggle({ name = "Aura Color Override", flag = "character_aura_color_override", default = false,
    callback = function(v) CH.Aura["Color Override"].Enabled = v; genv:RefreshAura() end })
an_sec:colorpicker({ name = "Aura Color", flag = "character_aura_color", default = Color3.fromRGB(255, 151, 226),
    callback = function(c) CH.Aura["Color Override"].Color = c; genv:RefreshAura() end })

an_sec:toggle({ name = "Gaming Chair", flag = "gaming_chair_enabled", default = false,
    callback = function(v) CH["GamingChair"].Enabled = v end })
an_sec:slider({ name = "Chair Height", flag = "gaming_chair_height", default = 24, min = 5, max = 40,
    callback = function(v) CH["GamingChair"].Height = v end })
an_sec:slider({ name = "Chair Scale", flag = "gaming_chair_scale", default = 1, min = 0.5, max = 2,
    callback = function(v) CH["GamingChair"].Scale = v end })
an_sec:colorpicker({ name = "Chair Color", flag = "gaming_chair_color", default = Color3.fromRGB(180, 180, 255),
    callback = function(c) CH["GamingChair"].Color = c end })

-- ═══════════════════════════════════════════════════════════════════
--  TRIGGERBOT — RUNTIME
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players           = game:GetService("Players")
    local Workspace         = game:GetService("Workspace")
    local RunService        = game:GetService("RunService")
    local lp                = Players.LocalPlayer

    local PlayerScripts = lp:WaitForChild("PlayerScripts")
    local FighterController = require(PlayerScripts.Controllers.FighterController)

    local TB = getgenv().Elisium.Combat.Triggerbot

    local viewModels = Workspace:FindFirstChild("ViewModels")
    local function hasShield(player)
        if not viewModels then return false end
        return viewModels:FindFirstChild(player.Name .. " - Riot Shield - Riot Shield") ~= nil
    end

    local deflecting = {}
    pcall(function()
        local Katana = require(PlayerScripts.Modules.Items.Katana)
        if Katana and Katana._StartDeflecting then
            local orig = Katana._StartDeflecting
            Katana._StartDeflecting = function(self, ...)
                local cf = self.ClientFighter and self.ClientFighter.Player
                if cf then
                    deflecting[cf] = true
                    task.delay(self.Info and self.Info.DeflectDuration or 0.1, function()
                        deflecting[cf] = nil
                    end)
                end
                return orig(self, ...)
            end
        end
    end)

    local function passesWall(part)
        local cam = Workspace.CurrentCamera
        if not cam then return false end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { lp.Character, part.Parent }
        local hit = Workspace:Raycast(cam.CFrame.Position, part.Position - cam.CFrame.Position, params)
        return hit == nil
    end

    local function currentAmmo(item)
        if not item then return 0 end
        return item:Get("Ammo") or 0
    end

    local function isScoped()
        local lf = FighterController.LocalFighter
        local item = lf and lf.EquippedItem
        return item ~= nil and item:Get("IsAiming") == true
    end

    local function isSniper()
        local lf = FighterController.LocalFighter
        local item = lf and lf.EquippedItem
        if not item then return false end
        return item.Name == "Sniper" or (item.Info and item.Info.Class == "Sniper")
    end

    local function hitEnemy()
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { lp.Character }
        local hit = Workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * 2000, params)
        if not hit then return nil end

        local part = hit.Instance
        local model = part:FindFirstAncestorOfClass("Model")
        if not model then return nil end
        local plr = Players:GetPlayerFromCharacter(model)
        if not plr or plr == lp then return nil end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return nil end

        if TB.TeamCheck then
            local tA, tB = lp:GetAttribute("TeamID"), plr:GetAttribute("TeamID")
            if tA and tB and tA == tB then return nil end
        end

        if #TB.Whitelist > 0 then
            local ok = false
            for _, name in ipairs(TB.Whitelist) do
                if part.Name == name then ok = true; break end
            end
            if not ok then return nil end
        end

        if TB.Checks.Shield and hasShield(plr) then return nil end
        if TB.Checks.Katana and deflecting[plr] then return nil end
        if TB.Checks.Wall and not passesWall(part) then return nil end

        return plr, part
    end

    local state = { onTargetSince = 0, lastShot = 0 }

    RunService.Heartbeat:Connect(function()
        if not TB.Enabled then
            state.onTargetSince = 0
            return
        end

        local lf = FighterController.LocalFighter
        local item = lf and lf.EquippedItem
        if not item then return end
        if currentAmmo(item) <= 0 then return end
        if TB.DisableOnScope and isScoped() then return end
        if TB.Checks.SniperScoped and isSniper() and isScoped() then return end

        local onTarget = hitEnemy() ~= nil
        local now = tick()

        if not onTarget then
            state.onTargetSince = 0
            return
        end

        if state.onTargetSince == 0 then
            state.onTargetSince = now
        end
        if (now - state.onTargetSince) < TB.ReactionTime then return end
        if (now - state.lastShot) < TB.ShootDelay then return end

        state.lastShot = now
        local id = getthreadidentity()
        setthreadidentity(2)
        pcall(item.Input, item, "StartShooting")
        setthreadidentity(id)
    end)

    print("[syrex.lol] Triggerbot installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  SILENT AIM — RUNTIME
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players           = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace         = game:GetService("Workspace")
    local RunService        = game:GetService("RunService")
    local lp                = Players.LocalPlayer

    local PlayerScripts = lp:WaitForChild("PlayerScripts")
    local Modules       = PlayerScripts:WaitForChild("Modules")
    local Gun           = require(Modules.ItemTypes.Gun)

    local RSModules = ReplicatedStorage:WaitForChild("Modules")
    local Utility   = require(RSModules:WaitForChild("Utility"))

    local FighterController = require(PlayerScripts.Controllers.FighterController)

    local SA = getgenv().Elisium.Combat.SilentAim

    local function getActive()
        local fighter = FighterController.LocalFighter
        local item    = fighter and fighter.EquippedItem
        local name    = item and item.Name
        local override = name and SA.Weapons[name]
        if override and override.Enabled then
            return {
                Enabled      = SA.Enabled,
                Radius       = override.Radius,
                HitChance    = override.HitChance,
                Part         = override.Part,
                ClosestPart  = override.ClosestPart,
                Checks       = SA.Checks,
                FollowGunpoint = SA.FollowGunpoint,
                Fov          = SA.Fov,
                WeaponOverride = true,
            }
        end
        return SA
    end

    local function passesWall(part)
        local cam = Workspace.CurrentCamera
        if not cam then return false end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { lp.Character, part.Parent }
        local hit = Workspace:Raycast(cam.CFrame.Position, part.Position - cam.CFrame.Position, params)
        return hit == nil
    end

    local deflecting = {}
    pcall(function()
        local Katana = require(PlayerScripts.Modules.Items.Katana)
        if Katana and Katana._StartDeflecting then
            local orig = Katana._StartDeflecting
            Katana._StartDeflecting = function(self, ...)
                local cf = self.ClientFighter and self.ClientFighter.Player
                if cf then
                    deflecting[cf] = true
                    task.delay(self.Info and self.Info.DeflectDuration or 0.1, function()
                        deflecting[cf] = nil
                    end)
                end
                return orig(self, ...)
            end
        end
    end)

    local viewModels = Workspace:FindFirstChild("ViewModels")
    local function hasShield(player)
        if not viewModels then return false end
        return viewModels:FindFirstChild(player.Name .. " - Riot Shield - Riot Shield") ~= nil
    end

    local function closestPartOn(character, anchor)
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local best, bestDist = nil, math.huge
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                local screen, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local d = (anchor - Vector2.new(screen.X, screen.Y)).Magnitude
                    if d < bestDist then bestDist, best = d, part end
                end
            end
        end
        return best
    end

    local function getClosest(cfg)
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local anchor = cfg.FollowGunpoint and Vector2.zero or (cam.ViewportSize * 0.5)
        local envID  = lp:GetAttribute("EnvironmentID")
        local teamID = lp:GetAttribute("TeamID")
        local bestPart, bestDist = nil, math.huge

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health > 0 then
                    local pEnv, pTeam = plr:GetAttribute("EnvironmentID"), plr:GetAttribute("TeamID")
                    local envOk  = not (envID and pEnv and pEnv ~= envID)
                    local teamOk = not (teamID and pTeam == teamID)
                    if envOk and teamOk then
                        if cfg.Checks.Katana and deflecting[plr] then
                            -- skip
                        else
                            local part = cfg.ClosestPart
                                and closestPartOn(plr.Character, anchor)
                                or  plr.Character:FindFirstChild(cfg.Part)

                            if part then
                                local shieldFail = cfg.Checks.Shield and hasShield(plr)
                                local wallFail   = cfg.Checks.Wall and not passesWall(part)
                                if not shieldFail and not wallFail then
                                    local sp, onScreen = cam:WorldToViewportPoint(part.Position)
                                    if onScreen then
                                        local d = (anchor - Vector2.new(sp.X, sp.Y)).Magnitude
                                        if d < bestDist and d <= cfg.Fov.Radius then
                                            bestDist, bestPart = d, part
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return bestPart
    end

    -- ── FOV renderer ──
    local fovGui = Instance.new("ScreenGui")
    fovGui.Name = "Elisium_SilentAimFov"
    fovGui.IgnoreGuiInset = true
    fovGui.ResetOnSpawn = false
    fovGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() fovGui.Parent = gethui() end)
    if not fovGui.Parent then fovGui.Parent = lp:WaitForChild("PlayerGui") end

    local fovFrame = Instance.new("Frame")
    fovFrame.Name = "FOV"
    fovFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    fovFrame.BackgroundTransparency = 1
    fovFrame.BorderSizePixel = 0
    fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    fovFrame.Size = UDim2.fromOffset(360, 360)
    fovFrame.Visible = false
    fovFrame.Parent = fovGui

    local fovCorner = Instance.new("UICorner")
    fovCorner.CornerRadius = UDim.new(1, 0)
    fovCorner.Parent = fovFrame

    local fovFill = Instance.new("Frame")
    fovFill.Name = "Fill"
    fovFill.BackgroundColor3 = Color3.fromRGB(120, 81, 166)
    fovFill.BorderSizePixel = 0
    fovFill.Size = UDim2.fromScale(1, 1)
    fovFill.BackgroundTransparency = 0.4
    fovFill.Parent = fovFrame

    local fovFillCorner = Instance.new("UICorner")
    fovFillCorner.CornerRadius = UDim.new(1, 0)
    fovFillCorner.Parent = fovFill

    local fovFillGradient = Instance.new("UIGradient")
    fovFillGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(120, 81, 166)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(120, 81, 166)),
    })
    fovFillGradient.Parent = fovFill

    local fovStroke = Instance.new("UIStroke")
    fovStroke.Color = Color3.fromRGB(120, 81, 166)
    fovStroke.Thickness = 2
    fovStroke.Transparency = 0.2
    fovStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    fovStroke.Parent = fovFrame

    local fovStrokeGradient = Instance.new("UIGradient")
    fovStrokeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(120, 81, 166)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(120, 81, 166)),
    })
    fovStrokeGradient.Parent = fovStroke

    local fovState = { position = Vector2.zero, rotation = 0 }

    local function muzzle()
        local fighter = FighterController.LocalFighter
        local item    = fighter and fighter.EquippedItem
        local vm      = item and item.ViewModel
        local model   = vm and vm.ItemModel
        if not model then return nil end
        for _, att in ipairs(model:QueryDescendants("Attachment")) do
            if att.Name == "_muzzle" then
                local sp = Workspace.CurrentCamera:WorldToViewportPoint(att.WorldPosition)
                return Vector2.new(sp.X, sp.Y)
            end
        end
        return nil
    end

    RunService.RenderStepped:Connect(function(dt)
        local cfg = getActive()
        if not SA.Enabled or not cfg.Fov.Enabled then
            fovFrame.Visible = false
            return
        end
        fovFrame.Visible = true

        local cam = Workspace.CurrentCamera
        if not cam then return end

        local target = SA.FollowGunpoint and (muzzle() or (cam.ViewportSize * 0.5)) or (cam.ViewportSize * 0.5)

        local lerp = math.clamp(SA.Fov.Lerp, 0.1, 1)
        fovState.position = fovState.position:Lerp(target, math.min(lerp * dt * 60, 1))
        fovFrame.Position = UDim2.fromOffset(fovState.position.X, fovState.position.Y)

        local radius = SA.Fov.Radius
        fovFrame.Size = UDim2.fromOffset(radius * 2, radius * 2)

        local col1, col2, col3 = SA.Fov.Color1, SA.Fov.Color2, SA.Fov.Color3
        local fill1, fill2, fill3 = SA.Fov.FillColor1, SA.Fov.FillColor2, SA.Fov.FillColor3

        local seq = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, col1),
            ColorSequenceKeypoint.new(0.50, col2),
            ColorSequenceKeypoint.new(1.00, col3),
        })
        fovStrokeGradient.Color = seq

        local fillSeq = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, fill1),
            ColorSequenceKeypoint.new(0.50, fill2),
            ColorSequenceKeypoint.new(1.00, fill3),
        })
        fovFillGradient.Color = fillSeq

        fovState.rotation = (fovState.rotation + SA.Fov.Speed * dt) % 360
        fovStrokeGradient.Rotation = fovState.rotation
        fovFillGradient.Rotation = fovState.rotation

        fovStroke.Thickness = SA.Fov.Thickness
        fovStroke.Transparency = SA.Fov.Transparency

        if SA.Fov.Fill then
            fovFill.Visible = true
            fovFill.BackgroundTransparency = 1 - (1 - SA.Fov.FillTransparency)
        else
            fovFill.Visible = false
        end
    end)

    -- ── Hook Gun.StartShooting ──
    local origStartShooting = Gun.StartShooting
    Gun.StartShooting = function(self, ...)
        local args = table.pack(origStartShooting(self, ...))

        if not self.ClientFighter or not self.ClientFighter.IsLocalPlayer then
            return table.unpack(args, 1, args.n)
        end
        if not SA.Enabled then
            return table.unpack(args, 1, args.n)
        end
        if args[1] ~= "StartShooting" or type(args[3]) ~= "table" then
            return table.unpack(args, 1, args.n)
        end

        local cfg = getActive()

        if math.random(1, 100) > cfg.HitChance then
            return table.unpack(args, 1, args.n)
        end

        local target = getClosest(cfg)
        if not target then
            return table.unpack(args, 1, args.n)
        end

        local cam = Workspace.CurrentCamera
        if not cam then return table.unpack(args, 1, args.n) end

        local origin = cam.CFrame.Position
        local dir    = target.Position - origin
        if dir.Magnitude < 1e-4 then
            return table.unpack(args, 1, args.n)
        end

        local encodedLook   = Utility:EncodeCFrame(CFrame.lookAt(origin, target.Position))
        local encodedOffset = Utility:EncodeCFrame(CFrame.new(0, 0.6, 0))

        local payload = args[3]
        payload[utf8.char(0)] = encodedLook
        payload[utf8.char(1)] = encodedLook
        payload[utf8.char(2)] = target
        payload[utf8.char(3)] = encodedOffset

        return table.unpack(args, 1, args.n)
    end

    getgenv().Elisium_SilentAim_Installed = true
    print("[syrex.lol] Silent Aim installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  AIMBOT — RUNTIME
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players           = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace         = game:GetService("Workspace")
    local RunService        = game:GetService("RunService")
    local lp                = Players.LocalPlayer

    local PlayerScripts = lp:WaitForChild("PlayerScripts")
    local Utility       = require(ReplicatedStorage.Modules.Utility)
    local FighterController = require(PlayerScripts.Controllers.FighterController)

    local AB = getgenv().Elisium.Combat.Aimbot

    local viewModels = Workspace:FindFirstChild("ViewModels")
    local function hasShield(player)
        if not viewModels then return false end
        return viewModels:FindFirstChild(player.Name .. " - Riot Shield - Riot Shield") ~= nil
    end

    -- Katana deflect state
    local deflecting = {}
    pcall(function()
        local Katana = require(PlayerScripts.Modules.Items.Katana)
        if Katana and Katana._StartDeflecting then
            local orig = Katana._StartDeflecting
            Katana._StartDeflecting = function(self, ...)
                local cf = self.ClientFighter and self.ClientFighter.Player
                if cf then
                    deflecting[cf] = true
                    task.delay(self.Info and self.Info.DeflectDuration or 0.1, function()
                        deflecting[cf] = nil
                    end)
                end
                return orig(self, ...)
            end
        end
    end)

    local function passesWall(part)
        local cam = Workspace.CurrentCamera
        if not cam then return false end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { lp.Character, part.Parent }
        local hit = Workspace:Raycast(cam.CFrame.Position, part.Position - cam.CFrame.Position, params)
        return hit == nil
    end

    local function closestPartOn(character, anchor)
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local best, bestDist = nil, math.huge
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                local screen, onScreen = cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local d = (anchor - Vector2.new(screen.X, screen.Y)).Magnitude
                    if d < bestDist then bestDist, best = d, part end
                end
            end
        end
        return best
    end

    local function getClosest(cfg)
        local cam = Workspace.CurrentCamera
        if not cam then return nil end
        local anchor = cfg.FollowGunpoint and Vector2.zero or (cam.ViewportSize * 0.5)
        local envID  = lp:GetAttribute("EnvironmentID")
        local teamID = lp:GetAttribute("TeamID")
        local bestPart, bestDist = nil, math.huge

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health > 0 then
                    local pEnv, pTeam = plr:GetAttribute("EnvironmentID"), plr:GetAttribute("TeamID")
                    local envOk  = not (envID and pEnv and pEnv ~= envID)
                    local teamOk = not (teamID and pTeam == teamID)
                    if envOk and teamOk then
                        if not (cfg.Checks.Katana and deflecting[plr]) then
                            local part = cfg.ClosestPart
                                and closestPartOn(plr.Character, anchor)
                                or  plr.Character:FindFirstChild(cfg.Part)
                            if part then
                                local shieldFail = cfg.Checks.Shield and hasShield(plr)
                                local wallFail   = cfg.Checks.Wall and not passesWall(part)
                                if not shieldFail and not wallFail then
                                    local sp, onScreen = cam:WorldToViewportPoint(part.Position)
                                    if onScreen then
                                        local d = (anchor - Vector2.new(sp.X, sp.Y)).Magnitude
                                        if d < bestDist and d <= cfg.Fov.Radius then
                                            bestDist, bestPart = d, part
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return bestPart
    end

    local function isScoped()
        local fighter = FighterController.LocalFighter
        local item    = fighter and fighter.EquippedItem
        return item ~= nil and item:Get("IsAiming") == true
    end

    local function muzzle()
        local fighter = FighterController.LocalFighter
        local item    = fighter and fighter.EquippedItem
        local vm      = item and item.ViewModel
        local model   = vm and vm.ItemModel
        if not model then return nil end
        for _, att in ipairs(model:QueryDescendants("Attachment")) do
            if att.Name == "_muzzle" then
                local sp = Workspace.CurrentCamera:WorldToViewportPoint(att.WorldPosition)
                return Vector2.new(sp.X, sp.Y)
            end
        end
        return nil
    end

    -- ══════════════════════════════════════════════════════════
    --  Aimbot FOV renderer
    -- ══════════════════════════════════════════════════════════
    local fovGui = Instance.new("ScreenGui")
    fovGui.Name = "Elisium_AimbotFov"
    fovGui.IgnoreGuiInset = true
    fovGui.ResetOnSpawn = false
    fovGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() fovGui.Parent = gethui() end)
    if not fovGui.Parent then fovGui.Parent = lp:WaitForChild("PlayerGui") end

    local fovFrame = Instance.new("Frame")
    fovFrame.Name = "FOV"
    fovFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    fovFrame.BackgroundTransparency = 1
    fovFrame.BorderSizePixel = 0
    fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    fovFrame.Size = UDim2.fromOffset(360, 360)
    fovFrame.Visible = false
    fovFrame.Parent = fovGui

    local fovCorner = Instance.new("UICorner")
    fovCorner.CornerRadius = UDim.new(1, 0)
    fovCorner.Parent = fovFrame

    local fovFill = Instance.new("Frame")
    fovFill.Name = "Fill"
    fovFill.BackgroundColor3 = Color3.fromRGB(120, 81, 166)
    fovFill.BorderSizePixel = 0
    fovFill.Size = UDim2.fromScale(1, 1)
    fovFill.BackgroundTransparency = 0.4
    fovFill.Parent = fovFrame

    local fovFillCorner = Instance.new("UICorner")
    fovFillCorner.CornerRadius = UDim.new(1, 0)
    fovFillCorner.Parent = fovFill

    local fovFillGradient = Instance.new("UIGradient")
    fovFillGradient.Parent = fovFill

    local fovStroke = Instance.new("UIStroke")
    fovStroke.Color = Color3.fromRGB(120, 81, 166)
    fovStroke.Thickness = 2
    fovStroke.Transparency = 0.2
    fovStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    fovStroke.Parent = fovFrame

    local fovStrokeGradient = Instance.new("UIGradient")
    fovStrokeGradient.Parent = fovStroke

    local fovState = { position = Vector2.zero, rotation = 0 }

    RunService.RenderStepped:Connect(function(dt)
        if not AB.Enabled or not AB.Fov.Enabled then
            fovFrame.Visible = false
            return
        end
        fovFrame.Visible = true
        local cam = Workspace.CurrentCamera
        if not cam then return end

        local anchor = AB.FollowGunpoint and (muzzle() or (cam.ViewportSize * 0.5)) or (cam.ViewportSize * 0.5)

        local lerp = math.clamp(AB.Fov.Lerp, 0.1, 1)
        fovState.position = fovState.position:Lerp(anchor, math.min(lerp * dt * 60, 1))
        fovFrame.Position = UDim2.fromOffset(fovState.position.X, fovState.position.Y)
        fovFrame.Size     = UDim2.fromOffset(AB.Fov.Radius * 2, AB.Fov.Radius * 2)

        fovStrokeGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, AB.Fov.Color1),
            ColorSequenceKeypoint.new(0.50, AB.Fov.Color2),
            ColorSequenceKeypoint.new(1.00, AB.Fov.Color3),
        })
        fovFillGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, AB.Fov.FillColor1),
            ColorSequenceKeypoint.new(0.50, AB.Fov.FillColor2),
            ColorSequenceKeypoint.new(1.00, AB.Fov.FillColor3),
        })

        fovState.rotation = (fovState.rotation + AB.Fov.Speed * dt) % 360
        fovStrokeGradient.Rotation = fovState.rotation
        fovFillGradient.Rotation   = fovState.rotation

        fovStroke.Thickness     = AB.Fov.Thickness
        fovStroke.Transparency  = AB.Fov.Transparency
        fovFill.Visible = AB.Fov.Fill
        if AB.Fov.Fill then
            fovFill.BackgroundTransparency = 1 - (1 - AB.Fov.FillTransparency)
        end
    end)

    -- ══════════════════════════════════════════════════════════
    --  UpdateCameraRotation remote (for server-side aim)
    -- ══════════════════════════════════════════════════════════
    local updateCameraRemote = nil
    pcall(function()
        local remotes     = ReplicatedStorage:WaitForChild("Remotes")
        local replication = remotes:WaitForChild("Replication")
        local fighter     = replication:WaitForChild("Fighter")
        updateCameraRemote = fighter:FindFirstChild("UpdateCameraRotation")
    end)

    -- ══════════════════════════════════════════════════════════
    --  Aim loop state
    -- ══════════════════════════════════════════════════════════
    local aim = {
        target      = nil,
        firstSeenAt = 0,
    }

    local function aimStep(dt)
        if not AB.Enabled then return end
        local cam = Workspace.CurrentCamera
        if not cam then return end

        -- On Scope
        if AB.OnScope == "disable" and isScoped()  then return end
        if AB.OnScope == "enable"  and not isScoped() then return end

        local target = getClosest(AB)
        local now    = tick()

        if not target then
            aim.target      = nil
            aim.firstSeenAt = 0
            return
        end

        if target ~= aim.target then
            aim.target      = target
            aim.firstSeenAt = now
        end

        if (now - aim.firstSeenAt) < AB.ReactionTime then return end

        local camPos  = cam.CFrame.Position
        local desired = CFrame.lookAt(camPos, target.Position)

        -- Smoothness: 0 = instant, 1 = very slow
        local smoothness = math.clamp(AB.Smoothness, 0, 1)
        local alpha
        if smoothness <= 0.001 then
            alpha = 1
        else
            alpha = math.min(1, dt * 30 / math.max(smoothness * 10, 0.1))
        end
        alpha = math.clamp(alpha, 0, 1)

        cam.CFrame = cam.CFrame:Lerp(desired, alpha)

        -- Send server-side rotation
        if updateCameraRemote then
            local dir = target.Position - camPos
            if dir.Magnitude > 1e-4 then
                local unit = dir.Unit
                local yaw   = math.atan2(-unit.X, -unit.Z)
                local pitch = math.asin(math.clamp(unit.Y, -1, 1))
                pcall(function()
                    local encoded = Utility:EncodeCameraRotation(Vector2.new(pitch, yaw), nil)
                    updateCameraRemote:FireServer(encoded, nil)
                end)
            end
        end
    end

    -- Bind AFTER the game's camera controller runs
    RunService:BindToRenderStep(
        "Elisium_Aimbot",
        Enum.RenderPriority.Camera.Value + 1,
        function(dt)
            pcall(aimStep, dt)
        end
    )

    print("[syrex.lol] Aimbot installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  RAGEBOT — RUNTIME
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players           = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace         = game:GetService("Workspace")
    local RunService        = game:GetService("RunService")
    local HttpService       = game:GetService("HttpService")
    local lp                = Players.LocalPlayer

    local PlayerScripts     = lp:WaitForChild("PlayerScripts")
    local Controllers       = PlayerScripts:WaitForChild("Controllers")
    local FighterController = require(Controllers.FighterController)
    local EnumLibrary       = require(ReplicatedStorage.Modules:WaitForChild("EnumLibrary"))
    pcall(function() EnumLibrary:WaitForEnumBuilder() end)

    local useItem     = ReplicatedStorage:FindFirstChild("UseItem", true)
    local updateState = ReplicatedStorage:FindFirstChild("UpdateState", true)
    if not useItem then
        warn("[syrex.lol] Ragebot: UseItem remote not found — firing disabled.")
    end

    local RB     = getgenv().Elisium.Combat.Ragebot
    local REP    = getgenv().Elisium.Combat.Reposition
    local DODGE  = getgenv().Elisium.Combat.Dodge

    getgenv().Ragebot = getgenv().Ragebot or { Status = "idle", Target = "none" }

    local function setHidden(part, prop, value)
        if type(sethiddenproperty) == "function" then
            pcall(sethiddenproperty, part, prop, value)
        end
    end

    local function toEnum(name)
        local ok, v = pcall(function() return EnumLibrary:ToEnum(name) end)
        return ok and v or nil
    end

    -- ══════════════════════════════════════════════════════════
    --  DESYNC — keep client at real pos, server sees pos field
    -- ══════════════════════════════════════════════════════════
    local Desync = {}
    Desync.__index = Desync

    function Desync.new(rootPart)
        local self = setmetatable({
            rootPart = rootPart,
            id = HttpService:GenerateGUID(false),
            oldPos = rootPart.CFrame,
            pos = nil,
        }, Desync)
        RunService:BindToRenderStep(self.id, Enum.RenderPriority.First.Value, function()
            self:Step()
        end)
        return self
    end
    function Desync:Step()
        if self.oldPos then
            if self.rootPart.Parent then
                self.rootPart.CFrame = self.oldPos
            end
            self.oldPos = nil
        end
    end
    function Desync:Beat()
        if self.pos and self.rootPart.Parent then
            if self.oldPos == nil then
                self.oldPos = self.rootPart.CFrame
            end
            self.rootPart.CFrame = self.pos
        end
    end
    function Desync:SetServer(pos) self.pos = pos end
    function Desync:Destroy()
        pcall(function() RunService:UnbindFromRenderStep(self.id) end)
        if self.oldPos and self.rootPart.Parent then
            self.rootPart.CFrame = self.oldPos
        end
    end

    -- ══════════════════════════════════════════════════════════
    --  GLUE — attach root networking to target hitbox
    -- ══════════════════════════════════════════════════════════
    local Glue = {}
    Glue.__index = Glue
    function Glue.new() return setmetatable({ gluedParts = {}, bindings = {} }, Glue) end

    function Glue:Setup(part)
        local rec = self.gluedParts[part]
        if rec then rec.count += 1 return end
        local weld  = part:FindFirstChildOfClass("WeldConstraint")
        local real1 = nil
        if weld then
            real1 = weld.Part1
            if real1 then weld.Part1 = nil end
            part.Anchored = true
        end
        self.gluedParts[part] = { count = 1, weld = weld, real = real1 }
    end
    function Glue:Release(part)
        local rec = self.gluedParts[part]
        if not rec then return end
        rec.count -= 1
        if rec.count > 0 then return end
        if rec.weld and rec.real then
            rec.weld.Part1 = rec.real
            rec.real.Anchored = false
        end
        self.gluedParts[part] = nil
    end
    function Glue:Connect(rootPart, targetPart)
        setHidden(rootPart, "PhysicsRepRootPart", targetPart)
        local prev = self.bindings[rootPart]
        if prev ~= targetPart then
            if prev then self:Release(prev) end
            self:Setup(targetPart)
            self.bindings[rootPart] = targetPart
        end
        targetPart.CFrame = CFrame.new(math.random(67108864, 134217728), 0, math.random(67108864, 134217728))
        return targetPart.CFrame
    end
    function Glue:Free(rootPart)
        local prev = self.bindings[rootPart]
        if not prev then return end
        self.bindings[rootPart] = nil
        self:Release(prev)
        setHidden(rootPart, "PhysicsRepRootPart", nil)
    end
    function Glue:Destroy()
        for _, rec in pairs(self.gluedParts) do
            if rec.weld and rec.real then
                pcall(function()
                    rec.weld.Part1 = rec.real
                    rec.real.Anchored = false
                end)
            end
        end
        table.clear(self.gluedParts)
        table.clear(self.bindings)
    end

    -- ══════════════════════════════════════════════════════════
    --  HELPERS
    -- ══════════════════════════════════════════════════════════
    local function isKatanaDeflecting(item)
        if item and item.Name == "Katana" then
            local now = tick()
            return (item._attack_cooldown or 0) > now
               and (item._deflect_cooldown or 0) > now
               and ((item._deflect_hash or 0) % 2) == 1
        end
        return false
    end

    local function targetHasKnife(fighter)
        local item = fighter and fighter.EquippedItem
        if not item then return false end
        local ok, res = pcall(function() return item.Name == "Knife" end)
        return ok and res == true
    end

    local function isAbove(target)
        local item = target.fighter and target.fighter.EquippedItem
        if not item then return nil end
        local ok, res = pcall(function()
            if item.Name == "Riot Shield" then
                local pitch = math.deg(target.fighter:GetCameraRotation().X)
                if pitch > 22 and pitch < 91 then return false end
                return true
            end
            for _, it in next, target.fighter.Items or {}, nil do
                if it.Name == "Riot Shield" then
                    local pitch = math.deg(target.fighter:GetCameraRotation().X)
                    if (pitch > 315 and pitch < 360) or (pitch > 0 and pitch < 91) then return true end
                    return false
                end
            end
            return nil
        end)
        return ok and res
    end

    local function isMatchActive()
        local lf   = FighterController.LocalFighter
        local char = lp.Character
        if not lf or not char or lf:Get("IsInDuel") ~= true or not lf:IsActive() then return false end
        local envA = lp:GetAttribute("EnvironmentID") or lf:Get("EnvironmentID")
        local envB = char:GetAttribute("EnvironmentID")
        if envA == nil then return false end
        if envB ~= nil and envB ~= envA then return false end
        return true
    end

    local function isEnemy(player, fighter)
        if not player or player == lp or not fighter then return false end
        if not isMatchActive() then return false end
        local lf = FighterController.LocalFighter
        if not lf or lf:Get("IsInDuel") ~= true or fighter:Get("IsInDuel") ~= true then return false end
        local envA = lp:GetAttribute("EnvironmentID") or lf:Get("EnvironmentID")
        local envB = player:GetAttribute("EnvironmentID") or fighter:Get("EnvironmentID")
        if not envA or envB ~= envA then return false end
        local char = player.Character
        char = char and char:GetAttribute("EnvironmentID")
        if char ~= nil and char ~= envA then return false end
        local teamA = lp:GetAttribute("TeamID") or lf:Get("TeamID")
        local teamB = player:GetAttribute("TeamID") or fighter:Get("TeamID")
        return lf:Get("TeamkillEnabled") == true or teamA == nil or teamB == nil or teamB ~= teamA
    end

    local function isFFA()
        local lf = FighterController.LocalFighter
        return lf ~= nil and lf:Get("TeamkillEnabled") == true
    end

    local function getEnemies()
        local list = {}
        for _, fighter in pairs(FighterController.Objects) do
            local player = fighter.Player
            local entity = fighter.Entity
            local model  = entity and entity.Model
            if model and isEnemy(player, fighter) then
                local hh = model:FindFirstChild("HitboxHead")
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hh and hrp then
                    local hum  = model:FindFirstChildOfClass("Humanoid")
                    local data = entity and entity.Data
                    table.insert(list, {
                        player = player, model = model,
                        hitboxHead = hh, rootPart = hrp, fighter = fighter,
                        alive = hum and hum.Health > 0 or false,
                        health = hum and hum.Health or math.huge,
                        invincible = data and data.IsInvincible == true or false,
                    })
                end
            end
        end
        return list
    end

    -- ══════════════════════════════════════════════════════════
    --  STATE
    -- ══════════════════════════════════════════════════════════
    local RB_STATE = {
        desync       = nil,
        glue         = Glue.new(),
        rootPart     = nil,
        timer        = tick(),
        lastFire     = 0,
        wasReloading = false,
        currentTarget  = nil,
        previousTarget = nil,
        lastTargetEnv  = nil,
        targetPolicy   = nil,
        glued        = nil,
        hitboxWindowUntil = -1,
        attackCooldown    = -1,
        voidSpamPhase     = nil,
        voidSpamPhaseEndsAt = 0,
        voidSpamCFrame    = nil,
        safeMethod   = nil,
        safePosition = nil,
        repositionUntil = setmetatable({}, { __mode = "k" }),
    }

    local function resetTarget()
        RB_STATE.currentTarget  = nil
        RB_STATE.previousTarget = nil
        RB_STATE.lastTargetEnv  = nil
        RB_STATE.targetPolicy   = nil
    end

    local function resetDesync()
        if RB_STATE.desync then
            RB_STATE.desync:Destroy()
            RB_STATE.desync = nil
        end
        RB_STATE:FreeGlue()
        RB_STATE:ClearSafe()
        RB_STATE.rootPart = nil
        RB_STATE.hitboxWindowUntil = -1
        RB_STATE.attackCooldown = -1
        RB_STATE:ResetVoidSpam()
    end

    function RB_STATE:FreeGlue()
        if self.glued then
            self.glue:Free(self.glued)
            self.glued = nil
        end
    end

    function RB_STATE:ClearSafe()
        self.safeMethod = nil
        self.safePosition = nil
        self.safeRetryAt = 0
    end

    function RB_STATE:ResetVoidSpam()
        self.voidSpamPhase = nil
        self.voidSpamPhaseEndsAt = 0
        self.voidSpamCFrame = nil
    end

    function RB_STATE:UpdateVoidSpam(now)
        local vs = RB.VoidSpam
        if type(vs) ~= "table" or not vs.Enabled then
            self:ResetVoidSpam()
            return false
        end
        if not self.voidSpamPhase then
            self.voidSpamPhase = "hide"
            self.voidSpamPhaseEndsAt = now + math.clamp(tonumber(vs.HideSeconds) or 0.69, 0.05, 5)
            self.voidSpamCFrame = CFrame.new(math.random(67108864, 134217728), 0, math.random(67108864, 134217728))
        elseif now >= self.voidSpamPhaseEndsAt then
            if self.voidSpamPhase == "hide" then
                self.voidSpamPhase = "attack"
                self.voidSpamPhaseEndsAt = now + math.clamp(tonumber(vs.AttackSeconds) or 0.01, 0.01, 2)
            else
                self.voidSpamPhase = "hide"
                self.voidSpamPhaseEndsAt = now + math.clamp(tonumber(vs.HideSeconds) or 0.69, 0.05, 5)
                self.voidSpamCFrame = CFrame.new(math.random(67108864, 134217728), 0, math.random(67108864, 134217728))
            end
        end
        return self.voidSpamPhase == "hide"
    end

    function RB_STATE:GetRandomSafe()
        local lf = FighterController.LocalFighter
        local hrp = lf and lf.Entity and lf.Entity.RootPart
        if not hrp then return nil end
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = { lp.Character }
        rp.IgnoreWater = true
        for _ = 1, 20 do
            local ang  = math.random() * math.pi * 2
            local dist = math.random(35, 100)
            local origin = hrp.Position + Vector3.new(math.cos(ang)*dist, 50, math.sin(ang)*dist)
            local hit = Workspace:Raycast(origin, Vector3.new(0, -100, 0), rp)
            if hit and hit.Instance then
                local pos = hit.Position + Vector3.new(0, 2, 0)
                local blocked = false
                pcall(function()
                    local cs = game:GetService("CollectionService")
                    for _, p in ipairs(cs:GetTagged("OutOfBoundsPart")) do
                        if not blocked and (p.Position - pos).Magnitude < math.max(p.Size.X, p.Size.Z) / 2 + 2 then
                            blocked = true
                        end
                    end
                    for _, p in ipairs(cs:GetTagged("Barrier")) do
                        if not blocked and (p.Position - pos).Magnitude < math.max(p.Size.X, p.Size.Y, p.Size.Z) / 2 + 2 then
                            blocked = true
                        end
                    end
                end)
                if not blocked then return CFrame.new(pos) end
            end
        end
        return nil
    end

    function RB_STATE:GetUndergroundCFrame()
        if not self.desync then return nil end
        local client = self.desync.rootPart.CFrame
        local depth  = math.clamp(tonumber(RB.UndergroundDepth) or 10, 5, 14)
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = { lp.Character, Workspace.CurrentCamera }
        rp.IgnoreWater = true
        local hit = Workspace:Raycast(client.Position + Vector3.new(0, 2, 0), Vector3.new(0, -512, 0), rp)
        if not hit then return nil end
        local targetY = hit.Position.Y - depth
        local minY    = Workspace.FallenPartsDestroyHeight + 10
        if minY == minY and targetY < minY then targetY = minY end
        if targetY > hit.Position.Y - 5 then return nil end
        return client + Vector3.new(0, targetY - client.Position.Y, 0)
    end

    function RB_STATE:GetRepositionCFrame()
        if not self.desync then return nil end
        local client = self.desync.rootPart.CFrame
        local offset = tonumber(REP.Offset) or -5
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = { lp.Character }
        rp.IgnoreWater = true
        local hit = Workspace:Raycast(client.Position + Vector3.new(0, 2, 0), Vector3.new(0, -20, 0), rp)
        if hit then
            return client + Vector3.new(0, (hit.Position.Y + offset) - client.Position.Y, 0)
        end
        return nil
    end

    function RB_STATE:SetSafe(method)
        self:FreeGlue()
        if not self.desync then return end
        if RB.VoidSpam.Enabled and self.voidSpamPhase == "hide" then
            self.safeMethod = "void spam"
            self.safePosition = self.voidSpamCFrame or CFrame.new(math.random(67108864, 134217728), 0, math.random(67108864, 134217728))
            self.desync:SetServer(self.safePosition)
            return
        end
        if REP.Enabled then
            local cf = self:GetRepositionCFrame()
            if cf then
                self.safeMethod = "reposition"
                self.safePosition = cf
                self.desync:SetServer(cf)
                return
            end
        end
        if method == "underground" then
            local cf = self:GetUndergroundCFrame()
            if cf then
                self.safeMethod = method
                self.safePosition = cf
                self.desync:SetServer(cf)
                return
            end
        end
        if method == "random pos" then
            local cf = self:GetRandomSafe()
            if cf then
                self.safeMethod = method
                self.safePosition = cf
                self.desync:SetServer(cf)
                return
            end
        end
        self.safeMethod = "void"
        self.desync:SetServer(CFrame.new(math.random(67108864, 134217728), 0, math.random(67108864, 134217728)))
    end

    -- ══════════════════════════════════════════════════════════
    --  TARGETING
    -- ══════════════════════════════════════════════════════════
    local function isRepositioned(target, now)
        local player = target.player
        local rootPart = target.rootPart
        if not player or player == lp or not rootPart then return false end
        if getgenv().Elisium_IsRepositioned and getgenv().Elisium_IsRepositioned(rootPart.Position) then
            RB_STATE.repositionUntil[player] = now + 0.55
            return true
        end
        local t = RB_STATE.repositionUntil[player]
        if type(t) == "number" and now < t then return true end
        RB_STATE.repositionUntil[player] = nil
        return false
    end

    function RB_STATE:GetTarget()
        local lf    = FighterController.LocalFighter
        local envA  = lp:GetAttribute("EnvironmentID") or (lf and lf:Get("EnvironmentID"))
        local prio  = RB.FFATargetPriority
        local lowHP = prio == "lowest health" or (type(prio) == "table" and prio["lowest health"] == true)
        local clos  = prio == "closest proximity" or (type(prio) == "table" and prio["closest proximity"] == true)
        local smart = RB.FFASmartTargeting and isFFA() and (lowHP or clos)
        local policy = smart and ((lowHP and "health" or "") .. (clos and "+proximity" or "")) or "cycle"

        if self.lastTargetEnv ~= envA then
            resetTarget()
            self.lastTargetEnv = envA
        end
        if self.targetPolicy ~= policy then
            self.currentTarget  = nil
            self.previousTarget = nil
            self.targetPolicy   = policy
        end

        local now       = os.clock()
        local hrp       = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        local candidates = {}
        for _, t in pairs(getEnemies()) do
            if t.alive and not t.invincible and not isKatanaDeflecting(t.fighter and t.fighter.EquippedItem) then
                t.repositioned = REP.Anti and isRepositioned(t, now) or false
                t.distance     = hrp and (t.rootPart.Position - hrp.Position).Magnitude or math.huge
                table.insert(candidates, t)
            end
        end
        table.sort(candidates, function(a, b)
            if smart then
                if lowHP and a.health ~= b.health then return a.health < b.health end
                if clos  and a.distance ~= b.distance then return a.distance < b.distance end
            end
            return a.player.UserId < b.player.UserId
        end)

        if self.currentTarget then
            for _, t in pairs(candidates) do
                if t.player == self.currentTarget then return t end
            end
            self.previousTarget = self.currentTarget
            self.currentTarget  = nil
        end
        local chosen
        if smart then
            chosen = candidates[1]
        else
            for _, t in pairs(candidates) do
                if t.player ~= self.previousTarget then chosen = t break end
            end
        end
        chosen = chosen or candidates[1]
        if chosen then self.currentTarget = chosen.player end
        return chosen
    end

    -- ══════════════════════════════════════════════════════════
    --  WEAPON MANAGEMENT
    -- ══════════════════════════════════════════════════════════
    local RELOAD_ANIMS = { "EmptyReload", "EmptyReloadStart", "EmptyReloadSegment", "EmptyReloadFinish", "Reload" }
    local function isReloading(fighter)
        local item = (fighter or FighterController.LocalFighter).EquippedItem
        if not item then return false end
        local vm = item.ViewModel
        if not vm then return false end
        for _, n in ipairs(RELOAD_ANIMS) do
            if vm:IsAnimationPlaying(n) then return true end
        end
        return false
    end

    local function ammoOf(item)
        if not item then return 0, 0 end
        return item:Get("Ammo") or 0, item:Get("AmmoReserve") or 0
    end

    local function itemBySlot(fighter, slot)
        for _, item in pairs(fighter.Items or {}) do
            if item then
                local idx = item:Get("ItemIndex") or (item.Data and item.Data.ItemIndex)
                if idx == slot then return item end
            end
        end
        return nil
    end

    local function desiredSlot(fighter)
        local prio  = RB.PriorityWeapon == "secondary" and 2 or 1
        local other = prio == 1 and 2 or 1
        local a = itemBySlot(fighter, prio)
        local b = itemBySlot(fighter, other)
        local ammoA, resA = ammoOf(a)
        local ammoB, resB = ammoOf(b)
        if ammoA <= 0 and resA <= 0 and ammoB <= 0 and resB <= 0 then return 3 end
        if ammoA > 0 then return prio end
        if ammoB > 0 then return other end
        return prio
    end

    local function reload(item)
        local vm = item and item.ViewModel
        if not vm or vm:IsAnimationPlaying("Reload") then return end
        local id = getthreadidentity()
        setthreadidentity(2)
        pcall(item.Input, item, "StartReloading")
        setthreadidentity(id)
    end

    -- ══════════════════════════════════════════════════════════
    --  FIRING
    -- ══════════════════════════════════════════════════════════
    local function buildPayload(rotPitch, yaw, roll, hitPart, isGun)
        local rot = {
            [utf8.char(0)] = -9e37,
            [utf8.char(1)] = 0,
            [utf8.char(2)] = 0,
            [utf8.char(3)] = rotPitch,
            [utf8.char(4)] = yaw,
            [utf8.char(5)] = roll,
        }
        local payload = {
            [utf8.char(1)] = {
                [utf8.char(0)] = rot,
                [utf8.char(1)] = hitPart,
                [utf8.char(2)] = hitPart,
                [utf8.char(3)] = {
                    [utf8.char(0)] = 0,
                    [utf8.char(1)] = 1,
                    [utf8.char(2)] = 0,
                    [utf8.char(3)] = 0,
                    [utf8.char(4)] = 0,
                    [utf8.char(5)] = 0,
                },
            },
        }
        if isGun then payload[utf8.char(2)] = true end
        return payload
    end

    local function FireGun(target, item, objectID, isAboveTarget)
        local _, yaw, roll = target.rootPart.CFrame:ToOrientation()
        local pitch = isAboveTarget and -math.pi/2 or math.pi/2
        local payload = buildPayload(pitch, yaw, roll, target.hitboxHead, true)
        if RB.AutoCrouch and updateState then
            pcall(function() updateState:FireServer(toEnum("IsCrouching"), true, nil) end)
        end
        if useItem then
            pcall(function()
                useItem:FireServer(objectID, toEnum("StartShooting"), payload, nil)
            end)
        end
    end

    local function FireMelee(target, item, objectID, isAboveTarget)
        local _, yaw, roll = target.rootPart.CFrame:ToOrientation()
        local pitch = isAboveTarget and -math.pi/2 or math.pi/2
        local payload = buildPayload(pitch, yaw, roll, target.hitboxHead, false)
        local now = os.clock()
        local isKnife = item.Name == "Knife"

        if RB.AutoCrouch and updateState then
            pcall(function() updateState:FireServer(toEnum("IsCrouching"), true, nil) end)
        end

        if now < RB_STATE.hitboxWindowUntil and isKnife then
            payload[utf8.char(2)] = toEnum("HeavyAttack1")
            if useItem then
                pcall(function()
                    useItem:FireServer(objectID, toEnum("StartAiming"), payload, nil)
                end)
            end
            return
        end

        if now < RB_STATE.attackCooldown and not getgenv().Elisium.Misc.GunMods.NoMeleeCooldown then
            return
        end

        if isKnife then
            RB_STATE.hitboxWindowUntil = now + 0.625
            RB_STATE.attackCooldown    = now + 1.25
            payload[utf8.char(2)] = toEnum("HeavyAttack1")
            if useItem then
                pcall(function()
                    useItem:FireServer(objectID, toEnum("StartAiming"), payload, nil)
                end)
            end
        else
            if useItem then
                pcall(function()
                    useItem:FireServer(objectID, toEnum("StartShooting"), payload, nil)
                end)
            end
        end
    end

    -- ══════════════════════════════════════════════════════════
    --  ANTI-KNIFE (simplified guard)
    -- ══════════════════════════════════════════════════════════
    local knifeState = { NextCheck = 0, Threats = {} }

    local function guardKnife(root, dt)
        if not RB.AntiKnife or not RB_STATE.desync then return false end
        local now = os.clock()
        if now < knifeState.NextCheck then return #knifeState.Threats > 0 and RB_STATE.safeMethod == "anti knife" end
        knifeState.NextCheck = now + 0.1
        table.clear(knifeState.Threats)

        for _, fighter in pairs(FighterController.Objects) do
            local player = fighter.Player
            if isEnemy(player, fighter) then
                local item = fighter.EquippedItem
                if item and item.Name == "Knife" then
                    local entity  = fighter.Entity
                    local rootPart = entity and entity.RootPart
                    if rootPart and rootPart.Parent then
                        local hum = entity.Model and entity.Model:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local dist = (rootPart.Position - root.Position).Magnitude
                            if dist <= 35 then
                                table.insert(knifeState.Threats, { pos = rootPart.Position })
                            end
                        end
                    end
                end
            end
        end

        if #knifeState.Threats > 0 then
            local safe = RB_STATE:GetRandomSafe()
            if safe then
                RB_STATE.desync:SetServer(safe)
                RB_STATE.safeMethod = "anti knife"
                RB_STATE.safePosition = safe
                getgenv().Ragebot.Status = "anti knife: retreat"
                return true
            end
        end
        return false
    end

    -- ══════════════════════════════════════════════════════════
    --  MAIN LOOP
    -- ══════════════════════════════════════════════════════════
    RunService.Heartbeat:Connect(function(dt)
        local ok, err = pcall(function()
            if not RB.Enabled then
                if RB_STATE.desync then resetDesync() end
                resetTarget()
                getgenv().Ragebot.Status = "idle"
                getgenv().Ragebot.Target = "none"
                return
            end

            if not isMatchActive() then
                RB_STATE:ResetVoidSpam()
                RB_STATE:FreeGlue()
                getgenv().Ragebot.Status = "lobby"
                getgenv().Ragebot.Target = "none"
                return
            end

            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            local hum = hrp and lp.Character:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then
                RB_STATE:ResetVoidSpam()
                RB_STATE:FreeGlue()
                getgenv().Ragebot.Status = "idle"
                return
            end

            if RB_STATE.rootPart ~= hrp then
                resetDesync()
                RB_STATE.rootPart = hrp
                RB_STATE.desync = Desync.new(hrp)
            end

            -- restore client pos BEFORE main logic
            RB_STATE.desync:Step()

            local hiding = RB_STATE:UpdateVoidSpam(os.clock())

            local target = RB_STATE:GetTarget()

            if RB.AntiKnife then
                if guardKnife(hrp, dt) then
                    RB_STATE.desync:Beat()
                    return
                end
            end

            local tItem = target and target.fighter and target.fighter.EquippedItem
            if not target or (tItem and isKatanaDeflecting(tItem)) then
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "no target"
                getgenv().Ragebot.Target = "none"
                RB_STATE.desync:Beat()
                return
            end

            local lf       = FighterController.LocalFighter
            local equipped = lf and lf.EquippedItem
            if not lf or not lf:IsActive() or not equipped then
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "no weapon"
                getgenv().Ragebot.Target = target and target.player.Name or "enemy"
                RB_STATE.desync:Beat()
                return
            end

            local attackMode = RB.AttackMode or "gun"
            local idx        = equipped:Get("ItemIndex") or -1

            if attackMode == "melee" then
                if idx ~= 3 then
                    RB_STATE:SetSafe(RB.SafeMethod)
                    lf:EquipItem(3)
                    getgenv().Ragebot.Status = "swapping"
                    RB_STATE.desync:Beat()
                    return
                end
            else
                local want
                if RB.SwapWeaponOnEmpty then want = desiredSlot(lf)
                else want = RB.PriorityWeapon == "secondary" and 2 or 1 end
                if idx ~= want then
                    RB_STATE:SetSafe(RB.SafeMethod)
                    lf:EquipItem(want)
                    getgenv().Ragebot.Status = "swapping"
                    RB_STATE.desync:Beat()
                    return
                end
                if want == 3 then attackMode = "melee" end
            end

            if isReloading(lf) then
                RB_STATE.wasReloading = true
                RB_STATE.timer = tick() + 0.3
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "reloading"
                RB_STATE.desync:Beat()
                return
            end
            if RB_STATE.wasReloading then
                RB_STATE.wasReloading = false
                RB_STATE.timer = tick() + 0.3
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "waiting"
                RB_STATE.desync:Beat()
                return
            end

            local ammo, reserve = ammoOf(equipped)
            if attackMode == "gun" and ammo <= 0 and reserve > 0 then
                reload(equipped)
                RB_STATE.wasReloading = true
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "reloading"
                RB_STATE.desync:Beat()
                return
            end
            if attackMode == "gun" and ammo <= 0 then
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "reloading"
                RB_STATE.desync:Beat()
                return
            end

            if tick() < RB_STATE.timer then
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "waiting"
                RB_STATE.desync:Beat()
                return
            end
            if hiding then
                RB_STATE:SetSafe(RB.SafeMethod)
                getgenv().Ragebot.Status = "void hiding"
                RB_STATE.desync:Beat()
                return
            end

            -- Compute attack CFrame
            local above = isAbove(target) == true
            local repCF = REP.Enabled and RB_STATE:GetRepositionCFrame() or nil
            local attackCFrame

            if repCF then
                RB_STATE:FreeGlue()
                attackCFrame = repCF
            else
                local glueCF = RB_STATE.glue:Connect(hrp, target.hitboxHead)
                RB_STATE.glued = hrp
                local off = above and Vector3.new(0, -0.7, 0.05) or Vector3.new(0, -3.85, 0.05)
                if attackMode == "melee" and equipped.Name == "Knife" then
                    attackCFrame = glueCF * CFrame.new(0, 2, 0) * CFrame.Angles(-math.pi/2, 0, 0)
                elseif targetHasKnife(target.fighter) then
                    attackCFrame = glueCF * CFrame.new(0, 2, 0) * CFrame.Angles(-math.pi/2, 0, 0)
                elseif above then
                    attackCFrame = glueCF + off
                else
                    attackCFrame = CFrame.new(glueCF.Position + off, target.hitboxHead.Position)
                end
            end

            RB_STATE:ClearSafe()
            RB_STATE.desync:SetServer(attackCFrame)

            local now = os.clock()
            if now - RB_STATE.lastFire < 0.001 then
                RB_STATE.desync:Beat()
                return
            end
            RB_STATE.lastFire = now

            local objectID = equipped:Get("ObjectID")
            if not objectID then
                RB_STATE.desync:Beat()
                return
            end

            local isMelee = equipped.Info and equipped.Info.Type == "Melee"
            local tname = target.player and target.player.Name or "enemy"
            getgenv().Ragebot.Status = isMelee and ("hitting " .. tname) or ("killing " .. tname)
            getgenv().Ragebot.Target = tname

            if isMelee then
                FireMelee(target, equipped, objectID, above)
            else
                FireGun(target, equipped, objectID, above)
            end

            RB_STATE.desync:Beat()
        end)
        if not ok then
            warn("[syrex.lol] Ragebot error: " .. tostring(err))
            pcall(function() RB_STATE:FreeGlue() end)
        end
    end)

    -- Cleanup
    lp.CharacterRemoving:Connect(function()
        if RB_STATE.desync then RB_STATE.desync:Destroy() RB_STATE.desync = nil end
        RB_STATE.glue:Destroy()
    end)

    print("[syrex.lol] Ragebot installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  GUN MODS + MISC RUNTIME
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players           = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace         = game:GetService("Workspace")
    local RunService        = game:GetService("RunService")
    local lp                = Players.LocalPlayer

    local PlayerScripts = lp:WaitForChild("PlayerScripts")
    local Modules       = PlayerScripts:WaitForChild("Modules")
    local RSModules     = ReplicatedStorage:WaitForChild("Modules")

    local Gun          = require(Modules.ItemTypes.Gun)
    local Throwable    = require(Modules.ItemTypes.Throwable)
    local Utility      = require(RSModules:WaitForChild("Utility"))
    local FighterController = require(PlayerScripts.Controllers.FighterController)

    local GM = getgenv().Elisium.Misc.GunMods

    -- ── No Recoil ──────────────────────────────────────────────
    pcall(function()
        local orig = Gun._Recoil
        Gun._Recoil = function(self, ...)
            if GM.NoRecoil and self.ClientFighter and self.ClientFighter.IsLocalPlayer then return end
            return orig(self, ...)
        end
    end)

    -- ── No Spread ──────────────────────────────────────────────
    pcall(function()
        local orig = Gun.IsFullyAiming
        Gun.IsFullyAiming = function(self, ...)
            if GM.NoSpread and self.ClientFighter and self.ClientFighter.IsLocalPlayer then return true end
            return orig(self, ...)
        end
    end)

    -- ── No Muzzle Flash ────────────────────────────────────────
    pcall(function()
        local orig = Utility.PlayParticles
        Utility.PlayParticles = function(self, attachment)
            if GM.NoMuzzleFlash and attachment and attachment.Name == "_muzzle" then return end
            return orig(self, attachment)
        end
    end)

    -- ── Explode on throw ───────────────────────────────────────
    pcall(function()
        local orig = Throwable._FinishThrow
        Throwable._FinishThrow = function(self, ...)
            local res = { orig(self, ...) }
            if GM.ExplodeOnThrow and res[2] ~= nil then res[2] = 0 end
            return table.unpack(res)
        end
    end)

    -- ── Rapid Fire ─────────────────────────────────────────────
    pcall(function()
        local orig = Gun.StartShooting
        Gun.StartShooting = function(self, ...)
            if GM.RapidFire and self.ClientFighter and self.ClientFighter.IsLocalPlayer and self.Info then
                local saved = self.Info.ShootCooldown
                self.Info.ShootCooldown = 0
                local res = table.pack(orig(self, ...))
                self.Info.ShootCooldown = saved
                return table.unpack(res, 1, res.n)
            end
            return orig(self, ...)
        end
    end)

    -- ── Automatic Weapon ───────────────────────────────────────
    RunService.Heartbeat:Connect(function()
        if not GM.AutomaticWeapon then return end
        local lf = FighterController.LocalFighter
        local item = lf and lf.EquippedItem
        if item and item.Info and item.Info.InputSpammingEnabled then
            item.Info.InputSpammingEnabled.StartShooting   = 0
            item.Info.InputSpammingEnabled.StartReloading  = 0
        end
    end)

    -- ── No Fuse ────────────────────────────────────────────────
    task.spawn(function()
        while task.wait(0.2) do
            local lf = FighterController.LocalFighter
            if lf and GM.NoFuse then
                for _, item in pairs(lf.Items or {}) do
                    if item._cook_detonate_delay then
                        item._cook_detonate_delay = 999999
                    end
                end
            end
        end
    end)

    -- ── Faster Reload ──────────────────────────────────────────
    task.spawn(function()
        local reloadAnims = { "EmptyReload", "EmptyReloadStart", "Reload" }
        while task.wait(0.1) do
            if GM.FasterReload then
                local lf = FighterController.LocalFighter
                local item = lf and lf.EquippedItem
                if item then
                    local idx = item:Get("ItemIndex")
                    if idx == 1 or idx == 2 then
                        local vm = item.ViewModel
                        if vm then
                            local playing = false
                            for _, n in ipairs(reloadAnims) do
                                if vm:IsAnimationPlaying(n) then playing = true break end
                            end
                            if playing and item:Get("Ammo") == item.Info.MaxAmmo then
                                lf:EquipItem(idx == 1 and 2 or 1)
                                lf:EquipItem(idx)
                            end
                        end
                    end
                end
            end
        end
    end)

    -- ── Anti Flash ─────────────────────────────────────────────
    RunService.Heartbeat:Connect(function()
        if not getgenv().Elisium.Misc.AntiFlash.Enabled then return end
        pcall(function()
            for _, c in pairs(Workspace:GetChildren()) do
                if c.Name == "FlashbangEffect" then c:Destroy() end
            end
            local pg = lp:FindFirstChildOfClass("PlayerGui")
            if pg then
                for _, c in pairs(pg:GetChildren()) do
                    if c.Name == "FlashbangGui" then c:Destroy() end
                end
            end
        end)
    end)

    -- ── Anti Smoke ─────────────────────────────────────────────
    pcall(function()
        local SmokeScreen = require(Modules.SmokeScreen)
        local SmokeCloud  = require(Modules.SmokeCloud)
        local origSS = SmokeScreen.Update
        SmokeScreen.Update = function(self, ...)
            if getgenv().Elisium.Misc.RemoveSmoke.Enabled then
                if self._smoke_cloud_spring then self._smoke_cloud_spring.Target = 0 end
                if self._smoke_cloud_cover  then self._smoke_cloud_cover.Transparency = 1 end
                return
            end
            return origSS(self, ...)
        end
        local origSC = SmokeCloud.Update
        SmokeCloud.Update = function(self, ...)
            if getgenv().Elisium.Misc.RemoveSmoke.Enabled then
                if self.Model then self.Model.Transparency = 1 end
                return
            end
            return origSC(self, ...)
        end
    end)

    -- ── No Scope Overlay ───────────────────────────────────────
    RunService.RenderStepped:Connect(function()
        if not getgenv().Elisium.Misc.NoScopeOverlay.Enabled then return end
        pcall(function()
            local pg = lp:FindFirstChildOfClass("PlayerGui")
            if pg then
                local scope = pg:FindFirstChild("ScopeOverlay", true)
                if scope and scope.Visible then scope.Visible = false end
            end
        end)
    end)

    -- ── No Projectile Visuals ──────────────────────────────────
    pcall(function()
        local orig = Gun._ProjectileEffect
        Gun._ProjectileEffect = function(self, ...)
            if getgenv().Elisium.Misc.NoProjectileVisuals.Enabled then return end
            return orig(self, ...)
        end
    end)

    -- ── Stretch Resolution ─────────────────────────────────────
    RunService.RenderStepped:Connect(function()
        local SR = getgenv().Elisium.Misc.StretchResolution
        if SR.Enabled and Workspace.CurrentCamera then
            Workspace.CurrentCamera.CFrame = Workspace.CurrentCamera.CFrame *
                CFrame.new(0, 0, 0, 1, 0, 0, 0, SR.Amount, 0, 0, 0, 1)
        end
    end)

    -- ── Auto Destroy Tripmine ──────────────────────────────────
    RunService.Heartbeat:Connect(function()
        if not getgenv().Elisium.Misc.DestroyTripmine.Enabled then return end
        pcall(function()
            for _, c in pairs(Workspace:GetChildren()) do
                if c.Name == "Subspace Tripmine" or c.Name == "SubspaceTripmineHitbox" then c:Destroy() end
            end
        end)
    end)

    -- ── Auto Reload ────────────────────────────────────────────
    RunService.Heartbeat:Connect(function()
        if not getgenv().Elisium.Misc.AutoReload.Enabled then return end
        local lf = FighterController.LocalFighter
        local item = lf and lf.EquippedItem
        if not item then return end
        local ammo = item:Get("Ammo") or 0
        local res  = item:Get("AmmoReserve") or 0
        if ammo == 0 and res > 0 and not item.ViewModel:IsAnimationPlaying("Reload") then
            pcall(function()
                local id = getthreadidentity()
                setthreadidentity(2)
                item:Input("StartReloading")
                setthreadidentity(id)
            end)
        end
    end)

    print("[syrex.lol] Misc runtimes installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  CHARACTER RUNTIME
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players    = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UIS        = game:GetService("UserInputService")
    local Workspace  = game:GetService("Workspace")
    local lp         = Players.LocalPlayer

    local CH = getgenv().Elisium.Character

    -- ── WalkSpeed + JumpPower ──────────────────────────────────
    RunService.Heartbeat:Connect(function()
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        local ws = CH["WalkSpeed Multiplier"]
        if ws.Enabled then hum.WalkSpeed = ws.Speed end

        local jp = CH["JumpPower Multiplier"]
        if jp.Enabled then
            hum.UseJumpPower = true
            hum.JumpPower = jp.Speed
        end
    end)

    -- ── Noclip ─────────────────────────────────────────────────
    RunService.Stepped:Connect(function()
        if not CH.Noclip then return end
        local char = lp.Character
        if not char then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)

    -- ── Infinite Jump ──────────────────────────────────────────
    UIS.JumpRequest:Connect(function()
        if not CH["Infinite Jump"] then return end
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    -- ── Fly ────────────────────────────────────────────────────
    RunService.RenderStepped:Connect(function(dt)
        if not CH.Fly.Enabled then return end
        local char = lp.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        local cam = Workspace.CurrentCamera
        if not cam then return end

        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space)     then move += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end

        if move.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + move.Unit * CH.Fly.Speed * dt
        else
            local rot = hrp.CFrame - hrp.CFrame.Position
            hrp.CFrame = CFrame.new(hrp.Position) * rot
        end
        hrp.AssemblyLinearVelocity  = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)

    -- ── Spinbot ────────────────────────────────────────────────
    local spinAngle = 0
    RunService.RenderStepped:Connect(function()
        if not CH.Spinbot.Enabled then return end
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        spinAngle = (spinAngle + CH.Spinbot.Speed) % 360
        hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(spinAngle), 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, math.huge, 0)
    end)

    -- ── Thirdperson ────────────────────────────────────────────
    RunService.RenderStepped:Connect(function()
        if not CH.Thirdperson.Enabled then return end
        local cam = Workspace.CurrentCamera
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not cam or not hrp then return end
        cam.CameraSubject = hrp
        cam.CameraType = Enum.CameraType.Custom
        -- simple offset - overlays the game camera controller's default
        local offset = Vector3.new(CH.Thirdperson.X, CH.Thirdperson.Y, CH.Thirdperson.Z)
        pcall(function()
            local baseCamPos = hrp.Position + offset
            cam.CFrame = CFrame.new(baseCamPos, hrp.Position + Vector3.new(0, 1, 0))
        end)
    end)
end)

-- ═══════════════════════════════════════════════════════════════════
--  HIT SOUND + HITMARKER + HIT OVERLAY
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players           = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService        = game:GetService("RunService")
    local SoundService      = game:GetService("SoundService")
    local lp                = Players.LocalPlayer

    local PlayerScripts = lp:WaitForChild("PlayerScripts")
    local Modules       = PlayerScripts:WaitForChild("Modules")
    local ClientViewModel = require(Modules.ClientReplicatedClasses.ClientFighter.ClientItem.ClientViewModel)
    local Crosshair       = require(Modules.Crosshair)

    local HS  = getgenv().Elisium.HitSound
    local HMK = getgenv().Elisium.Visuals["Hitmarker"]

    -- ── Hit Sound ──────────────────────────────────────────────
    local origHitSound = ClientViewModel.PlayHitmarkerSound
    ClientViewModel.PlayHitmarkerSound = function(self, a1, a2, a3)
        if HS.Enabled then
            local id = HS["Custom Sound"]
            if type(id) == "string" and id ~= "" then
                if id:match("^%d+$") then id = "rbxassetid://" .. id end
                pcall(function()
                    local s = Instance.new("Sound")
                    s.SoundId = id
                    s.Volume  = math.clamp(HS.Volume or 1, 0, 5)
                    s.PlaybackSpeed = math.clamp(HS.Pitch or 1, 0.5, 3)
                    s.Parent = SoundService
                    s:Play()
                    s.Ended:Once(function() s:Destroy() end)
                    task.delay(5, function() if s.Parent then s:Destroy() end end)
                end)
            end
            if HS["Remove Default"] then return end
        end
        return origHitSound(self, a1, a2, a3)
    end

    -- ── Custom Hitmarker Color ─────────────────────────────────
    local origSetHitmarker = Crosshair.SetHitmarkerColor
    Crosshair.SetHitmarkerColor = function(self, isCrit, ...)
        if HMK.Enabled then
            self._hitmarker_color      = "#" .. HMK.Color:ToHex()
            self._hitmarker_color_crit = "#" .. HMK["Headshot Color"]:ToHex()
        end
        return origSetHitmarker(self, isCrit, ...)
    end

    -- ── Hit Overlay ────────────────────────────────────────────
    local HOV = getgenv().Elisium.Visuals["Hit Overlay"]
    local overlayGui = Instance.new("ScreenGui")
    overlayGui.Name = "Elisium_HitOverlay"
    overlayGui.IgnoreGuiInset = true
    overlayGui.ResetOnSpawn = false
    overlayGui.DisplayOrder = 1003
    pcall(function() overlayGui.Parent = gethui() end)
    if not overlayGui.Parent then overlayGui.Parent = lp:WaitForChild("PlayerGui") end

    local overlayFrame = Instance.new("Frame")
    overlayFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    overlayFrame.BackgroundTransparency = 1
    overlayFrame.BorderSizePixel = 0
    overlayFrame.Size = UDim2.fromScale(1, 1)
    overlayFrame.Visible = false
    overlayFrame.Parent = overlayGui

    local overlayState = { startedAt = 0, duration = 0, startTransparency = 1, color = Color3.new(1, 1, 1), active = false }

    RunService.PreRender:Connect(function()
        if not overlayState.active then return end
        local n = (os.clock() - overlayState.startedAt) / overlayState.duration
        if n >= 1 then
            overlayState.active = false
            overlayFrame.Visible = false
            overlayFrame.BackgroundTransparency = 1
            return
        end
        overlayFrame.BackgroundColor3 = overlayState.color
        overlayFrame.BackgroundTransparency = overlayState.startTransparency + (1 - overlayState.startTransparency) * n
        overlayFrame.Visible = true
    end)

    getgenv().Elisium_TriggerHitOverlay = function(isHeadshot)
        if not HOV.Enabled then return end
        overlayState.startedAt = os.clock()
        overlayState.duration  = math.max(HOV.Duration or 0.35, 0.05)
        overlayState.startTransparency = math.clamp(HOV.Transparency or 0.55, 0, 1)
        overlayState.color = isHeadshot and HOV["Headshot Color"] or HOV.Color
        overlayState.active = true
    end

    -- ── Hit Notify (hook LocalFighter.ReplicateFromServer) ────
    local FighterController = require(PlayerScripts.Controllers.FighterController)
    local HN = getgenv().Elisium.HitNotify

    task.spawn(function()
        while not FighterController.LocalFighter do task.wait() end
        local lf = FighterController.LocalFighter
        local origReplicate = lf.ReplicateFromServer
        lf.ReplicateFromServer = function(self, kind, ...)
            if kind == "DamageNumberEffect" then
                local args = table.pack(...)
                local part, value, isHead = args[1], args[2], args[3]
                if typeof(part) == "Instance" and part:IsA("BasePart") then
                    local parent = part.Parent
                    local hum = parent and parent:FindFirstChildOfClass("Humanoid")
                    if hum then
                        pcall(getgenv().Elisium_TriggerHitOverlay, isHead == true)
                        if HN.Enabled and getgenv().window then
                            local msg = HN.Message
                                :gsub("{target}", parent.Name or "target")
                                :gsub("{damage}", tostring(math.floor(tonumber(value) or 0)))
                                :gsub("{hitpart}", isHead and "Head" or "Body")
                            pcall(function()
                                library.notifications:create_notification({ name = "Hit", info = msg })
                            end)
                        end
                    end
                end
            end
            return origReplicate(self, kind, ...)
        end
    end)

    print("[syrex.lol] Hit sound + overlay + notify installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  SPOOF + SLIDE BOOST RUNTIME
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players    = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local lp         = Players.LocalPlayer

    local PlayerScripts = lp:WaitForChild("PlayerScripts")
    local MechanicsController = require(PlayerScripts.Controllers.MechanicsController)

    local SP = getgenv().Elisium.Misc.Spoof
    local CH = getgenv().Elisium.Character

    -- capture originals once
    local origLevel  = lp:GetAttribute("Level")
    local origStreak = lp:GetAttribute("StatisticDuelsWinStreak")
    local origStatus = lp:GetAttribute("PlayerStatus")

    RunService.Heartbeat:Connect(function()
        if SP.Level.Enabled and SP.Level.Value then
            pcall(function() lp:SetAttribute("Level", SP.Level.Value) end)
        elseif not SP.Level.Enabled and origLevel ~= nil then
            pcall(function() lp:SetAttribute("Level", origLevel) end)
        end

        if SP.Streak.Enabled and SP.Streak.Value then
            pcall(function() lp:SetAttribute("StatisticDuelsWinStreak", SP.Streak.Value) end)
        elseif not SP.Streak.Enabled and origStreak ~= nil then
            pcall(function() lp:SetAttribute("StatisticDuelsWinStreak", origStreak) end)
        end

        if SP.Status.Enabled and SP.Status.Value then
            pcall(function() lp:SetAttribute("PlayerStatus", SP.Status.Value) end)
        elseif not SP.Status.Enabled and origStatus ~= nil then
            pcall(function() lp:SetAttribute("PlayerStatus", origStatus) end)
        end
    end)

    -- ── Slide Boost ────────────────────────────────────────────
    RunService.PreRender:Connect(function()
        local boost = CH.Sliding["Slide Boost"]
        if not boost.Enabled then return end
        if not MechanicsController.IsSliding or not MechanicsController._sliding_velocity then return end
        MechanicsController._sliding_velocity.Velocity =
            MechanicsController._sliding_velocity.Velocity * boost.Speed / 100
    end)

    -- ── Auto Slide ─────────────────────────────────────────────
    RunService.PreRender:Connect(function()
        if not CH.Sliding.AutoSlide then return end
        if MechanicsController.LocalFighter:IsGrounded()
           and MechanicsController.IsSprinting
           and not MechanicsController.IsSliding then
            MechanicsController:Slide()
        end
    end)

    print("[syrex.lol] Spoof + slide installed.")
end)

-- ═══════════════════════════════════════════════════════════════════
--  MOD DETECTOR (simplified) + USERNAME SPOOFER
-- ═══════════════════════════════════════════════════════════════════
task.spawn(function()
    local Players           = game:GetService("Players")
    local RunService        = game:GetService("RunService")
    local HttpService       = game:GetService("HttpService")
    local lp                = Players.LocalPlayer

    local MD = getgenv().Elisium.Misc.ModDetector
    local classified = {}
    local nextCheck  = 0

    local function isModerator(player)
        local ok, groups = pcall(function()
            return Players:GetGroupsAsync(player.UserId)
        end)
        if not ok or type(groups) ~= "table" then return false end
        for _, g in ipairs(groups) do
            if g.Id == 3461453 and (tonumber(g.Rank) or 0) >= 100 then return true end
        end
        return false
    end

    RunService.Heartbeat:Connect(function()
        if not MD.Enabled then classified = {} return end
        local now = os.clock()
        if now < nextCheck then return end
        nextCheck = now + 15  -- every 15s (avoid rate-limits)

        task.spawn(function()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= lp and not classified[plr.UserId] then
                    local mod = isModerator(plr)
                    if mod then
                        classified[plr.UserId] = true
                        if MD.Moderators.Notify and library then
                            pcall(function()
                                library.notifications:create_notification({
                                    name = "Moderator Detected",
                                    info = plr.DisplayName .. " is a moderator",
                                })
                            end)
                        end
                        if MD.Moderators.Kick then
                            pcall(function() lp:Kick(plr.DisplayName .. " is a moderator") end)
                        end
                        if MD.Moderators["To Lobby"] then
                            pcall(function()
                                local ts = game:GetService("TeleportService")
                                ts:Teleport(17625359962, lp)
                            end)
                        end
                    end
                end
            end
        end)
    end)

    -- ── Username Spoofer (walks own PlayerGui TextLabels) ──────
    local usernameState = {
        Conn       = nil,
        Written    = setmetatable({}, { __mode = "k" }),
        Original   = setmetatable({}, { __mode = "k" }),
        Applying   = setmetatable({}, { __mode = "k" }),
    }

    local function transform(text)
        local cfg = getgenv().Elisium.Misc.Spoof.Username
        if not cfg.Enabled or cfg.Value == "" then return text end
        local pat = string.gsub(lp.Name, "([^%w])", "%%%1")
        return string.gsub(text, "%f[%w_]" .. pat .. "%f[^%w_]", string.gsub(cfg.Value, "%%", "%%%%"))
    end

    local function applyLabel(lbl)
        if not lbl.Parent then return end
        local orig = usernameState.Original[lbl]
        if not getgenv().Elisium.Misc.Spoof.Username.Enabled then
            if orig then lbl.Text = orig usernameState.Original[lbl] = nil end
            return
        end
        local text = orig or lbl.Text
        local new  = transform(text)
        if new ~= text then
            usernameState.Original[lbl] = text
            usernameState.Applying[lbl] = true
            lbl.Text = new
            usernameState.Applying[lbl] = nil
        end
    end

    local function trackLabel(lbl)
        if usernameState.Written[lbl] then return end
        usernameState.Written[lbl] = true
        applyLabel(lbl)
        lbl:GetPropertyChangedSignal("Text"):Connect(function()
            if not usernameState.Applying[lbl] and lbl.Text ~= (usernameState.Original[lbl] or "") then
                usernameState.Original[lbl] = lbl.Text
                applyLabel(lbl)
            end
        end)
    end

    local function refresh()
        local pg = lp:FindFirstChildOfClass("PlayerGui")
        if not pg then return end
        for _, d in ipairs(pg:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then trackLabel(d) end
        end
    end

    genv.RefreshUsernames = refresh

    task.spawn(function()
        while not lp:FindFirstChildOfClass("PlayerGui") do task.wait() end
        refresh()
        lp:FindFirstChildOfClass("PlayerGui").DescendantAdded:Connect(function(d)
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                task.defer(function() trackLabel(d) end)
            end
        end)
    end)

    print("[syrex.lol] Mod detector + username spoofer installed.")
end)
