- ==========================================
-- 1. VALIDASI ID GAME (CHOP AND STEAL AN EGG)
-- ==========================================
local ID_GAME_ANDA = 135361740992269 

if game.PlaceId ~= ID_GAME_ANDA then
    warn("Script ini tidak cocok dengan game ini!")
    return 
end

-- ==========================================
-- 2. CORE GUI & MAIN PANEL (CELESTIAL ONLY)
-- ==========================================
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaCustomPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 260) -- Ukuran pas untuk 3 tombol fungsi
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(75, 55, 110) -- Warna ungu khas Celestial
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

-- Judul Panel
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Celestial Zone Helper"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = TopBar

-- Tombol Minimize / Maximize
local MinMaxBtn = Instance.new("TextButton")
MinMaxBtn.Name = "MinMaxBtn"
MinMaxBtn.Size = UDim2.new(0, 30, 0, 30)
MinMaxBtn.Position = UDim2.new(1, -30, 0, 0)
MinMaxBtn.Text = "-"
MinMaxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinMaxBtn.BackgroundColor3 = Color3.fromRGB(90, 70, 130)
MinMaxBtn.BorderSizePixel = 0
MinMaxBtn.Font = Enum.Font.SourceSansBold
MinMaxBtn.TextSize = 18
MinMaxBtn.Parent = TopBar

-- Konten Utama
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- ==========================================
-- 3. TOMBOL FITUR (SESUAI ALUR GAME)
-- ==========================================
-- Tombol 1: Masuk ke Zona Celestial
local GoCelestialBtn = Instance.new("TextButton")
GoCelestialBtn.Name = "GoCelestialBtn"
GoCelestialBtn.Size = UDim2.new(0, 260, 0, 40)
GoCelestialBtn.Position = UDim2.new(0, 20, 0, 15)
GoCelestialBtn.Text = "1. Go to Celestial Zone"
GoCelestialBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GoCelestialBtn.BackgroundColor3 = Color3.fromRGB(90, 60, 150)
GoCelestialBtn.Font = Enum.Font.SourceSansBold
GoCelestialBtn.TextSize = 15
GoCelestialBtn.BorderSizePixel = 0
GoCelestialBtn.Parent = ContentFrame

-- Tombol 2: Auto Swing (Chop Tree)
local SwingBtn = Instance.new("TextButton")
SwingBtn.Name = "SwingBtn"
SwingBtn.Size = UDim2.new(0, 260, 0, 40)
SwingBtn.Position = UDim2.new(0, 20, 0, 70)
SwingBtn.Text = "2. Auto Swing (Chop): OFF"
SwingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SwingBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Warna merah (mati)
SwingBtn.Font = Enum.Font.SourceSansBold
SwingBtn.TextSize = 15
SwingBtn.BorderSizePixel = 0
SwingBtn.Parent = ContentFrame

-- Tombol 3: Auto Collect & Secure Egg (Ambil -> Safezone -> Drop -> Pull)
local SecureBtn = Instance.new("TextButton")
SecureBtn.Name = "SecureBtn"
SecureBtn.Size = UDim2.new(0, 260, 0, 40)
SecureBtn.Position = UDim2.new(0, 20, 0, 125)
SecureBtn.Text = "3. Auto Secure Egg: OFF"
SecureBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SecureBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
SecureBtn.Font = Enum.Font.SourceSansBold
SecureBtn.TextSize = 15
SecureBtn.BorderSizePixel = 0
SecureBtn.Parent = ContentFrame

-- ==========================================
-- 4. FUNGSI LOGIK & LOOPS INTERAKSI
-- ==========================================
local isMinimized = false
_G.AutoSwing = false
_G.AutoSecure = false

-- Logik Minimize/Maximize
MinMaxBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 260), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
        ContentFrame.Visible = true
        MinMaxBtn.Text = "-"
        isMinimized = false
    else
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 30), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
        ContentFrame.Visible = false
        MinMaxBtn.Text = "+"
        isMinimized = true
    end
end)

-- LOGIK TOMBOL 1: Masuk ke Zona Celestial
GoCelestialBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        -- Mencari objek bernama "Celestial" di Workspace untuk titik tujuan berjalan/teleport
        local celestialZone = workspace:FindFirstChild("Celestial", true)
        if celestialZone then
            local targetPart = celestialZone:IsA("BasePart") and celestialZone or celestialZone:FindFirstChildOfClass("BasePart")
            if targetPart then
                character.HumanoidRootPart.CFrame = targetPart.CFrame * CFrame.new(0, 5, 0)
                print("Teleport sukses menuju Zona Celestial.")
            end
        else
            warn("Objek bernama 'Celestial' tidak ditemukan di Workspace!")
        end
    end
end)

-- LOGIK TOMBOL 2: Auto Swing (Chop Tree)
SwingBtn.MouseButton1Click:Connect(function()
    _G.AutoSwing = not _G.AutoSwing
    if _G.AutoSwing then
        SwingBtn.Text = "2. Auto Swing (Chop): ON"
        SwingBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40) -- Berubah HIJAU saat menyala
        
        task.spawn(function()
            while _G.AutoSwing do
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and player:FindFirstChild("Backpack") then
                    -- 1. Pasang Kapak (Axe) secara otomatis jika belum dipegang
                    local holdingTool = character:FindFirstChildOfClass("Tool")
                    if not holdingTool or not holdingTool.Name:match("Axe") then
                        for _, tool in pairs(player.Backpack:GetChildren()) do
                            if tool:IsA("Tool") and tool.Name:match("Axe") then
                                character.Humanoid:EquipTool(tool)
                                break
                            end
                        end
                    end
                    -- 2. Swing / Aktifkan kapak yang sedang dipegang
                    local activeTool = character:FindFirstChildOfClass("Tool")
                    if activeTool then
                        activeTool:Activate()
                    end
                end
                task.wait(0.2)
            end
        end)
    else
        SwingBtn.Text = "2. Auto Swing (Chop): OFF"
        SwingBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Kembali MERAH saat mati
    end
end)

-- LOGIK TOMBOL 3: Auto Secure Egg (Ambil -> Safezone -> Drop -> Pull)
SecureBtn.MouseButton1Click:Connect(function()
    _G.AutoSecure = not _G.AutoSecure
    if _G.AutoSecure then
        SecureBtn.Text = "3. Auto Secure Egg: ON"
        SecureBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40) -- Berubah HIJAU
        
        task.spawn(function()
            while _G.AutoSecure do
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    
                    -- 1. Cari apakah ada objek mengandung nama "Egg" di Workspace dekat peta
                    local targetEgg = nil
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name:match("Egg") then
                            targetEgg = obj
                            break
                        end
                    end
                    
                    if targetEgg then
                        -- A. Ambil Telur (Teleport ke telur)
                        character.HumanoidRootPart.CFrame = targetEgg.CFrame
                        task.wait(0.4) -- Jeda agar sistem mencatat pengambilan telur
                        
                        -- B. Bawa ke Safezone (Mencari objek SafeZone atau SpawnLocation)
                        local safeZone = workspace:FindFirstChild("SafeZone", true) or workspace:FindFirstChild("SpawnLocation", true)
                        if safeZone and safeZone:IsA("BasePart") then
                            character.HumanoidRootPart.CFrame = safeZone.CFrame * CFrame.new(0, 3, 0)
                            task.wait(0.4)
                        end
                        
                        -- C. Drop egg ke DROP eggs pad (Mencari part bernama "DropPad" atau "EggPad")
                        local dropPad = workspace:FindFirstChild("DropPad", true) or workspace:FindFirstChild("EggPad", true)
                        if dropPad and dropPad:IsA("BasePart") then
                            character.HumanoidRootPart.CFrame = dropPad.CFrame * CFrame.new(0, 3, 0)
                            task.wait(0.4)
                        end
                        
                        -- D. Tekan / Pemicu tombol Pull (Mencari ProximityPrompt atau ClickDetector tombol Pull)
                        local pullBtn = workspace:FindFirstChild("Pull", true) or workspace:FindFirstChild("PullButton", true)
                        if pullBtn then
