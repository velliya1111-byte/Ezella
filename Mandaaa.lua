-- =========================================================
--========================
-- Louire.lua Anime Edition Final
--========================

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- CONFIG / SETTINGS
local config = {
    minDelay = 0.5,
    maxDelay = 1.2,
    aggression = 1,
    maxLength = 10,
    usedWords = {}
}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AnimeSambungKata"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,0,0,0)
main.Position = UDim2.new(0.5, -180, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(35,20,50)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- Gradient
local grad = Instance.new("UIGradient", main)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,120,200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140,120,255))
}

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🌸 Anime Auto Sambung Kata"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)

-- Status
local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1,0,0,25)
status.Position = UDim2.new(0,0,0,45)
status.BackgroundTransparency = 1
status.Text = "Status : OFF"
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.TextColor3 = Color3.fromRGB(255,80,80)

-- Watermark
local watermark = Instance.new("TextLabel", main)
watermark.Size = UDim2.new(1,0,0,20)
watermark.Position = UDim2.new(0,0,1,-20)
watermark.BackgroundTransparency = 1
watermark.Text = "v Script | Anime Edition"
watermark.Font = Enum.Font.Gotham
watermark.TextSize = 12
watermark.TextColor3 = Color3.fromRGB(230,200,255)

-- Toggle Button
local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(0.8,0,0,45)
toggle.Position = UDim2.new(0.1,0,0.65,0)
toggle.BackgroundColor3 = Color3.fromRGB(255,120,200)
toggle.Text = "AKTIFKAN"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 18
toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,12)

-- Minimize Button
local minimize = Instance.new("TextButton", main)
minimize.Size = UDim2.new(0,30,0,30)
minimize.Position = UDim2.new(1,-35,0,5)
minimize.BackgroundColor3 = Color3.fromRGB(200,120,255)
minimize.Text = "—"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", minimize).CornerRadius = UDim.new(1,0)

-- Slider Helper
local function CreateSlider(parent, name, min, max, default, yOffset, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.8,0,0,30)
    frame.Position = UDim2.new(0.1,0,0,yOffset)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = Color3.fromRGB(50,20,80)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = name.." : "..tostring(default)
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local slider = Instance.new("TextButton", frame)
    slider.Size = UDim2.new(0.25,0,1,0)
    slider.Position = UDim2.new(0.72,0,0,0)
    slider.Text = tostring(default)
    slider.BackgroundColor3 = Color3.fromRGB(255,120,200)
    slider.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", slider).CornerRadius = UDim.new(0,8)

    local dragging = false
    slider.MouseButton1Down:Connect(function() dragging = true end)
    RunService.RenderStepped:Connect(function()
        if dragging then
            local mouse = player:GetMouse()
            local newVal = math.clamp(min + (max-min)*((mouse.X-frame.AbsolutePosition.X)/frame.AbsoluteSize.X), min, max)
            callback(newVal)
            label.Text = name.." : "..string.format("%.2f", newVal)
            slider.Text = string.format("%.2f", newVal)
        end
    end)
    slider.MouseButton1Up:Connect(function() dragging = false end)
end

-- Sliders
CreateSlider(main, "Delay Min", 0.1, 2, config.minDelay, 0.25, function(v) config.minDelay=v end)
CreateSlider(main, "Delay Max", 0.1, 2, config.maxDelay, 0.33, function(v) config.maxDelay=v end)
CreateSlider(main, "Aggression", 1, 3, config.aggression, 0.41, function(v) config.aggression=v end)
CreateSlider(main, "Max Word Len", 3, 20, config.maxLength, 0.49, function(v) config.maxLength=v end)

-- Used Words List
local usedLabel = Instance.new("TextLabel", main)
usedLabel.Size = UDim2.new(0.8,0,0.1,0)
usedLabel.Position = UDim2.new(0.1,0,0.6,0)
usedLabel.BackgroundTransparency = 0.3
usedLabel.Text = "Used Words: 0"
usedLabel.TextColor3 = Color3.new(1,1,1)
usedLabel.Font = Enum.Font.Gotham
usedLabel.TextSize = 14
usedLabel.TextWrapped = true

-- Animasi Open
TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size=UDim2.new(0,360,0,400)}):Play()

-- Toggle Logic
local enabled = false
toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        status.Text = "Status : ON"
        status.TextColor3 = Color3.fromRGB(120,255,180)
        toggle.Text = "MATIKAN"
        toggle.BackgroundColor3 = Color3.fromRGB(140,120,255)
    else
        status.Text = "Status : OFF"
        status.TextColor3 = Color3.fromRGB(255,80,80)
        toggle.Text = "AKTIFKAN"
        toggle.BackgroundColor3 = Color3.fromRGB(255,120,200)
    end
end)

-- Minimize Logic
local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size=UDim2.new(0,200,0,40)}):Play()
        title.Visible = true
        status.Visible = false
        toggle.Visible = false
        watermark.Visible = false
    else
        TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size=UDim2.new(0,360,0,400)}):Play()
        status.Visible = true
        toggle.Visible = true
        watermark.Visible = true
    end
end)

-- LOOP AUTO SAMBUNG KATA
task.spawn(function()
    while task.wait(0.1) do
        if enabled then
            -- LOGIC AUTO KATA DI SINI
            -- gunakan config.minDelay, config.maxDelay, config.aggression, config.maxLength
            -- update config.usedWords
            usedLabel.Text = "Used Words: "..tostring(#config.usedWords)
        end
    end
end)

-- ================================
-- LOAD MODULE
-- ================================
local function ShowError(msg)
    local errFrame = Instance.new("Frame", gui)
    errFrame.Size = UDim2.new(0,250,0,60)
    errFrame.Position = UDim2.new(0.5,-125,0.5,-30)
    errFrame.BackgroundColor3 = Color3.fromRGB(200,50,50)
    Instance.new("UICorner", errFrame).CornerRadius = UDim.new(0,12)

    local errText = Instance.new("TextLabel", errFrame)
    errText.Size = UDim2.new(1,0,1,0)
    errText.BackgroundTransparency = 1
    errText.Text = msg
    errText.TextColor3 = Color3.new(1,1,1)
    errText.Font = Enum.Font.GothamBold
    errText.TextSize = 16

    -- fade out animasi
    TweenService:Create(errFrame, TweenInfo.new(3), {BackgroundTransparency=1}):Play()
    task.delay(3, function()
        errFrame:Destroy()
    end)
end

local wordList = ReplicatedStorage:FindFirstChild("WordList")
if not wordList then
    ShowError("WordList tidak ditemukan!")
    return
end

local kataModule = require(wordList:WaitForChild("IndonesianWords"))

-- ================================
-- REMOTES
-- ================================
local remotes = ReplicatedStorage:WaitForChild("Remotes")

local MatchUI = remotes:WaitForChild("MatchUI")
local SubmitWord = remotes:WaitForChild("SubmitWord")
local BillboardUpdate = remotes:WaitForChild("BillboardUpdate")
local BillboardEnd = remotes:WaitForChild("BillboardEnd")
local TypeSound = remotes:WaitForChild("TypeSound")
local UsedWordWarn = remotes:WaitForChild("UsedWordWarn")

-- =========================================================
-- STATE
-- =========================================================
local matchActive = false
local isMyTurn = false
local serverLetter = ""

local usedWords = {}
local usedWordsList = {}
local opponentStreamWord = ""

local autoEnabled = false
local autoRunning = false

local config = {
    minDelay = 35,
    maxDelay = 150,
    aggression = 50,
    minLength = 3,
    maxLength = 20
}

-- =========================================================
-- HELPERS
-- =========================================================
local function isUsed(word)
    return usedWords[string.lower(word)] == true
end

local usedWordsDropdown

local function addUsedWord(word)
    local w = string.lower(word)
    if not usedWords[w] then
        usedWords[w] = true
        table.insert(usedWordsList, word)

        if usedWordsDropdown then
            usedWordsDropdown:Set(usedWordsList)
        end
    end
end

local function getSmartWords(prefix)
    prefix = string.lower(prefix)
    local results = {}

    for _, word in ipairs(kataModule) do
        local w = tostring(word)
        if string.sub(string.lower(w), 1, #prefix) == prefix then
            if not isUsed(w) then
                local len = #w
                if len >= config.minLength and len <= config.maxLength then
                    table.insert(results, w)
                end
            end
        end
    end

    table.sort(results, function(a, b)
        return #a > #b
    end)

    return results
end

local function humanDelay()
    local min = config.minDelay
    local max = config.maxDelay
    if min > max then min = max end
    task.wait(math.random(min, max) / 1000)
end

-- =========================================================
-- SMART AUTO ENGINE
-- =========================================================
local function startUltraAI()
    if autoRunning then return end
    if not autoEnabled then return end
    if not matchActive or not isMyTurn then return end
    if serverLetter == "" then return end

    autoRunning = true

    task.spawn(function()
        humanDelay()

        local words = getSmartWords(serverLetter)
        if #words == 0 then
            autoRunning = false
            return
        end

        local selectedWord

        if config.aggression >= 100 then
            selectedWord = words[1]
        elseif config.aggression <= 0 then
            selectedWord = words[math.random(1, #words)]
        else
            local topN = math.max(1, math.floor(#words * (1 - config.aggression/100)))
            topN = math.min(topN, #words)
            selectedWord = words[math.random(1, topN)]
        end

        if not selectedWord then
            autoRunning = false
            return
        end

        local currentWord = serverLetter
        local remain = selectedWord:sub(#serverLetter + 1)

        for i = 1, #remain do
            if not matchActive or not isMyTurn then
                autoRunning = false
                return
            end

            currentWord = currentWord .. remain:sub(i, i)

            TypeSound:FireServer()
            BillboardUpdate:FireServer(currentWord)

            humanDelay()
        end

        humanDelay()

        SubmitWord:FireServer(selectedWord)
        addUsedWord(selectedWord)

        humanDelay()
        BillboardEnd:FireServer()

        autoRunning = false
    end)
end

-- =========================================================
-- UI RAYFIELD
-- =========================================================
local Window = Rayfield:CreateWindow({
    Name = "Sambung-kata by Velliya",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Rayfield Edition",
    ConfigurationSaving = {
        Enabled = false
    }
})

local MainTab = Window:CreateTab("Main", 4483345998)

MainTab:CreateToggle({
    Name = "Aktifkan Auto",
    CurrentValue = false,
    Callback = function(Value)
        autoEnabled = Value
        if Value then
            startUltraAI()
        end
    end
})

MainTab:CreateSlider({
    Name = "Min Delay (ms)",
    Range = {10, 500},
    Increment = 5,
    CurrentValue = config.minDelay,
    Callback = function(Value)
        config.minDelay = Value
    end
})

MainTab:CreateSlider({
    Name = "Max Delay (ms)",
    Range = {20, 1000},
    Increment = 5,
    CurrentValue = config.maxDelay,
    Callback = function(Value)
        config.maxDelay = Value
    end
})

MainTab:CreateSlider({
    Name = "Aggression",
    Range = {0, 100},
    Increment = 5,
    CurrentValue = config.aggression,
    Callback = function(Value)
        config.aggression = Value
    end
})

MainTab:CreateSlider({
    Name = "Min Word Length",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = config.minLength,
    Callback = function(Value)
        config.minLength = Value
    end
})

MainTab:CreateSlider({
    Name = "Max Word Length",
    Range = {5, 30},
    Increment = 1,
    CurrentValue = config.maxLength,
    Callback = function(Value)
        config.maxLength = Value
    end
})

usedWordsDropdown = MainTab:CreateDropdown({
    Name = "Used Words",
    Options = usedWordsList,
    CurrentOption = "",
    Callback = function() end
})

local statusParagraph = MainTab:CreateParagraph({
    Title = "Status",
    Content = "Idle"
})

-- =========================================================
-- REMOTE EVENTS
-- =========================================================
MatchUI.OnClientEvent:Connect(function(cmd, value)

    if cmd == "ShowMatchUI" then
        matchActive = true
        isMyTurn = false
        usedWords = {}
        usedWordsList = {}
        usedWordsDropdown:Set({})

    elseif cmd == "HideMatchUI" then
        matchActive = false
        isMyTurn = false
        serverLetter = ""
        usedWords = {}
        usedWordsList = {}
        usedWordsDropdown:Set({})

    elseif cmd == "StartTurn" then
        if opponentStreamWord ~= "" then
            addUsedWord(opponentStreamWord)
            opponentStreamWord = ""
        end

        isMyTurn = true
        if autoEnabled then
            startUltraAI()
        end

    elseif cmd == "EndTurn" then
        isMyTurn = false

    elseif cmd == "UpdateServerLetter" then
        serverLetter = value or ""
    end

    statusParagraph:Set({
        Title = "Status",
        Content = "Match: "..tostring(matchActive)..
        " | Turn: "..(isMyTurn and "You" or "Opponent")..
        " | Start: "..serverLetter
    })
end)

BillboardUpdate.OnClientEvent:Connect(function(word)
    if matchActive and not isMyTurn then
        opponentStreamWord = word or ""
    end
end)

UsedWordWarn.OnClientEvent:Connect(function(word)
    if word then
        addUsedWord(word)

        if autoEnabled and matchActive and isMyTurn then
            humanDelay()
            startUltraAI()
        end
    end
end)