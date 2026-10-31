local Skin = {
    Background = Color3.fromRGB(12, 13, 18),
    Surface = Color3.fromRGB(20, 21, 29),
    SurfaceHover = Color3.fromRGB(29, 30, 41),
    Accent = Color3.fromRGB(235, 48, 66),
    AccentDark = Color3.fromRGB(95, 24, 36),
    Text = Color3.fromRGB(242, 243, 248),
    Muted = Color3.fromRGB(142, 145, 158),
    Border = Color3.fromRGB(48, 40, 51),
    
}

local function corner(object, radius)
    local c = object:FindFirstChildOfClass("UICorner")
    if not c then
        c = Instance.new("UICorner")
        c.Parent = object
    end
    c.CornerRadius = UDim.new(0, radius)
end

local function stroke(object, color, thickness, transparency)
    local s = object:FindFirstChildOfClass("UIStroke")
    if not s then
        s = Instance.new("UIStroke")
        s.Parent = object
    end
    s.Color = color
    s.Thickness = thickness
    s.Transparency = transparency or 0
end

-- Main window
bgBox.Size = UDim2.fromOffset(340, 540)
bgBox.BackgroundColor3 = Skin.Background
bgBox.BorderSizePixel = 0
corner(bgBox, 14)
stroke(bgBox, Skin.Border, 1.2, 0)

-- Soft shadow behind the window
local shadow = bgBox:FindFirstChild("ConExShadow")
if not shadow then
    shadow = Instance.new("ImageLabel")
    shadow.Name = "ConExShadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.35
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Size = UDim2.new(1, 34, 1, 34)
    shadow.Position = UDim2.new(0, -17, 0, -17)
    shadow.ZIndex = 0
    shadow.Parent = bgBox
end
bgBox.ZIndex = 5

-- Header
dragBar.BackgroundColor3 = Color3.fromRGB(17, 18, 25)
corner(dragBar, 14)
dragBarFix.BackgroundColor3 = dragBar.BackgroundColor3
dragIcon.Text = "✦   CON EX"
dragIcon.TextColor3 = Skin.Text
dragIcon.Font = Enum.Font.GothamBold
dragIcon.TextSize = 14

-- Accent line under the header
local accentLine = bgBox:FindFirstChild("ConExAccentLine")
if not accentLine then
    accentLine = Instance.new("Frame")
    accentLine.Name = "ConExAccentLine"
    accentLine.BorderSizePixel = 0
    accentLine.BackgroundColor3 = Skin.Accent
    accentLine.Size = UDim2.new(1, -28, 0, 2)
    accentLine.Position = UDim2.new(0, 14, 0, 35)
    accentLine.ZIndex = 10
    accentLine.Parent = bgBox
    corner(accentLine, 2)
end

-- Tabs
tabBar.BackgroundColor3 = Skin.Background
for _, tab in ipairs({clientTab, espTab, aimTab}) do
    tab.BackgroundColor3 = Skin.Surface
    tab.TextColor3 = Skin.Muted
    tab.Font = Enum.Font.GothamSemibold
    tab.TextSize = 12
    corner(tab, 8)
end
tabUnderline.BackgroundColor3 = Skin.Accent
tabUnderline.Size = UDim2.new(0.333, 0, 0, 3)

-- Scroll panels
for _, scroll in ipairs({clientScroll, espScroll, aimScroll}) do
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = Skin.Accent
    scroll.ScrollBarImageTransparency = 0.15
end

-- Section headings and descriptions
for _, root in ipairs({clientScroll, espScroll, aimScroll}) do
    for _, item in ipairs(root:GetDescendants()) do
        if item:IsA("TextLabel") then
            if item.Text == string.upper(item.Text) and #item.Text < 28 then
                item.TextColor3 = Skin.Accent
                item.Font = Enum.Font.GothamBold
                item.TextSize = 10
            elseif item.Font == Enum.Font.Code then
                item.TextColor3 = Skin.Muted
            else
                item.TextColor3 = Skin.Text
                item.Font = Enum.Font.Gotham
            end
        end
    end
end

-- Buttons: consistent surfaces, rounded corners and accent borders
for _, item in ipairs(bgBox:GetDescendants()) do
    if item:IsA("TextButton") then
        corner(item, 9)
        item.AutoButtonColor = false
        if item == rtxBtn or item == aimbotBtn or item == espToggleBtn then
            item.BackgroundColor3 = Skin.Surface
            item.TextColor3 = Skin.Text
            item.Font = Enum.Font.GothamBold
            item.TextSize = 13
            stroke(item, Skin.Border, 1, 0)
        end
    end
end

-- Sliders and tracks
for _, trackObject in ipairs({
    track, bgTrack, aimTrack, fovTrack, smoothTrack, distTrack, espDistTrack
}) do
    trackObject.BackgroundColor3 = Skin.SurfaceHover
    trackObject.BorderSizePixel = 0
    corner(trackObject, 8)
end

for _, knobObject in ipairs({knob, bgKnob, aimKnob, fovKnob, smoothKnob, distKnob, espDistKnob}) do
    corner(knobObject, 10)
    knobObject.BackgroundColor3 = Skin.Accent
    stroke(knobObject, Skin.Text, 1.2, 0.2)
end

for _, fillObject in ipairs({fovFill, smoothFill, distFill, espDistFill}) do
    fillObject.BackgroundColor3 = Skin.Accent
    corner(fillObject, 8)
end

-- Keep the window above its shadow and preserve the existing L-key hide toggle.
for _, child in ipairs(bgBox:GetChildren()) do
    if child ~= shadow then
        if child:IsA("GuiObject") and child.ZIndex < 5 then
            child.ZIndex = 5
        end
    end
end

print("[Con Ex] Dark red UI skin applied.")
