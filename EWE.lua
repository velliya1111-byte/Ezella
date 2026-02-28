--// Sambung Kata ULTIMATE (Full Featured)
--// Auto + Dropdown + Kamus Besar + Detect Lawan

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
-- =========================
-- AI SMART SETTINGS
-- =========================
local usedWords = {}
local smartMode = true -- aktifkan AI pintar
local minDelay = 0.4
local maxDelay = 1.2
-- =========================
-- TRAP LETTER MODE
-- =========================
local trapMode = true

-- huruf akhir paling sulit
local rareEndingLetters = {
    v=true, z=true, x=true, q=true, f=true, g=true, k=true
}
-- ======================================================
-- KAMUS BESAR INDONESIA (bisa tambah ribuan kata)

-- ======================================================
local BIG_DICTIONARY = {}

local function addWords(tbl)
    for _,w in ipairs(tbl) do
        table.insert(BIG_DICTIONARY, string.lower(w))
    end
end

addWords(BASE_WORDS)
addWords(RARE_WORDS)
addWords(ULTRA_RARE_WORDS)
addWords(LATIN_ILMIAH)
addWords(KBBI_FORMAL_TINGGI)
addWords(KATA_LANGKA_SUPER)
addWords(ULTRA_SCIENCE)
addWords(FILSAFAT)

local success, data = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/stopwords-iso/stopwords-id/master/stopwords-id.txt")
end)

if success and data then
    for word in string.gmatch(data, "%S+") do
        table.insert(DICTIONARY, word:lower())
    end
else

local ULTRA_SCIENCE = {
    "elektroensefalografi","elektrokardiogram","neurotransmiter",
    "mikroarsitektur","makromolekular","bioluminesensi",
    "termoregulasi","imunohistokimia","fotodegradasi",
    "metamorfosis","heterogenitas","homogenisasi",
    "desentralisasi","konstitusionalitas","interdisipliner",
    "multilateralitas","transubstansiasi","hiperkonektivitas",
    "neuroplastisitas","psikolinguistik","antropomorfisme",
    "elektromagnetisme","hiperparatiroidisme","hiperinsulinemia",
    "otoritarianisme","ultramikroskopis","transnasionalisme",
    "institusionalisasi","kompartementalisasi","rasionalitas"
}

local FILSAFAT = {
    "eksistensialisme","fenomenologi","postmodernisme","strukturalisme",
    "dekonstruksionisme","rasionalisme","empirisisme","utilitarianisme",
    "determinisme","nihilisme","relativisme","dialektika","ontologi",
    "epistemologi","metafisika","teleologi","kosmologi","etika","logika"
}

local BASE_WORDS = {
"apel","anggur","anak","api","angin","ayam","air","akar","alat","awan","antara","antar","angkat",
"bola","buku","bunga","bulan","batu","baju","beras","benang","botol","bakar","baterai","bahasa",
"cacing","cahaya","cinta","cermin","cerita","coklat","candi","daging","daun","dapur","darat","dunia",
"elang","emas","ember","enak","energi","fajar","foto","film","gajah","garam","gelas","gigi","gula",
"gunung","gurita","hujan","hutan","harimau","hidung","ikan","istri","indah","ilmu","jaket","jalan",
"jarum","jendela","jari","kuda","kucing","kaca","kertas","kursi","kelapa","kamar","kunci","kapal",
"lampu","laut","lemari","lilin","lengan","mata","meja","mobil","minum","makan","malam","nenek",
"nanas","nasi","obat","orang","padi","pintu","pisang","pulau","pohon","rumah","roti","sapi","sepatu",
"susu","sabun","tangan","tikus","tanah","topi","ular","udang","uang","warna","wira","waktu","yakin",
"zebra","zaman","zakat","zodiak"
"apel","anggur","anak","api","angin","ayam","air","akar","alat","awan",
"bola","buku","bunga","bulan","batu","baju","beras","benang","botol","bakar",
"cacing","cahaya","cinta","cermin","cerita","coklat","daun","daging","dapur","darat",
"elang","emas","ember","enak","fajar","foto","film","gajah","garam","gelas",
"gigi","gula","gunung","gurita","hujan","hutan","harimau","hidung","ikan","istri",
"indah","ilmu","jaket","jalan","jarum","jendela","jari","kuda","kucing","kaca",
"kertas","kursi","kelapa","kamar","kunci","lampu","laut","lemari","lilin","lengan",
"mata","meja","mobil","minum","makan","malam","nenek","nanas","nasi","obat",
"orang","padi","pintu","pisang","pulau","pohon","rumah","roti","sapi","sepatu",
"susu","sabun","tangan","tikus","tanah","topi","ular","udang","uang","warna",
"apel","elang","gajah","harimau","ular","rumah","hujan","nasi","ikan",
"kuda","ayam","makan","minum","laut","tanah","hutan","angin","nenek",
"kucing","gigi","indah","hewan","warna","api","ilmu","udang","gurita",
"anggur","rambut","tikus","sepatu","ulari","ikanan","nanas","sapi",
"pisang","galon","nilai","istri","robot","topi","ikan","naga","apii"
}
-- =========================
-- LATIN ILMIAH + KBBI FORMAL
-- =========================
local LATIN_ILMIAH = {
    "aberratio","abscissa","absolutum","absorptio","acromion","acuminatus","adagio",
    "adhesio","ad infinitum","ad interim","ad libitum","ad valorem","aerob","aerobik",
    "aerodinamik","aerofit","aerofon","aerolit","aerosfer","aestetika",
    "afinitas","aforisme","agregat","agregasi","agronomi","aksentuasi","aksial",
    "aksion","aksis","akson","albedo","alga","alkaloid","alveolus","amalgam",
    "ambivalen","ameliorasi","amfibi","amfiteater","amplitudo","analogi",
    "analitik","anastesi","anatomis","anekdot","anomali","antagonis","antitesis",
    "apendiks","apogee","apriori","aquatik","arboretum","argumentasi",
    "aritmetika","arsitektur","artikulasi","asimetri","asimilasi","asosiatif",
    "asteroid","astronomis","asumsi","atmosfer","atomik","atribut",
    "auditori","autentik","autonomi","aksara","axioma","azimut",
}

local KBBI_FORMAL_TINGGI = {
    "abstraksi","adidaya","adiguna","adikara","adipati","adisi","adjektiva",
    "administratif","advokasi","aklamasi","akomodasi","akomodatif","akreditasi",
    "aktualisasi","alokasi","alternatif","ambigu","amendemen","analisis",
    "aneksasi","anotasi","antologi","antropologi","aproksimasi","argumentatif",
    "aristokrasi","artifisial","artikulator","asertif","aspirasi","asosiasi",
    "autoritif","birokrasi","dedikasi","definitif","deklarasi","delegasi",
    "demokratis","derivatif","determinasi","diferensiasi","diseminasi",
    "disiplin","diskursus","distorsi","dominasi","edukatif","efektivitas",
    "efisiensi","eksistensi","ekspansi","eksplisit","eksposisi","ekstrapolasi",
    "elaborasi","elastisitas","eliminasi","emansipasi","empiris","enklitik",
    "entitas","enumerasi","epistemologi","evaluatif","evolusioner","eksplanasi",
}

local KATA_LANGKA_SUPER = {
    "klandestin","konklaf","konstelasi","konstruksi","kontemplasi","konvergensi",
    "korelatif","kredibilitas","kumulatif","kualifikasi","legitimasi","linearitas",
    "lokalisasi","manifestasi","matrikulasi","mekanistik","metaforis","metodologis",
    "mikrostruktur","modifikasi","monolitik","multidimensi","naratif","negasi",
    "nomenklatur","normatif","notifikasi","objektivitas","observasi","operasional",
    "optimisasi","orientasi","paradigma","paralelisme","parameter","partisipatif",
    "persepsi","perspektif","pluralisme","polaritas","postulat","preskriptif",
    "probabilitas","progresif","proporsional","proyeksi","rasionalisasi","rekonstruksi",
    "representatif","resistensi","retorika","sistematis","signifikansi","simetris",
    "simulasi","sinkronisasi","sintaksis","sintesis","solidaritas","struktural",
    "subjektif","substansial","sugestif","suprastruktur","transendental",
    "transformatif","universalitas","utilitarian","validitas","verifikasi",
}

local ULTRA_RARE_WORDS = {
"aberrasi","absolutisme","absorptivitas","abstrus","adendum","adiabatik","adjudikasi","adversatif",
"aerodinamika","afirmatif","afinitas","aforisme","agregasi","aksentuasi","akselerator","aksion",
"akulturasi","akustika","albedo","alelomorf","algoritmik","alienasi","alkalinitas","alokasi",
"alternatif","ameliorasi","amortisasi","aneksasi","anorganik","antitesis","antroposentris",
"aposteriori","aproksimasi","argumentatif","artikulator","asosiasi","asosiatif","astigmatisme",
"asumsi","aterosklerosis","atmosferik","atributif","augmentasi","autokorelasi","autonomisasi",
"bifurkasi","bioakumulasi","biodegradasi","biogeokimia","biometrika","birokratis","boikotase",
"causalitas","deduktif","deforestasi","degenerasi","deklaratif","dekonstruksi","deliberasi",
"demarkasi","denotatif","depolarisasi","depresiasi","derivasi","desentralisasi","deskriptor",
"deterministik","difraksi","diferensiasi","dilatasi","dinamisasi","diseminasi","disipatif",
"disjungsi","disparitas","dispersi","distilasi","distribusional","dominansi","duplikasi",
"efektivitas","efloresensi","egosentris","elastisitas","eliminasi","eliptik","emansipasi",
"embriogenesis","empati","enklitik","enkulturasi","entropi","enumerasi","epistemologi",
"equidistan","eskalasi","eskatologi","esoterik","evaluatif","evidensi","evolusioner",
"eksaserbasi","eksentrik","ekstrapolasi","ekuilibrium","ekspresivitas","ekstremitas",
"faktualitas","falsifikasi","fenomenologi","fermentasi","filogenetik","fluktuatif","formalisasi",
"fragmentaris","fungsionalitas","generalisasi","geometrik","gradualisme","gravitasi",
"heuristik","homogenitas","hubristik","identifikasi","ideografik","ideologis","idiomatik",
"iluminasi","imaterial","imitatif","imunisasi","imperatif","implementatif","implikatif",
"improvisasi","inklusivitas","inkubasi","inovatif","insinuasi","integratif","intensional",
"interdependensi","interferensi","interkoneksi","intermiten","interogatif","interpretatif",
"interpolasi","intervensional","introspeksi","invarian","irreduktibel","isomorfisme",
"iteratif","justifikasi","kalkulus","kapilaritas","karakteristik","katalisator","kategorisasi",
"kausalitas","klasifikasi","koagulasi","koherensi","kognisi","kohesivitas","kolektivitas",
"komplementer","kompleksifikasi","komposisional","komprehensif","konduktivitas","konfiguratif",
"konformitas","konjugasi","konkretisasi","konsekuensial","konsensus","konsolidasi","konstitutif",
"konstruktivisme","kontekstualisasi","kontingensi","kontradiktif","konvergensi","kooperatif",
"korelativitas","kreativitas","kristalisasi","kumulatif","legislasi","legitimasi","linearitas",
"logaritmik","manifesto","materialisasi","matriks","mekanistik","metafisik","metodologis",
"mikrostruktur","minimalisasi","mobilitas","modalitas","modulasi","morfogenesis","narasi",
"negativitas","neologisme","nominalisasi","normalisasi","notasional","objektivisme",
"observasional","operasionalisasi","optimalitas","organisasi","orientasional","parametrik",
"partisipatif","perifer","perseveransi","persuasif","pluralisme","polaritas","polimorfisme",
"posisional","postmodernisme","pragmatisme","prediktif","preskriptif","probabilistik",
"progresivitas","proporsionalitas","prosedural","proyektif","rasionalisasi","reaktivitas",
"redundansi","referensial","regeneratif","regularisasi","rekonstruksi","relativitas",
"representatif","reproduktif","resiliensi","retrospektif","revaluasi","segmentasi",
"selektivitas","semantik","semiotika","sensitivitas","separabilitas","signifikansi",
"simetrikal","simultan","sinkretisme","sirkulasi","situasional","skalabilitas","sosiokultural",
"spektroskopi","stereotipikal","stimulan","stratifikasi","subjektivitas","substansial",
"substitusi","superstruktur","suplementasi","sustentabilitas","synchronisasi","sintagmatik",
"sistemik","taksonomi","teleologis","terminologi","termodinamika","transformasional",
"transendental","transfigurasi","transitivitas","transliterasi","transmutasi","transparansi",
"triangulasi","universalitas","utilitarianisme","validitas","variabilitas","verbalistik",
"verisimilitude","vitalitas","volumetrik","xenofobia","yurisdiksi","zeitgeist"
}

for _,w in ipairs(ULTRA_RARE_WORDS) do
    table.insert(DICTIONARY, w)
end
-- RARE WORDS (jarang dipakai orang)
local RARE_WORDS = {
"abstrak","abstraksi","akselerasi","adaptasi","adiktif","afeksi","agitasi","akomodasi","akumulasi",
"altruisme","ambivalen","analogi","anomali","antagonis","antologi","arbitrer","arsip","asimetris",
"asosiasi","atensi","autentik","deduksi","defisit","definisi","dekade","delusi","demonstrasi",
"derivatif","deskripsi","determinasi","deviasi","difusi","dilema","disiplin","distorsi","divergen",
"dominasi","edukasi","efisiensi","egaliter","elaborasi","empiris","enkapsulasi","entitas","epilog",
"equivalen","esensial","evaluasi","evolusi","eksistensi","eksplisit","ekspansi","ekstraksi","faktor",
"fiktif","filosofi","fragmentasi","fusi","generik","gradien","hipotesis","identitas","ilustrasi",
"implementasi","implisit","indikator","inferensi","inflasi","inisiatif","inovasi","integrasi",
"interaksi","interpretasi","intervensi","intensitas","iterasi","justifikasi","kapasitas","kognitif",
"kolektif","kompleksitas","komposisi","konfigurasi","konsepsi","konsistensi","konstruksi","kontinum",
"kontradiksi","konvergen","korelasi","kreativitas","legitimasi","linearitas","manifestasi","metafora",
"metodologi","modifikasi","naratif","negosiasi","objektivitas","observasi","optimalisasi","orientasi",
"paradigma","parameter","partikel","persepsi","perspektif","polaritas","postulat","presisi","probabilitas",
"progresif","proyeksi","rasionalitas","reduksi","refleksi","regulasi","relevansi","representasi",
"resolusi","retorika","simulasi","sinkronisasi","sintesis","sistematis","solusi","stabilitas","struktur",
"substansi","superposisi","spekulasi","transformasi","transisi","validasi","variabel","verifikasi",
"visualisasi","volatilitas"
}

for _,w in ipairs(RARE_WORDS) do
    table.insert(DICTIONARY, w)
end

-- ======================================================
-- ======================================================
local function getLastLetter(word)
    return word:lower():sub(-1)
end

local function isUsed(word)
    return usedWords[word] == true
end

local function markUsed(word)
    usedWords[word] = true
end

-- pilih kata TERBAIK (terpanjang & belum dipakai)
local function scoreWord(word)
    local score = 0
    
    -- prioritas panjang kata
    score += #word * 2
    
    -- bonus jika huruf akhir langka
    local last = word:sub(-1)
    if rareEndingLetters[last] then
        score += 50
    end
    
    -- penalti jika terlalu pendek
    if #word <= 3 then
        score -= 10
    end
    
    return score
end

local function findSmartWord(letter)
    local bestWord = nil
    local bestScore = -math.huge

    for _,word in ipairs(DICTIONARY) do
        if word:sub(1,1) == letter and not usedWords[word] then
            local score = scoreWord(word)

            if not trapMode then
                score = #word -- mode normal hanya panjang
            end

            if score > bestScore then
                bestScore = score
                bestWord = word
            end
        end
    end

    return bestWord
end
-- ======================================================
-- ======================================================
local function randomDelay()
    return minDelay + math.random() * (maxDelay - minDelay)
end

local function onChat(plr, msg)
    if not auto or plr == player then return end

    local last = getLastLetter(msg)
    lastLetterLabel.Text = "Huruf lawan: "..last

    local chosenWord

    if smartMode then
        chosenWord = findSmartWord(last)
    else
        chosenWord = findBestWord(last) -- mode biasa
    end

    if chosenWord then
        task.wait(randomDelay()) -- delay biar natural
        markUsed(chosenWord)

        status.Text = "AI Jawab: "..chosenWord
        ReplicatedStorage.DefaultChatSystemChatEvents
            .SayMessageRequest:FireServer(chosenWord, "All")
    else
        status.Text = "AI: Tidak ada kata!"
    end
end



-- ======================================================
-- GUI
-- ======================================================
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SambungKataUltimate"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 320, 0, 260)
main.Position = UDim2.new(0.35, 0, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "Sambung Kata ULTIMATE"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- Tabs
local autoTab = Instance.new("TextButton", main)
autoTab.Size = UDim2.new(0.5,0,0,25)
autoTab.Position = UDim2.new(0,0,0,30)
autoTab.Text = "Auto"

local selectTab = Instance.new("TextButton", main)
selectTab.Size = UDim2.new(0.5,0,0,25)
selectTab.Position = UDim2.new(0.5,0,0,30)
selectTab.Text = "Select Word"

local autoFrame = Instance.new("Frame", main)
autoFrame.Size = UDim2.new(1,0,1,-55)
autoFrame.Position = UDim2.new(0,0,0,55)
autoFrame.BackgroundTransparency = 1

local selectFrame = autoFrame:Clone()
selectFrame.Parent = main
selectFrame.Visible = false

-- ======================================================
-- AUTO TAB
-- ======================================================
local trapToggle = Instance.new("TextButton", autoFrame)
trapToggle.Size = UDim2.new(1,-20,0,30)
trapToggle.Position = UDim2.new(0,10,0,180)
trapToggle.Text = "TRAP MODE : ON"
trapToggle.BackgroundColor3 = Color3.fromRGB(90,60,60)
trapToggle.TextColor3 = Color3.new(1,1,1)

trapToggle.MouseButton1Click:Connect(function()
    trapMode = not trapMode
    trapToggle.Text = trapMode and "TRAP MODE : ON" or "TRAP MODE : OFF"
end)

local toggle = Instance.new("TextButton", autoFrame)
toggle.Size = UDim2.new(1,-20,0,40)
toggle.Position = UDim2.new(0,10,0,10)
toggle.Text = "AUTO : OFF"
toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 18

local status = Instance.new("TextLabel", autoFrame)
status.Size = UDim2.new(1,-20,0,40)
status.Position = UDim2.new(0,10,0,60)
status.BackgroundTransparency = 1
status.Text = "Status : Idle"
status.TextColor3 = Color3.new(1,1,1)

local lastLetterLabel = Instance.new("TextLabel", autoFrame)
lastLetterLabel.Size = UDim2.new(1,-20,0,30)
lastLetterLabel.Position = UDim2.new(0,10,0,100)
lastLetterLabel.BackgroundTransparency = 1
lastLetterLabel.Text = "Huruf lawan: -"
lastLetterLabel.TextColor3 = Color3.new(1,1,1)

-- ======================================================
-- SELECT WORD TAB (DROPDOWN)
-- ======================================================
local input = Instance.new("TextBox", selectFrame)
input.Size = UDim2.new(1,-20,0,30)
input.Position = UDim2.new(0,10,0,10)
input.PlaceholderText = "Masukkan huruf..."
input.BackgroundColor3 = Color3.fromRGB(45,45,45)
input.TextColor3 = Color3.new(1,1,1)

local dropdown = Instance.new("ScrollingFrame", selectFrame)
dropdown.Size = UDim2.new(1,-20,0,120)
dropdown.Position = UDim2.new(0,10,0,50)
dropdown.BackgroundColor3 = Color3.fromRGB(35,35,35)
dropdown.BorderSizePixel = 0
dropdown.CanvasSize = UDim2.new(0,0,0,0)

local layout = Instance.new("UIListLayout", dropdown)

local sendBtn = Instance.new("TextButton", selectFrame)
sendBtn.Size = UDim2.new(1,-20,0,35)
sendBtn.Position = UDim2.new(0,10,0,180)
sendBtn.Text = "Kirim Kata"
sendBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
sendBtn.TextColor3 = Color3.new(1,1,1)

local selectedWord = nil

-- ======================================================
-- TAB SWITCH
-- ======================================================
autoTab.MouseButton1Click:Connect(function()
    autoFrame.Visible = true
    selectFrame.Visible = false
end)

selectTab.MouseButton1Click:Connect(function()
    autoFrame.Visible = false
    selectFrame.Visible = true
end)

-- ======================================================
-- LOGIC
-- ======================================================
local auto = false

toggle.MouseButton1Click:Connect(function()
    auto = not auto
    toggle.Text = auto and "AUTO : ON" or "AUTO : OFF"
end)

local function clearDropdown()
    for _,v in pairs(dropdown:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
end

local function populateDropdown(letter)
    clearDropdown()
    local count = 0
    for _,word in ipairs(DICTIONARY) do
        if word:sub(1,1) == letter then
            count += 1
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,0,0,25)
            btn.Text = word
            btn.Parent = dropdown
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
            btn.TextColor3 = Color3.new(1,1,1)

            btn.MouseButton1Click:Connect(function()
                selectedWord = word
            end)
        end
    end
    dropdown.CanvasSize = UDim2.new(0,0,0,count*25)
end

input:GetPropertyChangedSignal("Text"):Connect(function()
    local letter = input.Text:lower():sub(1,1)
    if letter and letter ~= "" then
        populateDropdown(letter)
    end
end)

sendBtn.MouseButton1Click:Connect(function()
    if selectedWord then
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(selectedWord, "All")
    end
end)

-- ======================================================
-- AUTO DETECT LAWAN
-- ======================================================
local function getLastLetter(word)
    return word:lower():sub(-1)
end

local function findBestWord(letter)
    for _,word in ipairs(DICTIONARY) do
        if word:sub(1,1) == letter then
            return word -- prioritas kata pertama (cepat)
        end
    end
end

local function onChat(plr, msg)
    if not auto or plr == player then return end
    local last = getLastLetter(msg)
    lastLetterLabel.Text = "Huruf lawan: "..last

    local best = findBestWord(last)
    if best then
        status.Text = "Jawab: "..best
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(best, "All")
    else
        status.Text = "Tidak ada kata!"
    end
end

for _,plr in pairs(Players:GetPlayers()) do
    plr.Chatted:Connect(function(msg)
        onChat(plr, msg)
    end)
end

Players.PlayerAdded:Connect(function(plr)
    plr.Chatted:Connect(function(msg)
        onChat(plr, msg)
    end)
end)