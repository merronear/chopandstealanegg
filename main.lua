-- ==========================================
-- 1. VALIDASI ID GAME (CHOP AND STEAL AN EGG)
-- ==========================================
local ID_GAME_ANDA = 135361740992269 

if game.PlaceId ~= ID_GAME_ANDA then
    warn("Script ini tidak cocok dengan game ini!")
    return 
end

if game.Players.LocalPlayer.PlayerGui:FindFirstChild("DeltaCustomPanel") then
    game.Players.LocalPlayer.PlayerGui.DeltaCustomPanel:Destroy()
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
MainFrame.Size = UDim2.new(0, 300, 0, 185) 
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -92)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(75, 55, 110) 
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Celestial Helper v3.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = TopBar

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

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- ==========================================
-- 3. TOMBOL TOGGLE (AXE & CELESTIAL TREE)
-- ==========================================
local HoldAxeBtn = Instance.new("TextButton")
HoldAxeBtn.Name = "HoldAxeBtn"
HoldAxeBtn.Size = UDim2.new(0, 260, 0, 40)
HoldAxeBtn.Position = UDim2.new(0, 20, 0, 15)
HoldAxeBtn.Text = "Auto Hold Axe: OFF"
HoldAxeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HoldAxeBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
HoldAxeBtn.Font = Enum.Font.SourceSansBold
HoldAxeBtn.TextSize = 14
HoldAxeBtn.BorderSizePixel = 0
HoldAxeBtn.Parent = ContentFrame

local GoTreeBtn = Instance.new("TextButton")
GoTreeBtn.Name = "GoTreeBtn"
GoTreeBtn.Size = UDim2.new(0, 260, 0, 40)
GoTreeBtn.Position = UDim2.new(0, 20, 0, 65)
GoTreeBtn.Text = "Go to Celestial Tree: OFF"
GoTreeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GoTreeBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
GoTreeBtn.Font = Enum.Font.SourceSansBold
GoTreeBtn.TextSize = 14
GoTreeBtn.BorderSizePixel = 0
GoTreeBtn.Parent = ContentFrame

-- ==========================================
-- 4. FUNGSI LOGIK & INTERAKSI
-- ==========================================
local isMinimized = false
_G.AutoHoldAxe = false
_G.GoCelestialTree = false

MinMaxBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 185), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
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

-- LOGIK TOMBOL 1: Auto Hold Axe
HoldAxeBtn.MouseButton1Click:Connect(function()
    _G.AutoHoldAxe = not _G.AutoHoldAxe
    if _G.AutoHoldAxe then
        HoldAxeBtn.Text = "Auto Hold Axe: ON"
        HoldAxeBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40)
        
        task.spawn(function()
            while _G.AutoHoldAxe do
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and player:FindFirstChild("Backpack") then
                    local holdingTool = character:FindFirstChildOfClass("Tool")
                    if not holdingTool or not holdingTool.Name:match("Axe") then
                        for _, tool in pairs(player.Backpack:GetChildren()) do
                            if tool:IsA("Tool") and tool.Name:match("Axe") then
                                character.Humanoid:EquipTool(tool)
                                break
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        HoldAxeBtn.Text = "Auto Hold Axe: OFF"
        HoldAxeBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    end
end)

-- LOGIK TOMBOL 2: Go to Nearest Celestial Tree (Pencarian Lebih Pintar)
GoTreeBtn.MouseButton1Click:Connect(function()
    _G.GoCelestialTree = not _G.GoCelestialTree
    if _G.GoCelestialTree then
        GoTreeBtn.Text = "Go to Celestial Tree: ON"
        GoTreeBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40)
        
        task.spawn(function()
            while _G.GoCelestialTree do
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    
                    local nearestTreePart = nil
                    local shortestDistance = math.huge
                    
                    -- Memindai Workspace dengan sistem kecocokan teks (Case-Insensitive)
                    for _, obj in pairs(workspace:GetDescendants()) do
                        local namaObjek = string.lower(obj.Name)
                        
                        -- Deteksi jika objek mengandung kata celestial dan tree secara bersamaan
                        if (string.match(namaObjek, "celestial") and string.match(namaObjek, "tree")) or namaObjek == "celestial tree" then
                            -- Jika objek berupa Model, cari Part di dalamnya. Jika objek sudah berupa Part, langsung pakai.
                            local targetPart = nil
                            if obj:IsA("Model") then
                                targetPart = obj:FindFirstChild("Part") or obj:FindFirstChildOfClass("BasePart")
                            elseif obj:IsA("BasePart") then
                                targetPart = obj
                            end
                            
                            if targetPart then
                                local distance = (character.HumanoidRootPart.Position - targetPart.Position).Magnitude
                                if distance < shortestDistance then
                                    shortestDistance = distance
                                    nearestTreePart = targetPart
                                end
                            end
                        end
                    end
                    
                    -- Eksekusi gerakan jika pohon ditemukan
                    if nearestTreePart then
                        -- Memindahkan karakter ke samping pohon (jarak aman 3 stud)
                        character.HumanoidRootPart.CFrame = nearestTreePart.CFrame * CFrame.new(0, 0, 3)
                    else
                        -- Jika nama model pohonnya berbeda, script akan memindai folder "Celestial" langsung jika ada
                        local zoneCelestial = workspace:FindFirstChild("Celestial", true)
                        if zoneCelestial then
                            -- Cari part apa saja di dalam folder Celestial yang memiliki nama Tree
                            for _, subObj in pairs(zoneCelestial:GetDescendants()) do
                                if string.match(string.lower(subObj.Name), "tree") and subObj:IsA("BasePart") then
                                        local distance = (character.HumanoidRootPart.Position - subObj.Position).Magnitude
                                        if distance < shortestDistance then
                                            shortestDistance = distance
                                            nearestTreePart = subObj
                                        end
                                end
                            end
                            if nearestTreePart then
                                character.HumanoidRootPart.CFrame = nearestTreePart.CFrame * CFrame.new(0, 0, 3)
                            end
                        end
                    end
                end
                task.wait(0.3) -- Dipercepat agar respon berpindah ke pohon berikutnya lebih sigap
            end
        end)
    else
        GoTreeBtn.Text = "Go to Celestial Tree: OFF"
        GoTreeBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    end
end)

print("Panel Celestial Helper v3.1 Berhasil Dimuat!")
