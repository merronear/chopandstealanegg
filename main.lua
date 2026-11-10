-- ==========================================
-- 1. VALIDASI ID GAME
-- ==========================================
local ID_GAME_ANDA = 135361740992269 

if game.PlaceId ~= ID_GAME_ANDA then
    warn("Script ini tidak cocok dengan game ini!")
    return 
end

-- ==========================================
-- 2. LOGIN MASUK ZONA CELESTIAL
-- ==========================================
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Mencari objek bernama "Celestial" di game
local celestialZone = workspace:FindFirstChild("Celestial", true)

if celestialZone then
    -- Mengambil part utama dari objek Celestial
    local targetPart = celestialZone:IsA("BasePart") and celestialZone or celestialZone:FindFirstChildOfClass("BasePart")
    
    if targetPart then
        -- Memindahkan karakter langsung ke area Celestial
        humanoidRootPart.CFrame = targetPart.CFrame * CFrame.new(0, 5, 0)
        print("Berhasil masuk ke Zona Celestial!")
    else
        warn("Part dari objek Celestial tidak ditemukan!")
    end
else
    warn("Objek bernama 'Celestial' tidak ditemukan di Workspace!")
end
