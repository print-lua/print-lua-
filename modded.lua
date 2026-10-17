--[[
    Milenium Library (FIXED SCROLLING & FONTS)
]]

local uis = game:GetService("UserInputService") 
local players = game:GetService("Players") 
local ws = game:GetService("Workspace")
local http_service = game:GetService("HttpService")
local coregui = game:GetService("CoreGui")
local tween_service = game:GetService("TweenService")

local vec2 = Vector2.new
local dim2 = UDim2.new
local dim  = UDim.new 
local rect = Rect.new
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

local floor, min, clamp = math.floor, math.min, math.clamp
local insert, find, remove, concat = table.insert, table.find, table.remove, table.concat

local IS_MOBILE = uis.TouchEnabled and not uis.KeyboardEnabled
local PLATFORM  = IS_MOBILE and "MOBILE" or "PC"

local function safe_pcall(fn, ...) local ok, a, b, c = pcall(fn, ...) if ok then return a, b, c end return nil end
local function safe_isfile(p) return (safe_pcall(isfile, p) == true) end
local function safe_delfile(p) safe_pcall(delfile, p) end
local function safe_listfiles(p) return safe_pcall(listfiles, p) or {} end

local function get_ui_parent()
    local hui = rawget(getgenv and getgenv() or {}, "gethui")
    if type(gethui) == "function" then local ok, result = pcall(gethui) if ok and result then return result end end
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
    directory = "milenium", folders = { "/configs" }, flags = {}, config_flags = {},
    connections = {}, notifications = {notifs = {}}, current_open, is_mobile = IS_MOBILE,
    platform = PLATFORM, scale = 1, scales = {}, _flag_count = 0
}

local themes = { preset = { accent = rgb(155, 150, 219) }, utility = { accent = { BackgroundColor3 = {}, TextColor3 = {}, ImageColor3 = {}, ScrollBarImageColor3 = {} } } }
local keys = { [Enum.KeyCode.Insert] = "INS", [Enum.UserInputType.MouseButton1] = "MB1", [Enum.UserInputType.MouseButton2] = "MB2" }

library.__index = library
for _, path in next, library.folders do pcall(makefolder, library.directory .. path) end

-- FIXED: Standard Font Enums instead of FontFace
local fonts = { small = Enum.Font.Gotham, font = Enum.Font.GothamBold }

library.cache = Instance.new("ScreenGui")
library.cache.Name = "\0"
library.cache.Enabled = false
library.cache.IgnoreGuiInset = true
library.cache.ResetOnSpawn = false
library.cache.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
library.cache.Parent = get_ui_parent()

local flags, config_flags, notifications = library.flags, library.config_flags, library.notifications 

function library:calc_scale(size) if not IS_MOBILE or not ws.CurrentCamera then return 1 end local vp = ws.CurrentCamera.ViewportSize return clamp(min((vp.X * 0.95) / size.X.Offset, (vp.Y * 0.90) / size.Y.Offset), 0.5, 1.25) end
function library:add_scale(instance) local s = Instance.new("UIScale") s.Scale = library.scale s.Parent = instance insert(library.scales, s) return s end
function library:set_scale(value) library.scale = value for _, s in next, library.scales do if s and s.Parent then s.Scale = value end end end
function library:tween(obj, properties, easing_style, time) if not obj or not obj.Parent then return end tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties):Play() end
function library:connection(signal, callback) local connection = signal:Connect(callback) insert(library.connections, connection) return connection end
function library:create(instance, options) local ins = Instance.new(instance) for prop, value in next, options do if value ~= nil then if prop == "Parent" then if typeof(value) == "Instance" then ins.Parent = value end else pcall(function() ins[prop] = value end) end end end return ins end
function library:next_flag() library._flag_count = library._flag_count + 1 return "flag_" .. library._flag_count end
function library:apply_theme(instance, theme, property) local theme_tbl = themes.utility[theme] if theme_tbl and theme_tbl[property] then insert(theme_tbl[property], instance) end end

function library:update_theme(theme_name, new_color)
    local theme_utility = themes.utility[theme_name]
    if theme_utility then for prop_name, objects in next, theme_utility do for _, object in next, objects do if object and object.Parent and object[prop_name] == themes.preset[theme_name] then object[prop_name] = new_color end end end end 
    themes.preset[theme_name] = new_color 
end

function library:close_element(new_path) local open_element = library.current_open if open_element and new_path ~= open_element then if open_element.set_visible then open_element.set_visible(false) end open_element.open = false end if new_path ~= open_element then library.current_open = new_path or nil end end

function library:draggify(frame, handle)
    handle = handle or frame
    local dragging, start_pos, start = false, frame.Position, nil
    handle.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true start = input.Position start_pos = frame.Position library:close_element() end end)
    library:connection(uis.InputEnded, function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    local last_drag = 0
    library:connection(uis.InputChanged, function(input)
        if not dragging or not frame.Parent then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local now = os.clock() if now - last_drag < 0.016 then return end last_drag = now
        local cam = ws.CurrentCamera if not cam then return end
        local vp, s = cam.ViewportSize, library.scale
        frame.Position = dim2(0, clamp(start_pos.X.Offset + (input.Position.X - start.X), 0, vp.X - frame.Size.X.Offset * s), 0, clamp(start_pos.Y.Offset + (input.Position.Y - start.Y), 0, vp.Y - frame.Size.Y.Offset * s))
    end)
end 

function library:window(properties)
    local cfg = { suffix = properties.suffix or "", name = properties.name or "", game_name = properties.gameInfo or "Milenium", size = properties.size or dim2(0, 700, 0, 565), selected_tab, items = {} }
    local sidebar_width = IS_MOBILE and 140 or 196
    if IS_MOBILE and not properties.size then cfg.size = dim2(0, 620, 0, 330) end
    local vp_start = ws.CurrentCamera and ws.CurrentCamera.ViewportSize or vec2(1920, 1080)
    local w, h = cfg.size.X.Offset, cfg.size.Y.Offset
    if w > vp_start.X - 20 then w = vp_start.X - 20 end if h > vp_start.Y - 20 then h = vp_start.Y - 20 end
    cfg.size = dim2(0, w, 0, h)
    library:set_scale(library:calc_scale(cfg.size))
    
    library.items = library:create("ScreenGui", { Parent = get_ui_parent(), Name = "\0", Enabled = true, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Global, IgnoreGuiInset = true })
    library.other = library:create("ScreenGui", { Parent = get_ui_parent(), Name = "\0", Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true })
    library.toggle_ui_gui = library:create("ScreenGui", { Parent = get_ui_parent(), Name = "\0", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
    
    local items = cfg.items
    items.main = library:create("Frame", { Parent = library.items, Size = cfg.size, Name = "\0", Position = dim2(0, (vp_start.X - cfg.size.X.Offset * library.scale) / 2, 0, (vp_start.Y - cfg.size.Y.Offset * library.scale) / 2), BorderSizePixel = 0, BackgroundColor3 = rgb(14, 14, 16) })
    library:add_scale(items.main)
    library:create("UICorner", { Parent = items.main, CornerRadius = dim(0, 10) })
    library:create("UIStroke", { Color = rgb(23, 23, 29), Parent = items.main, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
    
    items.side_frame = library:create("Frame", { Parent = items.main, BackgroundTransparency = 1, Name = "\0", Size = dim2(0, sidebar_width, 1, -25), BorderSizePixel = 0, BackgroundColor3 = rgb(14, 14, 16) })
    library:create("Frame", { AnchorPoint = vec2(1, 0), Parent = items.side_frame, Position = dim2(1, 0, 0, 0), Size = dim2(0, 1, 1, 0), BorderSizePixel = 0, BackgroundColor3 = rgb(21, 21, 23) })
    
    items.button_holder = library:create("ScrollingFrame", { Parent = items.side_frame, Name = "\0", BackgroundTransparency = 1, Position = dim2(0, 0, 0, 60), Size = dim2(1, 0, 1, -60), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255), ScrollBarThickness = 2, ScrollBarImageColor3 = rgb(44, 44, 46), AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = dim2(0, 0, 0, 0) })
    cfg.button_holder = items.button_holder
    library:create("UIListLayout", { Parent = items.button_holder, Padding = dim(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
    library:create("UIPadding", { PaddingTop = dim(0, 16), PaddingBottom = dim(0, 36), Parent = items.button_holder, PaddingRight = dim(0, 11), PaddingLeft = dim(0, 10) })
    
    items.title = library:create("TextLabel", { Font = fonts.font, Parent = items.side_frame, Name = "\0", Text = string.format('<u>%s</u><font color = "rgb(255, 255, 255)">%s</font>', cfg.name, cfg.suffix), BackgroundTransparency = 1, Size = dim2(1, 0, 0, 70), TextColor3 = themes.preset.accent, BorderSizePixel = 0, RichText = true, TextSize = 26, BackgroundColor3 = rgb(255, 255, 255) })
    library:apply_theme(items.title, "accent", "TextColor3")
    
    items.multi_holder = library:create("Frame", { Parent = items.main, Name = "\0", BackgroundTransparency = 1, Position = dim2(0, sidebar_width, 0, 0), Size = dim2(1, -sidebar_width, 0, 56), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255) })
    cfg.multi_holder = items.multi_holder
    library:create("Frame", { AnchorPoint = vec2(0, 1), Parent = items.multi_holder, Position = dim2(0, 0, 1, 0), Size = dim2(1, 0, 0, 1), BorderSizePixel = 0, BackgroundColor3 = rgb(21, 21, 23) })
    
    items.shadow = library:create("ImageLabel", { ImageColor3 = rgb(0,0,0), ScaleType = Enum.ScaleType.Slice, Parent = items.main, BackgroundColor3 = rgb(255,255,255), Size = dim2(1, 75, 1, 75), AnchorPoint = vec2(0.5, 0.5), Image = "rbxassetid://112971167999062", BackgroundTransparency = 1, Position = dim2(0.5, 0, 0.5, 0), SliceScale = 0.75, ZIndex = -100, BorderSizePixel = 0, SliceCenter = rect(vec2(112, 112), vec2(147, 147)) })
    items.global_fade = library:create("Frame", { Parent = items.main, Name = "\0", BackgroundTransparency = 1, Position = dim2(0, sidebar_width, 0, 56), Size = dim2(1, -sidebar_width, 1, -81), BorderSizePixel = 0, BackgroundColor3 = rgb(14, 14, 16), ZIndex = 2 })
    library:create("UICorner", { Parent = items.shadow, CornerRadius = dim(0, 5) })
    
    items.info = library:create("Frame", { AnchorPoint = vec2(0, 1), Parent = items.main, Name = "\0", Position = dim2(0, 0, 1, 0), Size = dim2(1, 0, 0, 25), BorderSizePixel = 0, BackgroundColor3 = rgb(23, 23, 25) })
    library:create("UICorner", { Parent = items.info, CornerRadius = dim(0, 10) })
    
    items.toggle_ui_btn = library:create("TextButton", { Parent = library.toggle_ui_gui, Name = "\0", AnchorPoint = vec2(1, 1), Position = dim2(1, -20, 1, -20), Size = dim2(0, 160, 0, 52), BackgroundColor3 = rgb(30, 30, 36), BorderSizePixel = 0, AutoButtonColor = false, Font = fonts.font, Text = "toggle ui", TextSize = 15, TextColor3 = rgb(255, 255, 255), ZIndex = 50 })
    library:create("UICorner", { Parent = items.toggle_ui_btn, CornerRadius = dim(0, 999) })
    library:create("UIStroke", { Parent = items.toggle_ui_btn, Color = rgb(50, 50, 62), Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
    
    if IS_MOBILE then library:draggify(items.main, items.title) else library:draggify(items.main) end
    
    function cfg.toggle_menu(bool) if library.items then library.items.Enabled = bool end end
    items.toggle_ui_btn.MouseButton1Click:Connect(function() if library.items then cfg.toggle_menu(not library.items.Enabled) end end)
    return setmetatable(cfg, library)
end

function library:tab(properties)
    local cfg = { name = properties.name or "visuals", icon = properties.icon or "http://www.roblox.com/asset/?id=6034767608", tabs = properties.tabs or {"Main"}, pages = {}, current_multi, items = {} }
    local sidebar_width = IS_MOBILE and 140 or 196
    local items = cfg.items
    
    items.tab_holder = library:create("Frame", { Parent = library.cache, Name = "\0", Visible = false, BackgroundTransparency = 1, Position = dim2(0, sidebar_width, 0, 56), Size = dim2(1, -(sidebar_width + 20), 1, -101), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255) })
    items.button = library:create("TextButton", { Font = fonts.font, Parent = self.items.button_holder, BackgroundTransparency = 1, Name = "\0", Size = dim2(1, 0, 0, 35), BorderSizePixel = 0, BackgroundColor3 = rgb(29, 29, 29) })
    items.icon = library:create("ImageLabel", { ImageColor3 = rgb(72, 72, 73), Parent = items.button, AnchorPoint = vec2(0, 0.5), Image = cfg.icon, BackgroundTransparency = 1, Position = dim2(0, 10, 0.5, 0), Name = "\0", Size = dim2(0, 22, 0, 22), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255) })
    library:apply_theme(items.icon, "accent", "ImageColor3")
    items.name = library:create("TextLabel", { Font = fonts.font, TextColor3 = rgb(72, 72, 73), Text = cfg.name, Parent = items.button, Name = "\0", Size = dim2(0, 0, 1, 0), Position = dim2(0, 40, 0, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X, TextSize = 16, BackgroundColor3 = rgb(255, 255, 255) })
    library:create("UICorner", { Parent = items.button, CornerRadius = dim(0, 7) })
    
    items.multi_section_button_holder = library:create("Frame", { Parent = library.cache, BackgroundTransparency = 1, Name = "\0", Visible = false, Size = dim2(1, 0, 1, 0), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255) })
    library:create("UIListLayout", { Parent = items.multi_section_button_holder, Padding = dim(0, 7), SortOrder = Enum.SortOrder.LayoutOrder, FillDirection = Enum.FillDirection.Horizontal })
    library:create("UIPadding", { PaddingTop = dim(0, 8), PaddingBottom = dim(0, 7), Parent = items.multi_section_button_holder, PaddingRight = dim(0, 7), PaddingLeft = dim(0, 7) })
    
    for _, section in next, cfg.tabs do
        local data = {items = {}}
        local mi = data.items
        mi.button = library:create("TextButton", { Font = fonts.font, Parent = items.multi_section_button_holder, Name = "\0", Size = dim2(0, 0, 0, 39), BackgroundTransparency = 1, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X, TextSize = 16, BackgroundColor3 = rgb(25, 25, 29) })
        mi.name = library:create("TextLabel", { Font = fonts.font, TextColor3 = rgb(62, 62, 63), Text = section, Parent = mi.button, Name = "\0", Size = dim2(0, 0, 1, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY, TextSize = 16, BackgroundColor3 = rgb(255, 255, 255) })
        mi.accent = library:create("Frame", { AnchorPoint = vec2(0, 1), Parent = mi.button, BackgroundTransparency = 1, Position = dim2(0, 10, 1, 4), Name = "\0", Size = dim2(1, -20, 0, 6), BorderSizePixel = 0, BackgroundColor3 = themes.preset.accent })
        library:apply_theme(mi.accent, "accent", "BackgroundColor3")
        library:create("UICorner", { Parent = mi.accent, CornerRadius = dim(0, 999) })
        library:create("UICorner", { Parent = mi.button, CornerRadius = dim(0, 7) })
        
        mi.tab = library:create("Frame", { Parent = library.cache, BackgroundTransparency = 1, Name = "\0", Size = dim2(1, -20, 1, -20), BorderSizePixel = 0, Visible = false, BackgroundColor3 = rgb(255, 255, 255) })
        library:create("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, HorizontalFlex = Enum.UIFlexAlignment.Fill, Parent = mi.tab, Padding = dim(0, 7), SortOrder = Enum.SortOrder.LayoutOrder })
        library:create("UIPadding", { PaddingTop = dim(0, 7), PaddingBottom = dim(0, 7), Parent = mi.tab, PaddingRight = dim(0, 7), PaddingLeft = dim(0, 7) })
        
        data.text, data.accent, data.button, data.page = mi.name, mi.accent, mi.button, mi.tab
        data.parent = setmetatable(data, library):sub_tab({}).items.tab_parent
        
        function data.open_page()
            local page = cfg.current_multi
            if page and page.text ~= data.text then self.items.global_fade.BackgroundTransparency = 0 library:tween(self.items.global_fade, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4) page.page.Size = dim2(1, -20, 1, -20) end
            if page then library:tween(page.text, {TextColor3 = rgb(62, 62, 63)}) library:tween(page.accent, {BackgroundTransparency = 1}) library:tween(page.button, {BackgroundTransparency = 1}) page.page.Visible = false page.page.Parent = library.cache end
            library:tween(data.text, {TextColor3 = rgb(255, 255, 255)}) library:tween(data.accent, {BackgroundTransparency = 0}) library:tween(data.button, {BackgroundTransparency = 0}) library:tween(data.page, {Size = dim2(1, 0, 1, 0)}, Enum.EasingStyle.Quad, 0.4)
            data.page.Visible = true data.page.Parent = items.tab_holder cfg.current_multi = data library:close_element()
        end
        mi.button.MouseButton1Down:Connect(function() data.open_page() end)
        cfg.pages[#cfg.pages + 1] = setmetatable(data, library)
    end
    
    function cfg.open_tab()
        local selected_tab = self.selected_tab
        if selected_tab then
            if selected_tab[4] ~= items.tab_holder then self.items.global_fade.BackgroundTransparency = 0 library:tween(self.items.global_fade, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4) selected_tab[4].Size = dim2(1, -(sidebar_width + 20), 1, -101) end
            library:tween(selected_tab[1], {BackgroundTransparency = 1}) library:tween(selected_tab[2], {ImageColor3 = rgb(72, 72, 73)}) library:tween(selected_tab[3], {TextColor3 = rgb(72, 72, 73)})
            selected_tab[4].Visible = false selected_tab[4].Parent = library.cache selected_tab[5].Visible = false selected_tab[5].Parent = library.cache
        end
        library:tween(items.button, {BackgroundTransparency = 0}) library:tween(items.icon, {ImageColor3 = themes.preset.accent}) library:tween(items.name, {TextColor3 = rgb(255, 255, 255)}) library:tween(items.tab_holder, {Size = dim2(1, -sidebar_width, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
        items.tab_holder.Visible = true items.tab_holder.Parent = self.items.main items.multi_section_button_holder.Visible = true items.multi_section_button_holder.Parent = self.items.multi_holder
        self.selected_tab = {items.button, items.icon, items.name, items.tab_holder, items.multi_section_button_holder}
        library:close_element()
    end
    
    items.button.MouseButton1Down:Connect(function() cfg.open_tab() end)
    if not self.selected_tab then cfg.open_tab() end
    return unpack(cfg.pages)
end

function library:sub_tab(properties) local cfg = {items = {}, order = properties.order or 0, size = properties.size or 1} cfg.items.tab_parent = library:create("Frame", {Parent = self.items.tab, BackgroundTransparency = 1, Name = "\0", Size = dim2(0, 0, cfg.size, 0), BorderSizePixel = 0, Visible = true, BackgroundColor3 = rgb(255, 255, 255)}) library:create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalFlex = Enum.UIFlexAlignment.Fill, Parent = cfg.items.tab_parent, Padding = dim(0, 7), SortOrder = Enum.SortOrder.LayoutOrder}) return setmetatable(cfg, library) end

-- FIXED: Column is now a ScrollingFrame to prevent squishing
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

function library:section(properties) local cfg = {name = properties.name or "section", size = properties.size or self.size or 0.5, items = {}} local items = cfg.items items.outline = library:create("Frame", {Name = "\0", Parent = self.items.column, Size = dim2(0, 0, cfg.size, -3), BorderSizePixel = 0, BackgroundColor3 = rgb(25, 25, 29)}) library:create("UICorner", {Parent = items.outline, CornerRadius = dim(0, 7)}) items.inline = library:create("Frame", {Parent = items.outline, Name = "\0", Position = dim2(0, 1, 0, 1), Size = dim2(1, -2, 1, -2), BorderSizePixel = 0, BackgroundColor3 = rgb(22, 22, 24)}) library:create("UICorner", {Parent = items.inline, CornerRadius = dim(0, 7)}) items.scrolling = library:create("ScrollingFrame", {ScrollBarImageColor3 = rgb(44, 44, 46), Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, Parent = items.inline, Name = "\0", Size = dim2(1, 0, 1, -40), BackgroundTransparency = 1, Position = dim2(0, 0, 0, 35), BorderSizePixel = 0, CanvasSize = dim2(0, 0, 0, 0)}) items.elements = library:create("Frame", {Parent = items.scrolling, Name = "\0", BackgroundTransparency = 1, Position = dim2(0, 10, 0, 10), Size = dim2(1, -20, 0, 0), BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = rgb(255, 255, 255)}) library:create("UIListLayout", {Parent = items.elements, Padding = dim(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}) library:create("UIPadding", {PaddingBottom = dim(0, 15), Parent = items.elements}) items.button = library:create("TextButton", {Font = fonts.font, Parent = items.outline, Name = "\0", Position = dim2(0, 1, 0, 1), Size = dim2(1, -2, 0, 35), BorderSizePixel = 0, BackgroundColor3 = rgb(19, 19, 21)}) library:create("UICorner", {Parent = items.button, CornerRadius = dim(0, 7)}) items.section_title = library:create("TextLabel", {Font = fonts.font, Parent = items.button, Name = "\0", Text = cfg.name, Size = dim2(0, 0, 1, 0), Position = dim2(0, 10, 0, -1), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.X, TextSize = 16, BackgroundColor3 = rgb(255, 255, 255)}) return setmetatable(cfg, library) end

function library:toggle(options)
    local cfg = { name = options.name or "Toggle", flag = options.flag or library:next_flag(), default = options.default or false, callback = options.callback or function() end, items = {} }
    flags[cfg.flag] = cfg.default
    local items = cfg.items
    items.toggle = library:create("TextButton", {Font = fonts.small, Parent = self.items.elements, Name = "\0", BackgroundTransparency = 1, Size = dim2(1, 0, 0, 0), BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = rgb(255, 255, 255)})
    items.name = library:create("TextLabel", {Font = fonts.small, TextColor3 = rgb(245, 245, 245), Text = cfg.name, Parent = items.toggle, Name = "\0", Size = dim2(1, 0, 0, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY, TextSize = 16, BackgroundColor3 = rgb(255, 255, 255)})
    items.right_components = library:create("Frame", {Parent = items.toggle, Name = "\0", Position = dim2(1, 0, 0, 0), Size = dim2(0, 0, 1, 0), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255)})
    library:create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Parent = items.right_components, Padding = dim(0, 9), SortOrder = Enum.SortOrder.LayoutOrder})
    items.toggle_button = library:create("TextButton", {LayoutOrder = 2, AnchorPoint = vec2(1, 0.5), Parent = items.right_components, Name = "\0", Position = dim2(1, -9, 0.5, 0), Size = dim2(0, 36, 0, 18), BorderSizePixel = 0, BackgroundColor3 = rgb(58, 58, 62)})
    library:apply_theme(items.toggle_button, "accent", "BackgroundColor3")
    library:create("UICorner", {Parent = items.toggle_button, CornerRadius = dim(0, 999)})
    items.inline = library:create("Frame", {Parent = items.toggle_button, Size = dim2(1, -2, 1, -2), Name = "\0", BorderMode = Enum.BorderMode.Inset, Position = dim2(0, 1, 0, 1), BorderSizePixel = 0, BackgroundColor3 = rgb(50, 50, 50)})
    library:create("UICorner", {Parent = items.inline, CornerRadius = dim(0, 999)})
    items.circle = library:create("Frame", {Parent = items.inline, Name = "\0", Position = dim2(1, -14, 0, 2), Size = dim2(0, 12, 0, 12), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255)})
    library:create("UICorner", {Parent = items.circle, CornerRadius = dim(0, 999)})
    function cfg.set(bool) library:tween(items.toggle_button, {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad) library:tween(items.inline, {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad) library:tween(items.circle, {Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad) pcall(cfg.callback, bool) flags[cfg.flag] = bool end
    items.toggle.MouseButton1Click:Connect(function() cfg.set(not flags[cfg.flag]) end)
    items.toggle_button.MouseButton1Click:Connect(function() cfg.set(not flags[cfg.flag]) end)
    cfg.set(cfg.default) config_flags[cfg.flag] = cfg.set
    return setmetatable(cfg, library)
end

function library:slider(options)
    local cfg = { name = options.name or "", suffix = options.suffix or "", flag = options.flag or library:next_flag(), callback = options.callback or function() end, min = options.min or 0, max = options.max or 100, intervals = options.interval or 1, default = options.default or 10, value = options.default or 10, dragging = false, items = {} }
    flags[cfg.flag] = cfg.default
    local items = cfg.items
    items.slider_object = library:create("TextButton", {Parent = self.items.elements, Name = "\0", BackgroundTransparency = 1, Size = dim2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255)})
    items.name = library:create("TextLabel", {Font = fonts.small, TextColor3 = rgb(245, 245, 245), Text = cfg.name, Parent = items.slider_object, Name = "\0", Size = dim2(1, 0, 0, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.XY, TextSize = 16, BackgroundColor3 = rgb(255, 255, 255)})
    items.right_components = library:create("Frame", {Parent = items.slider_object, Name = "\0", BackgroundTransparency = 1, Position = dim2(0, 4, 0, 23), Size = dim2(1, 0, 0, 12), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255)})
    items.slider = library:create("TextButton", {AnchorPoint = vec2(1, 0), Parent = items.right_components, Name = "\0", Position = dim2(1, 0, 0, 0), Size = dim2(1, -4, 0, 4), BorderSizePixel = 0, BackgroundColor3 = rgb(33, 33, 35)})
    library:create("UICorner", {Parent = items.slider, CornerRadius = dim(0, 999)})
    items.fill = library:create("Frame", {Parent = items.slider, Name = "\0", Size = dim2(0.5, 0, 0, 4), BorderSizePixel = 0, BackgroundColor3 = themes.preset.accent})
    library:apply_theme(items.fill, "accent", "BackgroundColor3")
    items.value = library:create("TextLabel", {Font = fonts.small, TextColor3 = rgb(72, 72, 73), Parent = items.slider_object, Name = "\0", Size = dim2(1, 0, 0, 0), Position = dim2(0, 6, 0, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Right, AutomaticSize = Enum.AutomaticSize.XY, TextSize = 16, BackgroundColor3 = rgb(255, 255, 255)})
    function cfg.set(value) cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max) library:tween(items.fill, {Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), cfg.value == cfg.min and 0 or -4, 0, 2)}, Enum.EasingStyle.Linear, 0.05) items.value.Text = tostring(cfg.value) .. cfg.suffix flags[cfg.flag] = cfg.value pcall(cfg.callback, cfg.value) end
    items.slider.MouseButton1Down:Connect(function() cfg.dragging = true end)
    library:connection(uis.InputChanged, function(input) if cfg.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local size_x = (input.Position.X - items.slider.AbsolutePosition.X) / items.slider.AbsoluteSize.X cfg.set(((cfg.max - cfg.min) * size_x) + cfg.min) end end)
    library:connection(uis.InputEnded, function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then cfg.dragging = false end end)
    cfg.set(cfg.default) config_flags[cfg.flag] = cfg.set
    return setmetatable(cfg, library)
end

function library:dropdown(options)
    local cfg = { name = options.name or "", flag = options.flag or library:next_flag(), options = options.items or {""}, callback = options.callback or function() end, width = options.width or 130, open = false, option_instances = {}, items = {} }
    cfg.default = options.default or cfg.options[1] or "None" flags[cfg.flag] = cfg.default
    local items = cfg.items
    items.dropdown_object = library:create("TextButton", {Parent = self.items.elements, Name = "\0", BackgroundTransparency = 1, Size = dim2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255)})
    items.name = library:create("TextLabel", {Font = fonts.small, TextColor3 = rgb(245, 245, 245), Text = cfg.name or "Dropdown", Parent = items.dropdown_object, Name = "\0", Size = dim2(1, 0, 0, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.XY, TextSize = 16, BackgroundColor3 = rgb(255, 255, 255)})
    items.right_components = library:create("Frame", {Parent = items.dropdown_object, Name = "\0", Position = dim2(1, 0, 0, 0), Size = dim2(0, 0, 1, 0), BorderSizePixel = 0, BackgroundColor3 = rgb(255, 255, 255)})
    items.dropdown = library:create("TextButton", {AnchorPoint = vec2(1, 0), Parent = items.right_components, Name = "\0", Position = dim2(1, 0, 0, 0), Size = dim2(0, cfg.width, 0, 16), BorderSizePixel = 0, BackgroundColor3 = rgb(33, 33, 35)})
    library:create("UICorner", {Parent = items.dropdown, CornerRadius = dim(0, 4)})
    items.sub_text = library:create("TextLabel", {Font = fonts.small, TextColor3 = rgb(86, 86, 87), Parent = items.dropdown, Name = "\0", Size = dim2(1, -12, 0, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.Y, TextSize = 14, BackgroundColor3 = rgb(255, 255, 255)})
    items.dropdown_holder = library:create("Frame", {Parent = library.items, Name = "\0", Visible = true, BackgroundTransparency = 1, Size = dim2(0, 0, 0, 0), BorderSizePixel = 0, ZIndex = 10})
    items.outline = library:create("Frame", {Parent = items.dropdown_holder, Size = dim2(1, 0, 1, 0), ClipsDescendants = true, BorderSizePixel = 0, BackgroundColor3 = rgb(33, 33, 35), ZIndex = 10})
    library:create("UIListLayout", {Parent = items.outline, Padding = dim(0, 5), SortOrder = Enum.SortOrder.LayoutOrder})
    
    function cfg.set_visible(bool) local a = bool and (#cfg.options * 22) or 0 if items.dropdown and items.dropdown.Parent then library:tween(items.dropdown_holder, {Size = dim_offset(items.dropdown.AbsoluteSize.X / library.scale, a)}) items.dropdown_holder.Position = dim2(0, items.dropdown.AbsolutePosition.X, 0, items.dropdown.AbsolutePosition.Y + 80) end library:close_element(cfg) end
    function cfg.set(value)
        for _, opt in next, cfg.option_instances do if opt.Text == value then opt.TextColor3 = themes.preset.accent else opt.TextColor3 = rgb(72, 72, 73) end end
        items.sub_text.Text = tostring(value) flags[cfg.flag] = value pcall(cfg.callback, value) 
    end
    function cfg.refresh_options(list)
        for _, opt in next, cfg.option_instances do opt:Destroy() end cfg.option_instances = {}
        for _, option in next, list do
            local button = library:create("TextButton", {Font = fonts.small, TextColor3 = rgb(72, 72, 73), Text = option, Parent = items.outline, Name = "\0", Size = dim2(1, -12, 0, 18), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, BorderSizePixel = 0, TextSize = 14, BackgroundColor3 = rgb(255, 255, 255), ZIndex = 10})
            insert(cfg.option_instances, button)
            button.MouseButton1Down:Connect(function() cfg.set_visible(false) cfg.open = false cfg.set(button.Text) end)
        end
        cfg.options = list
    end
    items.dropdown.MouseButton1Click:Connect(function() cfg.open = not cfg.open cfg.set_visible(cfg.open) end)
    config_flags[cfg.flag] = cfg.set cfg.refresh_options(cfg.options)
    return setmetatable(cfg, library)
end

function library:colorpicker(options)
    local cfg = { name = options.name or "Color", flag = options.flag or library:next_flag(), color = options.color or rgb(255,255,255), alpha = options.alpha or 0, open = false, callback = options.callback or function() end, items = {} }
    local items = cfg.items
    items.colorpicker = library:create("TextButton", {AnchorPoint = vec2(1, 0), Parent = self.items.right_components, Name = "\0", Size = dim2(0, 16, 0, 16), BorderSizePixel = 0, BackgroundColor3 = cfg.color})
    library:create("UICorner", {Parent = items.colorpicker, CornerRadius = dim(0, 4)})
    items.colorpicker_inline = library:create("Frame", {Parent = items.colorpicker, Size = dim2(1, -2, 1, -2), Name = "\0", Position = dim2(0, 1, 0, 1), BorderSizePixel = 0, BackgroundColor3 = cfg.color})
    library:create("UICorner", {Parent = items.colorpicker_inline, CornerRadius = dim(0, 4)})
    
    items.colorpicker_holder = library:create("Frame", {Parent = library.other, Name = "\0", Position = dim2(0.2, 20, 0.297, 0), Size = dim2(0, 166, 0, 197), BorderSizePixel = 0, Visible = true, BackgroundColor3 = rgb(25, 25, 29)})
    items.colorpicker_components = library:create("Frame", {Parent = items.colorpicker_holder, Name = "\0", Position = dim2(0, 1, 0, 1), Size = dim2(1, -2, 1, -2), BorderSizePixel = 0, BackgroundColor3 = rgb(22, 22, 24)})
    library:create("UICorner", {Parent = items.colorpicker_components, CornerRadius = dim(0, 6)})
    
    function cfg.set_visible(bool) items.colorpicker_holder.Parent = bool and library.items or library.other if items.colorpicker.Parent then items.colorpicker_holder.Position = dim_offset(items.colorpicker.AbsolutePosition.X, items.colorpicker.AbsolutePosition.Y + items.colorpicker.AbsoluteSize.Y + 45) end library:close_element(cfg) end
    function cfg.set(color) items.colorpicker.BackgroundColor3 = color items.colorpicker_inline.BackgroundColor3 = color flags[cfg.flag] = color pcall(cfg.callback, color, 0) end
    items.colorpicker.MouseButton1Click:Connect(function() cfg.open = not cfg.open cfg.set_visible(cfg.open) end)
    cfg.set(cfg.color) config_flags[cfg.flag] = cfg.set
    return setmetatable(cfg, library)
end

function library:label(options) local cfg = { name = options.name or "", items = {} } cfg.items.label = library:create("TextButton", {Parent = self.items.elements, Name = "\0", BackgroundTransparency = 1, Size = dim2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y}) cfg.items.name = library:create("TextLabel", {Font = fonts.small, TextColor3 = rgb(245, 245, 245), Text = cfg.name, Parent = cfg.items.label, Name = "\0", Size = dim2(1, 0, 0, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.XY, TextSize = 16}) return setmetatable(cfg, library) end
function library:button(options) local cfg = { name = options.name or "", callback = options.callback or function() end, items = {} } cfg.items.btn = library:create("TextButton", {Parent = self.items.elements, BackgroundTransparency = 1, Size = dim2(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y}) cfg.items.inner = library:create("TextButton", {AnchorPoint = vec2(1, 0), Parent = cfg.items.btn, Position = dim2(1, -4, 0, 0), Size = dim2(1, -8, 0, 30), BackgroundColor3 = rgb(33, 33, 35), Text = cfg.name, TextColor3 = rgb(245,245,245), Font = fonts.small}) library:create("UICorner", {Parent = cfg.items.inner, CornerRadius = dim(0,3)}) cfg.items.inner.MouseButton1Click:Connect(function() pcall(cfg.callback) end) return setmetatable(cfg, library) end

return library