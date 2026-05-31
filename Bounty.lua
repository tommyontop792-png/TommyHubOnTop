repeat task.wait() until game:IsLoaded()

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local TeleportService   = game:GetService("TeleportService")
local UIS               = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")
local VIM               = game:GetService("VirtualInputManager")

-- ══════════════════════════════════════════════
--  CONFIGURACIÓN DE CAZA (PVP AGRESIVO)
-- ══════════════════════════════════════════════
local SELECTED_TEAM         = "Pirates"     -- Equipo al que te unirá
local MIN_PLAYER_LEVEL      = 2300          -- Nivel mínimo del rival para dar recompensa
local PREDICTION_TIME       = 0.20          -- Tiempo de predicción de TP (más bajo = más pegado al rival)
local PREDICTION_SAMPLES    = 3
local YOffset               = -2            -- Altura respecto al rival (-2 te pone ligeramente debajo/detrás)
local LOW_HEALTH_THRESHOLD  = 3500          -- Vida para escapar si estás muriendo
local SAFE_HEALTH_THRESHOLD = 8500          -- Vida para regresar al combate tras escapar
local ESCAPE_HEIGHT         = 15000         -- Altura del TP de escape celular
local ATTACK_RATE           = 0.05          -- Velocidad de clics del T-Rex (Muy rápido)
local NO_TARGET_HOP_TIME    = 8             -- Segundos sin jugadores válidos antes de cambiar de server

-- ══════════════════════════════════════════════
--  ESTADO DEL SCRIPT
-- ══════════════════════════════════════════════
local lp          = Players.LocalPlayer
local ShuttingDown  = false

local Conns = {
    instaTp   = nil,
    antiSeat  = nil,
    antiSeat2 = nil,
    attack    = nil,
    watcher   = nil,
}

local CurrentTarget     = nil
local AutoBountyEnabled = false
local FastAttackEnabled = false 
local BackupThread      = nil
local EscapeActive      = false  

local PositionHistory   = {}
local NoTargetSince     = nil  

local SessionStart   = tick()
local InitialBounty  = 0
local TotalKills     = 0

local _place       = game.PlaceId
local _id          = game.JobId
local _isHopping   = false
local _lastHopTime = -999
local HOP_COOLDOWN = 5

-- Declaraciones adelantadas obligatorias en Lua
local PickNextTarget
local StartAttackLoop
local StopAll
local StartFastAttack
local StartInstaTeleport

-- ══════════════════════════════════════════════
--  REMOTES DE BLOX FRUITS
-- ══════════════════════════════════════════════
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 15)
local CommF_  = Remotes and Remotes:WaitForChild("CommF_", 10)
local CommE_  = Remotes and Remotes:WaitForChild("CommE",  10)

-- ══════════════════════════════════════════════
--  DETECTOR DE BAJAS (KILLS)
-- ══════════════════════════════════════════════
local function SetupKillDetection()
    if not CommE_ then return end
    CommE_.OnClientEvent:Connect(function(event, msg)
        if event ~= "Notify" then return end
        msg = tostring(msg or "")
        if (msg:find("Bounty") and msg:find("from")) or (msg:find("Honor") and msg:find("from")) then
            TotalKills = TotalKills + 1
            NoTargetSince = nil  
            if AutoBountyEnabled then
                task.spawn(PickNextTarget)
            end
        end
    end)
end
task.spawn(SetupKillDetection)

-- ══════════════════════════════════════════════
--  SERVER HOP (SISTEMA ANTI-SERVIDORES VACÍOS)
-- ══════════════════════════════════════════════
local function Hop()
    if _isHopping then return false end
    local now = os.clock()
    if now - _lastHopTime < HOP_COOLDOWN then return false end

    _isHopping   = true
    _lastHopTime = now

    task.delay(15, function() _isHopping = false end)
    local browser = ReplicatedStorage:FindFirstChild("__ServerBrowser")

    if browser then
        local allServers = {}
        local ok, result = pcall(function() return browser:InvokeServer(1) end)
        if ok and type(result) == "table" then
            for uuid, info in pairs(result) do
                if type(info) == "table" and info.Count and uuid ~= _id then
                    table.insert(allServers, { uuid = uuid, count = info.Count })
                end
            end
        end

        if #allServers > 0 then
            local valid = {}
            for _, s in pairs(allServers) do
                if s.count >= 4 and s.count <= 11 then
                    table.insert(valid, s)
                end
            end
            if #valid == 0 then valid = allServers end
            table.sort(valid, function(a, b) return a.count > b.count end)
            local chosen = valid[math.random(1, math.min(5, #valid))]

            pcall(function() browser:InvokeServer("teleport", chosen.uuid) end)
        end
    end

    -- Alternativa mediante API HTTP si falla el ServerBrowser interno
    local apiServers = {}
    pcall(function()
        local r = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. _place .. "/servers/Public?sortOrder=Desc&limit=100"))
        if r and r.data then
            for _, sv in ipairs(r.data) do
                if sv.id and sv.id ~= _id and sv.playing and sv.maxPlayers and sv.playing >= 3 and sv.playing < sv.maxPlayers then
                    table.insert(apiServers, sv)
                end
            end
        end
    end)

    if #apiServers > 0 then
        local chosen = apiServers[math.random(1, math.min(5, #apiServers))]
        pcall(function() TeleportService:TeleportToPlaceInstance(_place, chosen.id, lp) end)
    end

    _isHopping   = false
    return false
end

-- ══════════════════════════════════════════════
--  AUTO SELECCIÓN DE EQUIPO
-- ══════════════════════════════════════════════
local function selectFaction(faction)
    pcall(function()
        local activity = nil
        if Remotes then activity = Remotes:FindFirstChild("RE/OnEventServiceActivity") end
        if not activity then
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") and v.Name == "RE/OnEventServiceActivity" then
                    activity = v; break
                end
            end
        end
        if activity then activity:FireServer("TeamSelect/Team/" .. faction) end
        task.wait(0.05)
        if CommF_ then CommF_:InvokeServer("SetTeam", faction) end
    end)
end

task.spawn(function()
    local elapsed = 0
    while elapsed < 20 do
        task.wait(0.5); elapsed = elapsed + 0.5
        selectFaction(SELECTED_TEAM)
        if lp.Team and lp.Team.Name == SELECTED_TEAM then break end
    end
end)

-- ══════════════════════════════════════════════
--  ESPERAR PERSONAJE Y ANTI ASENTARSE
-- ══════════════════════════════════════════════
local char = lp.Character or lp.CharacterAdded:Wait()
char:WaitForChild("HumanoidRootPart", 10)
char:WaitForChild("Humanoid", 10)

local function StartAntiSeat()
    if Conns.antiSeat  then Conns.antiSeat:Disconnect()  end
    if Conns.antiSeat2 then Conns.antiSeat2:Disconnect() end
    local c = lp.Character; if not c then return end
    local h = c:FindFirstChild("Humanoid"); if not h then return end
    Conns.antiSeat = RunService.Heartbeat:Connect(function()
        if h.Sit then h.Sit = false; h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
    Conns.antiSeat2 = h.StateChanged:Connect(function(_, new)
        if new == Enum.HumanoidStateType.Seated then
            h.Sit = false; h:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end
StartAntiSeat()

-- ══════════════════════════════════════════════
--  SISTEMA DE FILTRADO Y VALIDACIÓN DE JUGADORES
-- ══════════════════════════════════════════════
local function GetPlayerLevel(p)
    local d = p:FindFirstChild("Data"); if not d then return 0 end
    local l = d:FindFirstChild("Level"); return l and (tonumber(l.Value) or 0) or 0
end

local function IsPlayerInSafeZone(p)
    if not p.Character then return false end
    local tHRP = p.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return false end
    local inCombat = p.Character:GetAttribute("InCombat")
    if inCombat == "0" or inCombat == "1" then return false end
    local origin = workspace:FindFirstChild("_WorldOrigin"); if not origin then return false end
    local zones  = origin:FindFirstChild("SafeZones");       if not zones  then return false end
    for _, zone in pairs(zones:GetChildren()) do
        local mesh = zone:FindFirstChild("Mesh")
        if mesh and mesh:IsA("SpecialMesh") then
            if (zone.Position - tHRP.Position).Magnitude <= (zone.Size.X * mesh.Scale.X) / 2 then
                return true
            end
        end
    end
    return false
end

local function IsPlayerValid(p)
    if p == lp or not p.Character then return false end
    local h = p.Character:FindFirstChild("Humanoid")
    if not h or h.Health <= 0 then return false end
    
    -- No atacar a aliados si eres Marine
    if lp.Team and p.Team and lp.Team.Name == "Marines" and p.Team == lp.Team then return false end
    
    if p:GetAttribute("pvpDisabled") == true  then return false end
    if p:GetAttribute("IslandRaiding") == true then return false end
    if GetPlayerLevel(p) < MIN_PLAYER_LEVEL    then return false end
    if IsPlayerInSafeZone(p)                   then return false end
    return true
end

local function IsHealthLow()
    local c = lp.Character; if not c then return false end
    local h = c:FindFirstChild("Humanoid"); if not h then return false end
    return h.Health <= LOW_HEALTH_THRESHOLD
end

-- ══════════════════════════════════════════════
--  AUTO MEJORAS DE COMBATE (HAKI, PVP, V4)
-- ══════════════════════════════════════════════
local function BusoKen()
    pcall(function() if CommE_ then CommE_:FireServer("Ken", true) end end)
    pcall(function()
        local c = lp.Character
        if c and not c:FindFirstChild("HasBuso") and CommF_ then CommF_:InvokeServer("Buso") end
    end)
end

local function PvpEnable()
    pcall(function() if CommF_ then CommF_:InvokeServer("EnablePvp") end end)
end

local function antimover()
    local c = lp.Character
    if c and not c:FindFirstChild("AntiMover") then Instance.new("Folder", c).Name = "AntiMover" end
end

local function v4()
    pcall(function()
        local bp = lp:FindFirstChild("Backpack"); if not bp then return end
        local aw = bp:FindFirstChild("Awakening"); if not aw then return end
        local rf = aw:FindFirstChild("RemoteFunction"); if not rf then return end
        rf:InvokeServer(true)
    end)
    pcall(function()
        VIM:SendKeyEvent(true,  Enum.KeyCode.T, false, game)
        task.wait(0.02)
        VIM:SendKeyEvent(false, Enum.KeyCode.T, false, game)
    end)
end

-- ══════════════════════════════════════════════
--  ATAQUE CON T-REX EXCLUSIVO CONTRA JUGADORES
-- ══════════════════════════════════════════════
local TRexName = "T-Rex-T-Rex"

function StartAttackLoop()
    if Conns.attack then task.cancel(Conns.attack); Conns.attack = nil end

    -- Forzar clic inicial para activar hitboxes de Roblox
    pcall(function()
        VIM:SendMouseButtonEvent(0, 0, 0, true,  game, 1)
        task.wait(0.02)
        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)

    -- Auto-Equipador de la Fruta T-Rex
    local equipConn = task.spawn(function()
        while AutoBountyEnabled do
            task.wait(0.1)
            pcall(function()
                local c = lp.Character; if not c then return end
                if c:FindFirstChild(TRexName) then return end
                local bp = lp.Backpack; if not bp then return end
                local tool = bp:FindFirstChild(TRexName); if not tool then return end
                local hum = c:FindFirstChildOfClass("Humanoid"); if not hum then return end
                hum:EquipTool(tool)
            end)
        end
    end)

    -- Bucle de clics/remotos directo al jugador objetivo
    Conns.attack = task.spawn(function()
        local moveIndex = 1
        while AutoBountyEnabled do
            task.wait(ATTACK_RATE)
            if EscapeActive or not CurrentTarget then continue end
            
            local thisMove = moveIndex
            moveIndex = moveIndex >= 3 and 1 or moveIndex + 1
            
            pcall(function()
                local myChar = lp.Character; if not myChar then return end
                local myHRP  = myChar:FindFirstChild("HumanoidRootPart"); if not myHRP then return end
                if not CurrentTarget.Parent or not CurrentTarget.Character then return end
                
                local tHRP = CurrentTarget.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return end
                local tHum = CurrentTarget.Character:FindFirstChild("Humanoid")
                if not tHum or tHum.Health <= 0 then return end
                
                local tool = myChar:FindFirstChild(TRexName); if not tool then return end
                local remote = tool:FindFirstChild("LeftClickRemote"); if not remote then return end
                
                local dir = (tHRP.Position - myHRP.Position).Unit
                remote:FireServer(Vector3.new(dir.X, dir.Y, dir.Z), thisMove)
            end)
        end
        task.cancel(equipConn)
        Conns.attack = nil
    end)
end

-- ══════════════════════════════════════════════
--  INSTA TELEPORT HACIA EL JUGADOR OBJETIVO
-- ══════════════════════════════════════════════
function StartInstaTeleport()
    if Conns.instaTp then Conns.instaTp:Disconnect(); Conns.instaTp = nil end
    Conns.instaTp = RunService.Stepped:Connect(function()
        if EscapeActive or not AutoBountyEnabled or not CurrentTarget then return end
        pcall(function()
            local myChar = lp.Character; if not myChar then return end
            if not CurrentTarget.Parent or not CurrentTarget.Character then return end
            local myHRP = myChar:FindFirstChild("HumanoidRootPart"); if not myHRP then return end
            local tHRP  = CurrentTarget.Character:FindFirstChild("HumanoidRootPart"); if not tHRP then return end

            local name = CurrentTarget.Name
            if not PositionHistory[name] then
                PositionHistory[name] = { positions = {}, timestamps = {} }
            end
            local hist = PositionHistory[name]
            local now  = tick()
            local pos  = tHRP.Position
            
            table.insert(hist.positions,  pos)
            table.insert(hist.timestamps, now)
            while #hist.positions > PREDICTION_SAMPLES do
                table.remove(hist.positions,  1)
                table.remove(hist.timestamps, 1)
            end

            -- Cálculo matemático de predicción de movimiento para evitar teletransporte desfasado
            local predicted = pos
            if #hist.positions >= 2 then
                local totalDisp = Vector3.zero
                local totalTime = 0
                for i = 2, #hist.positions do
                    local dt = hist.timestamps[i] - hist.timestamps[i-1]
                    if dt > 0 then
                        totalDisp = totalDisp + (hist.positions[i] - hist.positions[i-1])
                        totalTime = totalTime + dt
                    end
                end
                if totalTime > 0 then
                    predicted = pos + ((totalDisp / totalTime) * PREDICTION_TIME)
                end
            end
            
            local myChar2 = lp.Character
            if myChar2 then
                -- Te posiciona exactamente sobre la predicción del jugador objetivo mas el desfase Y Offset
                myChar2:PivotTo(CFrame.new(predicted) * CFrame.new(0, YOffset, 0))
            end
        end)
    end)
end

-- ══════════════════════════════════════════════
--  SISTEMA DE ESCAPE DE EMERGENCIA
-- ══════════════════════════════════════════════
local function StartEscape()
    if EscapeActive then return end
    EscapeActive = true
    if Conns.instaTp then Conns.instaTp:Disconnect(); Conns.instaTp = nil end

    task.spawn(function()
        while EscapeActive do
            pcall(function()
                local c = lp.Character; if not c then return end
                c:PivotTo(CFrame.new(c:GetPivot().Position.X, c:GetPivot().Position.Y + ESCAPE_HEIGHT, c:GetPivot().Position.Z))
            end)
            task.wait(0.05)
            local c = lp.Character
            local h = c and c:FindFirstChild("Humanoid")
            if h and h.Health >= SAFE_HEALTH_THRESHOLD then
                EscapeActive = false
                if AutoBountyEnabled then task.spawn(PickNextTarget) end
            end
        end
    end)
end

-- ══════════════════════════════════════════════
--  SELECCIÓN SISTEMÁTICA DE JUGADORES
-- ══════════════════════════════════════════════
local function DiscardTarget()
    CurrentTarget = nil
    if Conns.watcher then task.cancel(Conns.watcher); Conns.watcher = nil end
    if Conns.instaTp then Conns.instaTp:Disconnect(); Conns.instaTp = nil end
    PositionHistory = {}
end

function PickNextTarget()
    if not AutoBountyEnabled then return end
    DiscardTarget()

    local all = Players:GetPlayers()
    -- Mezclar lista de jugadores de manera aleatoria
    for i = #all, 2, -1 do
        local j = math.random(1, i)
        all[i], all[j] = all[j], all[i]
    end

    local nextPlayer = nil
    for _, p in ipairs(all) do
        if IsPlayerValid(p) then nextPlayer = p; break end
    end

    if not nextPlayer then
        if NoTargetSince == nil then NoTargetSince = tick() end
        return
    end

    NoTargetSince = nil  
    CurrentTarget = nextPlayer
    PositionHistory[nextPlayer.Name] = { positions = {}, timestamps = {} }
    
    StartInstaTeleport()

    if Conns.watcher then task.cancel(Conns.watcher) end
    Conns.watcher = task.spawn(function()
        while AutoBountyEnabled and CurrentTarget == nextPlayer do
            task.wait(0.2)
            local gone = not nextPlayer.Parent  
            local pvpOff = nextPlayer:GetAttribute("pvpDisabled") == true
            local inSafe = IsPlayerInSafeZone(nextPlayer)
            
            if gone or pvpOff or inSafe then
                if Conns.instaTp then Conns.instaTp:Disconnect(); Conns.instaTp = nil end
                if CurrentTarget == nextPlayer then
                    CurrentTarget = nil
                    NoTargetSince = tick()
                    if AutoBountyEnabled then task.spawn(PickNextTarget) end
                end
                return
            end
        end
    end)
end

function StopAll()
    AutoBountyEnabled = false
    EscapeActive      = false
    if Conns.instaTp then Conns.instaTp:Disconnect(); Conns.instaTp = nil end
    if Conns.attack  then task.cancel(Conns.attack);  Conns.attack  = nil end
    if Conns.watcher then task.cancel(Conns.watcher); Conns.watcher = nil end
    if BackupThread then task.cancel(BackupThread); BackupThread = nil end
    CurrentTarget = nil
    PositionHistory = {}
    NoTargetSince = nil
end

local function StartAutoBounty()
    StopAll()
    AutoBountyEnabled = true
    EscapeActive      = false
    NoTargetSince     = nil

    StartAttackLoop()
    PickNextTarget()

    BackupThread = task.spawn(function()
        task.wait(1.5)
        while AutoBountyEnabled do
            task.wait(0.2)
            if IsHealthLow() and not EscapeActive then
                StartEscape()
                continue
            end
            if not CurrentTarget and not EscapeActive then
                if NoTargetSince and (tick() - NoTargetSince) >= NO_TARGET_HOP_TIME then
                    NoTargetSince = nil
                    task.spawn(Hop)
                else
                    PickNextTarget()
                end
            end
            if AutoBountyEnabled and not EscapeActive and Conns.attack == nil then
                StartAttackLoop()
            end
        end
    end)
end

-- ══════════════════════════════════════════════
--  SISTEMA FAST ATTACK EXPLOSIVO
-- ══════════════════════════════════════════════
local FastAttackConn = nil
function StartFastAttack()
    if FastAttackConn then task.cancel(FastAttackConn); FastAttackConn = nil end
    local Modules = ReplicatedStorage:WaitForChild("Modules", 5)
    local Net = Modules and Modules:WaitForChild("Net", 5)
    if not Net then return end
    
    local RegHit    = Net:FindFirstChild("RE/RegisterHit")
    local RegAttack = Net:FindFirstChild("RE/RegisterAttack")
    if not RegHit or not RegAttack then return end

    FastAttackConn = task.spawn(function()
        while FastAttackEnabled do
            RunService.Stepped:Wait()
            pcall(function()
                local targets = {}
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= lp and player.Character then
                        local hum = player.Character:FindFirstChild("Humanoid")
                        local head = player.Character:FindFirstChild("Head")
                        if hum and head and hum.Health > 0 then
                            table.insert(targets, {player.Character, head})
                        end
                    end
                end
                if #targets > 0 then
                    RegAttack:FireServer(0)
                    RegHit:FireServer(targets[1][2], targets)
                end
            end)
        end
    end)
end

-- Manejo de reapariciones tras morir
local function OnCharacterDeath()
    local wasEnabled = AutoBountyEnabled
    StopAll()
    local newChar = lp.CharacterAdded:Wait()
    newChar:WaitForChild("HumanoidRootPart", 10)
    local newHum = newChar:WaitForChild("Humanoid", 10)
    task.wait(1)
    StartAntiSeat()
    if wasEnabled then StartAutoBounty() end
    if newHum then newHum.Died:Once(OnCharacterDeath) end
end
if char:FindFirstChild("Humanoid") then char.Humanoid.Died:Once(OnCharacterDeath) end

-- Tareas asíncronas constantes en segundo plano
task.spawn(function() while task.wait(4) do pcall(BusoKen) end end)
task.spawn(function() while task.wait(0.5) do pcall(PvpEnable); pcall(v4); pcall(antimover) end end)

-- Parcheador para eliminar temblores de cámara molestos
pcall(function()
    local CS = require(ReplicatedStorage:WaitForChild("Util",12):WaitForChild("CameraShaker",10):WaitForChild("Main",10))
    CS.StartShake = function() end; CS.ShakeOnce = function() end
end)

-- ══════════════════════════════════════════════
--  CONSTRUCCIÓN DE LA INTERFAZ GRÁFICA (UI)
-- ══════════════════════════════════════════════
pcall(function() local old = CoreGui:FindFirstChild("TommyHub"); if old then old:Destroy() end end)

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TommyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

local Panel = Instance.new("Frame", ScreenGui)
Panel.Size = UDim2.new(0, 290, 0, 240)
Panel.Position = UDim2.new(0.5, -145, 0.4, -120)
Panel.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
Panel.BorderSizePixel = 0
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", Panel)
Stroke.Color = Color3.fromRGB(235, 35, 35)
Stroke.Thickness = 1.5

local Header = Instance.new("Frame", Panel)
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(185, 25, 25)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Text = "👑 Tommy Hub v7 | PVP AutoBounty"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Text = "─"
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -32, 0, 6)
MinBtn.BackgroundColor3 = Color3.fromRGB(210, 45, 45)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local Container = Instance.new("Frame", Panel)
Container.Size = UDim2.new(1, 0, 1, -38)
Container.Position = UDim2.new(0, 0, 0, 38)
Container.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center

local function CreateToggle(text, defaultState, callback)
    local Row = Instance.new("Frame", Container)
    Row.Size = UDim2.new(0, 260, 0, 40)
    Row.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    Row.BorderSizePixel = 0
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", Row)
    Label.Text = text
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(225, 225, 225)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Switch = Instance.new("TextButton", Row)
    Switch.Size = UDim2.new(0, 45, 0, 22)
    Switch.Position = UDim2.new(1, -55, 0.5, -11)
    Switch.BackgroundColor3 = defaultState and Color3.fromRGB(215, 35, 35) or Color3.fromRGB(45, 45, 55)
    Switch.Text = ""
    Switch.BorderSizePixel = 0
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(0, 11)

    local Ball = Instance.new("Frame", Switch)
    Ball.Size = UDim2.new(0, 16, 0, 16)
    Ball.Position = defaultState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    Ball.BackgroundColor3 = Color3.new(1, 1, 1)
    Ball.BorderSizePixel = 0
    Instance.new("UICorner", Ball).CornerRadius = UDim.new(0, 8)

    local state = defaultState
    Switch.MouseButton1Click:Connect(function()
        state = not state
        Switch.BackgroundColor3 = state and Color3.fromRGB(215, 35, 35) or Color3.fromRGB(45, 45, 55)
        Ball:TweenPosition(state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
        callback(state)
    end)
end

-- ══════════════════════════════════════════════
--  INTERRUPTORES DE LA INTERFAZ
-- ══════════════════════════════════════════════
CreateToggle("⚔️ Auto Hunt Players (T-Rex Clicks)", AutoBountyEnabled, function(enabled)
    if enabled then
        StartAutoBounty()
    else
        StopAll()
    end
end)

CreateToggle("⚡ Fast Attack (Explosive Hits)", FastAttackEnabled, function(enabled)
    FastAttackEnabled = enabled
    if enabled then
        StartFastAttack()
    else
        if FastAttackConn then task.cancel(FastAttackConn); FastAttackConn = nil end
    end
end)

-- Sistema de despliegue/ocultación de UI
local UI_Open = true
MinBtn.MouseButton1Click:Connect(function()
    UI_Open = not UI_Open
    Container.Visible = UI_Open
    Panel:TweenSize(UI_Open and UDim2.new(0, 290, 0, 240) or UDim2.new(0, 290, 0, 38), "Out", "Quad", 0.2, true)
end)

-- Soporte total de Arrastre táctil (Mobile/Delta)
local dragging, dragInput, dragStart, startPos
Panel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Panel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
Panel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
