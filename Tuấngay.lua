-- Tuấn Gay Hub | Blox Fruits - Auto Farm + All Bosses (SEA 1,2,3)
-- ID Ảnh: 77847987417610

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KiuYT/RD7.lua/main/UILib.lua"))()
local Window = Library:CreateWindow("Tuấn Gay Hub | Blox Fruits")
local CombatTab = Window:CreateTab("⚔️ Chiến Đấu")
local BossTab = Window:CreateTab("👑 Boss")
local ESPTab = Window:CreateTab("👁️ ESP")
local FruitTab = Window:CreateTab("🍎 Trái")
local SeaTab = Window:CreateTab("🌊 Biển")
local TeleportTab = Window:CreateTab("🌀 Dịch Chuyển")
local MiscTab = Window:CreateTab("🎯 Khác")
local SettingTab = Window:CreateTab("⚙️ Cài Đặt")

-- Trạng thái
local AutoFarmEnabled = false
local AutoBossEnabled = false
local AutoCollectFruit = false
local AutoStoreFruit = false
local AutoBuyItem = false
local AutoRace = false
local ESPEnabled = false
local AimbotEnabled = false
local SpeedEnabled = false
local FlyEnabled = false
local NoClipEnabled = false
local InfiniteYieldLoaded = false

local espObjects = {}
_G.SelectedFruit = "Kitsune"
_G.SelectedBoss = "Darkbeard"
_G.AutoFarmMob = "All"
_G.AutoFarmRadius = 250
_G.BossFarmDelay = 5
_G.SelectedSea = "All"

-- Danh sách trái
local Fruits = {
    "Rocket", "Spin", "Blade", "Spring", "Bomb", "Smoke", "Spike",
    "Flame", "Ice", "Sand", "Dark", "Eagle", "Diamond", "Light",
    "Rubber", "Ghost", "Magma", "Quake", "Buddha", "Love", "Creation",
    "Spider", "Sound", "Phoenix", "Portal", "Lightning", "Pain",
    "Blizzard", "Gravity", "Mammoth", "T-Rex", "Dough", "Shadow",
    "Venom", "Control", "Spirit", "Tiger", "Dragon", "Kitsune"
}

-- Danh sách đảo
local Islands = {
    "Starter Island", "Jungle", "Pirate Village", "Desert", "Middle Island",
    "Frozen Village", "Marine Fortress", "Skylands", "Prison", "Colosseum",
    "Magma Village", "Underwater City", "Fountain City", "Kingdom of Rose",
    "Usoap's Island", "Green Zone", "Graveyard Island", "Dark Arena",
    "Snow Mountain", "Hot and Cold", "Cursed Ship", "Ice Castle",
    "Forgotten Island", "Port Town", "Hydra Island", "Great Tree",
    "Floating Turtle", "Castle on the Sea", "Haunted Castle", "Sea of Treats",
    "Tiki Outpost", "Mirage Island", "Kitsune Island", "Mirror Land"
}

-- Danh sách Boss đầy đủ + SEA + Vị trí
local BossList = {
    -- SEA 1
    {name = "The Gorilla King (Jungle)", sea = 1, pos = Vector3.new(-1200, 80, -1200)},
    {name = "Bobby (Làng Hải Tặc)", sea = 1, pos = Vector3.new(-500, 50, -500)},
    {name = "Yeti (Làng Băng Giá)", sea = 1, pos = Vector3.new(-800, 100, -800)},
    {name = "Mob Leader (Đảo Sa Mạc)", sea = 1, pos = Vector3.new(-300, 50, -300)},
    {name = "Vice Admiral (Pháo Đài Hải Quân)", sea = 1, pos = Vector3.new(200, 50, 200)},
    {name = "Saber Expert (Hầm Ẩn Jungle)", sea = 1, pos = Vector3.new(500, 50, 500)},
    {name = "Warden (Nhà Tù)", sea = 1, pos = Vector3.new(800, 50, 800)},
    {name = "Chief Warden (Nhà Tù)", sea = 1, pos = Vector3.new(1000, 60, 1000)},
    {name = "Swan (Nhà Tù)", sea = 1, pos = Vector3.new(1200, 50, 1200)},
    {name = "Magma Admiral (Làng Dung Nham)", sea = 1, pos = Vector3.new(1400, 70, 1400)},
    {name = "Fishman Jones (Thành Phố Dưới Nước)", sea = 1, pos = Vector3.new(1600, 50, 1600)},
    {name = "Wysper (Skylands 1)", sea = 1, pos = Vector3.new(1800, 80, 1800)},
    {name = "Thunder God (Skylands 2)", sea = 1, pos = Vector3.new(-1800, 150, -1800)},
    {name = "Cyborg (Fountain City)", sea = 1, pos = Vector3.new(-1600, 60, -1600)},
    {name = "Greybeard (Pháo Đài Hải Quân)", sea = 1, pos = Vector3.new(-1400, 50, -1400)},
    -- SEA 2
    {name = "Diamond (Kingdom of Rose - Cỏ Trái)", sea = 2, pos = Vector3.new(-1200, 50, -1200)},
    {name = "Jeremy (Kingdom of Rose - Vách Núi Phải)", sea = 2, pos = Vector3.new(-1000, 70, -1000)},
    {name = "Fajita (Green Zone)", sea = 2, pos = Vector3.new(-800, 50, -800)},
    {name = "Don Swan (Kingdom of Rose - Dinh Thự)", sea = 2, pos = Vector3.new(-600, 60, -600)},
    {name = "Smoke Admiral (Hot and Cold - Bên Lạnh)", sea = 2, pos = Vector3.new(-400, 50, -400)},
    {name = "Awakened Ice Admiral (Ice Castle)", sea = 2, pos = Vector3.new(-200, 80, -200)},
    {name = "Tide Keeper (Forgotten Island)", sea = 2, pos = Vector3.new(200, 50, 200)},
    {name = "Darkbeard (Dark Arena)", sea = 2, pos = Vector3.new(1000, 50, 1000)},
    {name = "Order (Hot and Cold Lab)", sea = 2, pos = Vector3.new(1200, 60, 1200)},
    -- SEA 3
    {name = "Stone (Port Town)", sea = 3, pos = Vector3.new(1400, 50, 1400)},
    {name = "Hydra Leader (Hydra Island)", sea = 3, pos = Vector3.new(2200, 100, 2200)},
    {name = "Kilo Admiral (Great Tree)", sea = 3, pos = Vector3.new(2400, 50, 2400)},
    {name = "Captain Elephant (Floating Turtle)", sea = 3, pos = Vector3.new(2600, 60, 2600)},
    {name = "Beautiful Pirate (Floating Turtle - Phòng Đỏ)", sea = 3, pos = Vector3.new(2800, 50, 2800)},
    {name = "Longma (Floating Turtle - Dưới Trăng)", sea = 3, pos = Vector3.new(3000, 80, 3000)},
    {name = "Cursed Captain (Cursed Ship)", sea = 3, pos = Vector3.new(-2200, 50, -2200)},
    {name = "Soul Reaper (Haunted Castle)", sea = 3, pos = Vector3.new(3500, 120, 3500)},
    {name = "Cake Queen (Sea of Treats)", sea = 3, pos = Vector3.new(-1500, 70, -1500)},
    {name = "Deandre (Elite - Third Sea)", sea = 3, pos = Vector3.new(3200, 50, 3200)},
    {name = "Diablo (Elite - Third Sea)", sea = 3, pos = Vector3.new(3400, 60, 3400)},
    {name = "Urban (Elite - Third Sea)", sea = 3, pos = Vector3.new(3600, 50, 3600)},
    {name = "Cake Prince (Mirror Land)", sea = 3, pos = Vector3.new(-1700, 70, -1700)},
    {name = "Dough King (Mirror Land)", sea = 3, pos = Vector3.new(2500, 80, 2500)},
    {name = "rip_indra (Castle on the Sea)", sea = 3, pos = Vector3.new(-3000, 100, -3000)},
    {name = "Leviathan (Cổng Biển Thứ 3)", sea = 3, pos = Vector3.new(4000, 50, 4000)}
}

-- Lấy danh sách tên Boss
local BossNames = {}
for _, boss in pairs(BossList) do
    table.insert(BossNames, boss.name)
end

-- ==================== CHIẾN ĐẤU ====================
CombatTab:CreateToggle("🐉 Auto Farm", function(state)
    AutoFarmEnabled = state
    if state then
        spawn(function()
            while AutoFarmEnabled do
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
                if nearest then
                    pcall(function()
                        local args = {[1] = "Attack"}
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Attack"):FireServer(unpack(args))
                    end)
                    wait(0.2)
                end
                wait()
            end
        end)
    end
end)

CombatTab:CreateSlider("📏 Bán kính Farm", 50, 500, 250, function(v) _G.AutoFarmRadius = v end)
CombatTab:CreateInput("🔍 Tên quái (bỏ trống farm all)", function(v) _G.AutoFarmMob = v ~= "" and v or "All" end)

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

BossTab:CreateSlider("⏱️ Delay giữa các Boss (giây)", 1, 30, 5, function(v) _G.BossFarmDelay = v end)

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

BossTab:CreateToggle("👑 Auto Farm Boss", function(state)
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
                                for i = 1, 10 do
                                    pcall(function()
                                        local args = {[1] = "Attack"}
                                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Attack"):FireServer(unpack(args))
                                    end)
                                    wait(0.1)
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

BossTab:CreateButton("⚔️ Spam Attack 20 lần", function()
    for i = 1, 20 do
        pcall(function()
            local args = {[1] = "Attack"}
            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Attack"):FireServer(unpack(args))
        end)
        wait(0.05)
    end
end)

-- ==================== ESP ====================
ESPTab:CreateToggle("🔴 Bật ESP", function(state)
    ESPEnabled = state
    if state then
        spawn(function()
            while ESPEnabled do
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local hrp = v:FindFirstChild("HumanoidRootPart")
                        if hrp and not espObjects[hrp] then
                            local bill = Instance.new("BillboardGui")
                            bill.Size = UDim2.new(0, 250, 0, 60)
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
                            txt.TextColor3 = isBoss and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 0, 0)
                            txt.TextScaled = true
                            bill.Parent = hrp
                            espObjects[hrp] = bill
                        end
                    end
                end
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("Tool") and v.Name == "Fruit" and not espObjects[v] then
                        local bill = Instance.new("BillboardGui")
                        bill.Size = UDim2.new(0, 150, 0, 40)
                        bill.AlwaysOnTop = true
                        bill.Adornee = v
                        local txt = Instance.new("TextLabel", bill)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "🍎 TRÁI ÁC QUỶ"
                        txt.TextColor3 = Color3.fromRGB(255, 255, 0)
                        txt.TextScaled = true
                        bill.Parent = v
                        espObjects[v] = bill
                    end
                end
                wait(0.3)
            end
        end)
    else
        for _, v in pairs(espObjects) do pcall(function() v:Destroy() end) end
        espObjects = {}
    end
end)

ESPTab:CreateToggle("🎯 Aimbot (Tự Động Xoay)", function(state)
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
                if nearest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearest.Position) end
                wait(0.05)
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
    AutoStoreFruit = state
    if state then
        spawn(function()
            while AutoStoreFruit do
                pcall(function()
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Fruit"):FireServer("Store")
                end)
                wait(60)
            end
        end)
    end
end)

FruitTab:CreateDropdown("🍍 Chọn Trái Muốn Mua", Fruits, function(v) _G.SelectedFruit = v end)
FruitTab:CreateToggle("💰 Auto Mua Trái (Belì)", function(state)
    AutoBuyItem = state
    if state then
        spawn(function()
            while AutoBuyItem do
                pcall(function()
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Shop"):FireServer("Buy", _G.SelectedFruit)
                end)
                wait(300)
            end
        end)
    end
end)

FruitTab:CreateButton("🚀 Teleport Đến Trái Gần Nhất", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Tool") and v.Name == "Fruit" then
                    hrp.CFrame = v.CFrame
                    break
                end
            end
        end
    end
end)

-- ==================== BIỂN ====================
SeaTab:CreateButton("🌊 Teleport SEA 2", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(1450, 50, 500)
            wait(1)
            pcall(function() ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Game"):FireServer("UpgradeToSea2") end)
        end
    end
end)

SeaTab:CreateButton("🌊 Teleport SEA 3", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(2000, 50, 2000)
            wait(1)
            pcall(function() ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Game"):FireServer("UpgradeToSea3") end)
        end
    end
end)

SeaTab:CreateToggle("🏊 Auto Race (Đua Thuyền)", function(state)
    AutoRace = state
    if state then
        spawn(function()
            while AutoRace do
                pcall(function() ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Race"):FireServer("StartRace") end)
                wait(120)
            end
        end)
    end
end)

-- ==================== DỊCH CHUYỂN ====================
TeleportTab:CreateDropdown("🌍 Dịch Chuyển Đảo", Islands, function(selected)
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local map = Workspace:FindFirstChild("Map")
            if map and map:FindFirstChild(selected) then
                hrp.CFrame = map[selected].CFrame
            end
        end
    end
end)

TeleportTab:CreateButton("🎯 Teleport Đến Mob Gần Nhất", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local nearest, minDist = nil, 300
            for _, v in pairs(Workspace.Enemies:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                    local eHrp = v:FindFirstChild("HumanoidRootPart")
                    if eHrp then
                        local dist = (eHrp.Position - hrp.Position).Magnitude
                        if dist < minDist then
                            minDist, nearest = dist, eHrp
                        end
                    end
                end
            end
            if nearest then hrp.CFrame = nearest.CFrame * CFrame.new(0, 0, 5) end
        end
    end
end)

-- ==================== KHÁC ====================
MiscTab:CreateToggle("⚡ Tốc Độ Cao (WalkSpeed)", function(state)
    SpeedEnabled = state
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = state and 250 or 16 end
    end
end)

MiscTab:CreateToggle("🕊️ Bay (Fly)", function(state)
    FlyEnabled = state
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum:ChangeState(state and Enum.HumanoidStateType.Flying or Enum.HumanoidStateType.GettingUp) end
    end
end)

MiscTab:CreateToggle("🧱 Xuyên Tường (NoClip)", function(state)
    NoClipEnabled = state
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
    end
end)

MiscTab:CreateButton("🔄 Reset Nhân Vật", function()
    local char = LocalPlayer.Character
    if char then char:BreakJoints() end
end)

MiscTab:CreateButton("💥 Spam Attack x20", function()
    for i = 1, 20 do
        pcall(function()
            local args = {[1] = "Attack"}
            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("Attack"):FireServer(unpack(args))
        end)
        wait(0.05)
    end
end)

-- ==================== CÀI ĐẶT ====================
SettingTab:CreateButton("🔄 Rejoin (Vào Lại)", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

SettingTab:CreateButton("🎲 Server Hop (Đổi Máy Chủ)", function()
    local servers = {}
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
    end)
    if success and data then
        for _, v in pairs(data["data"]) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, v.id)
            end
        end
    end
    if #servers > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
    end
end)

SettingTab:CreateButton("🔧 Infinite Yield (Admin)", function()
    if not InfiniteYieldLoaded then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        InfiniteYieldLoaded = true
    end
end)

SettingTab:CreateButton("📋 ID ẢNH: 77847987417610", function()
    setclipboard("77847987417610")
end)

SettingTab:CreateButton("❌ Xóa Toàn Bộ ESP", function()
    for _, v in pairs(espObjects) do pcall(function() v:Destroy() end) end
    espObjects = {}
    ESPEnabled = false
end)

print("✅ Tuấn Gay Hub | Full Bosses SEA 1,2,3 đã tải thành công!")
print("📋 ID Ảnh: 77847987417610")
