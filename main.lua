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
MainFrame.Size = UDim2.new(0, 300, 0, 130) -- Ukuran pendek khusus 1 tombol
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -65)
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
Title.Text = "Chop & Steal - Helper"
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
-- 3. TOMBOL TOGGLE HOLD AXE
-- ==========================================
local HoldAxeBtn = Instance.new("TextButton")
HoldAxeBtn.Name = "HoldAxeBtn"
HoldAxeBtn.Size = UDim2.new(0, 260, 0, 45)
HoldAxeBtn.Position = UDim2.new(0, 20, 0, 20)
HoldAxeBtn.Text = "Auto Hold Axe: OFF"
HoldAxeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HoldAxeBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Merah awal mati
HoldAxeBtn.Font = Enum.Font.SourceSansBold
HoldAxeBtn.TextSize = 15
HoldAxeBtn.BorderSizePixel = 0
HoldAxeBtn.Parent = ContentFrame

-- ==========================================
-- 4. FUNGSI LOGIK & INTERAKSI
-- ==========================================
local isMinimized = false
_G.AutoHoldAxe = false

-- Logik Minimize/Maximize
MinMaxBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 130), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
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

-- Logik Klik Tombol Auto Hold Axe
HoldAxeBtn.MouseButton1Click:Connect(function()
    _G.AutoHoldAxe = not _G.AutoHoldAxe
    
    if _G.AutoHoldAxe then
        HoldAxeBtn.Text = "Auto Hold Axe: ON"
        HoldAxeBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40) -- Berubah HIJAU
        
        -- Loop untuk mengecek dan melengkapi kapak jika terlepas
        task.spawn(function()
            while _G.AutoHoldAxe do
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and player:FindFirstChild("Backpack") then
                    local holdingTool = character:FindFirstChildOfClass("Tool")
                    -- Jika sedang tidak pegang tool, atau tool yang dipegang bukan kapak
                    if not holdingTool or not holdingTool.Name:match("Axe") then
                        for _, tool in pairs(player.Backpack:GetChildren()) do
                            if tool:IsA("Tool") and tool.Name:match("Axe") then
                                character.Humanoid:EquipTool(tool)
                                break
                            end
                        end
                    end
                end
                task.wait(0.5) -- Cek setiap 0.5 detik agar ringan
            end
        end)
    else
        HoldAxeBtn.Text = "Auto Hold Axe: OFF"
        HoldAxeBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Kembali MERAH
    end
end)

print("Panel Auto Hold Axe Berhasil Dimuat!")