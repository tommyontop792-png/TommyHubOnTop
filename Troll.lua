-- =====================================================
--              ZEROX HUB ULTIMATE (DELTA OPTIMIZED)
-- =====================================================

--[[
    ╔══════════════════════════════════════════════════════════════════════╗
    ║                    🔥 ZEROX HUB ULTIMATE 🔥                          ║
    ║                         Optimizado para Delta                        ║
    ║                                                                      ║
    ║    Funciones:                                                        ║
    ║    ✓ Auto Bounty (PVP Automático)                                   ║
    ║    ✓ Fast Attack / Fruit Attack                                     ║
    ║    ✓ Insta Teleport                                                 ║
    ║    ✓ Server Hop                                                     ║
    ║    ✓ ESP (Jugadores, NPCs)                                          ║
    ║    ✓ Hitbox Expander                                                ║
    ║    ✓ Anti Seat + Auto V4                                            ║
    ║    ✓ Interfaz Rayfield Moderna                                      ║
    ║                                                                      ║
    ╚══════════════════════════════════════════════════════════════════════╝
--]]

-- =====================================================
--              CONFIGURACIÓN DEL USUARIO
-- =====================================================

local CONFIG = {
    Team = "Pirates",
    Fruit = "T-Rex",
    MinPlayerLevel = 2300,
    AttackRate = 0.08,
    NoTargetHopTime = 10,
    PredictionTime = 0.25,
    YOffset = 1,
    LowHealthThreshold = 5000,
    SafeHealthThreshold = 9000,
    EscapeHeight = 273861,
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

local lp = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

-- Estado del script
local State = {
    active = false,
    currentTarget = nil,
    kills = 0,
    sessionEarned = 0,
    startBounty = 0,
    lastHitTime = os.clock(),
    noTargetSince = nil,
    escapeActive = false,
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
            end
        end
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
        while State.active do
            task.wait(CONFIG.AttackRate)
            
            if State.escapeActive then goto continue end
            if not State.currentTarget then goto continue end
            
            local target = State.currentTarget
            if not target.Parent or not target.Character then goto continue end
            
            local targetHum = target.Character:FindFirstChild("Humanoid")
            if not targetHum or targetHum.Health <= 0 then goto continue end
            
            -- Fast Attack
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
            
            -- Fruit Attack
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP and myHRP and (targetHRP.Position - myHRP.Position).Magnitude <= 250 then
                FruitAttack(target)
            end
            
            ::continue::
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
                goto continue
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
            
            ::continue::
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
    end
end)

SetupKillDetection()

-- =====================================================
--              ESP
-- =====================================================

local espEnabled = false
local espObjects = {}

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
    
    table.insert(espObjects, bg)
    return bg
end

local function clearESP()
    for _, obj in pairs(espObjects) do
        pcall(function() obj:Destroy() end)
    end
    espObjects = {}
end

local function updateESP()
    clearESP()
    if not espEnabled then return end
    
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
        if espEnabled then updateESP() end
    end
end)

-- =====================================================
--              HITBOX EXPANDER
-- =====================================================

local hitboxEnabled = false
local originalGetWeaponData
local CombatUtil

pcall(function()
    CombatUtil = require(ReplicatedStorage.Modules.CombatUtil)
    originalGetWeaponData = CombatUtil.GetWeaponData
    if originalGetWeaponData then
        hookfunction(CombatUtil.GetWeaponData, newcclosure(function(self, name, ...)
            local data = originalGetWeaponData(self, name, ...)
            if hitboxEnabled and type(data) == "table" then
                return setmetatable({}, {
                    __index = function(_, k)
                        return k == "HitboxMagnitude" and 2048 or data[k]
                    end
                })
            end
            return data
        end))
    end
end)

-- =====================================================
--              INTERFAZ RAYFIELD
-- =====================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 ZEROX HUB ULTIMATE",
    LoadingTitle = "Cargando ZeroX Hub...",
    LoadingSubtitle = "Delta Optimized",
    ConfigurationSaving = {Enabled = false},
    KeySystem = false,
})

local MainTab = Window:CreateTab("⚔️ Auto Bounty", 4483362458)
local CombatTab = Window:CreateTab("💀 Combate", 4483362458)
local TeleportTab = Window:CreateTab("📍 Teletransportes", 4483362458)
local VisualTab = Window:CreateTab("👁️ Visuales", 4483362458)

-- ⚔️ TAB AUTO BOUNTY
MainTab:CreateSection("⚙️ Configuración")

MainTab:CreateToggle({
    Name = "🔥 AUTO BOUNTY (PVP)",
    CurrentValue = false,
    Callback = function(v)
        if v then
            StartAutoBounty()
        else
            StopAutoBounty()
        end
    end,
})

MainTab:CreateLabel("📊 Estadísticas")

local killsLabel = MainTab:CreateLabel("Kills: 0")
local bountyLabel = MainTab:CreateLabel("Bounty ganado: +0")
local targetLabel = MainTab:CreateLabel("Target: ninguno")
local statusLabel = MainTab:CreateLabel("Estado: inactivo")

task.spawn(function()
    while true do
        task.wait(0.5)
        killsLabel:Set("Kills: " .. State.kills)
        bountyLabel:Set("Bounty ganado: +" .. State.sessionEarned)
        
        if State.active then
            if State.currentTarget then
                targetLabel:Set("Target: " .. State.currentTarget.Name)
                local tHum = State.currentTarget.Character and State.currentTarget.Character:FindFirstChild("Humanoid")
                if tHum then
                    statusLabel:Set("Estado: peleando | HP: " .. math.floor(tHum.Health))
                else
                    statusLabel:Set("Estado: buscando...")
                end
            else
                targetLabel:Set("Target: buscando...")
                local waitTime = State.noTargetSince and math.floor(CONFIG.NoTargetHopTime - (os.clock() - State.noTargetSince)) or CONFIG.NoTargetHopTime
                statusLabel:Set("Hop en: " .. math.max(0, waitTime) .. "s")
            end
        else
            targetLabel:Set("Target: ninguno")
            statusLabel:Set("Estado: inactivo")
        end
    end
end)

MainTab:CreateSection("⚙️ Ajustes")

MainTab:CreateSlider({
    Name = "Nivel mínimo de objetivo",
    Range = {100, 2600},
    Increment = 50,
    CurrentValue = CONFIG.MinPlayerLevel,
    Callback = function(v) CONFIG.MinPlayerLevel = v end,
})

MainTab:CreateSlider({
    Name = "Tiempo sin target para Hop (s)",
    Range = {5, 30},
    Increment = 1,
    CurrentValue = CONFIG.NoTargetHopTime,
    Callback = function(v) CONFIG.NoTargetHopTime = v end,
})

-- 💀 TAB COMBATE
CombatTab:CreateSection("🍎 Fruit Attack")

CombatTab:CreateDropdown({
    Name = "Seleccionar Fruta",
    Options = {"T-Rex", "Kitsune", "Dragon", "Empyrean"},
    CurrentOption = CONFIG.Fruit,
    Callback = function(v) CONFIG.Fruit = v end,
})

CombatTab:CreateSlider({
    Name = "Velocidad de ataque (s)",
    Range = {0.03, 0.5},
    Increment = 0.01,
    CurrentValue = CONFIG.AttackRate,
    Callback = function(v) CONFIG.AttackRate = v end,
})

CombatTab:CreateSection("⚔️ Hitbox")

CombatTab:CreateToggle({
    Name = "Hitbox Expander (2048)",
    CurrentValue = false,
    Callback = function(v) hitboxEnabled = v end,
})

CombatTab:CreateSection("🛡️ Salud")

CombatTab:CreateSlider({
    Name = "Salud para escapar",
    Range = {1000, 10000},
    Increment = 100,
    CurrentValue = CONFIG.LowHealthThreshold,
    Callback = function(v) CONFIG.LowHealthThreshold = v end,
})

-- 📍 TAB TELEPORTES
TeleportTab:CreateSection("🌊 Mar 2")

TeleportTab:CreateButton({
    Name = "🚢 Barco Maldito",
    Callback = function()
        if lp.Character then lp.Character:PivotTo(CFrame.new(923, 126, 32853)) end
    end,
})

TeleportTab:CreateButton({
    Name = "🧊 Ice Castle",
    Callback = function()
        if lp.Character then lp.Character:PivotTo(CFrame.new(6148, 294, -6741)) end
    end,
})

TeleportTab:CreateSection("🏰 Mar 3")

TeleportTab:CreateButton({
    Name = "🏰 Castillo (Sea 3)",
    Callback = function()
        if lp.Character then lp.Character:PivotTo(CFrame.new(-5085, 315, -3150)) end
    end,
})

TeleportTab:CreateButton({
    Name = "🏛️ Mansión",
    Callback = function()
        if lp.Character then lp.Character:PivotTo(CFrame.new(-12463, 375, -7523)) end
    end,
})

TeleportTab:CreateButton({
    Name = "🌀 Portal Raid",
    Callback = function()
        if lp.Character then lp.Character:PivotTo(CFrame.new(-5017, 315, -2823)) end
    end,
})

TeleportTab:CreateSection("✨ Varios")

TeleportTab:CreateButton({
    Name = "🪦 Volar al cielo (B)",
    Callback = function()
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local flag = hrp:FindFirstChild("UpLoop")
            if flag then flag:Destroy() else
                flag = Instance.new("BoolValue", hrp)
                flag.Name = "UpLoop"
                task.spawn(function()
                    while flag.Parent do
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, 273861, 0)
                        task.wait(0.05)
                    end
                end)
            end
        end
    end,
})

-- 👁️ TAB VISUALES
VisualTab:CreateSection("ESP")

VisualTab:CreateToggle({
    Name = "👤 ESP Jugadores",
    CurrentValue = false,
    Callback = function(v) espEnabled = v; updateESP() end,
})

VisualTab:CreateSection("Misc")

VisualTab:CreateButton({
    Name = "Eliminar TouchInterest (reduce lag)",
    Callback = function()
        for _, descendant in pairs(game:GetDescendants()) do
            if descendant:IsA("TouchTransmitter") then descendant:Destroy() end
        end
    end,
})

-- =====================================================
--              NOTIFICACIÓN INICIAL
-- =====================================================

print("✅ ZeroX Hub Ultimate cargado correctamente (Delta Optimized)")
print("🔥 By itz_kitsune0588")
print("🎯 Activa Auto Bounty en la pestaña principal")

Rayfield:Notify({
    Title = "ZeroX Hub Ultimate",
    Content = "Script cargado correctamente | Delta Optimized",
    Duration = 3,
})
