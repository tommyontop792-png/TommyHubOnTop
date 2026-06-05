-- =====================================================
--              CONFIGURACIÓN DEL USUARIO
-- =====================================================

local CONFIG = {
    -- Configuración de equipo
    Team = "Pirates",  -- "Pirates" o "Marines"
    
    -- Configuración de fruta (para Fruit Attack)
    Fruit = "T-Rex",   -- "T-Rex", "Kitsune", "Dragon", "Empyrean"
    
    -- Configuración de PVP
    MinPlayerLevel = 2300,
    AttackRate = 0.08,      -- Velocidad de ataque (segundos)
    NoTargetHopTime = 10,   -- Segundos sin target antes de hacer hop
    PredictionTime = 0.25,  -- Predicción de movimiento
    YOffset = 1,            -- Altura de teleport
    
    -- Configuración de salud
    LowHealthThreshold = 5000,
    SafeHealthThreshold = 9000,
    EscapeHeight = 273861,  -- Altura para escapar
    
    -- Configuración de ataque
    FastAttackRange = 12000,
    HitboxSize = 30,
}

-- =====================================================
--              SERVICIOS Y VARIABLES GLOBALES
-- =====================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local lp = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

-- Estado del script
local State = {
    active = false,           -- Auto Bounty activado
    currentTarget = nil,
    kills = 0,
    sessionEarned = 0,
    startBounty = 0,
    lastHitTime = os.clock(),
    noTargetSince = nil,
    escapeActive = false,
}

-- Estado de visuales
local ESPState = {
    enabled = false,
    objects = {}
}

local HitboxState = {
    enabled = false
}

-- Conexiones
local Connections = {
    instaTp = nil,
    attack = nil,
    equip = nil,
    watcher = nil,
    backup = nil,
}

-- Server Hop
local _isHopping = false
local _lastHopTime = 0
local HOP_COOLDOWN = 8
local _place = game.PlaceId
local _id = game.JobId

-- =====================================================
--              GUI SIMPLE (PC/MÓVIL)
-- =====================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZeroXHubGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Verificar si CoreGui está disponible
local guiParent = (syn and syn.protect_gui) and CoreGui or (gethui and gethui()) or (Cloneref and Cloneref(CoreGui)) or CoreGui
pcall(function() screenGui.Parent = guiParent end)

-- Crear GUI
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSize = 0
mainFrame.Parent = screenGui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🔥 ZEROX HUB ULTIMATE"
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextSize = 18
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Botón toggle para Auto Bounty
local autoBountyBtn = Instance.new("TextButton")
autoBountyBtn.Size = UDim2.new(0, 200, 0, 45)
autoBountyBtn.Position = UDim2.new(0.5, -100, 0, 50)
autoBountyBtn.Text = "🔴 AUTO BOUNTY: OFF"
autoBountyBtn.TextColor3 = Color3.new(1, 1, 1)
autoBountyBtn.TextSize = 14
autoBountyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
autoBountyBtn.BorderSize = 0
autoBountyBtn.Font = Enum.Font.GothamBold
autoBountyBtn.Parent = mainFrame

-- Labels de stats
local killsLabel = Instance.new("TextLabel")
killsLabel.Size = UDim2.new(1, -20, 0, 25)
killsLabel.Position = UDim2.new(0, 10, 0, 110)
killsLabel.Text = "💀 Kills: 0"
killsLabel.TextColor3 = Color3.new(1, 1, 1)
killsLabel.TextSize = 12
killsLabel.BackgroundTransparency = 1
killsLabel.TextXAlignment = Enum.TextXAlignment.Left
killsLabel.Font = Enum.Font.Gotham
killsLabel.Parent = mainFrame

local bountyLabel = Instance.new("TextLabel")
bountyLabel.Size = UDim2.new(1, -20, 0, 25)
bountyLabel.Position = UDim2.new(0, 10, 0, 135)
bountyLabel.Text = "💰 Bounty ganado: +0"
bountyLabel.TextColor3 = Color3.new(1, 1, 1)
bountyLabel.TextSize = 12
bountyLabel.BackgroundTransparency = 1
bountyLabel.TextXAlignment = Enum.TextXAlignment.Left
bountyLabel.Font = Enum.Font.Gotham
bountyLabel.Parent = mainFrame

local targetLabel = Instance.new("TextLabel")
targetLabel.Size = UDim2.new(1, -20, 0, 25)
targetLabel.Position = UDim2.new(0, 10, 0, 160)
targetLabel.Text = "🎯 Target: ninguno"
targetLabel.TextColor3 = Color3.new(1, 1, 1)
targetLabel.TextSize = 12
targetLabel.BackgroundTransparency = 1
targetLabel.TextXAlignment = Enum.TextXAlignment.Left
targetLabel.Font = Enum.Font.Gotham
targetLabel.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 185)
statusLabel.Text = "📡 Estado: inactivo"
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.TextSize = 12
statusLabel.BackgroundTransparency = 1
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Separador
local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0, 220)
line.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
line.BorderSize = 0
line.Parent = mainFrame

-- Botones de fruta
local fruitLabel = Instance.new("TextLabel")
fruitLabel.Size = UDim2.new(0.9, 0, 0, 20)
fruitLabel.Position = UDim2.new(0.05, 0, 0, 235)
fruitLabel.Text = "🍎 Fruta equipada: " .. CONFIG.Fruit
fruitLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
fruitLabel.TextSize = 12
fruitLabel.BackgroundTransparency = 1
fruitLabel.TextXAlignment = Enum.TextXAlignment.Left
fruitLabel.Font = Enum.Font.GothamBold
fruitLabel.Parent = mainFrame

local fruits = {"T-Rex", "Kitsune", "Dragon", "Empyrean"}
local fruitIndex = 1
for i, f in ipairs(fruits) do
    if f == CONFIG.Fruit then fruitIndex = i break end
end

local prevFruitBtn = Instance.new("TextButton")
prevFruitBtn.Size = UDim2.new(0, 40, 0, 25)
prevFruitBtn.Position = UDim2.new(0.1, 0, 0, 260)
prevFruitBtn.Text = "<"
prevFruitBtn.TextColor3 = Color3.new(1, 1, 1)
prevFruitBtn.TextSize = 16
prevFruitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
prevFruitBtn.BorderSize = 0
prevFruitBtn.Font = Enum.Font.GothamBold
prevFruitBtn.Parent = mainFrame

local nextFruitBtn = Instance.new("TextButton")
nextFruitBtn.Size = UDim2.new(0, 40, 0, 25)
nextFruitBtn.Position = UDim2.new(0.7, 0, 0, 260)
nextFruitBtn.Text = ">"
nextFruitBtn.TextColor3 = Color3.new(1, 1, 1)
nextFruitBtn.TextSize = 16
nextFruitBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
nextFruitBtn.BorderSize = 0
nextFruitBtn.Font = Enum.Font.GothamBold
nextFruitBtn.Parent = mainFrame

local currentFruitLabel = Instance.new("TextLabel")
currentFruitLabel.Size = UDim2.new(0, 100, 0, 25)
currentFruitLabel.Position = UDim2.new(0.5, -50, 0, 260)
currentFruitLabel.Text = CONFIG.Fruit
currentFruitLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
currentFruitLabel.TextSize = 13
currentFruitLabel.BackgroundTransparency = 1
currentFruitLabel.Font = Enum.Font.GothamBold
currentFruitLabel.Parent = mainFrame

-- Botón ESP
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0, 130, 0, 35)
espBtn.Position = UDim2.new(0.05, 0, 0, 300)
espBtn.Text = "👁️ ESP: OFF"
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.TextSize = 12
espBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
espBtn.BorderSize = 0
espBtn.Font = Enum.Font.GothamBold
espBtn.Parent = mainFrame

-- Botón Hitbox
local hitboxBtn = Instance.new("TextButton")
hitboxBtn.Size = UDim2.new(0, 130, 0, 35)
hitboxBtn.Position = UDim2.new(0.52, 0, 0, 300)
hitboxBtn.Text = "⚔️ HITBOX: OFF"
hitboxBtn.TextColor3 = Color3.new(1, 1, 1)
hitboxBtn.TextSize = 12
hitboxBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
hitboxBtn.BorderSize = 0
hitboxBtn.Font = Enum.Font.GothamBold
hitboxBtn.Parent = mainFrame

-- Slider de velocidad (simulado con botones)
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.9, 0, 0, 20)
speedLabel.Position = UDim2.new(0.05, 0, 0, 350)
speedLabel.Text = "⚡ Velocidad ataque: " .. string.format("%.2f", CONFIG.AttackRate) .. "s"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.TextSize = 11
speedLabel.BackgroundTransparency = 1
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = mainFrame

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 35, 0, 25)
speedMinus.Position = UDim2.new(0.7, 0, 0, 370)
speedMinus.Text = "-"
speedMinus.TextColor3 = Color3.new(1, 1, 1)
speedMinus.TextSize = 16
speedMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedMinus.BorderSize = 0
speedMinus.Font = Enum.Font.GothamBold
speedMinus.Parent = mainFrame

local speedPlus = Instance.new("TextButton")
speedPlus.Size = UDim2.new(0, 35, 0, 25)
speedPlus.Position = UDim2.new(0.8, 0, 0, 370)
speedPlus.Text = "+"
speedPlus.TextColor3 = Color3.new(1, 1, 1)
speedPlus.TextSize = 16
speedPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedPlus.BorderSize = 0
speedPlus.Font = Enum.Font.GothamBold
speedPlus.Parent = mainFrame

-- Botones de teleport (fila 1)
local teleportSection = Instance.new("TextLabel")
teleportSection.Size = UDim2.new(0.9, 0, 0, 20)
teleportSection.Position = UDim2.new(0.05, 0, 0, 410)
teleportSection.Text = "📍 TELEPORTES RÁPIDOS"
teleportSection.TextColor3 = Color3.fromRGB(100, 150, 255)
teleportSection.TextSize = 11
teleportSection.BackgroundTransparency = 1
teleportSection.TextXAlignment = Enum.TextXAlignment.Left
teleportSection.Font = Enum.Font.GothamBold
teleportSection.Parent = mainFrame

local teleports = {
    {name = "🏴 Barco Maldito", pos = CFrame.new(923, 126, 32853)},
    {name = "🧊 Ice Castle", pos = CFrame.new(6148, 294, -6741)},
    {name = "🏰 Castillo S3", pos = CFrame.new(-5085, 315, -3150)},
    {name = "🏛️ Mansión", pos = CFrame.new(-12463, 375, -7523)},
    {name = "🌀 Portal Raid", pos = CFrame.new(-5017, 315, -2823)},
}

for i, tp in ipairs(teleports) do
    local btn = Instance.new("TextButton")
    local row = math.floor((i-1)/2)
    local col = (i-1)%2
    btn.Size = UDim2.new(0, 130, 0, 28)
    btn.Position = UDim2.new(0.05 + (col * 0.47), 0, 0, 435 + (row * 32))
    btn.Text = tp.name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 10
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    btn.BorderSize = 0
    btn.Font = Enum.Font.Gotham
    btn.Parent = mainFrame
    
    btn.MouseButton1Click:Connect(function()
        if lp.Character then
            lp.Character:PivotTo(tp.pos)
        end
    end)
    btn.TouchTap:Connect(function()
        if lp.Character then
            lp.Character:PivotTo(tp.pos)
        end
    end)
end

-- Botón para mover la GUI (arrastrable)
local dragBar = Instance.new("TextButton")
dragBar.Size = UDim2.new(1, 0, 0, 25)
dragBar.Position = UDim2.new(0, 0, 0, 0)
dragBar.Text = "⋮⋮  ZEROX HUB  ⋮⋮"
dragBar.TextColor3 = Color3.fromRGB(255, 255, 255)
dragBar.TextSize = 12
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
dragBar.BackgroundTransparency = 0.3
dragBar.BorderSize = 0
dragBar.Font = Enum.Font.GothamBold
dragBar.Parent = mainFrame

-- Sistema de arrastre
local dragging = false
local dragInput, dragStart, startPos

dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

dragBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- =====================================================
--              FUNCIONES DE LA GUI
-- =====================================================

-- Actualizar labels de stats
task.spawn(function()
    while true do
        task.wait(0.3)
        killsLabel.Text = "💀 Kills: " .. State.kills
        bountyLabel.Text = "💰 Bounty ganado: +" .. State.sessionEarned
        
        if State.active then
            if State.currentTarget then
                targetLabel.Text = "🎯 Target: " .. State.currentTarget.Name
                local tHum = State.currentTarget.Character and State.currentTarget.Character:FindFirstChild("Humanoid")
                if tHum then
                    statusLabel.Text = "⚔️ Estado: peleando | HP: " .. math.floor(tHum.Health)
                else
                    statusLabel.Text = "⚔️ Estado: buscando..."
                end
            else
                targetLabel.Text = "🎯 Target: buscando..."
                local waitTime = State.noTargetSince and math.floor(CONFIG.NoTargetHopTime - (os.clock() - State.noTargetSince)) or CONFIG.NoTargetHopTime
                statusLabel.Text = "⏳ Hop en: " .. math.max(0, waitTime) .. "s"
            end
        else
            targetLabel.Text = "🎯 Target: ninguno"
            statusLabel.Text = "⭕ Estado: inactivo"
        end
    end
end)

-- Auto Bounty toggle
autoBountyBtn.MouseButton1Click:Connect(function()
    if State.active then
        StopAutoBounty()
        autoBountyBtn.Text = "🔴 AUTO BOUNTY: OFF"
        autoBountyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    else
        StartAutoBounty()
        autoBountyBtn.Text = "🟢 AUTO BOUNTY: ON"
        autoBountyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end
end)
autoBountyBtn.TouchTap:Connect(function()
    if State.active then
        StopAutoBounty()
        autoBountyBtn.Text = "🔴 AUTO BOUNTY: OFF"
        autoBountyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    else
        StartAutoBounty()
        autoBountyBtn.Text = "🟢 AUTO BOUNTY: ON"
        autoBountyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end
end)

-- Cambio de fruta
local function updateFruitDisplay()
    CONFIG.Fruit = fruits[fruitIndex]
    currentFruitLabel.Text = CONFIG.Fruit
    fruitLabel.Text = "🍎 Fruta equipada: " .. CONFIG.Fruit
end

prevFruitBtn.MouseButton1Click:Connect(function()
    fruitIndex = fruitIndex - 1
    if fruitIndex < 1 then fruitIndex = #fruits end
    updateFruitDisplay()
end)
prevFruitBtn.TouchTap:Connect(function()
    fruitIndex = fruitIndex - 1
    if fruitIndex < 1 then fruitIndex = #fruits end
    updateFruitDisplay()
end)

nextFruitBtn.MouseButton1Click:Connect(function()
    fruitIndex = fruitIndex + 1
    if fruitIndex > #fruits then fruitIndex = 1 end
    updateFruitDisplay()
end)
nextFruitBtn.TouchTap:Connect(function()
    fruitIndex = fruitIndex + 1
    if fruitIndex > #fruits then fruitIndex = 1 end
    updateFruitDisplay()
end)

-- ESP Toggle
espBtn.MouseButton1Click:Connect(function()
    ESPState.enabled = not ESPState.enabled
    espBtn.Text = ESPState.enabled and "👁️ ESP: ON" or "👁️ ESP: OFF"
    espBtn.BackgroundColor3 = ESPState.enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(70, 70, 90)
    if ESPState.enabled then
        updateESP()
    else
        clearESP()
    end
end)
espBtn.TouchTap:Connect(function()
    ESPState.enabled = not ESPState.enabled
    espBtn.Text = ESPState.enabled and "👁️ ESP: ON" or "👁️ ESP: OFF"
    espBtn.BackgroundColor3 = ESPState.enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(70, 70, 90)
    if ESPState.enabled then
        updateESP()
    else
        clearESP()
    end
end)

-- Hitbox Toggle
hitboxBtn.MouseButton1Click:Connect(function()
    HitboxState.enabled = not HitboxState.enabled
    hitboxBtn.Text = HitboxState.enabled and "⚔️ HITBOX: ON" or "⚔️ HITBOX: OFF"
    hitboxBtn.BackgroundColor3 = HitboxState.enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(70, 70, 90)
end)
hitboxBtn.TouchTap:Connect(function()
    HitboxState.enabled = not HitboxState.enabled
    hitboxBtn.Text = HitboxState.enabled and "⚔️ HITBOX: ON" or "⚔️ HITBOX: OFF"
    hitboxBtn.BackgroundColor3 = HitboxState.enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(70, 70, 90)
end)

-- Velocidad de ataque
speedMinus.MouseButton1Click:Connect(function()
    CONFIG.AttackRate = math.max(0.03, CONFIG.AttackRate - 0.01)
    speedLabel.Text = "⚡ Velocidad ataque: " .. string.format("%.2f", CONFIG.AttackRate) .. "s"
end)
speedMinus.TouchTap:Connect(function()
    CONFIG.AttackRate = math.max(0.03, CONFIG.AttackRate - 0.01)
    speedLabel.Text = "⚡ Velocidad ataque: " .. string.format("%.2f", CONFIG.AttackRate) .. "s"
end)

speedPlus.MouseButton1Click:Connect(function()
    CONFIG.AttackRate = math.min(0.5, CONFIG.AttackRate + 0.01)
    speedLabel.Text = "⚡ Velocidad ataque: " .. string.format("%.2f", CONFIG.AttackRate) .. "s"
end)
speedPlus.TouchTap:Connect(function()
    CONFIG.AttackRate = math.min(0.5, CONFIG.AttackRate + 0.01)
    speedLabel.Text = "⚡ Velocidad ataque: " .. string.format("%.2f", CONFIG.AttackRate) .. "s"
end)

-- =====================================================
--              UTILIDADES
-- =====================================================

local function GetBounty()
    local leaderstats = lp:FindFirstChild("leaderstats")
    if leaderstats then
        local bounty = leaderstats:FindFirstChild("Bounty/Honor")
        if bounty then return tonumber(bounty.Value) or 0 end
    end
    return 0
end

local function GetPlayerLevel(p)
    local data = p:FindFirstChild("Data")
    if data then
        local level = data:FindFirstChild("Level")
        if level then return tonumber(level.Value) or 0 end
    end
    return 0
end

local function IsPlayerInSafeZone(p)
    if not p.Character then return false end
    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local safeZones = workspace:FindFirstChild("_WorldOrigin")
    if safeZones then safeZones = safeZones:FindFirstChild("SafeZones") end
    if not safeZones then return false end
    
    for _, zone in pairs(safeZones:GetChildren()) do
        local mesh = zone:FindFirstChild("Mesh")
        if mesh and mesh:IsA("SpecialMesh") then
            local radius = zone.Size.X * mesh.Scale.X / 2
            if (zone.Position - hrp.Position).Magnitude <= radius then
                return true
            end
        end
    end
    return false
end

local function IsPlayerValid(p)
    if p == lp or not p.Character then return false end
    local hum = p.Character:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if p:GetAttribute("pvpDisabled") == true then return false end
    if GetPlayerLevel(p) < CONFIG.MinPlayerLevel then return false end
    if IsPlayerInSafeZone(p) then return false end
    return true
end

local function IsHealthLow()
    local char = lp.Character
    if not char then return false end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return false end
    return hum.Health <= CONFIG.LowHealthThreshold
end

-- =====================================================
--              FUNCIONES DE HABILIDADES
-- =====================================================

local function BusoKen()
    pcall(function()
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if Remotes then
            local CommE = Remotes:FindFirstChild("CommE")
            local CommF = Remotes:FindFirstChild("CommF_")
            if CommE then CommE:FireServer("Ken", true) end
            if CommF and lp.Character and not lp.Character:FindFirstChild("HasBuso") then
                CommF:InvokeServer("Buso")
            end
        end
    end)
end

local function PvpEnable()
    pcall(function()
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if Remotes then
            local CommF = Remotes:FindFirstChild("CommF_")
            if CommF then CommF:InvokeServer("EnablePvp") end
        end
    end)
end

local function V4Awakening()
    pcall(function()
        local bp = lp:FindFirstChild("Backpack")
        if bp then
            local awakening = bp:FindFirstChild("Awakening")
            if awakening then
                local remote = awakening:FindFirstChild("RemoteFunction")
                if remote then remote:InvokeServer(true) end
            end
        end
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.T, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.T, false, game)
    end)
end

local function AntiMover()
    local char = lp.Character
    if char and not char:FindFirstChild("AntiMover") then
        Instance.new("Folder", char).Name = "AntiMover"
    end
end

-- =====================================================
--              SERVER HOP
-- =====================================================

local function Hop()
    if _isHopping or os.clock() - _lastHopTime < HOP_COOLDOWN then return false end
    _isHopping = true
    _lastHopTime = os.clock()
    
    task.delay(12, function() _isHopping = false end)
    
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local CommF_ = Remotes and Remotes:FindFirstChild("CommF_")
    
    if CommF_ then
        local ok, result = pcall(function()
            return CommF_:InvokeServer("TeleportToRandomServer")
        end)
        if ok then
            _isHopping = false
            return true
        end
    end
    
    pcall(function()
        TeleportService:TeleportToPlaceInstance(_place, _id, lp)
    end)
    
    _isHopping = false
    return true
end

-- =====================================================
--              FRUIT ATTACK
-- =====================================================

local FruitConfigs = {
    ["T-Rex"] = {ToolName = "T-Rex-T-Rex", RemoteName = "LeftClickRemote", Args = function(d) return {Vector3.new(d.X, d.Y, d.Z), 1} end},
    ["Kitsune"] = {ToolName = "Kitsune-Kitsune", RemoteName = "LeftClickRemote", Args = function(d) return {Vector3.new(d.X, d.Y, d.Z), 1} end},
    ["Dragon"] = {ToolName = "Dragon-Dragon", RemoteName = "LeftClickRemote", Args = function(d) return {Vector3.new(d.X, d.Y, d.Z), 1} end},
    ["Empyrean"] = {ToolName = "Empyrean (Kitsune)-Empyrean (Kitsune)", RemoteName = "LeftClickRemote", Args = function(d) return {Vector3.new(d.X, d.Y, d.Z), 1} end},
}

local function EquipFruit()
    local config = FruitConfigs[CONFIG.Fruit]
    if not config then return false end
    
    local char = lp.Character
    if not char then return false end
    
    if char:FindFirstChild(config.ToolName) then return true end
    
    local tool = lp.Backpack:FindFirstChild(config.ToolName)
    if tool and char:FindFirstChild("Humanoid") then
        char.Humanoid:EquipTool(tool)
        task.wait(0.1)
        return true
    end
    return false
end

local function FruitAttack(target)
    if not target or not target.Character then return end
    
    local config = FruitConfigs[CONFIG.Fruit]
    if not config then return end
    
    local myChar = lp.Character
    if not myChar then return end
    
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    
    if not myHRP or not targetHRP then return end
    
    local tool = myChar:FindFirstChild(config.ToolName)
    if not tool then
        EquipFruit()
        tool = myChar:FindFirstChild(config.ToolName)
        if not tool then return end
    end
    
    local remote = tool:FindFirstChild(config.RemoteName)
    if not remote then return end
    
    local direction = (targetHRP.Position - myHRP.Position).Unit
    pcall(function()
        remote:FireServer(unpack(config.Args(direction)))
    end)
end

-- =====================================================
--              FAST ATTACK (NET)
-- =====================================================

local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local RegisterHit = Net["RE/RegisterHit"]
local RegisterAttack = Net["RE/RegisterAttack"]

local function FastAttackTargets(targets)
    if not targets or #targets == 0 then return end
    
    local hitTargets = {}
    for _, char in pairs(targets) do
        local head = char:FindFirstChild("Head")
        if head then table.insert(hitTargets, {char, head}) end
    end
    
    if #hitTargets == 0 then return end
    
    pcall(function()
        RegisterAttack:FireServer(0.1)
        RegisterHit:FireServer(hitTargets[1][2], hitTargets)
    end)
end

-- =====================================================
--              INSTA TELEPORT
-- =====================================================

local function StartInstaTeleport()
    if Connections.instaTp then Connections.instaTp:Disconnect() end
    
    Connections.instaTp = RunService.Stepped:Connect(function()
        if State.escapeActive or not State.currentTarget then return end
        
        pcall(function()
            local myChar = lp.Character
            if not myChar then return end
            
            local target = State.currentTarget
            if not target.Parent or not target.Character then return end
            
            local myHRP = myChar:FindFirstChild("HumanoidRootPart")
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            
            if myHRP and targetHRP then
                local predictedPos = targetHRP.Position + (targetHRP.AssemblyLinearVelocity * CONFIG.PredictionTime)
                myHRP.CFrame = CFrame.new(predictedPos) * CFrame.new(0, CONFIG.YOffset, 0)
            end
        end)
    end)
end

-- =====================================================
--              HEALTH ESCAPE
-- =====================================================

local function StartEscape()
    if State.escapeActive then return end
    State.escapeActive = true
    
    if Connections.instaTp then
        Connections.instaTp:Disconnect()
        Connections.instaTp = nil
    end
    
    local wasAttacking = State.active
    local previousTarget = State.currentTarget
    
    State.active = false
    State.currentTarget = nil
    
    task.spawn(function()
        while State.escapeActive do
            pcall(function()
                local char = lp.Character
                if char then
                    char:PivotTo(CFrame.new(
                        char:GetPivot().Position.X,
                        char:GetPivot().Position.Y + CONFIG.EscapeHeight,
                        char:GetPivot().Position.Z
                    ))
                end
            end)
            task.wait(0.05)
            
            local char = lp.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and hum.Health >= CONFIG.SafeHealthThreshold then
                State.escapeActive = false
            end
        end
        
        StartInstaTeleport()
        
        if wasAttacking then
            State.active = true
            if previousTarget and previousTarget.Parent and previousTarget.Character then
                State.currentTarget = previousTarget
            end        end
    end)
end

-- =====================================================
--              TARGET SELECTION
-- =====================================================

local function GetNextTarget()
    local candidates = {}
    
    for _, p in pairs(Players:GetPlayers()) do
        if IsPlayerValid(p) then
            table.insert(candidates, p)
        end
    end
    
    if #candidates == 0 then return nil end
    
    table.sort(candidates, function(a, b)
        return GetPlayerLevel(a) > GetPlayerLevel(b)
    end)
    
    return candidates[1]
end

local function SelectTarget()
    local newTarget = GetNextTarget()
    
    if newTarget then
        State.currentTarget = newTarget
        State.noTargetSince = nil
        StartInstaTeleport()
        
        if Connections.watcher then task.cancel(Connections.watcher) end
        Connections.watcher = task.spawn(function()
            while State.active and State.currentTarget == newTarget do
                task.wait(0.5)
                if not newTarget.Parent or not newTarget.Character then
                    State.currentTarget = nil
                    State.noTargetSince = os.clock()
                    break
                end
                local hum = newTarget.Character:FindFirstChild("Humanoid")
                if hum and hum.Health <= 0 then
                    State.currentTarget = nil
                    State.noTargetSince = os.clock()
                    break
                end
            end
        end)
    else
        State.currentTarget = nil
        if State.noTargetSince == nil then
            State.noTargetSince = os.clock()
        end
    end
end

-- =====================================================
--              ATAQUE PRINCIPAL
-- =====================================================

local function StartAttackLoop()
    if Connections.attack then task.cancel(Connections.attack) end
    
    if Connections.equip then task.cancel(Connections.equip) end
    Connections.equip = task.spawn(function()
        while State.active do
            task.wait(0.5)
            EquipFruit()
            pcall(BusoKen)
        end
    end)
    
    Connections.attack = task.spawn(function()
        local moveIndex = 1
        while State.active do
            task.wait(CONFIG.AttackRate)
            
            if State.escapeActive then continue end
            if not State.currentTarget then continue end
            
            local target = State.currentTarget
            if not target.Parent or not target.Character then continue end
            
            local targetHum = target.Character:FindFirstChild("Humanoid")
            if not targetHum or targetHum.Health <= 0 then continue end
            
            local enemies = {}
            local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if myHRP then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character then
                        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                        local hum = p.Character:FindFirstChild("Humanoid")
                        if hrp and hum and hum.Health > 0 and (hrp.Position - myHRP.Position).Magnitude <= CONFIG.FastAttackRange then
                            table.insert(enemies, p.Character)
                        end
                    end
                end
            end
            if #enemies > 0 then
                FastAttackTargets(enemies)
            end
            
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP and myHRP and (targetHRP.Position - myHRP.Position).Magnitude <= 250 then
                FruitAttack(target)
            end
            
            moveIndex = moveIndex >= 3 and 1 or moveIndex + 1
        end
    end)
end

-- =====================================================
--              AUTO BOUNTY MAIN LOOP
-- =====================================================

local function StartAutoBounty()
    if State.active then return end
    
    State.active = true
    State.escapeActive = false
    State.startBounty = GetBounty()
    State.kills = 0
    State.sessionEarned = 0
    State.lastHitTime = os.clock()
    State.noTargetSince = nil
    
    SelectTarget()
    StartAttackLoop()
    StartInstaTeleport()
    
    if Connections.backup then task.cancel(Connections.backup) end
    Connections.backup = task.spawn(function()
        while State.active do
            task.wait(1)
            
            if IsHealthLow() and not State.escapeActive then
                StartEscape()
                continue
            end
            
            if not State.currentTarget and not State.escapeActive then
                if State.noTargetSince and (os.clock() - State.noTargetSince) >= CONFIG.NoTargetHopTime then
                    State.noTargetSince = nil
                    task.spawn(Hop)
                    task.wait(5)
                else
                    SelectTarget()
                end
            end
            
            if State.active and not State.escapeActive and Connections.attack == nil then
                StartAttackLoop()
            end
        end
    end)
end

local function StopAutoBounty()
    State.active = false
    State.currentTarget = nil
    State.escapeActive = false
    
    if Connections.instaTp then Connections.instaTp:Disconnect(); Connections.instaTp = nil end
    if Connections.attack then task.cancel(Connections.attack); Connections.attack = nil end
    if Connections.equip then task.cancel(Connections.equip); Connections.equip = nil end
    if Connections.watcher then task.cancel(Connections.watcher); Connections.watcher = nil end
    if Connections.backup then task.cancel(Connections.backup); Connections.backup = nil end
end

-- =====================================================
--              KILL DETECTION
-- =====================================================

local function SetupKillDetection()
    local CommE = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommE")
    if not CommE then return end
    
    CommE.OnClientEvent:Connect(function(event, msg)
        if event ~= "Notify" then return end
        msg = tostring(msg or "")
        if msg:find("Bounty") and msg:find("from") or msg:find("Honor") and msg:find("from") then
            local earned = tonumber(string.match(msg, ">(%d+)")) or 0
            State.kills = State.kills + 1
            State.sessionEarned = State.sessionEarned + earned
            State.lastHitTime = os.clock()
            State.noTargetSince = nil
        end
    end)
end

-- =====================================================
--              DEATH HANDLER
-- =====================================================

local function OnCharacterDeath()
    local wasActive = State.active
    StopAutoBounty()
    
    local newChar = lp.CharacterAdded:Wait()
    newChar:WaitForChild("HumanoidRootPart", 10)
    newChar:WaitForChild("Humanoid", 10)
    
    task.wait(2)
    
    if wasActive then
        StartAutoBounty()
        if autoBountyBtn then
            autoBountyBtn.Text = "🟢 AUTO BOUNTY: ON"
            autoBountyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        end
    end
end

if lp.Character then
    local hum = lp.Character:FindFirstChild("Humanoid")
    if hum then hum.Died:Connect(OnCharacterDeath) end
end
lp.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 10)
    if hum then hum.Died:Connect(OnCharacterDeath) end
end)

-- =====================================================
--              BACKGROUND LOOPS
-- =====================================================

task.spawn(function()
    while true do
        task.wait(5)
        pcall(BusoKen)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        pcall(PvpEnable)
        pcall(V4Awakening)
        pcall(AntiMover)
    end
end)

SetupKillDetection()

-- =====================================================
--              ESP (Krazy Hub)
-- =====================================================

local function createESP(target, text, color)
    local head = target:FindFirstChild("Head") or target:FindFirstChild("HumanoidRootPart")
    if not head then return end
    
    local bg = Instance.new("BillboardGui")
    bg.Name = "ZeroXESP"
    bg.Adornee = head
    bg.Size = UDim2.new(0, 200, 0, 50)
    bg.StudsOffset = Vector3.new(0, 2.5, 0)
    bg.AlwaysOnTop = true
    bg.Parent = head
    
    local label = Instance.new("TextLabel", bg)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    
    table.insert(ESPState.objects, bg)
    return bg
end

local function clearESP()
    for _, obj in pairs(ESPState.objects) do
        pcall(function() obj:Destroy() end)
    end
    ESPState.objects = {}
end

local function updateESP()
    clearESP()
    if not ESPState.enabled then return end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local dist = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and
                (p.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude or 0
            createESP(p.Character, p.Name .. " [" .. math.floor(dist) .. "m]", Color3.fromRGB(255, 80, 80))
        end
    end
    
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, npc in pairs(enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") then
                createESP(npc, npc.Name .. " [NPC]", Color3.fromRGB(0, 200, 255))
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(2)
        if ESPState.enabled then updateESP() end
    end
end)

-- =====================================================
--              HITBOX EXPANDER
-- =====================================================

local originalGetWeaponData
local CombatUtil

pcall(function()
    CombatUtil = require(ReplicatedStorage.Modules.CombatUtil)
    originalGetWeaponData = CombatUtil.GetWeaponData
end)

if originalGetWeaponData then
    hookfunction(CombatUtil.GetWeaponData, newcclosure(function(self, name, ...)
        local data = originalGetWeaponData(self, name, ...)
        if HitboxState.enabled and type(data) == "table" then
            return setmetatable({}, {
                __index = function(_, k)
                    return k == "HitboxMagnitude" and 2048 or data[k]
                end
            })
        end
        return data
    end))
end

-- =====================================================
--              NOTIFICACIÓN INICIAL
-- =====================================================

print("✅ ZeroX Hub Ultimate cargado correctamente")
print("🔥 By itz_kitsune0588")
print("🎯 Activa Auto Bounty en el botón rojo")

-- Notificación en pantalla
local notifFrame = Instance.new("Frame")
notifFrame.Size = UDim2.new(0, 250, 0, 50)
notifFrame.Position = UDim2.new(0.5, -125, 0.8, 0)
notifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
notifFrame.BackgroundTransparency = 0.3
notifFrame.BorderSize = 0
notifFrame.Parent = screenGui

local notifText = Instance.new("TextLabel")
notifText.Size = UDim2.new(1, 0, 1, 0)
notifText.Text = "✅ ZeroX Hub Ultimate cargado!"
notifText.TextColor3 = Color3.fromRGB(100, 255, 100)
notifText.TextSize = 12
notifText.BackgroundTransparency = 1
notifText.Font = Enum.Font.GothamBold
notifText.Parent = notifFrame

task.delay(3, function()
    notifFrame:Destroy()
end)
