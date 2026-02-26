local AUTO_HIDE = true
local BTN_COLOR = Color3.fromRGB(59, 15, 116)

---------------- ROOT GUI ----------------
local CoreGui = game:GetService("CoreGui")
pcall(function()
    local old = CoreGui:FindFirstChild("GAZE_SimpleLauncher")
    if old then old:Destroy() end
end)

local root = Instance.new("ScreenGui")
root.Name = "GAZE_SimpleLauncher"
root.ResetOnSpawn = false
root.IgnoreGuiInset = true
root.DisplayOrder = 10000
root.Parent = CoreGui

---------------- MAIN WINDOW ----------------
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(220,260)
Main.Position = UDim2.new(0.5,-110,0.5,-130)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = root
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

---------------- HEADER ----------------
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,22)
Header.BackgroundColor3 = Color3.fromRGB(25,25,35)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-30,1,0)
Title.Position = UDim2.new(0,8,0,0)
Title.BackgroundTransparency = 1
Title.Text = "Menu Velliya"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Close = Instance.new("TextButton")
Close.AnchorPoint = Vector2.new(1,0)
Close.Position = UDim2.new(1,-6,0,3)
Close.Size = UDim2.fromOffset(20,16)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(200,40,40)
Close.BorderSizePixel = 0
Close.Parent = Header
Instance.new("UICorner", Close).CornerRadius = UDim.new(0,5)
Close.MouseButton1Click:Connect(function() root:Destroy() end)

---------------- DRAG ----------------
local UIS = game:GetService("UserInputService")
do
    local dragging=false; local dragStart; local startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true
            dragStart=input.Position
            startPos=Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            local delta=input.Position-dragStart
            Main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=false
        end
    end)
end

---------------- TOGGLE AUTO ----------------
local ToggleHolder = Instance.new("Frame")
ToggleHolder.Size = UDim2.new(1,-10,0,30)
ToggleHolder.Position = UDim2.new(0,5,0,26)
ToggleHolder.BackgroundTransparency = 1
ToggleHolder.Parent = Main

local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(0.6,0,1,0)
AutoBtn.Text = "AUTO"
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.TextSize = 12
AutoBtn.TextColor3 = Color3.new(1,1,1)
AutoBtn.BackgroundColor3 = BTN_COLOR
AutoBtn.BorderSizePixel = 0
AutoBtn.Parent = ToggleHolder
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0,8)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(0.4,-5,1,0)
Status.Position = UDim2.new(0.6,5,0,0)
Status.BackgroundTransparency = 1
Status.Text = "OFF"
Status.Font = Enum.Font.GothamBold
Status.TextSize = 12
Status.TextColor3 = Color3.fromRGB(255,80,80)
Status.Parent = ToggleHolder

local autoEnabled=false
AutoBtn.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled
    Status.Text = autoEnabled and "ON" or "OFF"
    Status.TextColor3 = autoEnabled and Color3.fromRGB(80,255,120) or Color3.fromRGB(255,80,80)
end)

---------------- SLIDER ----------------
local SliderHolder = Instance.new("Frame")
SliderHolder.Size = UDim2.new(1,-10,0,36)
SliderHolder.Position = UDim2.new(0,5,0,60)
SliderHolder.BackgroundTransparency = 1
SliderHolder.Parent = Main

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(1,0,0,6)
Bar.Position = UDim2.new(0,0,0.5,-3)
Bar.BackgroundColor3 = Color3.fromRGB(60,60,80)
Bar.BorderSizePixel = 0
Bar.Parent = SliderHolder
Instance.new("UICorner", Bar).CornerRadius = UDim.new(0,6)

local Fill = Instance.new("Frame")
Fill.Size = UDim2.new(0.4,0,1,0)
Fill.BackgroundColor3 = BTN_COLOR
Fill.BorderSizePixel = 0
Fill.Parent = Bar
Instance.new("UICorner", Fill).CornerRadius = UDim.new(0,6)

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1,0,0,14)
PercentLabel.Position = UDim2.new(0,0,1,2)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "40%"
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 11
PercentLabel.TextColor3 = Color3.new(1,1,1)
PercentLabel.Parent = SliderHolder

local draggingSlider=false
Bar.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then draggingSlider=true end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then draggingSlider=false end
end)
UIS.InputChanged:Connect(function(input)
    if draggingSlider and input.UserInputType==Enum.UserInputType.MouseMovement then
        local rel = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(rel,0,1,0)
        PercentLabel.Text = math.floor(rel*100).."%"
    end
end)

---------------- SCROLL BUTTONS ----------------
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1,-10,1,-110)
Container.Position = UDim2.new(0,5,0,100)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,0,1,0)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.Parent = Container

local UIL = Instance.new("UIListLayout", Scroll)
UIL.Padding = UDim.new(0,6)

local function fit()
    Scroll.CanvasSize = UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y+6)
end
UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(fit)

---------------- BUTTON MAKER ----------------
local function mkButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,32)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = BTN_COLOR
    btn.BorderSizePixel = 0
    btn.Parent = Scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(callback)
end

---------------- SAMPLE LINKS ----------------
local LINKS = {
    {"Script 1", "https://example.com/script1.lua"},
    {"Script 2", "https://example.com/script2.lua"},
    {"Script 3", "https://example.com/script3.lua"},
}

local function launch(url)
    print("Launching:", url)
end

for _,v in ipairs(LINKS) do
    mkButton(v[1], function() launch(v[2]) end)
end

fit()
