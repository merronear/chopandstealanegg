-- ==========================================
-- 1. VALIDASI ID GAME (CHOP AND STEAL AN EGG)
-- ==========================================
local ID_GAME_ANDA = 135361740992269 

if game.PlaceId ~= ID_GAME_ANDA then
    warn("Script ini tidak cocok dengan game ini!")
    return 
end

-- ==========================================
-- 2. CORE GUI & MAIN PANEL
-- ==========================================
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaCustomPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

-- Judul Panel
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Chop & Steal - Farm"
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
MinMaxBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
-- 3. TOMBOL FITUR AUTO FARM (BARU)
-- ==========================================
local FarmBtn = Instance.new("TextButton")
FarmBtn.Name = "FarmBtn"
FarmBtn.Size = UDim2.new(0, 260, 0, 40)
FarmBtn.Position = UDim2.new(0, 20, 0, 20) -- Jarak dari atas konten
FarmBtn.Text = "Auto Farm: OFF"
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Awalnya warna merah (mati)
FarmBtn.Font = Enum.Font.SourceSansBold
FarmBtn.TextSize = 16
FarmBtn.BorderSizePixel = 0
FarmBtn.Parent = ContentFrame

-- ==========================================
-- 4. FUNGSI LOGIK & INTERAKSI
-- ==========================================
local isMinimized = false
_G.AutoFarm = false -- Status awal auto farm mati

-- Logik Minimize/Maximize
MinMaxBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 200), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
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

-- Logik Klik Tombol Auto Farm
FarmBtn.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm -- Membalikkan status true/false
    
    if _G.AutoFarm then
        FarmBtn.Text = "Auto Farm: ON"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40) -- Berubah hijau
        
        -- Memulai fungsi farming di background
        task.spawn(function()
            while _G.AutoFarm do
                print("Karakter sedang melakukan aksi farming client-side...")
                -- TODO: Masukkan mekanik gerakan/teleport farming di sini
                task.wait(1)
            end
        end)
    else
        FarmBtn.Text = "Auto Farm: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Berubah merah kembali
    end
end)

print("Panel Chop & Steal Berhasil Dimuat!")