-- =========================================================
-- 🌭 CHORIPAN HUB PREMIUM 🌭 | by azeu596
-- Versión PREMIUM con Features Exclusivas
-- =========================================================

-- ============================================================
--  INTRO CHORIPAN PREMIUM
-- ============================================================
local function RunChoripanIntro()
    local ScreenGui = Instance.new("ScreenGui")
    local Blackout = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Subtitle = Instance.new("TextLabel")
    local PremiumBadge = Instance.new("TextLabel")
    
    ScreenGui.Name = "ChoripanIntro"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Blackout.Size = UDim2.new(1, 0, 1, 0)
    Blackout.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Blackout.BorderSizePixel = 0
    Blackout.Parent = ScreenGui
    
    Title.Size = UDim2.new(1, 0, 0.5, 0)
    Title.Position = UDim2.new(0, 0, 0.25, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🌭 CHORIPAN HUB 🌭"
    Title.TextColor3 = Color3.fromRGB(255, 215, 0)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 48
    Title.TextStrokeTransparency = 0
    Title.TextStrokeColor3 = Color3.fromRGB(139, 69, 19)
    Title.ZIndex = 100
    Title.Parent = Blackout

    PremiumBadge.Size = UDim2.new(1, 0, 0.1, 0)
    PremiumBadge.Position = UDim2.new(0, 0, 0.5, 0)
    PremiumBadge.BackgroundTransparency = 1
    PremiumBadge.Text = "⭐ PREMIUM EDITION ⭐"
    PremiumBadge.TextColor3 = Color3.fromRGB(255, 215, 0)
    PremiumBadge.Font = Enum.Font.GothamBlack
    PremiumBadge.TextSize = 24
    PremiumBadge.Parent = Blackout

    Subtitle.Size = UDim2.new(1, 0, 0.1, 0)
    Subtitle.Position = UDim2.new(0, 0, 0.65, 0)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "by azeu596 | El Mejor Choripan Premium del Server"
    Subtitle.TextColor3 = Color3.fromRGB(255, 140, 0)
    Subtitle.Font = Enum.Font.Code
    Subtitle.TextSize = 18
    Subtitle.Parent = Blackout

    task.spawn(function()
        for i = 1, 120 do
            task.spawn(function()
                while Blackout.Parent do
                    local m = Instance.new("TextLabel")
                    m.Text = math.random(1, 2) == 1 and "🌭" or "⭐"
                    m.Position = UDim2.new(math.random(), 0, math.random(), 0)
                    m.BackgroundTransparency = 1
                    m.TextColor3 = Color3.fromRGB(math.random(200, 255), math.random(150, 255), math.random(0, 100))
                    m.Font = Enum.Font.Code
                    m.TextSize = math.random(20, 45)
                    m.TextTransparency = 1
                    m.Parent = Blackout
                    
                    local duration = math.random(3, 8) / 10
                    game:GetService("TweenService"):Create(m, TweenInfo.new(duration/2), {TextTransparency = 0}):Play()
                    task.wait(duration)
                    game:GetService("TweenService"):Create(m, TweenInfo.new(duration/2), {TextTransparency = 1}):Play()
                    game:GetService("Debris"):AddItem(m, duration)
                    task.wait(math.random(1, 3) / 10)
                end
            end)
        end
        
        task.wait(5)
        local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
        game:GetService("TweenService"):Create(Blackout, fadeInfo, {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(Title, fadeInfo, {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(PremiumBadge, fadeInfo, {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(Subtitle, fadeInfo, {TextTransparency = 1}):Play()
        task.wait(1)
        ScreenGui:Destroy()
    end)
end

RunChoripanIntro()
task.wait(6)

-- ============================================================
--  GUI ARRASTRABLE PREMIUM + CÍRCULO FLOTANTE
-- ============================================================
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Crear ScreenGui principal
local ChoripanGui = Instance.new("ScreenGui")
ChoripanGui.Name = "ChoripanPremiumGui"
ChoripanGui.Parent = game:GetService("CoreGui")
ChoripanGui.ResetOnSpawn = false
ChoripanGui.DisplayOrder = 999999
ChoripanGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ChoripanGui.IgnoreGuiInset = true

-- Frame Principal del GUI PREMIUM
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 140)
MainFrame.Position = UDim2.new(1, -440, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ChoripanGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 215, 0)
MainStroke.Thickness = 3
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

-- Header PREMIUM
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 165, 0))
}
HeaderGradient.Parent = Header

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
HeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
HeaderFix.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local HeaderGradientFix = Instance.new("UIGradient")
HeaderGradientFix.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 165, 0))
}
HeaderGradientFix.Parent = HeaderFix

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -110, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌭 CHORIPAN PREMIUM ⭐"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 17
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Badge Premium
local PremiumBadge = Instance.new("TextLabel")
PremiumBadge.Size = UDim2.new(0, 70, 0, 20)
PremiumBadge.Position = UDim2.new(0, 15, 1, 5)
PremiumBadge.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
PremiumBadge.Text = "⭐ PRO"
PremiumBadge.Font = Enum.Font.GothamBold
PremiumBadge.TextSize = 12
PremiumBadge.TextColor3 = Color3.fromRGB(0, 0, 0)
PremiumBadge.Parent = MainFrame

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(0, 5)
BadgeCorner.Parent = PremiumBadge

-- Botón X para cerrar
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 2.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseButton.Text = "✕"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BorderSizePixel = 0
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Contenido
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Position = UDim2.new(0, 10, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0.4, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🎮 Estado: PREMIUM Activado ⭐"
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 14
StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = Content

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Name = "InfoLabel"
InfoLabel.Size = UDim2.new(1, 0, 0.6, 0)
InfoLabel.Position = UDim2.new(0, 0, 0.4, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "👤 by azeu596 | Versión Premium"
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 13
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.Parent = Content

-- Círculo Flotante PREMIUM
local FloatingCircle = Instance.new("Frame")
FloatingCircle.Name = "FloatingCircle"
FloatingCircle.Size = UDim2.new(0, 80, 0, 80)
FloatingCircle.Position = UDim2.new(1, -100, 0, 20)
FloatingCircle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
FloatingCircle.Visible = false
FloatingCircle.BorderSizePixel = 0
FloatingCircle.Parent = ChoripanGui

local CircleGradient = Instance.new("UIGradient")
CircleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 165, 0))
}
CircleGradient.Parent = FloatingCircle

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FloatingCircle

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(139, 69, 19)
CircleStroke.Thickness = 4
CircleStroke.Parent = FloatingCircle

local CircleButton = Instance.new("TextButton")
CircleButton.Size = UDim2.new(1, 0, 1, 0)
CircleButton.BackgroundTransparency = 1
CircleButton.Text = "🌭⭐"
CircleButton.Font = Enum.Font.GothamBold
CircleButton.TextSize = 32
CircleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CircleButton.Parent = FloatingCircle

-- Sistema de Arrastre
local function MakeDraggable(frame)
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

MakeDraggable(MainFrame)
MakeDraggable(FloatingCircle)

-- Animaciones de hover premium
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(192, 57, 43),
        Size = UDim2.new(0, 45, 0, 45)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(231, 76, 60),
        Size = UDim2.new(0, 40, 0, 40)
    }):Play()
end)

CircleButton.MouseEnter:Connect(function()
    TweenService:Create(FloatingCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 95, 0, 95)
    }):Play()
end)

CircleButton.MouseLeave:Connect(function()
    TweenService:Create(FloatingCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 80, 0, 80)
    }):Play()
end)

-- Funcionalidad del botón X
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(1, -200, 0, 50)
    }):Play()
    
    task.wait(0.4)
    MainFrame.Visible = false
    FloatingCircle.Visible = true
    FloatingCircle.Size = UDim2.new(0, 0, 0, 0)
    
    TweenService:Create(FloatingCircle, TweenInfo.new(0.5, Enum.EasingStyle.Elastic), {
        Size = UDim2.new(0, 80, 0, 80)
    }):Play()
end)

-- Funcionalidad del círculo flotante
CircleButton.MouseButton1Click:Connect(function()
    TweenService:Create(FloatingCircle, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    task.wait(0.4)
    FloatingCircle.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Elastic), {
        Size = UDim2.new(0, 420, 0, 140)
    }):Play()
end)

-- Efecto de pulso premium en el círculo
task.spawn(function()
    while true do
        if FloatingCircle.Visible then
            TweenService:Create(CircleStroke, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Thickness = 6
            }):Play()
            task.wait(1)
            TweenService:Create(CircleStroke, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Thickness = 4
            }):Play()
            task.wait(1)
        else
            task.wait(0.5)
        end
    end
end)

-- ============================================================
--  RAYFIELD UI PREMIUM
-- ============================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🌭 Choripan Hub PREMIUM ⭐",
    LoadingTitle = "Cargando Choripanes Premium...",
    Icon = 4483362458,
    LoadingSubtitle = "by azeu596 | Premium Edition",
    ConfigurationSaving = {
      Enabled = true,
      FolderName = "ChoripanPremium",
      FileName = "ChoripanPro"
   },
    Discord = {Enabled = false},
    KeySystem = false
})

-- Variables globales
local running = false
local TeleportEnabled = false
local SelectedPlayer = nil
local TeleportConnection = nil
local TweenSpeed = {X = 500, Y = 500}  -- PREMIUM: Más rápido
local PredictionStrength = 0
local FastAttackEnabled = false
local FastAttackConnection = nil
local FastAttackRange = 20000  -- PREMIUM: Range aumentado
local ESPEnabled = true
local ESPBoxes = false
local ESPNames = true
local ActiveTween = nil
local RemoveAnimEnabled = false
local RemoveAnimConnection = nil
local SpinEnabled = false
local SpinConnection = nil
local SpinSpeed = 10  -- PREMIUM: Más rápido
local FlyEnabled = false
local FlySpeed = 100  -- PREMIUM: Más rápido
local FlyBodyVelocity = nil
local XOffset = 0
local YOffset = 0
local ZOffset = 0
local TrackTargetPart = "UpperTorso"
local GhostTpEnabled = false
local GhostTpConnection = nil
local GHOST_RATIO = 2  -- PREMIUM: Más frecuente
local ghostFrameCounter = 0
local TestingFarm = false
local InfRangeAllPlayersEnabled = false
local WalkSpeed = 16
local JumpPower = 50
local InfiniteJumpEnabled = false

-- Tabs PREMIUM
local Tab  = Window:CreateTab("🎯 Track", 4483362458)
local Tab2 = Window:CreateTab("⚔️ Kill Aura", 4483362458)
local Tab3 = Window:CreateTab("⭐ Premium", 4483362458)  -- TAB NUEVO
local Tab4 = Window:CreateTab("⚙️ Misc", 4483362458)
local Tab5 = Window:CreateTab("📍 Teleports", 4483362458)
local Tab6 = Window:CreateTab("👁️ ESP", 4483362458)
local Tab7 = Window:CreateTab("😈 Funny", 4483362458)
local Server = Window:CreateTab("🌐 Server", 4483362458)

-- Bypass de cámara
task.spawn(function()
    pcall(function()
        repeat wait() until game:GetService("ReplicatedStorage"):FindFirstChild("Util")
        local ss = require(game:GetService("ReplicatedStorage").Util.CameraShaker.Main)
        local xx = function() return nil end
        ss.StartShake = xx; ss.ShakeOnce = xx; ss.ShakeSustain = xx
        ss.CamerShakeInstance = xx; ss.Shake = xx; ss.Start = xx
    end)
end)

-- Security Kick Bypass
pcall(function()
    local mt = getrawmetatable(game)
    local old_namecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            if tostring(self) == "Kick" or string.find(tostring(self):lower(), "kick") then
                return
            end
        end
        return old_namecall(self, ...)
    end)
    setreadonly(mt, true)
end)

-- Servicios
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local RegisterHit = Net["RE/RegisterHit"]
local RegisterAttack = Net["RE/RegisterAttack"]

-- Funciones Base
local function IsInCombat()
    local playerGui = lp:FindFirstChild("PlayerGui")
    if not playerGui then return false end
    local mainGui = playerGui:FindFirstChild("Main")
    if not mainGui then return false end
    local bottomHUD = mainGui:FindFirstChild("BottomHUDList")
    if not bottomHUD then return false end
    local inCombatUI = bottomHUD:FindFirstChild("InCombat")
    if not inCombatUI then return false end
    return inCombatUI.Visible
end

local function TP(targetHRP)
    if not lp.Character then return end
    local HRP = lp.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    HRP.AssemblyLinearVelocity = Vector3.zero
    HRP.AssemblyAngularVelocity = Vector3.zero
    local predictedPos = targetHRP.Position + (targetHRP.Velocity * PredictionStrength)
    local targetCFrame = CFrame.new(predictedPos) * CFrame.Angles(0, math.rad(targetHRP.Orientation.Y), 0) * CFrame.new(XOffset, YOffset, ZOffset)
    local Distance = (targetCFrame.Position - HRP.Position).Magnitude
    if ActiveTween then ActiveTween:Cancel() end
    ActiveTween = TweenService:Create(HRP, TweenInfo.new(Distance / TweenSpeed.X, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    ActiveTween:Play()
end

local function GetPlayerList()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp then table.insert(list, p.Name) end
    end
    return #list > 0 and list or {"None"}
end

-- ============================================================
--  TAB 1: TRACK
-- ============================================================
local PlayerDropdown = Tab:CreateDropdown({
    Name = "Selecciona Jugador",
    Options = GetPlayerList(),
    CurrentOption = {"None"},
    Callback = function(opt)
        SelectedPlayer = (opt[1] ~= "None") and opt[1] or nil
    end,
})

Tab:CreateDropdown({
    Name = "Track Part",
    Options = {"UpperTorso", "LowerTorso", "HumanoidRootPart"},
    CurrentOption = {"UpperTorso"},
    Callback = function(opt) TrackTargetPart = opt[1] end,
})

Tab:CreateToggle({
    Name = "🚀 Tween (PREMIUM Speed)", 
    CurrentValue = false,
    Callback = function(v)
        TeleportEnabled = v
        if v and SelectedPlayer then
            if TeleportConnection then TeleportConnection:Disconnect() end
            TeleportConnection = RunService.Heartbeat:Connect(function()
                local t = Players:FindFirstChild(SelectedPlayer)
                if t and t.Character and t.Character:FindFirstChild(TrackTargetPart) then
                    TP(t.Character[TrackTargetPart])
                end
            end)
        elseif TeleportConnection then TeleportConnection:Disconnect() end
    end,
})

Tab:CreateToggle({
    Name = "⚡ Insta TP", 
    CurrentValue = false,
    Callback = function(v)
        InstaTeleportEnabled = v
        if v then
            InstaTpConnection = RunService.Stepped:Connect(function()
                local t = Players:FindFirstChild(SelectedPlayer)
                if t and t.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = t.Character:FindFirstChild(TrackTargetPart).CFrame * CFrame.new(XOffset, YOffset, ZOffset)
                end
            end)
        elseif InstaTpConnection then InstaTpConnection:Disconnect() end
    end,
})

Tab:CreateToggle({
    Name = "👻 Ghost TP (PREMIUM)", 
    CurrentValue = false,
    Callback = function(v)
        GhostTpEnabled = v
        if v and SelectedPlayer then
            GhostTpConnection = RunService.Heartbeat:Connect(function()
                local char = lp.Character
                local target = Players:FindFirstChild(SelectedPlayer)
                if char and target and target.Character then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local targetHRP = target.Character:FindFirstChild(TrackTargetPart)
                    if hrp and targetHRP then
                        ghostFrameCounter = ghostFrameCounter + 1
                        local targetCF = targetHRP.CFrame * CFrame.new(XOffset, YOffset, ZOffset)
                        if ghostFrameCounter % GHOST_RATIO == 0 then
                            hrp.CFrame = targetCF
                        end
                    end
                end
            end)
        elseif GhostTpConnection then GhostTpConnection:Disconnect() end
    end,
})

Tab:CreateToggle({
    Name = "🌐 TP Server", 
    CurrentValue = false,
    Callback = function(v)
        InfRangeAllPlayersEnabled = v
        if v then
            task.spawn(function()
                while InfRangeAllPlayersEnabled do
                    task.wait(0.05)
                    for _, target in pairs(Players:GetPlayers()) do
                        if target ~= lp and target.Character and target.Character:FindFirstChild("Head") then
                            RegisterAttack:FireServer(0)
                            RegisterHit:FireServer(target.Character.Head, {{target.Character, target.Character.Head}})
                        end
                    end
                end
            end)
        end
    end,
})

Tab:CreateButton({
    Name = "🔄 Actualizar Lista",
    Callback = function() 
        PlayerDropdown:Refresh(GetPlayerList(), true)
        Rayfield:Notify({
            Title = "🔄 Lista Actualizada",
            Content = "Jugadores actualizados",
            Duration = 2
        })
    end
})

Tab:CreateSlider({ Name = "📏 Y Offset", Range = {0,500}, Increment = 1, CurrentValue = 0, Callback = function(v) YOffset = v end })
Tab:CreateSlider({ Name = "📐 X Offset", Range = {0,250}, Increment = 1, CurrentValue = 0, Callback = function(v) XOffset = v end })
Tab:CreateSlider({ Name = "📐 Z Offset", Range = {0,250}, Increment = 1, CurrentValue = 0, Callback = function(v) ZOffset = v end })
Tab:CreateSlider({ Name = "🎯 Prediction", Range = {0,15}, Increment = 0.1, CurrentValue = 0, Callback = function(v) PredictionStrength = v end })

-- ============================================================
--  TAB 2: KILL AURA PREMIUM
-- ============================================================

local function AttackMultipleTargets(targets)
    pcall(function()
        if not targets or #targets == 0 then return end

        local allTargets = {}

        for _, targetChar in pairs(targets) do
            local head = targetChar:FindFirstChild("Head")
            if head then
                table.insert(allTargets, { targetChar, head })
            end
        end

        if #allTargets == 0 then return end

        RegisterAttack:FireServer(0)

        local hitArgs = {
            allTargets[1][2],
            allTargets
        }

        RegisterHit:FireServer(unpack(hitArgs))
    end)
end

Tab2:CreateToggle({
    Name = "⚔️ Fast Attack PREMIUM (20K Range)", 
    CurrentValue = false,
    Callback = function(v)
        FastAttackEnabled = v
        
        -- Actualizar GUI Custom
        if v then
            StatusLabel.Text = "🎮 Estado: Fast Attack PREMIUM ⚡⭐"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        else
            StatusLabel.Text = "🎮 Estado: PREMIUM Activado ⭐"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        end
        
        if v then
            FastAttackConnection = task.spawn(function()
                while FastAttackEnabled do
                    task.wait(0.01)

                    local myChar = lp.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    if not myHRP then continue end

                    local targetsInRange = {}

                    -- Jugadores
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= lp and player.Character then
                            local humanoid = player.Character:FindFirstChild("Humanoid")
                            local hrp = player.Character:FindFirstChild("HumanoidRootPart")

                            if humanoid and hrp and humanoid.Health > 0 then
                                local dist = (hrp.Position - myHRP.Position).Magnitude
                                if dist <= FastAttackRange then
                                    table.insert(targetsInRange, player.Character)
                                end
                            end
                        end
                    end

                    -- NPCs/Enemigos
                    local enemiesFolder = workspace:FindFirstChild("Enemies")
                    if enemiesFolder then
                        for _, npc in pairs(enemiesFolder:GetChildren()) do
                            local humanoid = npc:FindFirstChild("Humanoid")
                            local hrp = npc:FindFirstChild("HumanoidRootPart")

                            if humanoid and hrp and humanoid.Health > 0 then
                                local dist = (hrp.Position - myHRP.Position).Magnitude
                                if dist <= FastAttackRange then
                                    table.insert(targetsInRange, npc)
                                end
                            end
                        end
                    end

                    if #targetsInRange > 0 then
                        AttackMultipleTargets(targetsInRange)
                    end
                end
            end)
        elseif FastAttackConnection then 
            task.cancel(FastAttackConnection) 
        end
    end,
})

Tab2:CreateSlider({
    Name = "📏 Attack Range PREMIUM",
    Range = {100, 20000},
    Increment = 100,
    CurrentValue = 20000,
    Callback = function(v)
        FastAttackRange = v
    end,
})

Tab2:CreateToggle({
    Name = "🍎 Fruit Aura (All Fruits)", 
    CurrentValue = false,
    Callback = function(v)
        FruitAuraEnabled = v
        if v then
            FruitAuraConnection = task.spawn(function()
                while FruitAuraEnabled do
                    task.wait(0.1)
                    
                    pcall(function()
                        local char = lp.Character
                        if not char then return end
                        
                        local myHRP = char:FindFirstChild("HumanoidRootPart")
                        if not myHRP then return end

                        -- Buscar CUALQUIER fruta equipada
                        local fruit = nil
                        for _, item in ipairs(char:GetChildren()) do
                            if item:IsA("Tool") and item:FindFirstChild("LeftClickRemote") then 
                                fruit = item 
                                break 
                            end
                        end
                        
                        if not fruit then return end

                        local remote = fruit:FindFirstChild("LeftClickRemote")
                        if not remote then return end

                        -- Buscar jugador más cercano
                        local nearestPlayer = nil
                        local shortestDistance = math.huge

                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= lp and player.Character then
                                local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
                                local hum = player.Character:FindFirstChild("Humanoid")
                                if targetHRP and hum and hum.Health > 0 then
                                    local distance = (targetHRP.Position - myHRP.Position).Magnitude
                                    if distance <= 20000 and distance < shortestDistance then
                                        shortestDistance = distance
                                        nearestPlayer = player
                                    end
                                end
                            end
                        end

                        -- Atacar al jugador más cercano
                        if nearestPlayer and nearestPlayer.Character then
                            local targetHRP = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if targetHRP then
                                local dir = (targetHRP.Position - myHRP.Position).Unit
                                remote:FireServer(Vector3.new(dir.X, dir.Y, dir.Z), 1, true)
                            end
                        end
                    end)
                end
            end)
        elseif FruitAuraConnection then task.cancel(FruitAuraConnection) end
    end,
})

Tab2:CreateLabel("• Funciona con TODAS las frutas")
Tab2:CreateLabel("• Range: 20,000 studs")
Tab2:CreateLabel("• Ataca jugador más cercano")

-- ============================================================
--  TAB 3: PREMIUM EXCLUSIVO
-- ============================================================
Tab3:CreateLabel("⭐ FEATURES PREMIUM EXCLUSIVAS ⭐")
Tab3:CreateLabel("")

Tab3:CreateSlider({
    Name = "⚡ WalkSpeed PREMIUM",
    Range = {16, 500},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        WalkSpeed = v
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = WalkSpeed
        end
    end,
})

Tab3:CreateSlider({
    Name = "🦘 JumpPower PREMIUM",
    Range = {50, 500},
    Increment = 10,
    CurrentValue = 50,
    Callback = function(v)
        JumpPower = v
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.JumpPower = JumpPower
        end
    end,
})

Tab3:CreateToggle({
    Name = "🌟 Infinite Jump",
    CurrentValue = false,
    Callback = function(v)
        InfiniteJumpEnabled = v
    end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = WalkSpeed
            lp.Character.Humanoid.JumpPower = JumpPower
        end
    end
end)

Tab3:CreateLabel("")
Tab3:CreateLabel("⚠️ Solo disponible en PREMIUM")
Tab3:CreateLabel("✅ Range: 20,000 studs")
Tab3:CreateLabel("✅ Speed: 500 (más rápido)")
Tab3:CreateLabel("✅ WalkSpeed hasta 500")
Tab3:CreateLabel("✅ JumpPower hasta 500")

-- ============================================================
--  TAB 4: MISC
-- ============================================================
Tab4:CreateToggle({
    Name = "🚫 No Move", 
    CurrentValue = false,
    Callback = function(v)
        if v then
            local folder = Instance.new("Folder", lp.Character)
            folder.Name = "AntiMover"
        elseif lp.Character:FindFirstChild("AntiMover") then
            lp.Character.AntiMover:Destroy()
        end
    end,
})

Tab4:CreateToggle({
    Name = "🔒 Unbreakable", 
    CurrentValue = false,
    Callback = function(v)
        Unbreakable = v
        if v then
            UnbreakableConnection = task.spawn(function()
                while Unbreakable do
                    task.wait(0.1)
                    lp.Character:SetAttribute("UnbreakableAll", true)
                end
            end)
        elseif UnbreakableConnection then task.cancel(UnbreakableConnection) end
    end,
})

Tab4:CreateToggle({
    Name = "✨ V4 Bypass", 
    CurrentValue = false,
    Callback = function(v)
        autoV4 = v
        if v then
            v4Connection = task.spawn(function()
                while autoV4 do
                    task.wait(0.5)
                    local awk = lp.Backpack:FindFirstChild("Awakening")
                    if awk then awk.RemoteFunction:InvokeServer(true) end
                end
            end)
        elseif v4Connection then task.cancel(v4Connection) end
    end,
})

Tab4:CreateToggle({
    Name = "💨 Dash", 
    CurrentValue = false,
    Callback = function(v)
        DashEnabled = v
        if v then
            DashConnection = task.spawn(function()
                while DashEnabled do
                    task.wait(0.1)
                    lp.Character:SetAttribute("DashLength", DashLenghtDistance420 or 120)
                end
            end)
        elseif DashConnection then task.cancel(DashConnection) end
    end
})

Tab4:CreateDropdown({
    Name = "Dash Length",
    Options = {"180","120","90","60","35","5"},
    CurrentOption = {"5"},
    Callback = function(v) DashLenghtDistance420 = tonumber(v[1]) end
})

Tab4:CreateToggle({
    Name = "🎭 Remove Animations", 
    CurrentValue = false,
    Callback = function(v)
        RemoveAnimEnabled = v
        if v then
            RemoveAnimConnection = task.spawn(function()
                while RemoveAnimEnabled do
                    task.wait(0.1)
                    local hum = lp.Character:FindFirstChild("Humanoid")
                    if hum then
                        for _, t in pairs(hum:GetPlayingAnimationTracks()) do t:Stop() end
                    end
                end
            end)
        elseif RemoveAnimConnection then task.cancel(RemoveAnimConnection) end
    end,
})

Tab4:CreateToggle({
    Name = "🌀 Spin PREMIUM", 
    CurrentValue = false,
    Callback = function(v)
        SpinEnabled = v
        if v then
            SpinConnection = task.spawn(function()
                while SpinEnabled do
                    task.wait()
                    lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SpinSpeed), 0)
                end
            end)
        elseif SpinConnection then task.cancel(SpinConnection) end
    end,
})

Tab4:CreateSlider({ Name = "🌀 Spin Speed", Range = {1, 100}, Increment = 1, CurrentValue = 10, Callback = function(v) SpinSpeed = v end })

Tab4:CreateToggle({
    Name = "✈️ Fly PREMIUM", 
    CurrentValue = false,
    Callback = function(v)
        FlyEnabled = v
        if v then
            local bv = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
            bv.Velocity = Vector3.new(0,0,0)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            FlyBodyVelocity = bv
        elseif FlyBodyVelocity then FlyBodyVelocity:Destroy() end
    end,
})

Tab4:CreateSlider({ Name = "✈️ Fly Speed", Range = {10, 500}, Increment = 10, CurrentValue = 100, Callback = function(v) FlySpeed = v end })

-- ============================================================
--  TAB 5: TELEPORTS
-- ============================================================
local function TpTo(cf) lp.Character.HumanoidRootPart.CFrame = cf end

Tab5:CreateLabel("📍 SEA 1 TELEPORTS")

Tab5:CreateButton({ Name = "🏰 Mansion", Callback = function() TpTo(CFrame.new(-12463, 376, -7567)) end })
Tab5:CreateButton({ Name = "👼 Angel Island", Callback = function() TpTo(CFrame.new(-4627, 848, -1706)) end })
Tab5:CreateButton({ Name = "🗿 Tiki", Callback = function() TpTo(CFrame.new(-16801, 58, 306)) end })

Tab5:CreateLabel("")
Tab5:CreateLabel("🌊 SEA 2 TELEPORTS")

Tab5:CreateButton({ 
    Name = "🚢 Barco Maldito (Sea 2)", 
    Callback = function() 
        TpTo(CFrame.new(923, 126, 32852)) 
    end 
})

-- ============================================================
--  TAB 6: ESP
-- ============================================================
Tab6:CreateToggle({ Name = "👁️ Activar ESP", CurrentValue = true, Callback = function(v) ESPEnabled = v end })
Tab6:CreateToggle({ Name = "📦 Boxes", CurrentValue = false, Callback = function(v) ESPBoxes = v end })
Tab6:CreateToggle({ Name = "📛 Nombres", CurrentValue = true, Callback = function(v) ESPNames = v end })

-- ============================================================
--  TAB 7: FUNNY
-- ============================================================
Tab7:CreateToggle({
    Name = "♾️ Respawn Abuse (Godmode)",
    CurrentValue = false,
    Callback = function(v)
        TestingFarm = v
        if v then
            task.spawn(function()
                while TestingFarm do
                    task.wait(0.01)
                    if not IsInCombat() then
                        lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, 500000, 0)
                    end
                end
            end)
        end
    end,
})

Tab7:CreateToggle({
    Name = "🦖 T-Rex Kill Aura",
    CurrentValue = false,
    Callback = function(v)
        TrexKillAuraPlayers = v
        if v then
            TrexKillAuraPlayersConnection = task.spawn(function()
                while TrexKillAuraPlayers do
                    task.wait(0.1)
                    local trex = lp.Backpack:FindFirstChild("T-Rex-T-Rex") or lp.Character:FindFirstChild("T-Rex-T-Rex")
                    if trex and trex:FindFirstChild("LeftClickRemote") then
                        trex.LeftClickRemote:FireServer(Vector3.new(0,1,0), 1)
                    end
                end
            end)
        elseif TrexKillAuraPlayersConnection then task.cancel(TrexKillAuraPlayersConnection) end
    end,
})

-- ============================================================
--  TAB SERVER
-- ============================================================
Server:CreateToggle({
    Name = "🧪 Auto Equip Venom",
    CurrentValue = false,
    Callback = function(v)
        autoEquipVenom = v
        if v then
            task.spawn(function()
                while autoEquipVenom do
                    task.wait(1)
                    local ven = lp.Backpack:FindFirstChild("Venom-Venom")
                    if ven then lp.Character.Humanoid:EquipTool(ven) end
                end
            end)
        end
    end,
})

-- ============================================================
--  NOTIFICACIÓN FINAL PREMIUM
-- ============================================================
Rayfield:Notify({
    Title = "⭐ Choripan Hub PREMIUM ⭐", 
    Content = "✅ Versión Premium Cargada | by azeu596", 
    Duration = 6,
    Image = 4483362458
})

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🌭⭐ CHORIPAN HUB PREMIUM ⭐🌭")
print("by azeu596")
print("✅ GUI Premium con Gradientes")
print("✅ Features Premium Exclusivas")
print("✅ Range: 20,000 studs")
print("✅ Speed: 500 (2x más rápido)")
print("✅ WalkSpeed/JumpPower hasta 500")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
