local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ==================== THƯ VIỆN UI ====================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KiuYT/RD7.lua/main/UILib.lua"))()
local Window = Library:CreateWindow("Tuấn Gay Hub | Ultimate Edition")
local CombatTab = Window:CreateTab("⚔️ Chiến Đấu")
local BossTab = Window:CreateTab("👑 Boss")
local ESPTab = Window:CreateTab("👁️ ESP")
local FruitTab = Window:CreateTab("🍎 Trái")
local SeaTab = Window:CreateTab("🌊 Biển")
local TeleportTab = Window:CreateTab("🌀 Dịch Chuyển")
local MiscTab = Window:CreateTab("🎯 Khác")
local SettingTab = Window:CreateTab("⚙️ Cài Đặt")
local InfoTab = Window:CreateTab("📜 Thông Tin")

-- ==================== BIẾN TOÀN CỤC ====================
local AutoFarmEnabled = false
local AutoBossEnabled = false
local AutoCollectFruit = false
local AutoStoreFruit = false
local AutoBuyItem = false
local AutoRace = false
local AutoEliteEnabled = false
local AutoSeaBeast = false
local AutoFactory = false
local AutoChest = false
local ESPEnabled = false
local AimbotEnabled = false
local SpeedEnabled = false
local FlyEnabled = false
local NoClipEnabled = false
local InfiniteYieldLoaded = false
local AutoSkillEnabled = false
local AutoEatFruit = false
local AutoPvp = false
local AutoLevel = false
local AutoQuest = false
local TeleportToFruit = false
local TeleportToChest = false
local TeleportToFlower = false
local TeleportToNPC = false

local espObjects = {}
local skillLoop = nil
local questLoop = nil
local levelLoop = nil
local pvpLoop = nil

_G.SelectedFruit = "Kitsune"
_G.SelectedBoss = "Darkbeard"
_G.SelectedElite = "Deandre"
_G.AutoFarmMob = "All"
_G.AutoFarmRadius = 250
_G.BossFarmDelay = 5
_G.SelectedSea = "All"
_G.SkillDelay = 1
_G.SkillList = {"Z", "X", "C", "V"}
_G.AutoLevelTarget = 2550
_G.AutoQuestName = ""

-- ==================== DANH SÁCH TRÁI ====================
local Fruits = {
    "Rocket", "Spin", "Blade", "Spring", "Bomb", "Smoke", "Spike",
    "Flame", "Ice", "Sand", "Dark", "Eagle", "Diamond", "Light",
    "Rubber", "Ghost", "Magma", "Quake", "Buddha", "Love", "Creation",
    "Spider", "Sound", "Phoenix", "Portal", "Lightning", "Pain",
    "Blizzard", "Gravity", "Mammoth", "T-Rex", "Dough", "Shadow",
    "Venom", "Control", "Spirit", "Tiger", "Dragon", "Kitsune",
    "Yeti", "Gas", "Blade", "Phoenix V2", "Dough V2", "Leopard"
}

-- ==================== DANH SÁCH ĐẢO ====================
local Islands = {
    "Starter Island", "Jungle", "Pirate Village", "Desert", "Middle Island",
    "Frozen Village", "Marine Fortress", "Skylands", "Prison", "Colosseum",
    "Magma Village", "Underwater City", "Fountain City", "Kingdom of Rose",
    "Usoap's Island", "Green Zone", "Graveyard Island", "Dark Arena",
    "Snow Mountain", "Hot and Cold", "Cursed Ship", "Ice Castle",
    "Forgotten Island", "Port Town", "Hydra Island", "Great Tree",
    "Floating Turtle", "Castle on the Sea", "Haunted Castle", "Sea of Treats",
    "Tiki Outpost", "Mirage Island", "Kitsune Island", "Mirror Land",
    "Dangerous Island", "Pirate Island", "Cake Land", "Frost Island"
}

-- ==================== DANH SÁCH BOSS ====================
local BossList = {
    -- SEA 1
    {name = "The Gorilla King (Jungle)", sea = 1, pos = Vector3.new(-1200, 80, -1200), hp = 2500, reward = "Fist of Darkness"},
    {name = "Bobby (Làng Hải Tặc)", sea = 1, pos = Vector3.new(-500, 50, -500), hp = 3000, reward = "Bobby's Vest"},
    {name = "Yeti (Làng Băng Giá)", sea = 1, pos = Vector3.new(-800, 100, -800), hp = 3500, reward = "Yeti Fur"},
    {name = "Mob Leader (Đảo Sa Mạc)", sea = 1, pos = Vector3.new(-300, 50, -300), hp = 2000, reward = "Bandana"},
    {name = "Vice Admiral (Pháo Đài Hải Quân)", sea = 1, pos = Vector3.new(200, 50, 200), hp = 4000, reward = "Admiral's Cape"},
    {name = "Saber Expert (Hầm Ẩn Jungle)", sea = 1, pos = Vector3.new(500, 50, 500), hp = 5000, reward = "Saber V2"},
    {name = "Warden (Nhà Tù)", sea = 1, pos = Vector3.new(800, 50, 800), hp = 4500, reward = "Warden Sword"},
    {name = "Chief Warden (Nhà Tù)", sea = 1, pos = Vector3.new(1000, 60, 1000), hp = 6000, reward = "Chief's Key"},
    {name = "Swan (Nhà Tù)", sea = 1, pos = Vector3.new(1200, 50, 1200), hp = 5500, reward = "Swan Glasses"},
    {name = "Magma Admiral (Làng Dung Nham)", sea = 1, pos = Vector3.new(1400, 70, 1400), hp = 7000, reward = "Magma Ore"},
    {name = "Fishman Jones (Thành Phố Dưới Nước)", sea = 1, pos = Vector3.new(1600, 50, 1600), hp = 8000, reward = "Fishman Mask"},
    {name = "Wysper (Skylands 1)", sea = 1, pos = Vector3.new(1800, 80, 1800), hp = 9000, reward = "Wysper's Staff"},
    {name = "Thunder God (Skylands 2)", sea = 1, pos = Vector3.new(-1800, 150, -1800), hp = 12000, reward = "Thunder Cloud"},
    {name = "Cyborg (Fountain City)", sea = 1, pos = Vector3.new(-1600, 60, -1600), hp = 10000, reward = "Cyborg Parts"},
    {name = "Greybeard (Pháo Đài Hải Quân)", sea = 1, pos = Vector3.new(-1400, 50, -1400), hp = 15000, reward = "Greybeard's Hat"},
    -- SEA 2
    {name = "Diamond (Kingdom of Rose - Cỏ Trái)", sea = 2, pos = Vector3.new(-1200, 50, -1200), hp = 18000, reward = "Diamond Gem"},
    {name = "Jeremy (Kingdom of Rose - Vách Núi Phải)", sea = 2, pos = Vector3.new(-1000, 70, -1000), hp = 20000, reward = "Jeremy's Beard"},
    {name = "Fajita (Green Zone)", sea = 2, pos = Vector3.new(-800, 50, -800), hp = 16000, reward = "Fajita's Mask"},
    {name = "Don Swan (Kingdom of Rose - Dinh Thự)", sea = 2, pos = Vector3.new(-600, 60, -600), hp = 25000, reward = "Don Swan's Coat"},
    {name = "Smoke Admiral (Hot and Cold - Bên Lạnh)", sea = 2, pos = Vector3.new(-400, 50, -400), hp = 22000, reward = "Smoke Pipe"},
    {name = "Awakened Ice Admiral (Ice Castle)", sea = 2, pos = Vector3.new(-200, 80, -200), hp = 28000, reward = "Ice Crown"},
    {name = "Tide Keeper (Forgotten Island)", sea = 2, pos = Vector3.new(200, 50, 200), hp = 30000, reward = "Tide Keeper's Trident"},
    {name = "Darkbeard (Dark Arena)", sea = 2, pos = Vector3.new(1000, 50, 1000), hp = 50000, reward = "Dark Coat"},
    {name = "Order (Hot and Cold Lab)", sea = 2, pos = Vector3.new(1200, 60, 1200), hp = 35000, reward = "Order's Robe"},
    -- SEA 3
    {name = "Stone (Port Town)", sea = 3, pos = Vector3.new(1400, 50, 1400), hp = 40000, reward = "Stone Hammer"},
    {name = "Hydra Leader (Hydra Island)", sea = 3, pos = Vector3.new(2200, 100, 2200), hp = 45000, reward = "Hydra Tail"},
    {name = "Kilo Admiral (Great Tree)", sea = 3, pos = Vector3.new(2400, 50, 2400), hp = 48000, reward = "Kilo's Weight"},
    {name = "Captain Elephant (Floating Turtle)", sea = 3, pos = Vector3.new(2600, 60, 2600), hp = 52000, reward = "Elephant Tusk"},
    {name = "Beautiful Pirate (Floating Turtle - Phòng Đỏ)", sea = 3, pos = Vector3.new(2800, 50, 2800), hp = 55000, reward = "Beautiful Scarf"},
    {name = "Longma (Floating Turtle - Dưới Trăng)", sea = 3, pos = Vector3.new(3000, 80, 3000), hp = 60000, reward = "Longma's Scale"},
    {name = "Cursed Captain (Cursed Ship)", sea = 3, pos = Vector3.new(-2200, 50, -2200), hp = 65000, reward = "Cursed Hook"},
    {name = "Soul Reaper (Haunted Castle)", sea = 3, pos = Vector3.new(3500, 120, 3500), hp = 80000, reward = "Soul Scythe"},
    {name = "Cake Queen (Sea of Treats)", sea = 3, pos = Vector3.new(-1500, 70, -1500), hp = 75000, reward = "Cake Queen's Crown"},
    {name = "Deandre (Elite - Third Sea)", sea = 3, pos = Vector3.new(3200, 50, 3200), hp = 70000, reward = "Elite Hunter's Cape"},
    {name = "Diablo (Elite - Third Sea)", sea = 3, pos = Vector3.new(3400, 60, 3400), hp = 72000, reward = "Diablo's Horns"},
    {name = "Urban (Elite - Third Sea)", sea = 3, pos = Vector3.new(3600, 50, 3600), hp = 71000, reward = "Urban's Mask"},
    {name = "Cake Prince (Mirror Land)", sea = 3, pos = Vector3.new(-1700, 70, -1700), hp = 90000, reward = "Cake Prince's Crown"},
    {name = "Dough King (Mirror Land)", sea = 3, pos = Vector3.new(2500, 80, 2500), hp = 150000, reward = "Dough King's Crown"},
    {name = "rip_indra (Castle on the Sea)", sea = 3, pos = Vector3.new(-3000, 100, -3000), hp = 200000, reward = "Indra's Katana"},
    {name = "Leviathan (Cổng Biển Thứ 3)", sea = 3, pos = Vector3.new(4000, 50, 4000), hp = 250000, reward = "Leviathan Scale"}
}

-- ==================== DANH SÁCH ELITE ====================
local EliteBosses = {
    {name = "Deandre", pos = Vector3.new(3200, 50, 3200)},
    {name = "Diablo", pos = Vector3.new(3400, 60, 3400)},
    {name = "Urban", pos = Vector3.new(3600, 50, 3600)}
}

-- ==================== DANH SÁCH QUEST ====================
local Quests = {
    {name = "Bandit Quest", level = 1, mob = "Bandit", reward = 50},
    {name = "Pirate Quest", level = 10, mob = "Pirate", reward = 100},
    {name = "Desert Quest", level = 30, mob = "Desert Bandit", reward = 200},
    {name = "Snow Quest", level = 60, mob = "Snow Bandit", reward = 350},
    {name = "Marine Quest", level = 90, mob = "Marine", reward = 500},
    {name = "Sky Quest", level = 120, mob = "Sky Soldier", reward = 700},
    {name = "Water Quest", level = 150, mob = "Water Fighter", reward = 1000},
    {name = "Prison Quest", level = 200, mob = "Prisoner", reward = 1500},
    {name = "Magma Quest", level = 300, mob = "Magma Ninja", reward = 2500},
    {name = "Rose Quest", level = 375, mob = "Rose Soldier", reward = 4000},
    {name = "Sea 3 Quest", level = 500, mob = "Hydra", reward = 6000}
}

-- ==================== LẤY TÊN BOSS ====================
local BossNames = {}
for _, boss in pairs(BossList) do
    table.insert(BossNames, boss.name)
end

local EliteNames = {}
for _, elite in pairs(EliteBosses) do
    table.insert(EliteNames, elite.name)
end

-- ==================== HÀM AUTO SKILL ====================
local function UseSkill(skill)
    if skill == "Z" then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, string.byte(skill), false, game)
        wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, string.byte(skill), false, game)
    elseif skill == "X" then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, string.byte(skill), false, game)
        wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, string.byte(skill), false, game)
    elseif skill == "C" then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, string.byte(skill), false, game)
        wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, string.byte(skill), false, game)
    elseif skill == "V" then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, string.byte(skill), false, game)
        wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, string.byte(skill), false, game)
    end
end

-- ==================== HÀM TẤN CÔNG ====================
local function Attack()
    pcall(function()
        local args = {[1] = "Attack"}
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Attack"):FireServer(unpack(args))
    end)
end

-- ==================== HÀM TÌM QUÁI GẦN NHẤT ====================
local function GetNearestMob()
    local nearest = nil
    local minDist = _G.AutoFarmRadius
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(Workspace.Enemies:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    if _G.AutoFarmMob == "All" or v.Name:lower():find(_G.AutoFarmMob:lower()) then
                        local eHrp = v:FindFirstChild("HumanoidRootPart")
                        if eHrp then
                            local dist = (eHrp.Position - hrp.Position).Magnitude
                            if dist < minDist then
                                minDist = dist
                                nearest = v
                            end
                        end
                    end
                end
            end
        end
    end
    return nearest
end

-- ==================== HÀM AUTO LEVEL ====================
local function AutoLevelUp()
    local char = LocalPlayer.Character
    if char then
        local stats = char:FindFirstChild("Data")
        if stats and stats:FindFirstChild("Level") then
            local level = stats.Level.Value
            if level >= _G.AutoLevelTarget then
                return
            end
        end
    end
    
    local nearest = GetNearestMob()
    if nearest then
        Attack()
        wait(0.2)
    end
end

-- ==================== HÀM AUTO QUEST ====================
local function AutoCompleteQuest()
    local char = LocalPlayer.Character
    if char then
        local stats = char:FindFirstChild("Data")
        if stats and stats:FindFirstChild("Level") then
            local level = stats.Level.Value
            for _, quest in pairs(Quests) do
                if level >= quest.level then
                    _G.AutoQuestName = quest.name
                    break
                end
            end
        end
    end
    
    local nearest = GetNearestMob()
    if nearest then
        Attack()
        wait(0.2)
    end
end

-- ==================== AUTO FARM ====================
CombatTab:CreateToggle("🐉 Auto Farm (Siêu Nhanh)", function(state)
    AutoFarmEnabled = state
    if state then
        spawn(function()
            while AutoFarmEnabled do
                local nearest = GetNearestMob()
                if nearest then
                    Attack()
                    wait(0.15)
                end
                wait()
            end
        end)
    end
end)

CombatTab:CreateSlider("📏 Bán kính Farm", 50, 500, 250, function(v) _G.AutoFarmRadius = v end)
CombatTab:CreateInput("🔍 Tên quái (bỏ trống farm all)", function(v) _G.AutoFarmMob = v ~= "" and v or "All" end)

-- ==================== AUTO SKILL ====================
CombatTab:CreateToggle("✨ Auto Skill (Z, X, C, V)", function(state)
    AutoSkillEnabled = state
    if state then
        if skillLoop then
            skillLoop:Disconnect()
        end
        skillLoop = RunService.RenderStepped:Connect(function()
            if AutoSkillEnabled and AutoFarmEnabled then
                for _, skill in pairs(_G.SkillList) do
                    UseSkill(skill)
                    wait(_G.SkillDelay)
                end
            end
        end)
    else
        if skillLoop then
            skillLoop:Disconnect()
            skillLoop = nil
        end
    end
end)

CombatTab:CreateMultiDropdown("🎮 Chọn Skill", {"Z", "X", "C", "V"}, function(v) _G.SkillList = v end)
CombatTab:CreateSlider("⏱️ Delay Skill (giây)", 0.1, 3, 1, function(v) _G.SkillDelay = v end)

-- ==================== AUTO LEVEL ====================
CombatTab:CreateToggle("📈 Auto Level (Lên Cấp)", function(state)
    AutoLevel = state
    if state then
        spawn(function()
            while AutoLevel do
                AutoLevelUp()
                wait()
            end
        end)
    end
end)

CombatTab:CreateSlider("🎯 Mục tiêu Level", 100, 2550, 2550, function(v) _G.AutoLevelTarget = v end)

-- ==================== AUTO QUEST ====================
CombatTab:CreateToggle("📜 Auto Quest (Nhận/Trao)", function(state)
    AutoQuest = state
    if state then
        spawn(function()
            while AutoQuest do
                AutoCompleteQuest()
                wait()
            end
        end)
    end
end)

-- ==================== AUTO PVP ====================
CombatTab:CreateToggle("⚔️ Auto PvP (Tự Động Đánh Người)", function(state)
    AutoPvp = state
    if state then
        spawn(function()
            while AutoPvp do
                local nearest = nil
                local minDist = 200
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, v in pairs(Players:GetPlayers()) do
                            if v ~= LocalPlayer then
                                local vChar = v.Character
                                if vChar and vChar:FindFirstChild("Humanoid") and vChar.Humanoid.Health > 0 then
                                    local vHrp = vChar:FindFirstChild("HumanoidRootPart")
                                    if vHrp then
                                        local dist = (vHrp.Position - hrp.Position).Magnitude
                                        if dist < minDist then
                                            minDist = dist
                                            nearest = v
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if nearest then
                    Attack()
                    wait(0.2)
                end
                wait()
            end
        end)
    end
end)

-- ==================== BOSS ====================
BossTab:CreateDropdown("🌊 Chọn SEA", {"All", "SEA 1", "SEA 2", "SEA 3"}, function(selected)
    _G.SelectedSea = selected
    local filteredBosses = {}
    for _, boss in pairs(BossList) do
        if _G.SelectedSea == "All" or (_G.SelectedSea == "SEA 1" and boss.sea == 1) or (_G.SelectedSea == "SEA 2" and boss.sea == 2) or (_G.SelectedSea == "SEA 3" and boss.sea == 3) then
            table.insert(filteredBosses, boss.name)
        end
    end
    BossTab:RefreshDropdown("Chọn Boss", filteredBosses, function(v) _G.SelectedBoss = v end)
end)

BossTab:CreateDropdown("👑 Chọn Boss", BossNames, function(selected)
    _G.SelectedBoss = selected
end)

BossTab:CreateSlider("⏱️ Delay giữa các Boss (giây)", 1, 60, 5, function(v) _G.BossFarmDelay = v end)

BossTab:CreateButton("🚀 Teleport Đến Boss", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, boss in pairs(BossList) do
                if boss.name == _G.SelectedBoss then
                    hrp.CFrame = CFrame.new(boss.pos)
                    break
                end
            end
        end
    end
end)

BossTab:CreateToggle("👑 Auto Farm Boss (All)", function(state)
    AutoBossEnabled = state
    if state then
        spawn(function()
            while AutoBossEnabled do
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, boss in pairs(BossList) do
                            if _G.SelectedSea == "All" or (_G.SelectedSea == "SEA 1" and boss.sea == 1) or (_G.SelectedSea == "SEA 2" and boss.sea == 2) or (_G.SelectedSea == "SEA 3" and boss.sea == 3) then
                                hrp.CFrame = CFrame.new(boss.pos)
                                wait(1)
                                for i = 1, 15 do
                                    Attack()
                                    wait(0.1)
                                    for _, skill in pairs(_G.SkillList) do
                                        UseSkill(skill)
                                        wait(0.05)
                                    end
                                end
                                wait(_G.BossFarmDelay)
                            end
                        end
                    end
                end
                wait(10)
            end
        end)
    end
end)

-- ==================== AUTO ELITE ====================
BossTab:CreateDropdown("🎯 Chọn Elite", EliteNames, function(selected)
    _G.SelectedElite = selected
end)

BossTab:CreateButton("🚀 Teleport Đến Elite", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, elite in pairs(EliteBosses) do
                if elite.name == _G.SelectedElite then
                    hrp.CFrame = CFrame.new(elite.pos)
                    break
                end
            end
        end
    end
end)

BossTab:CreateToggle("👑 Auto Farm Elite", function(state)
    AutoEliteEnabled = state
    if state then
        spawn(function()
            while AutoEliteEnabled do
                for _, elite in pairs(EliteBosses) do
                    local char = LocalPlayer.Character
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = CFrame.new(elite.pos)
                            wait(1)
                            for i = 1, 20 do
                                Attack()
                                wait(0.1)
                            end
                            wait(30)
                        end
                    end
                end
                wait(5)
            end
        end)
    end
end)

BossTab:CreateButton("⚔️ Spam Attack 30 lần", function()
    for i = 1, 30 do
        Attack()
        wait(0.05)
    end
end)

-- ==================== ESP ====================
ESPTab:CreateToggle("🔴 Bật ESP (Quái + Boss + Trái)", function(state)
    ESPEnabled = state
    if state then
        spawn(function()
            while ESPEnabled do
                -- ESP Quái
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local hrp = v:FindFirstChild("HumanoidRootPart")
                        if hrp and not espObjects[hrp] then
                            local bill = Instance.new("BillboardGui")
                            bill.Size = UDim2.new(0, 300, 0, 70)
                            bill.AlwaysOnTop = true
                            bill.Adornee = hrp
                            local txt = Instance.new("TextLabel", bill)
                            txt.Size = UDim2.new(1, 0, 1, 0)
                            txt.BackgroundTransparency = 1
                            local dist = (hrp.Position - Camera.CFrame.Position).Magnitude
                            local isBoss = false
                            for _, boss in pairs(BossList) do
                                if v.Name:find(boss.name:split(" ")[1]) then
                                    isBoss = true
                                    break
                                end
                            end
                            txt.Text = (isBoss and "👑 " or "👾 ") .. v.Name .. " | ❤️ " .. math.floor(v.Humanoid.Health) .. " | 📍 " .. math.floor(dist) .. "m"
                            txt.TextColor3 = isBoss and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 0, 0)
                            txt.TextScaled = true
                            txt.Font = Enum.Font.GothamBold
                            bill.Parent = hrp
                            espObjects[hrp] = bill
                        end
                    end
                end
                -- ESP Trái
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("Tool") and v.Name == "Fruit" and not espObjects[v] then
                        local bill = Instance.new("BillboardGui")
                        bill.Size = UDim2.new(0, 200, 0, 50)
                        bill.AlwaysOnTop = true
                        bill.Adornee = v
                        local txt = Instance.new("TextLabel", bill)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "🍎 TRÁI ÁC QUỶ"
                        txt.TextColor3 = Color3.fromRGB(255, 255, 0)
                        txt.TextScaled = true
                        txt.Font = Enum.Font.GothamBold
                        bill.Parent = v
                        espObjects[v] = bill
                    end
                end
                -- ESP Rương
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("BasePart") and (v.Name:lower():find("chest") or v.Name:lower():find("crate")) and not espObjects[v] then
                        local bill = Instance.new("BillboardGui")
                        bill.Size = UDim2.new(0, 150, 0, 40)
                        bill.AlwaysOnTop = true
                        bill.Adornee = v
                        local txt = Instance.new("TextLabel", bill)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "📦 RƯƠNG"
                        txt.TextColor3 = Color3.fromRGB(0, 255, 255)
                        txt.TextScaled = true
                        bill.Parent = v
                        espObjects[v] = bill
                    end
                end
                wait(0.3)
            end
        end)
    else
        for _, v in pairs(espObjects) do
            pcall(function() v:Destroy() end)
        end
        espObjects = {}
    end
end)

ESPTab:CreateToggle("🎯 Aimbot (Tự Động Xoay Camera)", function(state)
    AimbotEnabled = state
    if state then
        spawn(function()
            while AimbotEnabled do
                local nearest, minDist = nil, 200
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, v in pairs(Workspace.Enemies:GetChildren()) do
                            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                local eHrp = v:FindFirstChild("HumanoidRootPart")
                                if eHrp then
                                    local dist = (eHrp.Position - hrp.Position).Magnitude
                                    if dist < minDist and dist < 150 then
                                        minDist, nearest = dist, eHrp
                                    end
                                end
                            end
                        end
                    end
                end
                if nearest then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearest.Position)
                end
                wait(0.05)
            end
        end)
    end
end)

ESPTab:CreateToggle("🔍 ESP Player (Người Chơi)", function(state)
    if state then
        spawn(function()
            while state do
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer then
                        local vChar = v.Character
                        if vChar then
                            local hrp = vChar:FindFirstChild("HumanoidRootPart")
                            if hrp and not espObjects[hrp] then
                                local bill = Instance.new("BillboardGui")
                                bill.Size = UDim2.new(0, 250, 0, 60)
                                bill.AlwaysOnTop = true
                                bill.Adornee = hrp
                                local txt = Instance.new("TextLabel", bill)
                                txt.Size = UDim2.new(1, 0, 1, 0)
                                txt.BackgroundTransparency = 1
                                local dist = (hrp.Position - Camera.CFrame.Position).Magnitude
                                txt.Text = "🧑 " .. v.Name .. " | 📍 " .. math.floor(dist) .. "m"
                                txt.TextColor3 = Color3.fromRGB(0, 255, 0)
                                txt.TextScaled = true
                                bill.Parent = hrp
                                espObjects[hrp] = bill
                            end
                        end
                    end
                end
                wait(0.3)
            end
        end)
    end
end)

-- ==================== TRÁI ====================
FruitTab:CreateToggle("🍎 Auto Nhặt Trái", function(state)
    AutoCollectFruit = state
    if state then
        spawn(function()
            while AutoCollectFruit do
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, v in pairs(Workspace:GetDescendants()) do
                            if v:IsA("Tool") and v.Name == "Fruit" then
                                hrp.CFrame = v.CFrame
                                wait(0.3)
                                fireclickdetector(v:FindFirstChild("ClickDetector"))
                                break
                            end
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

FruitTab:CreateToggle("📦 Auto Cất Trái (Store)", function(state)
