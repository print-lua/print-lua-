--[[
    Milenium Library
    -> Made by @finobe
    -> Fully fixed for Mobile, Scrolling Tabs, and Anti-Freeze
]]

local uis = game:GetService("UserInputService") 
local players = game:GetService("Players") 
local ws = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")
local http_service = game:GetService("HttpService")
local gui_service = game:GetService("GuiService")
local lighting = game:GetService("Lighting")
local run = game:GetService("RunService")
local stats = game:GetService("Stats")
local coregui = game:GetService("CoreGui")
local debris = game:GetService("Debris")
local tween_service = game:GetService("TweenService")
local sound_service = game:GetService("SoundService")

local vec2 = Vector2.new
local vec3 = Vector3.new
local dim2 = UDim2.new
local dim  = UDim.new 
local rect = Rect.new
local cfr  = CFrame.new
local empty_cfr = cfr()
local point_object_space = empty_cfr.PointToObjectSpace
local angle = CFrame.Angles
local dim_offset = UDim2.fromOffset

local color = Color3.new
local rgb = Color3.fromRGB
local hex = Color3.fromHex
local hsv = Color3.fromHSV
local rgbseq = ColorSequence.new
local rgbkey = ColorSequenceKeypoint.new
local numseq = NumberSequence.new
local numkey = NumberSequenceKeypoint.new

local camera = ws.CurrentCamera
local lp = players.LocalPlayer 
local mouse = lp:GetMouse() 

local max = math.max 
local floor = math.floor 
local min = math.min 
local abs = math.abs 
local noise = math.noise
local rad = math.rad 
local random = math.random 
local pow = math.pow 
local sin = math.sin 
local pi = math.pi 
local tan = math.tan 
local atan2 = math.atan2 
local clamp = math.clamp 

local insert = table.insert 
local find = table.find 
local remove = table.remove
local concat = table.concat

local IS_MOBILE = uis.TouchEnabled and not uis.KeyboardEnabled
local PLATFORM  = IS_MOBILE and "MOBILE" or "PC"

local function safe_pcall(fn, ...)
    local ok, a, b, c = pcall(fn, ...)
    if ok then return a, b, c end
    return nil
end

local function safe_isfile(p)        return (safe_pcall(isfile, p) == true) end
local function safe_delfile(p)       safe_pcall(delfile, p) end
local function safe_writefile(p, d)  return safe_pcall(writefile, p, d) ~= nil end
local function safe_makefolder(p)    safe_pcall(makefolder, p) end
local function safe_listfiles(p)     return safe_pcall(listfiles, p) or {} end

local function get_ui_parent()
    local hui = rawget(getgenv and getgenv() or {}, "gethui")
    if type(gethui) == "function" then
        local ok, result = pcall(gethui)
        if ok and result then return result end
    end
    local ok = pcall(function() return coregui:GetChildren() end)
    if ok then
        local test = Instance.new("ScreenGui")
        local ok2 = pcall(function() test.Parent = coregui end)
        test:Destroy()
        if ok2 then return coregui end
    end
    return lp:WaitForChild("PlayerGui")
end

getgenv().library = {
    directory = "milenium",
    folders = { "/fonts", "/configs" },
    flags = {},
    config_flags = {},
    connections = {},   
    notifications = {notifs = {}},
    current_open;

    is_mobile = IS_MOBILE,
    platform = PLATFORM,
    scale = 1,
    scales = {},
}

local themes = {
    preset = { accent = rgb(155, 150, 219) },
    utility = {
        accent = {
            BackgroundColor3 = {}, 	
            TextColor3 = {}, 
            ImageColor3 = {}, 
            ScrollBarImageColor3 = {} 
        },
    },
}

local keys = {
    [Enum.KeyCode.LeftShift] = "LS", [Enum.KeyCode.RightShift] = "RS",
    [Enum.KeyCode.LeftControl] = "LC", [Enum.KeyCode.RightControl] = "RC",
    [Enum.KeyCode.Insert] = "INS", [Enum.KeyCode.Backspace] = "BS",
    [Enum.KeyCode.Return] = "Ent", [Enum.KeyCode.LeftAlt] = "LA", [Enum.KeyCode.RightAlt] = "RA",
    [Enum.KeyCode.CapsLock] = "CAPS", [Enum.KeyCode.One] = "1", [Enum.KeyCode.Two] = "2",
    [Enum.KeyCode.Three] = "3", [Enum.KeyCode.Four] = "4", [Enum.KeyCode.Five] = "5",
    [Enum.KeyCode.Six] = "6", [Enum.KeyCode.Seven] = "7", [Enum.KeyCode.Eight] = "8",
    [Enum.KeyCode.Nine] = "9", [Enum.KeyCode.Zero] = "0", [Enum.KeyCode.KeypadOne] = "Num1",
    [Enum.KeyCode.KeypadTwo] = "Num2", [Enum.KeyCode.KeypadThree] = "Num3", [Enum.KeyCode.KeypadFour] = "Num4",
    [Enum.KeyCode.KeypadFive] = "Num5", [Enum.KeyCode.KeypadSix] = "Num6", [Enum.KeyCode.KeypadSeven] = "Num7",
    [Enum.KeyCode.KeypadEight] = "Num8", [Enum.KeyCode.KeypadNine] = "Num9", [Enum.KeyCode.KeypadZero] = "Num0",
    [Enum.KeyCode.Minus] = "-", [Enum.KeyCode.Equals] = "=", [Enum.KeyCode.Tilde] = "~",
    [Enum.KeyCode.LeftBracket] = "[", [Enum.KeyCode.RightBracket] = "]", [Enum.KeyCode.RightParenthesis] = ")",
    [Enum.KeyCode.LeftParenthesis] = "(", [Enum.KeyCode.Semicolon] = ",", [Enum.KeyCode.Quote] = "'",
    [Enum.KeyCode.BackSlash] = "\\", [Enum.KeyCode.Comma] = ",", [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Slash] = "/", [Enum.KeyCode.Asterisk] = "*", [Enum.KeyCode.Plus] = "+",
    [Enum.KeyCode.Backquote] = "`", [Enum.UserInputType.MouseButton1] = "MB1",
    [Enum.UserInputType.MouseButton2] = "MB2", [Enum.UserInputType.MouseButton3] = "MB3",
    [Enum.KeyCode.Escape] = "ESC", [Enum.KeyCode.Space] = "SPC",
}
        
library.__index = library

for _, path in next, library.folders do 
    safe_makefolder(library.directory .. path)
end

-- FIXED: Using standard Font Enums to prevent Executor-specific crashes
local fonts = {
    small = Enum.Font.Gotham,
    font  = Enum.Font.GothamBold,
}

library.cache = Instance.new("ScreenGui")
library.cache.Name = "\0"
library.cache.Enabled = false
library.cache.IgnoreGuiInset = true
library.cache.ResetOnSpawn = false
library.cache.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
library.cache.Parent = get_ui_parent()

local flags = library.flags 
local config_flags = library.config_flags
local notifications = library.notifications 

function library:pick(pc, mobile)
    if IS_MOBILE then return mobile end
    return pc
end

function library:calc_scale(size)
    if not IS_MOBILE then return 1 end
    local cam = ws.CurrentCamera
    if not cam then return 1 end
    local vp = cam.ViewportSize
    return clamp(min((vp.X * 0.95) / size.X.Offset, (vp.Y * 0.90) / size.Y.Offset), 0.5, 1.25)
end

function library:add_scale(instance)
    local s = Instance.new("UIScale")
    s.Scale = library.scale
    s.Parent = instance
    insert(library.scales, s)
    return s
end

function library:set_scale(value)
    library.scale = value
    for _, s in library.scales do
        if s and s.Parent then s.Scale = value end
    end
end

function library:tween(obj, properties, easing_style, time) 
    if not obj or not obj.Parent then return nil end
    local tween = tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
    return tween
end

function library:resizify(frame)
    local grip = IS_MOBILE and 28 or 10

    local Frame = Instance.new("TextButton")
    Frame.Position = dim2(1, -grip, 1, -grip)
    Frame.Size = dim2(0, grip, 0, grip)
    Frame.BorderSizePixel = 0
    Frame.BackgroundTransparency = 1
    Frame.Text = ""
    Frame.Parent = frame

    local resizing, start_size, start = false, nil, nil
    local og_size = frame.Size

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            start = input.Position
            start_size = frame.Size
        end
    end)

    library:connection(uis.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)

    local last_resize = 0
    library:connection(uis.InputChanged, function(input)
        if not resizing then return end
        if not frame or not frame.Parent then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end

        local now = os.clock()
        if now - last_resize < 0.016 then return end
        last_resize = now

        local cam = ws.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        local s = library.scale
        
        frame.Size = dim2(
            start_size.X.Scale,
            clamp(start_size.X.Offset + (input.Position.X - start.X) / s, og_size.X.Offset, vp.X / s),
            start_size.Y.Scale,
            clamp(start_size.Y.Offset + (input.Position.Y - start.Y) / s, og_size.Y.Offset, vp.Y / s)
        )
    end)
end 

function library:draggify(frame, handle)
    handle = handle or frame
    local dragging = false
    local start_pos = frame.Position
    local start

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            start = input.Position
            start_pos = frame.Position
        end
    end)

    library:connection(uis.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local last_drag = 0
    library:connection(uis.InputChanged, function(input)
        if not dragging then return end
        if not frame or not frame.Parent then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end

        local now = os.clock()
        if now - last_drag < 0.016 then return end
        last_drag = now

        local cam = ws.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        local s = library.scale
        local w = frame.Size.X.Offset * s
        local h = frame.Size.Y.Offset * s

        frame.Position = dim2(
            0, clamp(start_pos.X.Offset + (input.Position.X - start.X), 0, vp.X - w),
            0, clamp(start_pos.Y.Offset + (input.Position.Y - start.Y), 0, vp.Y - h)
        )
        library:close_element()
    end)
end 

function library:next_flag()
    library._flag_count = (library._flag_count or 0) + 1
    return "flag_" .. library._flag_count
end 

function library:convert(str)
    local values = {}
    for value in string.gmatch(str, "[^,]+") do
        insert(values, tonumber(value))
    end
    if #values == 4 then return unpack(values) end
end
    
function library:convert_enum(enum)
    local enum_parts = {}
    for part in string.gmatch(enum, "[%w_]+") do
        insert(enum_parts, part)
    end
    local enum_table = Enum
    for i = 2, #enum_parts do
        enum_table = enum_table[enum_parts[i]]
    end
    return enum_table
end

local config_holder
function library:update_config_list() 
    if not config_holder then return end
    local list = {}
    for _, file in safe_listfiles(library.directory .. "/configs") do
        local name = file:gsub("\\", "/")
        name = name:match("([^/]+)%.cfg$") or name:match("([^/]+)$") or name
        list[#list + 1] = name
    end
    if config_holder.refresh_options then
        config_holder.refresh_options(list)
    end
end 

function library:get_config()
    local Config = {}
    for _, v in next, flags do
        if type(v) == "table" and v.key then
            Config[_] = {active = v.active, mode = v.mode, key = tostring(v.key)}
        elseif type(v) == "table" and v["Transparency"] and v["Color"] then
            Config[_] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
        else
            Config[_] = v
        end
    end 
    return http_service:JSONEncode(Config)
end

function library:load_config(config_json) 
    local ok, config = pcall(function() return http_service:JSONDecode(config_json) end)
    if not ok or not config then return end
    for _, v in next, config do 
        local function_set = library.config_flags[_]
        if _ == "config_name_list" then continue end
        if function_set then 
            if type(v) == "table" and v["Transparency"] and v["Color"] then
                function_set(hex(v["Color"]), v["Transparency"])
            elseif type(v) == "table" and v["active"] then 
                function_set(v)
            else
                function_set(v)
            end
        end
    end 
end 
    
function library:round(number, float) 
    local multiplier = 1 / (float or 1)
    return floor(number * multiplier + 0.5) / multiplier
end 

function library:apply_theme(instance, theme, property) 
    local theme_tbl = themes.utility[theme]
    if theme_tbl and theme_tbl[property] then 
        insert(theme_tbl[property], instance)
    end 
end

function library:update_theme(theme_name, new_color)
    local theme_utility = themes.utility[theme_name]
    if theme_utility then 
        for prop_name, objects in next, theme_utility do 
            for _, object in next, objects do 
                if object and object.Parent then
                    pcall(function()
                        if object[prop_name] == themes.preset[theme_name] then 
                            object[prop_name] = new_color 
                        end
                    end)
                end 
            end 
        end 
    end 
    themes.preset[theme_name] = new_color 
end 

function library:connection(signal, callback)
    local connection = signal:Connect(callback)
    insert(library.connections, connection)
    return connection 
end

function library:close_element(new_path) 
    local open_element = library.current_open
    if open_element and new_path ~= open_element then
        if open_element.set_visible then
            pcall(open_element.set_visible, false)
        end
        open_element.open = false;
    end 
    if new_path ~= open_element then 
        library.current_open = new_path or nil;
    end
end 

function library:create(instance, options)
    local ins = Instance.new(instance) 
    for prop, value in next, options do 
        if value ~= nil then
            if prop == "Parent" then
                if typeof(value) == "Instance" then
                    ins.Parent = value
                end
            else
                ins[prop] = value
            end
        end
    end
    return ins 
end

function library:unload_menu() 
    for _, connection in next, library.connections do 
        pcall(function() connection:Disconnect() end)
    end
    library.connections = {}

    for _, key in next, { "items", "other", "toggle_ui_gui", "cache" } do 
        local obj = library[key]
        if obj then pcall(function() obj:Destroy() end) end
        library[key] = nil
    end

    library.current_open = nil
    library.scales = {}
end 

function library:window(properties)
    local cfg = { 
        suffix = properties.suffix or properties.Suffix or "";
        name = properties.name or properties.Name or "";
        game_name = properties.gameInfo or properties.game_info or properties.GameInfo or "Milenium";
        size = properties.size or properties.Size or dim2(0, 700, 0, 565);
        selected_tab;
        items = {};
    }

    local sidebar_width = IS_MOBILE and 140 or 196
    if IS_MOBILE and not (properties.size or properties.Size) then
        cfg.size = dim2(0, 620, 0, 330)
    end
    library:set_scale(library:calc_scale(cfg.size))
    
    local cam = ws.CurrentCamera
    local vp_start = cam and cam.ViewportSize or vec2(1920, 1080)
    local parent = get_ui_parent()

    library[ "items" ] = library:create( "ScreenGui" , {
        Parent = parent; Name = "\0"; Enabled = true;
        ResetOnSpawn = false; ZIndexBehavior = Enum.ZIndexBehavior.Global; IgnoreGuiInset = true;
    });
    
    task.wait(0)

    library[ "other" ] = library:create( "ScreenGui" , {
        Parent = parent; Name = "\0"; Enabled = false;
        ResetOnSpawn = false; ZIndexBehavior = Enum.ZIndexBehavior.Sibling; IgnoreGuiInset = true;
    }); 

    library[ "toggle_ui_gui" ] = library:create( "ScreenGui" , {
        Parent = parent; Name = "\0"; ResetOnSpawn = false;
        IgnoreGuiInset = true; ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    });

    task.wait(0)

    local items = cfg.items; do
        items[ "main" ] = library:create( "Frame" , {
            Parent = library[ "items" ]; Size = cfg.size; Name = "\0";
            Position = dim2(0, (vp_start.X - cfg.size.X.Offset * library.scale) / 2, 0, (vp_start.Y - cfg.size.Y.Offset * library.scale) / 2);
            BorderColor3 = rgb(0, 0, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(14, 14, 16)
        }); 

        library:add_scale(items[ "main" ])
        library:create( "UICorner" , { Parent = items[ "main" ]; CornerRadius = dim(0, 10) });
        library:create( "UIStroke" , { Color = rgb(23, 23, 29); Parent = items[ "main" ]; ApplyStrokeMode = Enum.ApplyStrokeMode.Border });
        
        items[ "side_frame" ] = library:create( "Frame" , {
            Parent = items[ "main" ]; BackgroundTransparency = 1; Name = "\0";
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, sidebar_width, 1, -25);
            BorderSizePixel = 0; BackgroundColor3 = rgb(14, 14, 16)
        });
        
        library:create( "Frame" , {
            AnchorPoint = vec2(1, 0); Parent = items[ "side_frame" ]; Position = dim2(1, 0, 0, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 1, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(21, 21, 23)
        });
        
        items[ "button_holder" ] = library:create( "ScrollingFrame" , {
            Parent = items[ "side_frame" ]; Name = "\0"; BackgroundTransparency = 1;
            Position = dim2(0, 0, 0, 60); BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, 0, 1, -60); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255);
            ScrollBarThickness = 2; ScrollBarImageColor3 = rgb(44, 44, 46);
            CanvasSize = dim2(0, 0, 20, 0) 
        }); cfg.button_holder = items[ "button_holder" ];
        
        library:create( "UIListLayout" , { Parent = items[ "button_holder" ]; Padding = dim(0, 5); SortOrder = Enum.SortOrder.LayoutOrder });
        library:create( "UIPadding" , { PaddingTop = dim(0, 16); PaddingBottom = dim(0, 36); Parent = items[ "button_holder" ]; PaddingRight = dim(0, 11); PaddingLeft = dim(0, 10) });

        items[ "title" ] = library:create( "TextLabel" , {
            Font = fonts.font; BorderColor3 = rgb(0, 0, 0); Parent = items[ "side_frame" ]; Name = "\0";
            Text = string.format('<u>%s</u><font color = "rgb(255, 255, 255)">%s</font>', cfg.name, cfg.suffix);
            BackgroundTransparency = 1; Size = dim2(1, 0, 0, 70); TextColor3 = themes.preset.accent;
            BorderSizePixel = 0; RichText = true; TextSize = 26; BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items[ "title" ], "accent", "TextColor3");
        
        items[ "multi_holder" ] = library:create( "Frame" , {
            Parent = items[ "main" ]; Name = "\0"; BackgroundTransparency = 1;
            Position = dim2(0, sidebar_width, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, -sidebar_width, 0, 56); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        }); cfg.multi_holder = items[ "multi_holder" ];
        
        library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = items[ "multi_holder" ]; Position = dim2(0, 0, 1, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = rgb(21, 21, 23)
        });
        
        items[ "shadow" ] = library:create( "ImageLabel" , {
            ImageColor3 = rgb(0, 0, 0); ScaleType = Enum.ScaleType.Slice; Parent = items[ "main" ];
            BorderColor3 = rgb(0, 0, 0); Name = "\0"; BackgroundColor3 = rgb(255, 255, 255);
            Size = dim2(1, 75, 1, 75); AnchorPoint = vec2(0.5, 0.5); Image = "rbxassetid://112971167999062";
            BackgroundTransparency = 1; Position = dim2(0.5, 0, 0.5, 0); SliceScale = 0.75;
            ZIndex = -100; BorderSizePixel = 0; SliceCenter = rect(vec2(112, 112), vec2(147, 147))
        });
        
        items[ "global_fade" ] = library:create( "Frame" , {
            Parent = items[ "main" ]; Name = "\0"; BackgroundTransparency = 1;
            Position = dim2(0, sidebar_width, 0, 56); BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, -sidebar_width, 1, -81); BorderSizePixel = 0; BackgroundColor3 = rgb(14, 14, 16); ZIndex = 2;
        });                

        library:create( "UICorner" , { Parent = items[ "shadow" ]; CornerRadius = dim(0, 5) });
        
        items[ "info" ] = library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = items[ "main" ]; Name = "\0";
            Position = dim2(0, 0, 1, 0); BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, 0, 0, 25); BorderSizePixel = 0; BackgroundColor3 = rgb(23, 23, 25)
        });
        
        library:create( "UICorner" , { Parent = items[ "info" ]; CornerRadius = dim(0, 10) });
        
        items[ "grey_fill" ] = library:create( "Frame" , {
            Name = "\0"; Parent = items[ "info" ]; BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, 0, 0, 6); BorderSizePixel = 0; BackgroundColor3 = rgb(23, 23, 25)
        });
        
        items[ "game" ] = library:create( "TextLabel" , {
            Font = fonts.font; Parent = items[ "info" ]; TextColor3 = rgb(72, 72, 73);
            BorderColor3 = rgb(0, 0, 0); Text = cfg.game_name .. "  |  " .. PLATFORM;
            Name = "\0"; Size = dim2(1, 0, 0, 0); AnchorPoint = vec2(0, 0.5);
            Position = dim2(0, 10, 0.5, -1); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left;
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        }); 
        
        items[ "other_info" ] = library:create( "TextLabel" , {
            Parent = items[ "info" ]; RichText = true; Name = "\0"; TextColor3 = themes.preset.accent;
            BorderColor3 = rgb(0, 0, 0); Text = '<font color="rgb(173, 216, 230)">Lifetime </font>' .. cfg.name .. cfg.suffix;
            Size = dim2(1, 0, 0, 0); Position = dim2(0, -10, 0.5, -1); AnchorPoint = vec2(0, 0.5);
            BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Right;
            AutomaticSize = Enum.AutomaticSize.XY; Font = fonts.font; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items[ "other_info" ], "accent", "TextColor3");

        items[ "toggle_ui_btn" ] = library:create( "TextButton" , {
            Parent = library[ "toggle_ui_gui" ]; Name = "\0"; AnchorPoint = vec2(1, 1);
            Position = dim2(1, -20, 1, -20); Size = dim2(0, 160, 0, 52);
            BackgroundColor3 = rgb(30, 30, 36); BorderSizePixel = 0; AutoButtonColor = false;
            Font = fonts.font; Text = "toggle ui"; TextSize = 15; TextColor3 = rgb(255, 255, 255); ZIndex = 50;
        });

        library:create( "UICorner" , { Parent = items[ "toggle_ui_btn" ]; CornerRadius = dim(0, 999) });
        library:create( "UIStroke" , {
            Parent = items[ "toggle_ui_btn" ]; Color = rgb(50, 50, 62); Thickness = 1; ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        });

        items[ "toggle_ui_btn" ].MouseEnter:Connect(function()
            library:tween(items[ "toggle_ui_btn" ], { BackgroundColor3 = rgb(50, 50, 64) }, Enum.EasingStyle.Quad, 0.15)
        end)
        items[ "toggle_ui_btn" ].MouseLeave:Connect(function()
            library:tween(items[ "toggle_ui_btn" ], { BackgroundColor3 = rgb(30, 30, 36) }, Enum.EasingStyle.Quad, 0.15)
        end)
    end 

    task.wait(0)

    do
        if IS_MOBILE then
            library:draggify(items[ "main" ], items[ "title" ])
        else
            library:draggify(items[ "main" ])
        end
        library:resizify(items[ "main" ])

        library:connection(ws:GetPropertyChangedSignal("CurrentCamera"), function()
            if IS_MOBILE then
                library:set_scale(library:calc_scale(cfg.size))
            end
        end)

        task.defer(function()
            pcall(function()
                notifications:create_notification({
                    name = "Platform detected",
                    info = PLATFORM .. (IS_MOBILE and " (touch UI)" or " (mouse UI)"),
                })
            end)
        end)
    end 

    function cfg.toggle_menu(bool) 
        if library[ "items" ] then library[ "items" ].Enabled = bool end
    end

    items[ "toggle_ui_btn" ].MouseButton1Click:Connect(function()
        if library[ "items" ] then cfg.toggle_menu(not library[ "items" ].Enabled) end
    end)
        
    return setmetatable(cfg, library)
end 

function library:tab(properties)
    local cfg = {
        name = properties.name or properties.Name or "visuals"; 
        icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6034767608";
        tabs = properties.tabs or properties.Tabs or {"Main", "Misc.", "Settings"};
        pages = {}; current_multi; items = {};
    } 

    local sidebar_width = IS_MOBILE and 140 or 196
    local items = cfg.items; do 
        items[ "tab_holder" ] = library:create( "Frame" , {
            Parent = library.cache; Name = "\0"; Visible = false; BackgroundTransparency = 1;
            Position = dim2(0, sidebar_width, 0, 56); BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, -(sidebar_width + 20), 1, -101); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "button" ] = library:create( "TextButton" , {
            Font = fonts.font; TextColor3 = rgb(255, 255, 255); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = self.items[ "button_holder" ]; AutoButtonColor = false;
            BackgroundTransparency = 1; Name = "\0"; Size = dim2(1, 0, 0, 35);
            BorderSizePixel = 0; TextSize = 16; BackgroundColor3 = rgb(29, 29, 29)
        });
        
        items[ "icon" ] = library:create( "ImageLabel" , {
            ImageColor3 = rgb(72, 72, 73); BorderColor3 = rgb(0, 0, 0); Parent = items[ "button" ];
            AnchorPoint = vec2(0, 0.5); Image = "http://www.roblox.com/asset/?id=6034767608";
            BackgroundTransparency = 1; Position = dim2(0, 10, 0.5, 0); Name = "\0";
            Size = dim2(0, 22, 0, 22); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items[ "icon" ], "accent", "ImageColor3");
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(72, 72, 73); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "button" ]; Name = "\0"; Size = dim2(0, 0, 1, 0);
            Position = dim2(0, 40, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left;
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , { Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        library:create( "UICorner" , { Parent = items[ "button" ]; CornerRadius = dim(0, 7) });
        library:create( "UIStroke" , { Color = rgb(23, 23, 29); Parent = items[ "button" ]; Enabled = false; ApplyStrokeMode = Enum.ApplyStrokeMode.Border });

        items[ "multi_section_button_holder" ] = library:create( "Frame" , {
            Parent = library.cache; BackgroundTransparency = 1; Name = "\0"; Visible = false;
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            Parent = items[ "multi_section_button_holder" ]; Padding = dim(0, 7);
            SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal
        });
        
        library:create( "UIPadding" , {
            PaddingTop = dim(0, 8); PaddingBottom = dim(0, 7); Parent = items[ "multi_section_button_holder" ];
            PaddingRight = dim(0, 7); PaddingLeft = dim(0, 7)
        });                        

        for _, section in next, cfg.tabs do
            local data = {items = {}} 

            local multi_items = data.items; do 
                multi_items[ "button" ] = library:create( "TextButton" , {
                    Font = fonts.font; TextColor3 = rgb(255, 255, 255); BorderColor3 = rgb(0, 0, 0);
                    AutoButtonColor = false; Text = ""; Parent = items[ "multi_section_button_holder" ]; Name = "\0";
                    Size = dim2(0, 0, 0, 39); BackgroundTransparency = 1; ClipsDescendants = true;
                    BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; TextSize = 16; BackgroundColor3 = rgb(25, 25, 29)
                });
                
                multi_items[ "name" ] = library:create( "TextLabel" , {
                    Font = fonts.font; TextColor3 = rgb(62, 62, 63); BorderColor3 = rgb(0, 0, 0);
                    Text = section; Parent = multi_items[ "button" ]; Name = "\0"; Size = dim2(0, 0, 1, 0);
                    BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , { Parent = multi_items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
                
                multi_items[ "accent" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0); AnchorPoint = vec2(0, 1); Parent = multi_items[ "button" ];
                    BackgroundTransparency = 1; Position = dim2(0, 10, 1, 4); Name = "\0";
                    Size = dim2(1, -20, 0, 6); BorderSizePixel = 0; BackgroundColor3 = themes.preset.accent
                }); library:apply_theme(multi_items[ "accent" ], "accent", "BackgroundColor3");
                
                library:create( "UICorner" , { Parent = multi_items[ "accent" ]; CornerRadius = dim(0, 999) });
                library:create( "UIPadding" , { Parent = multi_items[ "button" ]; PaddingRight = dim(0, 10); PaddingLeft = dim(0, 10) });
                library:create( "UICorner" , { Parent = multi_items[ "button" ]; CornerRadius = dim(0, 7) }); 

                multi_items[ "tab" ] = library:create( "Frame" , {
                    Parent = library.cache; BackgroundTransparency = 1; Name = "\0"; BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -20, 1, -20); BorderSizePixel = 0; Visible = false; BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Vertical; HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = multi_items[ "tab" ]; Padding = dim(0, 7); SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
                library:create( "UIPadding" , {
                    PaddingTop = dim(0, 7); PaddingBottom = dim(0, 7); Parent = multi_items[ "tab" ];
                    PaddingRight = dim(0, 7); PaddingLeft = dim(0, 7)
                });
            end

            data.text = multi_items[ "name" ]
            data.accent = multi_items[ "accent" ]
            data.button = multi_items[ "button" ]
            data.page = multi_items[ "tab" ]
            data.parent = setmetatable(data, library):sub_tab({}).items[ "tab_parent" ]

            function data.open_page()
                local page = cfg.current_multi; 
                
                if page and page.text ~= data.text then 
                    self.items[ "global_fade" ].BackgroundTransparency = 0
                    library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                    page.page.Size = dim2(1, -20, 1, -20)
                end

                if page then
                    library:tween(page.text, {TextColor3 = rgb(62, 62, 63)})
                    library:tween(page.accent, {BackgroundTransparency = 1})
                    library:tween(page.button, {BackgroundTransparency = 1})
                    page.page.Visible = false
                    page.page.Parent = library[ "cache" ] 
                end 
                
                library:tween(data.text, {TextColor3 = rgb(255, 255, 255)})
                library:tween(data.accent, {BackgroundTransparency = 0})
                library:tween(data.button, {BackgroundTransparency = 0})
                library:tween(data.page, {Size = dim2(1, 0, 1, 0)}, Enum.EasingStyle.Quad, 0.4)

                data.page.Visible = true
                data.page.Parent = items["tab_holder"]

                cfg.current_multi = data
                library:close_element()
            end

            multi_items[ "button" ].MouseButton1Down:Connect(function()
                data.open_page() 
            end)

            cfg.pages[#cfg.pages + 1] = setmetatable(data, library)
        end 

        if cfg.pages[1] and cfg.pages[1].open_page then 
            cfg.pages[1].open_page()
        end
    end 

    function cfg.open_tab() 
        local selected_tab = self.selected_tab
        
        if selected_tab then 
            if selected_tab[ 4 ] ~= items[ "tab_holder" ] then 
                self.items[ "global_fade" ].BackgroundTransparency = 0
                library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                selected_tab[ 4 ].Size = dim2(1, -(sidebar_width + 20), 1, -101)
            end

            library:tween(selected_tab[ 1 ], {BackgroundTransparency = 1})
            library:tween(selected_tab[ 2 ], {ImageColor3 = rgb(72, 72, 73)})
            library:tween(selected_tab[ 3 ], {TextColor3 = rgb(72, 72, 73)})

            selected_tab[ 4 ].Visible = false
            selected_tab[ 4 ].Parent = library[ "cache" ]
            selected_tab[ 5 ].Visible = false
            selected_tab[ 5 ].Parent = library[ "cache" ]
        end

        library:tween(items[ "button" ], {BackgroundTransparency = 0})
        library:tween(items[ "icon" ], {ImageColor3 = themes.preset.accent})
        library:tween(items[ "name" ], {TextColor3 = rgb(255, 255, 255)})
        library:tween(items[ "tab_holder" ], {Size = dim2(1, -sidebar_width, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
        
        items[ "tab_holder" ].Visible = true 
        items[ "tab_holder" ].Parent = self.items[ "main" ]
        items[ "multi_section_button_holder" ].Visible = true 
        items[ "multi_section_button_holder" ].Parent = self.items[ "multi_holder" ]

        self.selected_tab = {
            items[ "button" ]; items[ "icon" ]; items[ "name" ]; items[ "tab_holder" ]; items[ "multi_section_button_holder" ];
        }

        library:close_element()
    end

    items[ "button" ].MouseButton1Down:Connect(function()
        cfg.open_tab()
    end)
    
    if not self.selected_tab then 
        cfg.open_tab() 
    end

    return unpack(cfg.pages)
end

function library:seperator(properties)
    local cfg = {items = {}, name = properties.Name or properties.name or "General"}

    local items = cfg.items do 
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(72, 72, 73); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = self.items[ "button_holder" ]; Name = "\0";
            Size = dim2(1, 0, 0, 0); Position = dim2(0, 40, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left;
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , {
            Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5)
        });                
    end;    

    return setmetatable(cfg, library)
end 

function library:column(properties) 
    local cfg = {items = {}, size = properties.size or 1}

    local items = cfg.items; do     
        items[ "column" ] = library:create( "ScrollingFrame" , {
            Parent = self[ "parent" ] or self.items["tab_parent"]; BackgroundTransparency = 1;
            Name = "\0"; BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 0, cfg.size, 0);
            BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255);
            ScrollBarThickness = 2; ScrollBarImageColor3 = rgb(44, 44, 46);
            CanvasSize = dim2(0, 0, 0, 0);
            AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollingDirection = Enum.ScrollingDirection.Y
        });
        
        library:create( "UIPadding" , { PaddingBottom = dim(0, 10); Parent = items[ "column" ] });
        library:create( "UIListLayout" , {
            Parent = items[ "column" ]; HorizontalFlex = Enum.UIFlexAlignment.Fill;
            Padding = dim(0, 10); FillDirection = Enum.FillDirection.Vertical; SortOrder = Enum.SortOrder.LayoutOrder
        });
    end 

    return setmetatable(cfg, library)
end 

function library:sub_tab(properties) 
    local cfg = {items = {}, order = properties.order or 0; size = properties.size or 1}

    local items = cfg.items; do 
        items[ "tab_parent" ] = library:create( "Frame" , {
            Parent = self.items[ "tab" ]; BackgroundTransparency = 1; Name = "\0";
            Size = dim2(0,0,cfg.size,0); BorderColor3 = rgb(0, 0, 0);
            BorderSizePixel = 0; Visible = true; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill;
            VerticalFlex = Enum.UIFlexAlignment.Fill; Parent = items[ "tab_parent" ];
            Padding = dim(0, 7); SortOrder = Enum.SortOrder.LayoutOrder;
        });
    end

    return setmetatable(cfg, library)
end 

function library:section(properties)
    local cfg = {
        name = properties.name or properties.Name or "section"; side = properties.side or properties.Side or "left";
        default = properties.default or properties.Default or false; size = properties.size or properties.Size or self.size or 0.5; 
        icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6022668898";
        fading_toggle = properties.fading or properties.Fading or false; items = {};
    };
    
    local items = cfg.items; do 
        items[ "outline" ] = library:create( "Frame" , {
            Name = "\0"; Parent = self.items[ "column" ]; BorderColor3 = rgb(0, 0, 0);
            Size = dim2(0, 0, cfg.size, -3); BorderSizePixel = 0; BackgroundColor3 = rgb(25, 25, 29)
        });

        library:create( "UICorner" , { Parent = items[ "outline" ]; CornerRadius = dim(0, 7) });
        
        items[ "inline" ] = library:create( "Frame" , {
            Parent = items[ "outline" ]; Name = "\0"; Position = dim2(0, 1, 0, 1);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = rgb(22, 22, 24)
        });
        
        library:create( "UICorner" , { Parent = items[ "inline" ]; CornerRadius = dim(0, 7) });
        
        items[ "scrolling" ] = library:create( "ScrollingFrame" , {
            ScrollBarImageColor3 = rgb(44, 44, 46); Active = true; AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollBarThickness = 2; Parent = items[ "inline" ]; Name = "\0"; Size = dim2(1, 0, 1, -40);
            BackgroundTransparency = 1; Position = dim2(0, 0, 0, 35); BackgroundColor3 = rgb(255, 255, 255);
            BorderColor3 = rgb(0, 0, 0); BorderSizePixel = 0; CanvasSize = dim2(0, 0, 0, 0)
        });
        
        items[ "elements" ] = library:create( "Frame" , {
            BorderColor3 = rgb(0, 0, 0); Parent = items[ "scrolling" ]; Name = "\0";
            BackgroundTransparency = 1; Position = dim2(0, 10, 0, 10); Size = dim2(1, -20, 0, 0);
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , { Parent = items[ "elements" ]; Padding = dim(0, 10); SortOrder = Enum.SortOrder.LayoutOrder });
        library:create( "UIPadding" , { PaddingBottom = dim(0, 15); Parent = items[ "elements" ] });
        
        items[ "button" ] = library:create( "TextButton" , {
            Font = fonts.font; TextColor3 = rgb(255, 255, 255); BorderColor3 = rgb(0, 0, 0);
            Text = ""; AutoButtonColor = false; Parent = items[ "outline" ]; Name = "\0";
            Position = dim2(0, 1, 0, 1); Size = dim2(1, -2, 0, 35); BorderSizePixel = 0;
            TextSize = 16; BackgroundColor3 = rgb(19, 19, 21)
        });
        
        library:create( "UIStroke" , { Color = rgb(23, 23, 29); Parent = items[ "button" ]; Enabled = false; ApplyStrokeMode = Enum.ApplyStrokeMode.Border });
        library:create( "UICorner" , { Parent = items[ "button" ]; CornerRadius = dim(0, 7) });
        
        items[ "Icon" ] = library:create( "ImageLabel" , {
            ImageColor3 = themes.preset.accent; BorderColor3 = rgb(0, 0, 0); Parent = items[ "button" ];
            AnchorPoint = vec2(0, 0.5); Image = cfg.icon; BackgroundTransparency = 1;
            Position = dim2(0, 10, 0.5, 0); Name = "\0"; Size = dim2(0, 22, 0, 22);
            BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items[ "Icon" ], "accent", "ImageColor3");
        
        items[ "section_title" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(255, 255, 255); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "button" ]; Name = "\0"; Size = dim2(0, 0, 1, 0);
            Position = dim2(0, 40, 0, -1); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left;
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = items[ "button" ]; Position = dim2(0, 0, 1, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = rgb(36, 36, 37)
        });
        
        if cfg.fading_toggle then 
            items[ "toggle" ] = library:create( "TextButton" , {
                Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
                AutoButtonColor = false; Text = ""; AnchorPoint = vec2(1, 0.5); Parent = items[ "button" ];
                Name = "\0"; Position = dim2(1, -9, 0.5, 0); Size = dim2(0, 36, 0, 18);
                BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = rgb(58, 58, 62)
            }); library:apply_theme(items[ "toggle" ], "accent", "BackgroundColor3");
            
            library:create( "UICorner" , { Parent = items[ "toggle" ]; CornerRadius = dim(0, 999) });
            
            items[ "toggle_outline" ] = library:create( "Frame" , {
                Parent = items[ "toggle" ]; Size = dim2(1, -2, 1, -2); Name = "\0";
                BorderMode = Enum.BorderMode.Inset; BorderColor3 = rgb(0, 0, 0); Position = dim2(0, 1, 0, 1);
                BorderSizePixel = 0; BackgroundColor3 = rgb(50, 50, 50)
            }); library:apply_theme(items[ "toggle_outline" ], "accent", "BackgroundColor3");
            
            library:create( "UICorner" , { Parent = items[ "toggle_outline" ]; CornerRadius = dim(0, 999) });
            library:create( "UIGradient" , { Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}; Parent = items[ "toggle_outline" ] });
            
            items[ "toggle_circle" ] = library:create( "Frame" , {
                Parent = items[ "toggle_outline" ]; Name = "\0"; Position = dim2(0, 2, 0, 2);
                BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 12, 0, 12); BorderSizePixel = 0; BackgroundColor3 = rgb(86, 86, 88)
            });
            
            library:create( "UICorner" , { Parent = items[ "toggle_circle" ]; CornerRadius = dim(0, 999) });
            library:create( "UICorner" , { Parent = items[ "outline" ]; CornerRadius = dim(0, 7) });
        
            items[ "fade" ] = library:create( "Frame" , {
                Parent = items[ "outline" ]; BackgroundTransparency = 0.8; Name = "\0";
                BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(0, 0, 0)
            });
            
            library:create( "UICorner" , { Parent = items[ "fade" ]; CornerRadius = dim(0, 7) });
        end 
    end;

    if cfg.fading_toggle then
        items[ "button" ].MouseButton1Click:Connect(function()
            cfg.default = not cfg.default 
            cfg.toggle_section(cfg.default) 
        end)

        function cfg.toggle_section(bool)
            library:tween(items[ "toggle" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
            library:tween(items[ "toggle_outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
            library:tween(items[ "toggle_circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
            library:tween(items[ "fade" ], {BackgroundTransparency = bool and 1 or 0.8}, Enum.EasingStyle.Quad)
        end 
    end 

    return setmetatable(cfg, library)
end  

function library:toggle(options) 
    local rand = math.random(1, 2) 
    local cfg = {
        enabled = options.enabled or nil; name = options.name or "Toggle"; info = options.info or nil;
        flag = options.flag or library:next_flag(); type = options.type and string.lower(tostring(options.type)) or (rand == 1 and "toggle" or "checkbox");
        default = options.default or false; folding = options.folding or false; callback = options.callback or function() end;
        items = {}; seperator = options.seperator or options.Seperator or false;
    }

    flags[cfg.flag] = cfg.default

    local items = cfg.items; do
        items[ "toggle" ] = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = self.items[ "elements" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.small; TextColor3 = rgb(245, 245, 245); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "toggle" ]; Name = "\0"; Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });

        if cfg.info then 
            items[ "info" ] = library:create( "TextLabel" , {
                Font = fonts.small; TextColor3 = rgb(130, 130, 130); BorderColor3 = rgb(0, 0, 0);
                TextWrapped = true; Text = cfg.info; Parent = items[ "toggle" ]; Name = "\0";
                Position = dim2(0, 5, 0, 17); Size = dim2(1, -10, 0, 0); BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY;
                TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
            });
        end 
        
        library:create( "UIPadding" , { Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        
        items[ "right_components" ] = library:create( "Frame" , {
            Parent = items[ "toggle" ]; Name = "\0"; Position = dim2(1, 0, 0, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right;
            Parent = items[ "right_components" ]; Padding = dim(0, 9); SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        if cfg.type == "checkbox" then 
            items[ "toggle_button" ] = library:create( "TextButton" , {
                Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
                Text = ""; LayoutOrder = 2; AutoButtonColor = false; AnchorPoint = vec2(1, 0);
                Parent = items[ "right_components" ]; Name = "\0"; Position = dim2(1, 0, 0, 0);
                Size = dim2(0, 16, 0, 16); BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = rgb(67, 67, 68)
            }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
            
            library:create( "UICorner" , { Parent = items[ "toggle_button" ]; CornerRadius = dim(0, 4) });
            
            items[ "outline" ] = library:create( "Frame" , {
                Parent = items[ "toggle_button" ]; Size = dim2(1, -2, 1, -2); Name = "\0";
                BorderMode = Enum.BorderMode.Inset; BorderColor3 = rgb(0, 0, 0); Position = dim2(0, 1, 0, 1);
                BorderSizePixel = 0; BackgroundColor3 = rgb(22, 22, 24)
            }); library:apply_theme(items[ "outline" ], "accent", "BackgroundColor3");
            
            items[ "tick" ] = library:create( "ImageLabel" , {
                ImageTransparency = 1; BorderColor3 = rgb(0, 0, 0); Image = "rbxassetid://111862698467575";
                BackgroundTransparency = 1; Position = dim2(0, -1, 0, 0); Parent = items[ "outline" ];
                Size = dim2(1, 2, 1, 2); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255); ZIndex = 1;
            });

            library:create( "UICorner" , { Parent = items[ "outline" ]; CornerRadius = dim(0, 4) });
            library:create( "UIGradient" , { Enabled = false; Parent = items[ "outline" ]; Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))} });  
        else 
            items[ "toggle_button" ] = library:create( "TextButton" , {
                Font = fonts.font; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
                Text = ""; LayoutOrder = 2; AnchorPoint = vec2(1, 0.5); Parent = items[ "right_components" ];
                Name = "\0"; Position = dim2(1, -9, 0.5, 0); Size = dim2(0, 36, 0, 18);
                BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = themes.preset.accent
            }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
            
            library:create( "UICorner" , { Parent = items[ "toggle_button" ]; CornerRadius = dim(0, 999) });
            
            items[ "inline" ] = library:create( "Frame" , {
                Parent = items[ "toggle_button" ]; Size = dim2(1, -2, 1, -2); Name = "\0";
                BorderMode = Enum.BorderMode.Inset; BorderColor3 = rgb(0, 0, 0); Position = dim2(0, 1, 0, 1);
                BorderSizePixel = 0; BackgroundColor3 = themes.preset.accent
            }); library:apply_theme(items[ "inline" ], "accent", "BackgroundColor3");
            
            library:create( "UICorner" , { Parent = items[ "inline" ]; CornerRadius = dim(0, 999) });
            library:create( "UIGradient" , { Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}; Parent = items[ "inline" ] });
            
            items[ "circle" ] = library:create( "Frame" , {
                Parent = items[ "inline" ]; Name = "\0"; Position = dim2(1, -14, 0, 2);
                BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 12, 0, 12); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
            });
            
            library:create( "UICorner" , { Parent = items[ "circle" ]; CornerRadius = dim(0, 999) });                        
        end 
    end;
    
    function cfg.set(bool)
        if cfg.type == "checkbox" then 
            library:tween(items[ "tick" ], {Rotation = bool and 0 or 45, ImageTransparency = bool and 0 or 1})
            library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(67, 67, 68)})
            library:tween(items[ "outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(22, 22, 24)})
        else
            library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
            library:tween(items[ "inline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
            library:tween(items[ "circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
        end

        pcall(cfg.callback, bool)
        flags[cfg.flag] = bool
    end 
    
    items[ "toggle" ].MouseButton1Click:Connect(function()
        cfg.enabled = not cfg.enabled 
        cfg.set(cfg.enabled)
    end)

    items[ "toggle_button" ].MouseButton1Click:Connect(function()
        cfg.enabled = not cfg.enabled 
        cfg.set(cfg.enabled)
    end)
    
    if cfg.seperator then
        library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = self.items[ "elements" ]; Position = dim2(0, 0, 1, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 1, 0, 1); BorderSizePixel = 0; BackgroundColor3 = rgb(36, 36, 37)
        });
    end

    cfg.set(cfg.default)
    config_flags[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end 

function library:slider(options) 
    local cfg = {
        name = options.name or nil; suffix = options.suffix or ""; flag = options.flag or library:next_flag();
        callback = options.callback or function() end; info = options.info or nil; 
        min = options.min or options.minimum or 0; max = options.max or options.maximum or 100;
        intervals = options.interval or options.decimal or 1; default = options.default or 10;
        value = options.default or 10; seperator = options.seperator or options.Seperator or true;
        dragging = false; items = {}
    } 

    flags[cfg.flag] = cfg.default

    local items = cfg.items; do
        items[ "slider_object" ] = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = self.items[ "elements" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.small; TextColor3 = rgb(245, 245, 245); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "slider_object" ]; Name = "\0"; Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        if cfg.info then 
            items[ "info" ] = library:create( "TextLabel" , {
                Font = fonts.small; TextColor3 = rgb(130, 130, 130); BorderColor3 = rgb(0, 0, 0);
                TextWrapped = true; Text = cfg.info; Parent = items[ "slider_object" ]; Name = "\0";
                Position = dim2(0, 5, 0, 37); Size = dim2(1, -10, 0, 0); BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY;
                TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
            });
        end 

        library:create( "UIPadding" , { Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        
        items[ "right_components" ] = library:create( "Frame" , {
            Parent = items[ "slider_object" ]; Name = "\0"; BackgroundTransparency = 1;
            Position = dim2(0, 4, 0, 23); BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, 0, 0, 12); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            Parent = items[ "right_components" ]; Padding = dim(0, 7);
            SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal
        });
        
        items[ "slider" ] = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; AutoButtonColor = false; AnchorPoint = vec2(1, 0); Parent = items[ "right_components" ];
            Name = "\0"; Position = dim2(1, 0, 0, 0); Size = dim2(1, -4, 0, 4);
            BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create( "UICorner" , { Parent = items[ "slider" ]; CornerRadius = dim(0, 999) });
        
        items[ "fill" ] = library:create( "Frame" , {
            Name = "\0"; Parent = items[ "slider" ]; BorderColor3 = rgb(0, 0, 0);
            Size = dim2(0.5, 0, 0, 4); BorderSizePixel = 0; BackgroundColor3 = themes.preset.accent
        }); library:apply_theme(items[ "fill" ], "accent", "BackgroundColor3");
        
        library:create( "UICorner" , { Parent = items[ "fill" ]; CornerRadius = dim(0, 999) });
        
        items[ "circle" ] = library:create( "Frame" , {
            AnchorPoint = vec2(0.5, 0.5); Parent = items[ "fill" ]; Name = "\0";
            Position = dim2(1, 0, 0.5, 0); BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 12, 0, 12);
            BorderSizePixel = 0; BackgroundColor3 = rgb(244, 244, 244)
        });
        
        library:create( "UICorner" , { Parent = items[ "circle" ]; CornerRadius = dim(0, 999) });
        library:create( "UIPadding" , { Parent = items[ "right_components" ]; PaddingTop = dim(0, 4) });
        
        items[ "value" ] = library:create( "TextLabel" , {
            Font = fonts.small; TextColor3 = rgb(72, 72, 73); BorderColor3 = rgb(0, 0, 0);
            Text = "50%"; Parent = items[ "slider_object" ]; Name = "\0"; Size = dim2(1, 0, 0, 0);
            Position = dim2(0, 6, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Right;
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , { Parent = items[ "value" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });                
    end 

    function cfg.set(value)
        cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)
        library:tween(items[ "fill" ], {Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), cfg.value == cfg.min and 0 or -4, 0, 2)}, Enum.EasingStyle.Linear, 0.05)
        items[ "value" ].Text = tostring(cfg.value) .. cfg.suffix
        flags[cfg.flag] = cfg.value
        pcall(cfg.callback, flags[cfg.flag])
    end

    items[ "slider" ].MouseButton1Down:Connect(function()
        cfg.dragging = true 
        library:tween(items[ "value" ], {TextColor3 = rgb(255, 255, 255)}, Enum.EasingStyle.Quad, 0.2)
    end)

    library:connection(uis.InputChanged, function(input)
        if cfg.dragging and items[ "slider" ].Parent and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local size_x = (input.Position.X - items[ "slider" ].AbsolutePosition.X) / items[ "slider" ].AbsoluteSize.X
            cfg.set(((cfg.max - cfg.min) * size_x) + cfg.min)
        end
    end)

    library:connection(uis.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            cfg.dragging = false
            library:tween(items[ "value" ], {TextColor3 = rgb(72, 72, 73)}, Enum.EasingStyle.Quad, 0.2)
        end
    end)

    if cfg.seperator then 
        library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = self.items[ "elements" ]; Position = dim2(0, 0, 1, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 1, 0, 1); BorderSizePixel = 0; BackgroundColor3 = rgb(36, 36, 37)
        });
    end 

    cfg.set(cfg.default)
    config_flags[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end 

function library:dropdown(options) 
    local cfg = {
        name = options.name or nil; info = options.info or nil; flag = options.flag or library:next_flag();
        options = options.items or {""}; callback = options.callback or function() end;
        multi = options.multi or false; scrolling = options.scrolling or false; width = options.width or 130;
        open = false; option_instances = {}; multi_items = {}; ignore = options.ignore or false;
        items = {}; y_size; seperator = options.seperator or options.Seperator or true;
    }   

    cfg.default = options.default or (cfg.multi and {cfg.options[1]}) or cfg.options[1] or "None"
    flags[cfg.flag] = cfg.default

    local items = cfg.items; do 
        items[ "dropdown_object" ] = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = self.items[ "elements" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.small; TextColor3 = rgb(245, 245, 245); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name or "Dropdown"; Parent = items[ "dropdown_object" ]; Name = "\0";
            Size = dim2(1, 0, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left;
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        if cfg.info then 
            items[ "info" ] = library:create( "TextLabel" , {
                Font = fonts.small; TextColor3 = rgb(130, 130, 130); BorderColor3 = rgb(0, 0, 0);
                TextWrapped = true; Text = cfg.info; Parent = items[ "dropdown_object" ]; Name = "\0";
                Position = dim2(0, 5, 0, 17); Size = dim2(1, -10, 0, 0); BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY;
                TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
            });
        end 

        library:create( "UIPadding" , { Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        
        items[ "right_components" ] = library:create( "Frame" , {
            Parent = items[ "dropdown_object" ]; Name = "\0"; Position = dim2(1, 0, 0, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right;
            Parent = items[ "right_components" ]; Padding = dim(0, 7); SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        items[ "dropdown" ] = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; AutoButtonColor = false; AnchorPoint = vec2(1, 0); Parent = items[ "right_components" ];
            Name = "\0"; Position = dim2(1, 0, 0, 0); Size = dim2(0, cfg.width, 0, 16);
            BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create( "UICorner" , { Parent = items[ "dropdown" ]; CornerRadius = dim(0, 4) });
        
        items[ "sub_text" ] = library:create( "TextLabel" , {
            Font = fonts.small; TextColor3 = rgb(86, 86, 87); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = items[ "dropdown" ]; Name = "\0"; Size = dim2(1, -12, 0, 0);
            BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left;
            TextTruncate = Enum.TextTruncate.AtEnd; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , { Parent = items[ "sub_text" ]; PaddingTop = dim(0, 1); PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        
        items[ "indicator" ] = library:create( "ImageLabel" , {
            ImageColor3 = rgb(86, 86, 87); BorderColor3 = rgb(0, 0, 0); Parent = items[ "dropdown" ];
            AnchorPoint = vec2(1, 0.5); Image = "rbxassetid://101025591575185"; BackgroundTransparency = 1;
            Position = dim2(1, -5, 0.5, 0); Name = "\0"; Size = dim2(0, 12, 0, 12); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });

        items[ "dropdown_holder" ] = library:create( "Frame" , {
            BorderColor3 = rgb(0, 0, 0); Parent = library[ "items" ]; Name = "\0";
            Visible = true; BackgroundTransparency = 1; Size = dim2(0, 0, 0, 0);
            BorderSizePixel = 0; BackgroundColor3 = rgb(0, 0, 0); ZIndex = 10;
        });

        library:add_scale(items[ "dropdown_holder" ])
        
        items[ "outline" ] = library:create( "Frame" , {
            Parent = items[ "dropdown_holder" ]; Size = dim2(1, 0, 1, 0); ClipsDescendants = true;
            BorderColor3 = rgb(0, 0, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(33, 33, 35); ZIndex = 10;
        });
        
        library:create( "UIPadding" , { PaddingBottom = dim(0, 6); PaddingTop = dim(0, 3); PaddingLeft = dim(0, 3); Parent = items[ "outline" ] });
        library:create( "UIListLayout" , { Parent = items[ "outline" ]; Padding = dim(0, 5); SortOrder = Enum.SortOrder.LayoutOrder });
        library:create( "UICorner" , { Parent = items[ "outline" ]; CornerRadius = dim(0, 4) });
    end 

    function cfg.render_option(text)
        local button = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(72, 72, 73); BorderColor3 = rgb(0, 0, 0);
            Text = text; Parent = items[ "outline" ]; Name = "\0"; Size = dim2(1, -12, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255); ZIndex = 10;
        }); library:apply_theme(button, "accent", "TextColor3");
        
        library:create( "UIPadding" , { Parent = button; PaddingTop = dim(0, 1); PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        return button
    end
    
    function cfg.set_visible(bool)
        local a = bool and cfg.y_size or 0
        if not items[ "dropdown" ] or not items[ "dropdown" ].Parent then return end
        library:tween(items[ "dropdown_holder" ], {Size = dim_offset(items[ "dropdown" ].AbsoluteSize.X / library.scale, a)})
        items[ "dropdown_holder" ].Position = dim2(0, items[ "dropdown" ].AbsolutePosition.X, 0, items[ "dropdown" ].AbsolutePosition.Y + 80)
        if not (self.sanity and library.current_open == self) then 
            library:close_element(cfg)
        end
    end
    
    function cfg.set(value)
        local selected = {}
        local isTable = type(value) == "table"

        for _, option in next, cfg.option_instances do 
            if option.Text == value or (isTable and find(value, option.Text)) then 
                insert(selected, option.Text)
                cfg.multi_items = selected
                option.TextColor3 = themes.preset.accent
            else
                option.TextColor3 = rgb(72, 72, 73)
            end
        end

        items[ "sub_text" ].Text = isTable and concat(selected, ", ") or (selected[1] or "")
        flags[cfg.flag] = isTable and selected or selected[1]
        pcall(cfg.callback, flags[cfg.flag]) 
    end
    
    function cfg.refresh_options(list) 
        cfg.y_size = 0

        for _, option in next, cfg.option_instances do 
            option:Destroy() 
        end
        
        cfg.option_instances = {} 

        for _, option in next, list do 
            local button = cfg.render_option(option)
            cfg.y_size += button.AbsoluteSize.Y / library.scale + 6
            insert(cfg.option_instances, button)
            
            button.MouseButton1Down:Connect(function()
                if cfg.multi then 
                    local selected_index = find(cfg.multi_items, button.Text)
                    if selected_index then 
                        remove(cfg.multi_items, selected_index)
                    else
                        insert(cfg.multi_items, button.Text)
                    end
                    cfg.set(cfg.multi_items) 				
                else 
                    cfg.set_visible(false)
                    cfg.open = false 
                    cfg.set(button.Text)
                end
            end)
        end
    end

    items[ "dropdown" ].MouseButton1Click:Connect(function()
        cfg.open = not cfg.open 
        cfg.set_visible(cfg.open)
    end)

    if cfg.seperator then 
        library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = self.items[ "elements" ]; Position = dim2(0, 0, 1, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 1, 0, 1); BorderSizePixel = 0; BackgroundColor3 = rgb(36, 36, 37)
        });
    end 

    flags[cfg.flag] = {} 
    config_flags[cfg.flag] = cfg.set
    
    cfg.refresh_options(cfg.options)
    cfg.set(cfg.default)
        
    return setmetatable(cfg, library)
end

function library:label(options)
    local cfg = { enabled = options.enabled or nil; name = options.name or "Toggle"; seperator = options.seperator or options.Seperator or false; info = options.info or nil; items = {} }

    local items = cfg.items; do 
        items[ "label" ] = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = self.items[ "elements" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.small; TextColor3 = rgb(245, 245, 245); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "label" ]; Name = "\0"; Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });

        if cfg.info then 
            items[ "info" ] = library:create( "TextLabel" , {
                Font = fonts.small; TextColor3 = rgb(130, 130, 130); BorderColor3 = rgb(0, 0, 0);
                TextWrapped = true; Text = cfg.info; Parent = items[ "label" ]; Name = "\0";
                Position = dim2(0, 5, 0, 17); Size = dim2(1, -10, 0, 0); BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY;
                TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
            });
        end 
        
        library:create( "UIPadding" , { Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        
        items[ "right_components" ] = library:create( "Frame" , {
            Parent = items[ "label" ]; Name = "\0"; Position = dim2(1, 0, 0, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right;
            Parent = items[ "right_components" ]; Padding = dim(0, 9); SortOrder = Enum.SortOrder.LayoutOrder
        });                
    end 

    if cfg.seperator then 
        library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = self.items[ "elements" ]; Position = dim2(0, 0, 1, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 1, 0, 1); BorderSizePixel = 0; BackgroundColor3 = rgb(36, 36, 37)
        });
    end 

    return setmetatable(cfg, library)
end 

function library:colorpicker(options) 
    local cfg = {
        name = options.name or "Color"; flag = options.flag or library:next_flag();
        color = options.color or color(1, 1, 1); alpha = options.alpha and 1 - options.alpha or 0;
        open = false; callback = options.callback or function() end; items = {};
        seperator = options.seperator or options.Seperator or false;
    }

    local dragging_sat, dragging_hue, dragging_alpha = false, false, false 
    local h, s, v = cfg.color:ToHSV() 
    local a = cfg.alpha 
    flags[cfg.flag] = {Color = cfg.color, Transparency = cfg.alpha}

    local label; 
    if not self.items.right_components then 
        label = self:label({name = cfg.name, seperator = cfg.seperator})
    end

    local items = cfg.items; do 
        items[ "colorpicker" ] = library:create( "TextButton" , {
            Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; AutoButtonColor = false; AnchorPoint = vec2(1, 0);
            Parent = (label and label.items.right_components) or self.items.right_components;
            Name = "\0"; Position = dim2(1, 0, 0, 0); Size = dim2(0, 16, 0, 16);
            BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = rgb(54, 31, 184)
        });
        
        library:create( "UICorner" , { Parent = items[ "colorpicker" ]; CornerRadius = dim(0, 4) });
        
        items[ "colorpicker_inline" ] = library:create( "Frame" , {
            Parent = items[ "colorpicker" ]; Size = dim2(1, -2, 1, -2); Name = "\0";
            BorderMode = Enum.BorderMode.Inset; BorderColor3 = rgb(0, 0, 0); Position = dim2(0, 1, 0, 1);
            BorderSizePixel = 0; BackgroundColor3 = rgb(54, 31, 184)
        });
        
        library:create( "UICorner" , { Parent = items[ "colorpicker_inline" ]; CornerRadius = dim(0, 4) });
        library:create( "UIGradient" , { Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}; Parent = items[ "colorpicker_inline" ] });         
        
        items[ "colorpicker_holder" ] = library:create( "Frame" , {
            Parent = library[ "other" ]; Name = "\0"; Position = dim2(0.2, 20, 0.297, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 166, 0, 197); BorderSizePixel = 0;
            Visible = true; BackgroundColor3 = rgb(25, 25, 29)
        });

        library:add_scale(items[ "colorpicker_holder" ])

        items[ "colorpicker_fade" ] = library:create( "Frame" , {
            Parent = items[ "colorpicker_holder" ]; Name = "\0"; BackgroundTransparency = 0;
            Position = dim2(0, 0, 0, 0); BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 0, 1, 0);
            BorderSizePixel = 0; ZIndex = 100; BackgroundColor3 = rgb(25, 25, 29)
        });
        
        items[ "colorpicker_components" ] = library:create( "Frame" , {
            Parent = items[ "colorpicker_holder" ]; Name = "\0"; Position = dim2(0, 1, 0, 1);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = rgb(22, 22, 24)
        });
        
        library:create( "UICorner" , { Parent = items[ "colorpicker_components" ]; CornerRadius = dim(0, 6) });
        
        items[ "saturation_holder" ] = library:create( "Frame" , {
            Parent = items[ "colorpicker_components" ]; Name = "\0"; Position = dim2(0, 7, 0, 7);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, -14, 1, -80); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 39, 39)
        });
        
        items[ "sat" ] = library:create( "TextButton" , {
            Parent = items[ "saturation_holder" ]; Name = "\0"; Size = dim2(1, 0, 1, 0);
            Text = ""; AutoButtonColor = false; BorderColor3 = rgb(0, 0, 0); ZIndex = 2;
            BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UICorner" , { Parent = items[ "sat" ]; CornerRadius = dim(0, 4) });
        library:create( "UIGradient" , { Rotation = 270; Transparency = numseq{numkey(0, 0), numkey(1, 1)}; Parent = items[ "sat" ]; Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))} });
        
        items[ "val" ] = library:create( "Frame" , {
            Name = "\0"; Parent = items[ "saturation_holder" ]; BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIGradient" , { Parent = items[ "val" ]; Transparency = numseq{numkey(0, 0), numkey(1, 1)} });
        library:create( "UICorner" , { Parent = items[ "val" ]; CornerRadius = dim(0, 4) });
        library:create( "UICorner" , { Parent = items[ "saturation_holder" ]; CornerRadius = dim(0, 4) });
        
        items[ "satvalpicker" ] = library:create( "TextButton" , {
            BorderColor3 = rgb(0, 0, 0); AutoButtonColor = false; Text = ""; AnchorPoint = vec2(0, 1);
            Parent = items[ "saturation_holder" ]; Name = "\0"; Position = dim2(0, 0, 4, 0);
            Size = dim2(0, 8, 0, 8); ZIndex = 5; BorderSizePixel = 0; BackgroundColor3 = rgb(255, 0, 0)
        });
        
        library:create( "UICorner" , { Parent = items[ "satvalpicker" ]; CornerRadius = dim(0, 9999) });
        library:create( "UIStroke" , { Color = rgb(255, 255, 255); Parent = items[ "satvalpicker" ]; ApplyStrokeMode = Enum.ApplyStrokeMode.Border });
        
        items[ "hue_gradient" ] = library:create( "TextButton" , {
            Parent = items[ "colorpicker_components" ]; Name = "\0"; Position = dim2(0, 10, 1, -64);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, -20, 0, 8); BorderSizePixel = 0;
            BackgroundColor3 = rgb(255, 255, 255); AutoButtonColor = false; Text = "";
        });
        
        library:create( "UIGradient" , {
            Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))};
            Parent = items[ "hue_gradient" ]
        });
        
        library:create( "UICorner" , { Parent = items[ "hue_gradient" ]; CornerRadius = dim(0, 6) });
        
        items[ "hue_picker" ] = library:create( "TextButton" , {
            BorderColor3 = rgb(0, 0, 0); AutoButtonColor = false; Text = ""; AnchorPoint = vec2(0, 0.5);
            Parent = items[ "hue_gradient" ]; Name = "\0"; Position = dim2(0, 0, 0.5, 0);
            Size = dim2(0, 8, 0, 8); ZIndex = 5; BorderSizePixel = 0; BackgroundColor3 = rgb(255, 0, 0)
        });
        
        library:create( "UICorner" , { Parent = items[ "hue_picker" ]; CornerRadius = dim(0, 9999) });
        library:create( "UIStroke" , { Color = rgb(255, 255, 255); Parent = items[ "hue_picker" ]; ApplyStrokeMode = Enum.ApplyStrokeMode.Border });
        
        items[ "alpha_gradient" ] = library:create( "TextButton" , {
            Parent = items[ "colorpicker_components" ]; Name = "\0"; Position = dim2(0, 10, 1, -46);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, -20, 0, 8); BorderSizePixel = 0;
            BackgroundColor3 = rgb(25, 25, 29); AutoButtonColor = false; Text = "";
        });
        
        library:create( "UICorner" , { Parent = items[ "alpha_gradient" ]; CornerRadius = dim(0, 6) });
        
        items[ "alpha_picker" ] = library:create( "TextButton" , {
            BorderColor3 = rgb(0, 0, 0); AutoButtonColor = false; Text = ""; AnchorPoint = vec2(0, 0.5);
            Parent = items[ "alpha_gradient" ]; Name = "\0"; Position = dim2(1, 0, 0.5, 0);
            Size = dim2(0, 8, 0, 8); ZIndex = 5; BorderSizePixel = 0; BackgroundColor3 = rgb(255, 0, 0)
        });
        
        library:create( "UICorner" , { Parent = items[ "alpha_picker" ]; CornerRadius = dim(0, 9999) });
        library:create( "UIStroke" , { Color = rgb(255, 255, 255); ApplyStrokeMode = Enum.ApplyStrokeMode.Border; Parent = items[ "alpha_picker" ] });
        library:create( "UIGradient" , { Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(255, 255, 255))}; Parent = items[ "alpha_gradient" ] });
        
        items[ "alpha_indicator" ] = library:create( "ImageLabel" , {
            ScaleType = Enum.ScaleType.Tile; BorderColor3 = rgb(0, 0, 0); Parent = items[ "alpha_gradient" ];
            Image = "rbxassetid://18274452449"; BackgroundTransparency = 1; Name = "\0"; Size = dim2(1, 0, 1, 0);
            TileSize = dim2(0, 6, 0, 6); BorderSizePixel = 0; BackgroundColor3 = rgb(0, 0, 0)
        });
        
        library:create( "UIGradient" , {
            Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, rgb(255, 0, 0))};
            Transparency = numseq{numkey(0, 0.8062499761581421), numkey(1, 0)}; Parent = items[ "alpha_indicator" ]
        });
        
        library:create( "UICorner" , { Parent = items[ "alpha_indicator" ]; CornerRadius = dim(0, 6) });
        library:create( "UIGradient" , { Rotation = 90; Parent = items[ "colorpicker_components" ]; Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(66, 66, 66))} });

        items[ "input" ] = library:create( "TextBox" , {
            Font = fonts.font; AnchorPoint = vec2(1, 1); Text = ""; Parent = items[ "colorpicker_components" ];
            Name = "\0"; TextTruncate = Enum.TextTruncate.AtEnd; BorderSizePixel = 0; PlaceholderColor3 = rgb(255, 255, 255);
            CursorPosition = -1; ClearTextOnFocus = false; TextSize = 14; TextColor3 = rgb(72, 72, 72);
            BorderColor3 = rgb(0, 0, 0); Position = dim2(1, -8, 1, -11); Size = dim2(1, -16, 0, 18); BackgroundColor3 = rgb(33, 33, 35)
        }); 
        library:create( "UICorner" , { Parent = items[ "input" ]; CornerRadius = dim(0, 3) });
    end;

    function cfg.set_visible(bool)
        items[ "colorpicker_fade" ].BackgroundTransparency = 0
        items[ "colorpicker_holder" ].Parent = bool and library[ "items" ] or library[ "other" ]
        if items[ "colorpicker" ].Parent then
            items[ "colorpicker_holder" ].Position = dim_offset(items[ "colorpicker" ].AbsolutePosition.X, items[ "colorpicker" ].AbsolutePosition.Y + items[ "colorpicker" ].AbsoluteSize.Y + 45)
        end
        library:tween(items[ "colorpicker_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
        library:tween(items[ "colorpicker_holder" ], {Position = items[ "colorpicker_holder" ].Position + dim_offset(0, 20)})
        if not (self.sanity and library.current_open == self and self.open) then 
            library:close_element(cfg)
        end
    end

    function cfg.set(color, alpha)
        if type(color) == "boolean" then return end 
        if color then h, s, v = color:ToHSV() end
        if alpha then a = alpha end 
        local Color = hsv(h, s, v)

        library:tween(items[ "hue_picker" ], {Position = dim2(0, (items[ "hue_gradient" ].AbsoluteSize.X - items[ "hue_picker" ].AbsoluteSize.X) * h, 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
        library:tween(items[ "alpha_picker" ], {Position = dim2(0, (items[ "alpha_gradient" ].AbsoluteSize.X - items[ "alpha_picker" ].AbsoluteSize.X) * (1 - a), 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
        library:tween(items[ "satvalpicker" ], {Position = dim2(0, s * (items[ "saturation_holder" ].AbsoluteSize.X - items[ "satvalpicker" ].AbsoluteSize.X), 1, 1 - v * (items[ "saturation_holder" ].AbsoluteSize.Y - items[ "satvalpicker" ].AbsoluteSize.Y))}, Enum.EasingStyle.Linear, 0.05)

        items[ "alpha_indicator" ]:FindFirstChildOfClass("UIGradient").Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, hsv(h, 1, 1))};
        
        items[ "colorpicker" ].BackgroundColor3 = Color
        items[ "colorpicker_inline" ].BackgroundColor3 = Color
        items[ "saturation_holder" ].BackgroundColor3 = hsv(h, 1, 1)
        items[ "hue_picker" ].BackgroundColor3 = hsv(h, 1, 1)
        items[ "alpha_picker" ].BackgroundColor3 = hsv(h, 1, 1 - a)
        items[ "satvalpicker" ].BackgroundColor3 = hsv(h, s, v)

        flags[cfg.flag] = { Color = Color; Transparency = a }
        items[ "input" ].Text = string.format("%s, %s, %s, ", library:round(Color.R * 255), library:round(Color.G * 255), library:round(Color.B * 255))
        items[ "input" ].Text ..= library:round(1 - a, 0.01)
        
        pcall(cfg.callback, Color, a)
    end
    
    function cfg.update_color(position)
        local offset = vec2(position.X, position.Y)
        if dragging_sat then	
            s = math.clamp((offset - items["sat"].AbsolutePosition).X / items["sat"].AbsoluteSize.X, 0, 1)
            v = 1 - math.clamp((offset - items["sat"].AbsolutePosition).Y / items["sat"].AbsoluteSize.Y, 0, 1)
        elseif dragging_hue then
            h = math.clamp((offset - items[ "hue_gradient" ].AbsolutePosition).X / items[ "hue_gradient" ].AbsoluteSize.X, 0, 1)
        elseif dragging_alpha then
            a = 1 - math.clamp((offset - items[ "alpha_gradient" ].AbsolutePosition).X / items[ "alpha_gradient" ].AbsoluteSize.X, 0, 1)
        end
        cfg.set()
    end

    items[ "colorpicker" ].MouseButton1Click:Connect(function()
        cfg.open = not cfg.open 
        cfg.set_visible(cfg.open)            
    end)

    library:connection(uis.InputChanged, function(input)
        if (dragging_sat or dragging_hue or dragging_alpha) and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            cfg.update_color(input.Position)
        end
    end)

    library:connection(uis.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging_sat, dragging_hue, dragging_alpha = false, false, false
        end
    end)    

    items[ "alpha_gradient" ].MouseButton1Down:Connect(function() dragging_alpha = true end)
    items[ "hue_gradient" ].MouseButton1Down:Connect(function() dragging_hue = true end)
    items[ "sat" ].MouseButton1Down:Connect(function() dragging_sat = true end)

    items[ "input" ].FocusLost:Connect(function()
        local r, g, b, a = library:convert(items[ "input" ].Text)
        if r and g and b and a then cfg.set(rgb(r, g, b), 1 - a) end 
    end)

    items[ "input" ].Focused:Connect(function()
        library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
    end)

    items[ "input" ].FocusLost:Connect(function()
        library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
    end)
    
    cfg.set(cfg.color, cfg.alpha)
    config_flags[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end 

function library:textbox(options) 
    local cfg = {
        name = options.name or "TextBox"; placeholder = options.placeholder or options.placeholdertext or "type here...";
        default = options.default or ""; flag = options.flag or library:next_flag();
        callback = options.callback or function() end; visible = options.visible or true; items = {};
    }

    flags[cfg.flag] = cfg.default

    local items = cfg.items; do 
        items[ "textbox" ] = library:create( "TextButton" , {
            LayoutOrder = -1; Font = fonts.font; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = self.items[ "elements" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(245, 245, 245); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "textbox" ]; Name = "\0"; Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , { Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        
        items[ "right_components" ] = library:create( "Frame" , {
            Parent = items[ "textbox" ]; Name = "\0"; BackgroundTransparency = 1; Position = dim2(0, 4, 0, 19);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, 0, 0, 12); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            Parent = items[ "right_components" ]; Padding = dim(0, 7); SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal
        });
        
        items[ "input" ] = library:create( "TextBox" , {
            Font = fonts.font; Text = ""; Parent = items[ "right_components" ]; Name = "\0";
            TextTruncate = Enum.TextTruncate.AtEnd; BorderSizePixel = 0; PlaceholderColor3 = rgb(255, 255, 255);
            CursorPosition = -1; ClearTextOnFocus = false; TextSize = 14; TextColor3 = rgb(72, 72, 72);
            BorderColor3 = rgb(0, 0, 0); Position = dim2(1, 0, 0, 0); Size = dim2(1, -4, 0, 30); BackgroundColor3 = rgb(33, 33, 35)
        }); 

        library:create( "UICorner" , { Parent = items[ "input" ]; CornerRadius = dim(0, 3) });                
        library:create( "UIPadding" , { Parent = items[ "right_components" ]; PaddingTop = dim(0, 4); PaddingRight = dim(0, 4) });
    end 
    
    function cfg.set(text) 
        flags[cfg.flag] = text
        items[ "input" ].Text = text
        pcall(cfg.callback, text)
    end 
    
    items[ "input" ]:GetPropertyChangedSignal("Text"):Connect(function()
        cfg.set(items[ "input" ].Text) 
    end)

    items[ "input" ].Focused:Connect(function()
        library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
    end)

    items[ "input" ].FocusLost:Connect(function()
        library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
    end)
        
    if cfg.default then cfg.set(cfg.default) end
    config_flags[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end

function library:keybind(options) 
    local cfg = {
        flag = options.flag or library:next_flag(); callback = options.callback or function() end;
        name = options.name or nil; ignore_key = options.ignore or false; key = options.key or nil;
        mode = options.mode or "Toggle"; active = options.default or false; open = false;
        binding = nil; hold_instances = {}; items = {};
    }

    flags[cfg.flag] = { mode = cfg.mode, key = cfg.key, active = cfg.active }

    local items = cfg.items; do 
        items[ "keybind_element" ] = library:create( "TextButton" , {
            Font = fonts.font; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = self.items[ "elements" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(245, 245, 245); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name or "Keybind"; Parent = items[ "keybind_element" ]; Name = "\0"; Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , { Parent = items[ "name" ]; PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
        
        items[ "right_components" ] = library:create( "Frame" , {
            Parent = items[ "keybind_element" ]; Name = "\0"; Position = dim2(1, 0, 0, 0);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , {
            FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right;
            Parent = items[ "right_components" ]; Padding = dim(0, 7); SortOrder = Enum.SortOrder.LayoutOrder
        });
        
        items[ "keybind_holder" ] = library:create( "TextButton" , {
            Font = fonts.font; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; Parent = items[ "right_components" ]; AutoButtonColor = false;
            AnchorPoint = vec2(1, 0); Size = dim2(0, 0, 0, 16); Name = "\0"; Position = dim2(1, 0, 0, 0);
            BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; TextSize = 14; BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create( "UICorner" , { Parent = items[ "keybind_holder" ]; CornerRadius = dim(0, 4) });
        
        items[ "key" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(86, 86, 87); BorderColor3 = rgb(0, 0, 0);
            Text = "LSHIFT"; Parent = items[ "keybind_holder" ]; Name = "\0"; Size = dim2(1, -12, 0, 0);
            BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , { Parent = items[ "key" ]; PaddingTop = dim(0, 1); PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });                                  
        
        items[ "dropdown" ] = library:create( "Frame" , {
            BorderColor3 = rgb(0, 0, 0); Parent = library.items; Name = "\0"; BackgroundTransparency = 1;
            Position = dim2(0, 0, 0, 0); Size = dim2(0, 0, 0, 0); BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = rgb(0, 0, 0)
        });

        library:add_scale(items[ "dropdown" ])
        
        items[ "inline" ] = library:create( "Frame" , {
            Parent = items[ "dropdown" ]; Size = dim2(1, 0, 1, 0); Name = "\0"; ClipsDescendants = true;
            BorderColor3 = rgb(0, 0, 0); BorderSizePixel = 0; BackgroundColor3 = rgb(22, 22, 24)
        });
        
        library:create( "UIPadding" , { PaddingBottom = dim(0, 6); PaddingTop = dim(0, 3); PaddingLeft = dim(0, 3); Parent = items[ "inline" ] });
        library:create( "UIListLayout" , { Parent = items[ "inline" ]; Padding = dim(0, 5); SortOrder = Enum.SortOrder.LayoutOrder });
        library:create( "UICorner" , { Parent = items[ "inline" ]; CornerRadius = dim(0, 4) });
        
        local modes = {"Hold", "Toggle", "Always"}
        cfg.y_size = 20
        for _, option in next, modes do                        
            local name = library:create( "TextButton" , {
                Font = fonts.font; TextColor3 = rgb(72, 72, 73); BorderColor3 = rgb(0, 0, 0);
                Text = option; Parent = items[ "inline" ]; Name = "\0"; Size = dim2(0, 0, 0, 0);
                BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0;
                AutomaticSize = Enum.AutomaticSize.XY; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
            }); cfg.hold_instances[option] = name
            library:apply_theme(name, "accent", "TextColor3")
            cfg.y_size += name.AbsoluteSize.Y / library.scale

            library:create( "UIPadding" , { Parent = name; PaddingTop = dim(0, 1); PaddingRight = dim(0, 5); PaddingLeft = dim(0, 5) });
            name.MouseButton1Click:Connect(function()
                cfg.set(option)
                cfg.set_visible(false)
                cfg.open = false
            end)
        end
    end 
    
    function cfg.modify_mode_color(path)
        for _, v in next, cfg.hold_instances do v.TextColor3 = rgb(72, 72, 72) end 
        if path and cfg.hold_instances[path] then cfg.hold_instances[path].TextColor3 = themes.preset.accent end
    end

    function cfg.set_mode(mode) 
        cfg.mode = mode 
        if mode == "Always" then cfg.set(true)
        elseif mode == "Hold" then cfg.set(false) end
        flags[cfg.flag]["mode"] = mode
        cfg.modify_mode_color(mode)
    end 

    function cfg.set(input)
        if type(input) == "boolean" then 
            cfg.active = input
            if cfg.mode == "Always" then cfg.active = true end
        elseif tostring(input):find("Enum") then 
            input = input.Name == "Escape" and "NONE" or input
            cfg.key = input or "NONE"	
        elseif find({"Toggle", "Hold", "Always"}, input) then 
            if input == "Always" then cfg.active = true end 
            cfg.mode = input
            cfg.set_mode(cfg.mode) 
        elseif type(input) == "table" then 
            input.key = type(input.key) == "string" and input.key ~= "NONE" and library:convert_enum(input.key) or input.key
            input.key = input.key == Enum.KeyCode.Escape and "NONE" or input.key
            cfg.key = input.key or "NONE"
            cfg.mode = input.mode or "Toggle"
            if input.active then cfg.active = input.active end
            cfg.set_mode(cfg.mode) 
        end 

        pcall(cfg.callback, cfg.active)
        local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
        items[ "key" ].Text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", "")) or "NONE"
        flags[cfg.flag] = { mode = cfg.mode, key = cfg.key, active = cfg.active }
    end

    function cfg.set_visible(bool)
        local size = bool and cfg.y_size or 0
        if items[ "keybind_holder" ] and items[ "keybind_holder" ].Parent then
            library:tween(items[ "dropdown" ], {Size = dim_offset(items[ "keybind_holder" ].AbsoluteSize.X / library.scale, size)})
            items[ "dropdown" ].Position = dim_offset(items[ "keybind_holder" ].AbsolutePosition.X, items[ "keybind_holder" ].AbsolutePosition.Y + items[ "keybind_holder" ].AbsoluteSize.Y + 60)
        end
    end
    
    items[ "keybind_holder" ].MouseButton1Down:Connect(function()
        if IS_MOBILE then
            cfg.open = not cfg.open
            cfg.set_visible(cfg.open)
            return
        end
        task.wait()
        items[ "key" ].Text = "..."	
        cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
            cfg.set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
            if cfg.binding then
                cfg.binding:Disconnect() 
                cfg.binding = nil
            end
        end)
    end)

    items[ "keybind_holder" ].MouseButton2Down:Connect(function()
        cfg.open = not cfg.open 
        cfg.set_visible(cfg.open)
    end)

    library:connection(uis.InputBegan, function(input, game_event) 
        if not game_event then
            local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
            if selected_key == cfg.key then 
                if cfg.mode == "Toggle" then 
                    cfg.active = not cfg.active
                    cfg.set(cfg.active)
                elseif cfg.mode == "Hold" then 
                    cfg.set(true)
                end
            end
        end
    end)    

    library:connection(uis.InputEnded, function(input, game_event) 
        if game_event then return end 
        local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
        if selected_key == cfg.key and cfg.mode == "Hold" then 
            cfg.set(false)
        end
    end)
    
    cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})           
    config_flags[cfg.flag] = cfg.set

    return setmetatable(cfg, library)
end

function library:button(options) 
    local cfg = { name = options.name or "Button"; callback = options.callback or function() end; items = {} }
    
    local items = cfg.items; do 
        items[ "button_element" ] = library:create( "Frame" , {
            Parent = self.items[ "elements" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 0, 0); BorderColor3 = rgb(0, 0, 0); BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        items[ "button" ] = library:create( "TextButton" , {
            Font = fonts.font; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
            Text = ""; AutoButtonColor = false; AnchorPoint = vec2(1, 0); Parent = items[ "button_element" ];
            Name = "\0"; Position = dim2(1, -4, 0, 0); Size = dim2(1, -8, 0, 30);
            BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = rgb(33, 33, 35)
        });
        
        library:create( "UICorner" , { Parent = items[ "button" ]; CornerRadius = dim(0, 3) });
        
        items[ "name" ] = library:create( "TextLabel" , {
            Font = fonts.small; TextColor3 = rgb(245, 245, 245); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "button" ]; Name = "\0"; BackgroundTransparency = 1;
            Size = dim2(1, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY;
            TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        }); library:apply_theme(items[ "name" ], "accent", "BackgroundColor3");                            
    end 

    items[ "button" ].MouseButton1Click:Connect(function()
        pcall(cfg.callback)
        items[ "name" ].TextColor3 = themes.preset.accent 
        library:tween(items[ "name" ], {TextColor3 = rgb(245, 245, 245)})
    end)
    
    return setmetatable(cfg, library)
end 

function library:settings(options)  
    local cfg = { open = false; items = {}; sanity = true }

    local items = cfg.items; do 
        items[ "outline" ] = library:create( "Frame" , {
            Name = "\0"; Visible = true; Parent = library[ "items" ]; BorderColor3 = rgb(0, 0, 0);
            Size = dim2(0, 0, 0, 0); ClipsDescendants = true; BorderSizePixel = 0; BackgroundColor3 = rgb(25, 25, 29);
        });

        library:add_scale(items[ "outline" ])
        
        items[ "inline" ] = library:create( "Frame" , {
            Parent = items[ "outline" ]; Name = "\0"; Position = dim2(0, 1, 0, 1);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = rgb(22, 22, 24);
        });
        
        library:create( "UICorner" , { Parent = items[ "inline" ]; CornerRadius = dim(0, 7) });
        
        items[ "elements" ] = library:create( "Frame" , {
            BorderColor3 = rgb(0, 0, 0); Parent = items[ "inline" ]; Name = "\0"; BackgroundTransparency = 1;
            Position = dim2(0, 10, 0, 10); Size = dim2(1, -20, 0, 0); BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = rgb(255, 255, 255);
        });
        
        library:create( "UIListLayout" , { Parent = items[ "elements" ]; Padding = dim(0, 10); SortOrder = Enum.SortOrder.LayoutOrder });
        library:create( "UIPadding" , { PaddingBottom = dim(0, 15); Parent = items[ "elements" ] });
        library:create( "UICorner" , { Parent = items[ "outline" ]; CornerRadius = dim(0, 7) });
        
        items[ "tick" ] = library:create( "ImageButton" , {
            Image = "rbxassetid://128797200442698"; Name = "\0"; AutoButtonColor = false;
            Parent = self.items[ "right_components" ]; BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 16, 0, 16);
            BorderSizePixel = 0; BackgroundColor3 = rgb(255, 255, 255);
        });
    end 

    function cfg.set_visible(bool)                 
        items[ "outline" ].Visible = bool
        if items[ "tick" ].Parent then
            items[ "outline" ].Position = dim_offset(items[ "tick" ].AbsolutePosition.X, items[ "tick" ].AbsolutePosition.Y + 90)
        end
        library:close_element(cfg)
    end
    
    items[ "tick" ].MouseButton1Click:Connect(function()
        cfg.open = not cfg.open
        cfg.set_visible(cfg.open)
    end)

    return setmetatable(cfg, library)
end 

function library:list(properties) 
    local cfg = {
        items = {}; options = properties.options or {"1", "2", "3"};
        flag = properties.flag or library:next_flag(); callback = properties.callback or function() end;
        data_store = {}; current_element;
    }

    local items = cfg.items; do
        items[ "list" ] = library:create( "Frame" , {
            Parent = self.items[ "elements" ]; BackgroundTransparency = 1; Name = "\0";
            Size = dim2(1, 0, 0, 0); BorderColor3 = rgb(0, 0, 0); BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIListLayout" , { Parent = items[ "list" ]; Padding = dim(0, 10); SortOrder = Enum.SortOrder.LayoutOrder });
        library:create( "UIPadding" , { Parent = items[ "list" ]; PaddingRight = dim(0, 4); PaddingLeft = dim(0, 4) });
    end 

    function cfg.refresh_options(options_to_refresh)
        for _,option in next, cfg.data_store do 
            if option and option.Parent then option:Destroy() end
        end
        cfg.data_store = {}

        for _, option_data in next, options_to_refresh do
            local button = library:create( "TextButton" , {
                Font = fonts.small; TextColor3 = rgb(0, 0, 0); BorderColor3 = rgb(0, 0, 0);
                Text = ""; AutoButtonColor = false; AnchorPoint = vec2(1, 0); Parent = items[ "list" ];
                Name = "\0"; Position = dim2(1, 0, 0, 0); Size = dim2(1, 0, 0, 30);
                BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = rgb(33, 33, 35)
            }); cfg.data_store[#cfg.data_store + 1] = button;

            local name = library:create( "TextLabel" , {
                Font = fonts.font; TextColor3 = rgb(72, 72, 73); BorderColor3 = rgb(0, 0, 0);
                Text = option_data; Parent = button; Name = "\0"; BackgroundTransparency = 1;
                Size = dim2(1, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY;
                TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
            });
            
            library:create( "UICorner" , { Parent = button; CornerRadius = dim(0, 3) });     

            button.MouseButton1Click:Connect(function()
                local current = cfg.current_element 
                if current and current ~= name and current.Parent then 
                    library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                end
                flags[cfg.flag] = option_data
                pcall(cfg.callback, option_data)
                library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                cfg.current_element = name
            end)

            name.MouseEnter:Connect(function()
                if cfg.current_element ~= name then library:tween(name, {TextColor3 = rgb(140, 140, 140)}) end 
            end)

            name.MouseLeave:Connect(function()
                if cfg.current_element ~= name then library:tween(name, {TextColor3 = rgb(72, 72, 72)}) end 
            end)
        end
    end

    cfg.refresh_options(cfg.options)
    return setmetatable(cfg, library)
end 

function library:init_config(window) 
    window:seperator({name = "settings"})
    local main = window:tab({name = "settings", tabs = {"Main"}})
    
    local column = main:column({})
    local section = column:section({name = "configs", size = 1, default = true, icon = "rbxassetid://139628202576511"})
    config_holder = section:list({options = {"Report", "This", "Error", "To", "Finobe"}, callback = function(option) end, flag = "config_name_list"}); library:update_config_list()
    
    local column2 = main:column({})
    local section2 = column2:section({name = "Settings", side = "right", size = 1, default = true, icon = "rbxassetid://129380150574313"})
    section2:textbox({name = "Config name:", flag = "config_name_text"})
    section2:button({name = "Save", callback = function() 
        safe_writefile(library.directory .. "/configs/" .. (flags["config_name_text"] or flags["config_name_list"] or "unnamed") .. ".cfg", library:get_config()) 
        library:update_config_list() 
        notifications:create_notification({name = "Configs", info = "Saved config to:\n" .. (flags["config_name_list"] or flags["config_name_text"] or "unnamed")}) 
    end}) 
    section2:button({name = "Load", callback = function() 
        local ok, data = pcall(readfile, library.directory .. "/configs/" .. (flags["config_name_list"] or "") .. ".cfg") 
        if ok and data then 
            library:load_config(data) 
            library:update_config_list() 
            notifications:create_notification({name = "Configs", info = "Loaded config:\n" .. (flags["config_name_list"] or "")}) 
        end 
    end})
    section2:button({name = "Delete", callback = function() 
        safe_delfile(library.directory .. "/configs/" .. (flags["config_name_list"] or "") .. ".cfg") 
        library:update_config_list() 
        notifications:create_notification({name = "Configs", info = "Deleted config:\n" .. (flags["config_name_list"] or "")}) 
    end})
    section2:colorpicker({name = "Menu Accent", callback = function(color, alpha) library:update_theme("accent", color) end, color = themes.preset.accent})
    section2:keybind({name = "Menu Bind", callback = function(bool) window.toggle_menu(bool) end, default = true})
end

function notifications:refresh_notifs() 
    local offset = 50
    for i, v in next, notifications.notifs do
        local Position = vec2(20, offset)
        library:tween(v, {Position = dim_offset(Position.X, Position.Y)}, Enum.EasingStyle.Quad, 0.4)
        offset += (v.AbsoluteSize.Y + 10)
    end
    return offset
end

function notifications:fade(path, is_fading)
    if not path or not path.Parent then return end
    local fading = is_fading and 1 or 0 
    library:tween(path, {BackgroundTransparency = fading}, Enum.EasingStyle.Quad, 1)
    for _, instance in next, path:GetDescendants() do 
        if not instance:IsA("GuiObject") then 
            if instance:IsA("UIStroke") then
                library:tween(instance, {Transparency = fading}, Enum.EasingStyle.Quad, 1)
            end
            continue
        end 
        if instance:IsA("TextLabel") then
            library:tween(instance, {TextTransparency = fading})
        elseif instance:IsA("Frame") then
            library:tween(instance, {BackgroundTransparency = is_fading and 1 or 0.6}, Enum.EasingStyle.Quad, 1)
        end
    end
end 

function notifications:create_notification(options)
    if not library[ "items" ] then return end
    local cfg = { name = options.name or "This is a title!"; info = options.info or "This is extra info!"; lifetime = options.lifetime or 3; items = {} }

    local items = cfg.items; do 
        items[ "notification" ] = library:create( "Frame" , {
            Parent = library[ "items" ]; Size = dim2(0, 210, 0, 53); Name = "\0";
            BorderColor3 = rgb(0, 0, 0); BorderSizePixel = 0; BackgroundTransparency = 1;
            AnchorPoint = vec2(1, 0); AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = rgb(14, 14, 16)
        });

        library:add_scale(items[ "notification" ])
        library:create( "UIStroke" , { Color = rgb(23, 23, 29); Parent = items[ "notification" ]; Transparency = 1; ApplyStrokeMode = Enum.ApplyStrokeMode.Border });
        
        items[ "title" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(255, 255, 255); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.name; Parent = items[ "notification" ]; Name = "\0"; BackgroundTransparency = 1;
            Position = dim2(0, 7, 0, 6); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UICorner" , { Parent = items[ "notification" ]; CornerRadius = dim(0, 3) });
        
        items[ "info" ] = library:create( "TextLabel" , {
            Font = fonts.font; TextColor3 = rgb(145, 145, 145); BorderColor3 = rgb(0, 0, 0);
            Text = cfg.info; Parent = items[ "notification" ]; Name = "\0"; Position = dim2(0, 9, 0, 22);
            BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left;
            TextWrapped = true; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 14; BackgroundColor3 = rgb(255, 255, 255)
        });
        
        library:create( "UIPadding" , { PaddingBottom = dim(0, 17); PaddingRight = dim(0, 8); Parent = items[ "info" ] });
        
        items[ "bar" ] = library:create( "Frame" , {
            AnchorPoint = vec2(0, 1); Parent = items[ "notification" ]; Name = "\0"; Position = dim2(0, 8, 1, -6);
            BorderColor3 = rgb(0, 0, 0); Size = dim2(0, 0, 0, 5); BackgroundTransparency = 1; BorderSizePixel = 0; BackgroundColor3 = themes.preset.accent
        });
        
        library:create( "UICorner" , { Parent = items[ "bar" ]; CornerRadius = dim(0, 999) });
        library:create( "UIPadding" , { PaddingRight = dim(0, 8); Parent = items[ "notification" ] });
    end
    
    insert(notifications.notifs, items[ "notification" ])
    notifications:fade(items[ "notification" ], false)
    notifications:refresh_notifs()

    library:tween(items[ "notification" ], {AnchorPoint = vec2(0, 0)}, Enum.EasingStyle.Quad, 1)
    library:tween(items[ "bar" ], {Size = dim2(1, -8, 0, 5)}, Enum.EasingStyle.Quad, cfg.lifetime)

    task.spawn(function()
        task.wait(cfg.lifetime)
        local pos = find(notifications.notifs, items[ "notification" ])
        if pos then remove(notifications.notifs, pos) end
        notifications:fade(items[ "notification" ], true)
        library:tween(items[ "notification" ], {AnchorPoint = vec2(1, 0)}, Enum.EasingStyle.Quad, 1)
        task.wait(1)
        if items[ "notification" ] and items[ "notification" ].Parent then
            items[ "notification" ]:Destroy() 
        end
    end)
end

return library