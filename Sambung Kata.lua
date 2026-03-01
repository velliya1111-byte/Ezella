-- =========================================================
-- ULTRA SMART AUTO KATA (RAYFIELD EDITION - MOBILE SAFE)
-- =========================================================

-- ================================
-- LOAD RAYFIELD
-- ================================
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

if not Rayfield then
    warn("Rayfield gagal dimuat")
    return
end

-- ================================
-- SERVICES
-- ================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ================================
-- LOAD MODULE
-- ================================
local HttpService = game:GetService("HttpService")

-- =========================
-- 1. DICTIONARY MANUAL
-- =========================
local manualWords = {
    "elektroensefalografi","elektrokardiogram","neurotransmiter",
    "mikroarsitektur","makromolekular","bioluminesensi",
    "termoregulasi","imunohistokimia","fotodegradasi",
    "metamorfosis","heterogenitas","homogenisasi",
    "desentralisasi","konstitusionalitas","interdisipliner",
    "multilateralitas","transubstansiasi","hiperkonektivitas",
    "neuroplastisitas","psikolinguistik","antropomorfisme",
    "elektromagnetisme","hiperparatiroidisme","hiperinsulinemia",
    "otoritarianisme","ultramikroskopis","transnasionalisme",
    "institusionalisasi","kompartementalisasi","rasionalitas",
    "eksistensialisme","fenomenologi","postmodernisme","strukturalisme",
    "dekonstruksionisme","rasionalisme","empirisisme","utilitarianisme",
    "determinisme","nihilisme","relativisme","dialektika","ontologi",
    "epistemologi","metafisika","teleologi","kosmologi","etika","logika", 
    "apel","anggur","anak","api","angin","ayam","air","akar","alat","awan","antara","antar","angkat",
    "bola","buku","bunga","bulan","batu","baju","beras","benang","botol","bakar","baterai","bahasa",
    "cacing","cahaya","cinta","cermin","cerita","coklat","candi","daging","daun","dapur","darat","dunia",
    "elang","emas","ember","enak","energi","fajar","foto","film","gajah","garam","gelas","gigi","gula",
    "gunung","gurita","hujan","hutan","harimau","hidung","ikan","istri","indah","ilmu","jaket","jalan",
    "jarum","jendela","jari","kuda","kucing","kaca","kertas","kursi","kelapa","kamar","kunci","kapal",
    "lampu","laut","lemari","lilin","lengan","mata","meja","mobil","minum","makan","malam","nenek",
    "nanas","nasi","obat","orang","padi","pintu","pisang","pulau","pohon","rumah","roti","sapi","sepatu",
    "susu","sabun","tangan","tikus","tanah","topi","ular","udang","uang","warna","wira","waktu","yakin",
    "zebra","zaman","zakat","zodiak", 
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
    "pisang","galon","nilai","istri","robot","topi","ikan","naga","apii", 
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
    "visualisasi","volatilitas", 
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
    "verisimilitude","vitalitas","volumetrik","xenofobia","yurisdiksi","zeitgeist", 
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

-- =========================
-- 2. URL GITHUB DICTIONARY
-- =========================
local url = {
    "https://raw.githubusercontent.com/velliya1111-byte/Ezella/refs/heads/main/KATA-KATA%20v1.1.txt",
    "https://raw.githubusercontent.com/velliya1111-byte/Ezella/refs/heads/main/KATA-KATA%20v0.1.txt"
}

-- =========================
-- 3. GABUNG SEMUA KATA
-- =========================
local kataModule = {}

-- masukkan manual dulu
for _, kata in ipairs(manualWords) do
    table.insert(kataModule, string.lower(kata))
end

-- ambil dari GitHub
local success, result = pcall(function()
    return HttpService:GetAsync(url)
end)

if success then
    for kata in string.match(result, "[^\r\n]+") do
        table.insert(kataModule, string.lower(kata))
    end
    print("GitHub dictionary dimuat!")
else
    warn("Gagal load GitHub:", result)
end

-- =========================
-- 4. HAPUS DUPLIKAT
-- =========================
local unique = {}
local filtered = {}

for _, kata in ipairs(kataModule) do
    if not unique[kata] then
        unique[kata] = true
        table.insert(filtered, kata)
    end
end

kataModule = filtered

print("Total kata gabungan:", #kataModule)

-- =========================
-- 5. FUNGSI DICTIONARY
-- =========================
local function GetAll()
    return kataModule
end

local function GetNextWord(huruf)
    huruf = string.lower(huruf)
    for _, kata in ipairs(kataModule) do
        if string.sub(kata, 1, 1) == huruf then
            return kata
        end
    end
    return nil
end

-- =========================
-- 6. TEST OUTPUT (ATAS -> BAWAH)
-- =========================
print("===== DAFTAR KATA =====")
for i, kata in ipairs(kataModule) do
    print(i, kata)
end

-- contoh sambung kata
local nextWord = GetNextWord("a")
print("AI jawab huruf 'a':", nextWord or "Tidak ada")

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






