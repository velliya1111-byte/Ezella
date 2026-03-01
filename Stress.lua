-- ===============================================
-- ULTRA AI SAMBUNG KATA ROBLOX (Offline + GitHub)
-- ===============================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- =========================
-- CONFIG
-- =========================
local LOGO_IMAGE_ID = "rbxassetid://1234567890" -- ganti logo

local config = {
    minDelay = 100,        -- ms
    maxDelay = 300,        -- ms
    aggression = 50,       -- 0-100
    minLength = 3,
    maxLength = 15
}

-- =========================
-- DICTIONARY
-- =========================
local kataModule = {
    "mikroarsitektur","makromolekular","bioluminesensi",
    "termoregulasi","imunohistokimia","aktivitas","agresi","analisis","alat","api","auto"
}

-- =========================
-- LOAD GITHUB DICTIONARY
-- =========================
local function loadDictionary(url)
    local ok, body = pcall(function() return HttpService:GetAsync(url) end)
    if not ok then
        warn("Gagal load dictionary:", body)
        return {}
    end

    local dict = {}
    for word in body:gmatch("[^\r\n]+") do
        word = word:lower():gsub("^%s*(.-)%s*$","%1")
        if #word>0 then table.insert(dict,word) end
    end
    return dict
end

local githubDicts = {
    "https://raw.githubusercontent.com/velliya1111-byte/Ezella/refs/heads/main/KATA-KATA%20v1.1.txt",
    "https://raw.githubusercontent.com/velliya1111-byte/Ezella/refs/heads/main/KATA-KATA%20v0.1.txt"
}

for _,url in ipairs(githubDicts) do
    local words = loadDictionary(url)
    for _,w in ipairs(words) do table.insert(kataModule,w) end
end

-- =========================
-- STATE
-- =========================
local matchActive = true
local isMyTurn = true
local serverLetter = "a"
local opponentStreamWord = ""
local usedWords = {}
local usedWordsList = {}

-- =========================
-- HELPER FUNCTIONS
-- =========================
local function isUsed(word)
    return usedWords[string.lower(word)]==true
end

local usedWordsLabel
local function addUsedWord(word)
    local w = string.lower(word)
    if not usedWords[w] then
        usedWords[w] = true
        table.insert(usedWordsList, word)
        if usedWordsLabel then
            usedWordsLabel.Text = table.concat(usedWordsList,", ")
        end
    end
end

local function getSmartWords(prefix)
    prefix = string.lower(prefix)
    local results = {}
    for _, w in ipairs(kataModule) do
        if w:sub(1,#prefix) == prefix and not isUsed(w) and #w>=config.minLength and #w<=config.maxLength then
            table.insert(results,w)
        end
    end
    table.sort(results,function(a,b) return #a>#b end)
    return results
end

local function humanDelay()
    local min,max = config.minDelay,config.maxDelay
    if min>max then min=max end
    task.wait(math.random(min,max)/1000)
end

-- =========================
-- GUI
-- =========================
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.Name = "UltraAI_GUI"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,450)
frame.Position = UDim2.new(0.5,-200,0.5,-225)
frame.BackgroundColor3 = Color3.fromRGB(45,45,45)
frame.Parent = screenGui

-- Logo + Watermark
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,32,0,32)
logo.Position = UDim2.new(0,8,0,8)
logo.BackgroundTransparency=1
logo.Image = LOGO_IMAGE_ID
logo.Parent = frame

local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(0,120,0,16)
watermark.Position = UDim2.new(0,8,0,42)
watermark.BackgroundTransparency=1
watermark.Text="Velliya AI"
watermark.TextColor3 = Color3.fromRGB(200,200,200)
watermark.Font=Enum.Font.Gotham
watermark.TextSize=12
watermark.TextXAlignment=Enum.TextXAlignment.Left
watermark.Parent = frame

-- Hide Button
local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0,50,0,32)
hideBtn.Position = UDim2.new(1,-58,0,8)
hideBtn.BackgroundColor3=Color3.fromRGB(80,80,80)
hideBtn.TextColor3=Color3.fromRGB(255,255,255)
hideBtn.Text="_"
hideBtn.Font=Enum.Font.GothamBold
hideBtn.TextSize=20
hideBtn.Parent=frame
local guiVisible=true
hideBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    for _,v in ipairs(frame:GetChildren()) do
        if v~=hideBtn then v.Visible=guiVisible end
    end
end)

-- Auto Toggle
local autoBtn = Instance.new("TextButton")
autoBtn.Size=UDim2.new(0,120,0,32)
autoBtn.Position=UDim2.new(0,10,0,70)
autoBtn.BackgroundColor3=Color3.fromRGB(80,80,80)
autoBtn.TextColor3=Color3.fromRGB(255,255,255)
autoBtn.Font=Enum.Font.GothamSemibold
autoBtn.TextSize=14
autoBtn.Text="Auto: OFF"
autoBtn.Parent=frame
local autoEnabled=false
autoBtn.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled
    autoBtn.Text="Auto: "..(autoEnabled and "ON" or "OFF")
    if autoEnabled then startUltraAI() end
end)

-- Sliders
local function createSlider(name, yPos, minV, maxV, default, callback)
    local label = Instance.new("TextLabel")
    label.Size=UDim2.new(0,180,0,20)
    label.Position=UDim2.new(0,10,0,yPos)
    label.BackgroundTransparency=1
    label.Text=name..": "..default
    label.TextColor3=Color3.fromRGB(230,230,230)
    label.Font=Enum.Font.Gotham
    label.TextSize=14
    label.TextXAlignment=Enum.TextXAlignment.Left
    label.Parent=frame

    local bar = Instance.new("Frame")
    bar.Size=UDim2.new(0,200,0,16)
    bar.Position=UDim2.new(0,10,0,yPos+20)
    bar.BackgroundColor3=Color3.fromRGB(70,70,70)
    bar.Parent=frame

    local fill = Instance.new("Frame")
    fill.Size=UDim2.new((default-minV)/(maxV-minV),0,1,0)
    fill.BackgroundColor3=Color3.fromRGB(120,120,120)
    fill.Parent=bar

    local dragging=false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end
    end)
    bar.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
    end)
    bar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
            local x = math.clamp(input.Position.X - bar.AbsolutePosition.X,0,bar.AbsoluteSize.X)
            local ratio = x / bar.AbsoluteSize.X
            local val = minV + ratio*(maxV-minV)
            fill.Size = UDim2.new(ratio,0,1,0)
            label.Text=name..": "..string.format("%.0f",val)
            callback(val)
        end
    end)
end

createSlider("Min Delay (ms)",120,10,500,config.minDelay,function(v) config.minDelay=v end)
createSlider("Max Delay (ms)",170,20,1000,config.maxDelay,function(v) config.maxDelay=v end)
createSlider("Aggression",220,0,100,config.aggression,function(v) config.aggression=v end)
createSlider("Min Length",270,1,10,config.minLength,function(v) config.minLength=v end)
createSlider("Max Length",320,5,20,config.maxLength,function(v) config.maxLength=v end)

-- Used Words
usedWordsLabel = Instance.new("TextLabel")
usedWordsLabel.Size=UDim2.new(1,-20,0,50)
usedWordsLabel.Position=UDim2.new(0,10,0,360)
usedWordsLabel.BackgroundColor3=Color3.fromRGB(60,60,60)
usedWordsLabel.TextColor3=Color3.fromRGB(255,255,255)
usedWordsLabel.Font=Enum.Font.Gotham
usedWordsLabel.TextSize=14
usedWordsLabel.TextWrapped=true
usedWordsLabel.Text="Used Words:"
usedWordsLabel.Parent=frame

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size=UDim2.new(1,-20,0,30)
statusLabel.Position=UDim2.new(0,10,0,420)
statusLabel.BackgroundTransparency=1
statusLabel.TextColor3=Color3.fromRGB(255,255,255)
statusLabel.Font=Enum.Font.GothamBold
statusLabel.TextSize=14
statusLabel.Text="Status: Idle"
statusLabel.TextXAlignment=Enum.TextXAlignment.Left
statusLabel.Parent=frame

-- =========================
-- ULTRA AI LOOP
-- =========================
local autoRunning=false
function startUltraAI()
    if autoRunning then return end
    if not autoEnabled then return end
    autoRunning = true
    task.spawn(function()
        while autoEnabled do
            if not matchActive or not isMyTurn or serverLetter=="" then
                task.wait(0.5)
            else
                humanDelay()
                local words = getSmartWords(serverLetter)
                if #words>0 then
                    local selectedWord
                    if config.aggression>=100 then
                        selectedWord = words[1]
                    elseif config.aggression<=0 then
                        selectedWord = words[math.random(1,#words)]
                    else
                        local topN = math.max(1, math.floor(#words*(1-config.aggression/100)))
                        topN = math.min(topN,#words)
                        selectedWord = words[math.random(1,topN)]
                    end

                    if selectedWord then
                        addUsedWord(selectedWord)
                        serverLetter = selectedWord:sub(-1)
                        statusLabel.Text="AI submit: "..selectedWord
                    end
                end
                humanDelay()
            end
            task.wait(0.1)
        end
        autoRunning=false
        statusLabel.Text="Status: Idle"
    end)
end
