local v1 = game:GetService("Players").LocalPlayer
local v2 = v1:WaitForChild("PlayerGui")
local v3, v4, v5 = ipairs({
    "iruka_kamone",
    "W_yorudaze",
    "GOKUU03l2",
    "MercStoriafan",
    "hayakinn_kazuma",
    "DJORIANN",
    "so_kun14",
    "so_kun111444",
    "oasfrg3289",
    "ryu123301",
    "kozakana096"
})
local v6 = false
local vu7 = "irukadownshow"
while true do
    local v8
    v5, v8 = v3(v4, v5)
    if v5 == nil then
        break
    end
    if v1.Name == v8 then
        v6 = true
        break
    end
end
local function vu586()
    local vu9 = game:GetService("Players")
    local vu10 = game:GetService("TweenService")
    local vu11 = game:GetService("RunService")
    local vu12 = game:GetService("ReplicatedStorage")
    local vu13 = vu9.LocalPlayer
    local vu14 = 300
    local vu15 = "Head"
    local vu16 = workspace.Camera
    local vu17 = nil
    local vu18 = nil
    local vu19 = nil
    local vu20 = true
    local vu21 = false
    local vu22 = nil
    local vu23 = false
    local vu24 = false
    local vu25 = false
    local vu26 = false
    local vu27 = false
    local vu28 = true
    local vu29 = false
    local vu30 = false
    local vu31 = false
    local vu32 = false
    local vu33 = true
    local vu34 = nil
    local vu35 = false
    local vu36 = Vector3.new(2, 2, 1)
    local vu37 = false
    local vu38 = Vector3.new(60, 60, 60)
    local vu39 = 16
    local vu40 = false
    local vu41 = 50
    local vu42 = nil
    local vu43 = 60
    local vu44 = false
    local vu45 = nil
    local vu46 = nil
    local vu47 = false
    local vu48 = false
    local vu49 = false
    local vu50 = false
    local vu51 = tick()
    local vu52 = 0
    local vu53 = 0
    local vu54 = {}
    local vu55 = {}
    local function vu57(p56)
        if vu17 then
            vu17:Destroy()
        end
        vu17 = Instance.new("Part")
        vu17.Size = Vector3.new(4, 1, 4)
        vu17.Anchored = true
        vu17.CanCollide = false
        vu17.Transparency = 1
        vu17.Position = p56
        vu17.Parent = workspace
    end
    local function vu58()
        if vu17 then
            vu17:Destroy()
            vu17 = nil
        end
        if vu19 then
            vu19:Disconnect()
            vu19 = nil
        end
        if vu18 then
            vu18:Cancel()
            vu18 = nil
        end
    end
    local vu59 = Instance.new("ScreenGui")
    vu59.Name = "FollowGui"
    vu59.ResetOnSpawn = false
    vu59.Parent = vu13:WaitForChild("PlayerGui")
    local vu60 = Instance.new("Frame", vu59)
    vu60.Size = UDim2.new(0, 450, 0, 300)
    vu60.Position = UDim2.new(0.3, 0, 0.3, 0)
    vu60.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    vu60.BackgroundTransparency = 0.3
    vu60.BorderSizePixel = 0
    vu60.ClipsDescendants = true
    vu60.Active = true
    vu60.Draggable = true
    Instance.new("UICorner", vu60).CornerRadius = UDim.new(0, 20)
    local v61 = Instance.new("Frame", vu60)
    v61.Size = UDim2.new(1, 0, 0, 35)
    v61.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", v61).CornerRadius = UDim.new(0, 20)
    local v62 = Instance.new("TextLabel", v61)
    v62.Size = UDim2.new(100, 0, 1, 0)
    v62.Position = UDim2.new(0, 10, 0, 0)
    v62.BackgroundTransparency = 1
    v62.Text = "Iruka Hub"
    v62.TextColor3 = Color3.new(1, 1, 1)
    v62.Font = Enum.Font.GothamBold
    v62.TextSize = 20
    v62.TextXAlignment = Enum.TextXAlignment.Left
    local v63 = Instance.new("TextButton", v61)
    v63.Size = UDim2.new(0, 30, 0, 30)
    v63.Position = UDim2.new(1, - 32, 0, 2)
    v63.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    v63.TextColor3 = Color3.new(1, 1, 1)
    v63.Text = "\195\151"
    v63.Font = Enum.Font.GothamBold
    v63.TextSize = 40
    Instance.new("UICorner", v63).CornerRadius = UDim.new(1, 0)
    local vu64 = Instance.new("Frame", vu60)
    vu64.Size = UDim2.new(0, 250, 1, - 35)
    vu64.Position = UDim2.new(0, 180, 0, 35)
    vu64.BackgroundTransparency = 1
    local vu65 = Instance.new("ScrollingFrame", vu64)
    vu65.Size = UDim2.new(1, 0, 1, 0)
    vu65.BackgroundTransparency = 1
    vu65.ScrollBarThickness = 6
    vu65.ClipsDescendants = true
    local vu66 = Instance.new("UIListLayout", vu65)
    vu66.SortOrder = Enum.SortOrder.LayoutOrder
    vu66.Padding = UDim.new(0, 6)
    local v67 = Instance.new("UIPadding")
    v67.Parent = vu65
    v67.PaddingTop = UDim.new(0, 10)
    v67.PaddingBottom = UDim.new(0, 5)
    v67.PaddingLeft = UDim.new(0, 5)
    v67.PaddingRight = UDim.new(0, 5)
    local vu68 = Instance.new("Frame", vu60)
    vu68.Size = UDim2.new(0, 180, 1, - 35)
    vu68.Position = UDim2.new(0, 0, 0, 35)
    vu68.BackgroundTransparency = 1
    local vu69 = Instance.new("TextButton", vu68)
    vu69.Size = UDim2.new(0, 160, 0, 30)
    vu69.Position = UDim2.new(0, 10, 0, 10)
    vu69.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    vu69.TextColor3 = Color3.new(1, 1, 1)
    vu69.Text = "Select Player"
    vu69.Font = Enum.Font.GothamBold
    vu69.TextSize = 14
    local vu70 = Instance.new("ScrollingFrame", vu68)
    vu70.Size = UDim2.new(0, 160, 0, 120)
    vu70.Position = UDim2.new(0, 10, 0, 40)
    vu70.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    vu70.Visible = false
    vu70.ClipsDescendants = true
    vu70.BorderSizePixel = 0
    vu70.ScrollBarThickness = 6
    local v71 = Instance.new("UIListLayout", vu70)
    v71.SortOrder = Enum.SortOrder.LayoutOrder
    v71.Padding = UDim.new(0, 4)
    local v72 = Instance.new("Frame", v61)
    v72.Position = UDim2.new(0, 120, 0, 2)
    v72.Size = UDim2.new(0, 300, 1, - 4)
    v72.BackgroundTransparency = 1
    local v73 = Instance.new("UIListLayout", v72)
    v73.FillDirection = Enum.FillDirection.Horizontal
    v73.HorizontalAlignment = Enum.HorizontalAlignment.Left
    v73.VerticalAlignment = Enum.VerticalAlignment.Center
    v73.Padding = UDim.new(0, 4)
    local function v77(p74, p75)
        local v76 = Instance.new("TextButton", p74)
        v76.Size = UDim2.new(0.15, 0, 1, - 4)
        v76.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        v76.TextColor3 = Color3.new(1, 1, 1)
        v76.Text = p75
        v76.Font = Enum.Font.GothamBold
        v76.TextSize = 14
        Instance.new("UICorner", v76).CornerRadius = UDim.new(0, 6)
        return v76
    end
    local vu78 = v77(v72, "Home")
    local vu79 = v77(v72, "ESP")
    local vu80 = v77(v72, "Other")
    local vu81 = v77(v72, "BF")
    local vu82 = v77(v72, "Config")
    local vu83 = Instance.new("Frame", vu60)
    vu83.Size = UDim2.new(1, 0, 1, - 50)
    vu83.Position = UDim2.new(0, 0, 0, 50)
    vu83.BackgroundTransparency = 1
    vu83.Visible = false
    local v84 = Instance.new("UIListLayout")
    v84.Parent = vu83
    v84.SortOrder = Enum.SortOrder.LayoutOrder
    v84.Padding = UDim.new(0, 5)
    local vu85 = Instance.new("Frame", vu60)
    vu85.Size = UDim2.new(0, 180, 1, - 35)
    vu85.Position = UDim2.new(0, 0, 0, 35)
    vu85.BackgroundTransparency = 1
    vu85.Visible = false
    local vu86 = Instance.new("Frame", vu60)
    vu86.Size = UDim2.new(0, 250, 1, - 35)
    vu86.Position = UDim2.new(0, 180, 0, 35)
    vu86.BackgroundTransparency = 1
    vu86.Visible = false
    local v87 = Instance.new("ScrollingFrame", vu85)
    v87.Size = UDim2.new(1, 0, 1, 0)
    v87.BackgroundTransparency = 1
    v87.ScrollBarThickness = 6
    v87.ClipsDescendants = true
    local v88 = Instance.new("UIListLayout", v87)
    v88.SortOrder = Enum.SortOrder.LayoutOrder
    v88.Padding = UDim.new(0, 6)
    local v89 = Instance.new("ScrollingFrame", vu86)
    v89.Size = UDim2.new(1, 0, 1, 0)
    v89.BackgroundTransparency = 1
    v89.ScrollBarThickness = 6
    v89.ClipsDescendants = true
    local v90 = Instance.new("UIListLayout", v89)
    v90.SortOrder = Enum.SortOrder.LayoutOrder
    v90.Padding = UDim.new(0, 6)
    local vu91 = Instance.new("Frame", vu60)
    vu91.Size = UDim2.new(0, 180, 1, - 35)
    vu91.Position = UDim2.new(0, 0, 0, 35)
    vu91.BackgroundTransparency = 1
    vu91.Visible = false
    local vu92 = Instance.new("Frame", vu60)
    vu92.Size = UDim2.new(0, 250, 1, - 35)
    vu92.Position = UDim2.new(0, 180, 0, 35)
    vu92.BackgroundTransparency = 1
    vu92.Visible = false
    local v93 = Instance.new("ScrollingFrame", vu91)
    v93.Size = UDim2.new(1, 0, 1, 0)
    v93.BackgroundTransparency = 1
    v93.ScrollBarThickness = 6
    v93.ClipsDescendants = true
    local v94 = Instance.new("UIListLayout", v93)
    v94.SortOrder = Enum.SortOrder.LayoutOrder
    v94.Padding = UDim.new(0, 6)
    local v95 = Instance.new("ScrollingFrame", vu92)
    v95.Size = UDim2.new(1, 0, 1, 0)
    v95.BackgroundTransparency = 1
    v95.ScrollBarThickness = 6
    v95.ClipsDescendants = true
    local v96 = Instance.new("UIListLayout", v95)
    v96.SortOrder = Enum.SortOrder.LayoutOrder
    v96.Padding = UDim.new(0, 6)
    local vu97 = Instance.new("Frame", vu60)
    vu97.Size = UDim2.new(0, 180, 1, - 35)
    vu97.Position = UDim2.new(0, 0, 0, 35)
    vu97.BackgroundTransparency = 1
    vu97.Visible = false
    local vu98 = Instance.new("Frame", vu60)
    vu98.Size = UDim2.new(0, 250, 1, - 35)
    vu98.Position = UDim2.new(0, 180, 0, 35)
    vu98.BackgroundTransparency = 1
    vu98.Visible = false
    local v99 = Instance.new("ScrollingFrame", vu97)
    v99.Size = UDim2.new(1, 0, 1, 0)
    v99.BackgroundTransparency = 1
    v99.ScrollBarThickness = 6
    v99.ClipsDescendants = true
    local v100 = Instance.new("UIListLayout", v99)
    v100.SortOrder = Enum.SortOrder.LayoutOrder
    v100.Padding = UDim.new(0, 6)
    local v101 = Instance.new("ScrollingFrame", vu98)
    v101.Size = UDim2.new(1, 0, 1, 0)
    v101.BackgroundTransparency = 1
    v101.ScrollBarThickness = 6
    v101.ClipsDescendants = true
    local v102 = Instance.new("UIListLayout", v101)
    v102.SortOrder = Enum.SortOrder.LayoutOrder
    v102.Padding = UDim.new(0, 6)
    local vu103 = Instance.new("ScreenGui")
    vu103.Name = "TPGui"
    vu103.ResetOnSpawn = false
    vu103.Parent = vu13:WaitForChild("PlayerGui")
    vu103.Enabled = false
    local vu104 = Instance.new("ScreenGui")
    vu104.Name = "StatsGui"
    vu104.ResetOnSpawn = false
    vu104.Parent = vu13:WaitForChild("PlayerGui")
    vu104.Enabled = false
    local v105 = Instance.new("Frame", vu104)
    v105.Size = UDim2.new(0, 320, 0, 30)
    v105.Position = UDim2.new(0.03, 0, 0, 0)
    v105.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    v105.BackgroundTransparency = 0.2
    v105.Active = true
    Instance.new("UICorner", v105).CornerRadius = UDim.new(0, 12)
    local vu106 = Instance.new("TextLabel", v105)
    vu106.Size = UDim2.new(1, 0, 1, 0)
    vu106.BackgroundTransparency = 1
    vu106.Font = Enum.Font.GothamBold
    vu106.TextSize = 14
    vu106.TextColor3 = Color3.new(1, 1, 1)
    vu106.TextXAlignment = Enum.TextXAlignment.Left
    local function vu108(p107)
        if p107 == "Home" then
            vu68.Visible = true
            vu64.Visible = true
            vu83.Visible = false
            vu85.Visible = false
            vu86.Visible = false
            vu91.Visible = false
            vu92.Visible = false
            vu97.Visible = false
            vu98.Visible = false
        elseif p107 == "ESP" then
            vu68.Visible = false
            vu64.Visible = false
            vu83.Visible = true
            vu85.Visible = false
            vu86.Visible = false
            vu91.Visible = false
            vu92.Visible = false
            vu97.Visible = false
            vu98.Visible = false
        elseif p107 == "Other" then
            vu68.Visible = false
            vu64.Visible = false
            vu83.Visible = false
            vu85.Visible = true
            vu86.Visible = true
            vu91.Visible = false
            vu92.Visible = false
            vu97.Visible = false
            vu98.Visible = false
        elseif p107 == "Bloxfruits" then
            vu68.Visible = false
            vu64.Visible = false
            vu83.Visible = false
            vu85.Visible = false
            vu86.Visible = false
            vu91.Visible = true
            vu92.Visible = true
            vu97.Visible = false
            vu98.Visible = false
        elseif p107 == "Config" then
            vu68.Visible = false
            vu64.Visible = false
            vu83.Visible = false
            vu85.Visible = false
            vu86.Visible = false
            vu91.Visible = false
            vu92.Visible = false
            vu97.Visible = true
            vu98.Visible = true
        end
    end
    vu78.MouseButton1Click:Connect(function()
        vu108("Home")
    end)
    vu79.MouseButton1Click:Connect(function()
        vu108("ESP")
    end)
    vu80.MouseButton1Click:Connect(function()
        vu108("Other")
    end)
    vu81.MouseButton1Click:Connect(function()
        vu108("Bloxfruits")
    end)
    vu82.MouseButton1Click:Connect(function()
        vu108("Config")
    end)
    vu108("Home")
    local vu109 = Instance.new("TextLabel", vu68)
    vu109.Size = UDim2.new(0, 80, 0, 30)
    vu109.Position = UDim2.new(0, 10, 0, 180)
    vu109.BackgroundTransparency = 1
    vu109.Text = "Speed:"
    vu109.TextColor3 = Color3.new(1, 1, 1)
    vu109.Font = Enum.Font.GothamBold
    vu109.TextSize = 14
    vu109.TextXAlignment = Enum.TextXAlignment.Left
    local vu110 = Instance.new("TextBox", vu68)
    vu110.Size = UDim2.new(0, 80, 0, 30)
    vu110.Position = UDim2.new(0, 60, 0, 180)
    vu110.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    vu110.TextColor3 = Color3.new(1, 1, 1)
    vu110.Text = tostring(vu14)
    vu110.Font = Enum.Font.GothamBold
    vu110.TextSize = 14
    vu110.ClearTextOnFocus = false
    vu110.TextEditable = true
    vu110.FocusLost:Connect(function()
        local v111 = tonumber(vu110.Text)
        if v111 and 0 < v111 then
            vu14 = v111
        end
    end)
    local v112 = Instance.new("ImageButton")
    v112.Size = UDim2.new(0, 50, 0, 50)
    v112.Position = UDim2.new(0, 100, 0, 100)
    v112.BackgroundTransparency = 1
    v112.Image = "rbxassetid://125855645824065"
    v112.Parent = vu59
    v112.Active = true
    v112.Draggable = true
    Instance.new("UICorner", v112).CornerRadius = UDim.new(0.25, 0)
    v112.MouseButton1Click:Connect(function()
        vu60.Visible = not vu60.Visible
    end)
    local function vu120(p113, p114, p115)
        local vu116 = Instance.new("Frame")
        vu116.Size = UDim2.new(0, 200, 0, 60)
        vu116.Position = UDim2.new(1, 210, 0, - 70)
        vu116.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
        vu116.BackgroundTransparency = 0.2
        vu116.BorderSizePixel = 0
        vu116.Parent = vu59
        Instance.new("UICorner", vu116).CornerRadius = UDim.new(0.25, 0)
        local v117 = Instance.new("TextLabel", vu116)
        v117.Size = UDim2.new(0.9, 0, 0.9, 0)
        v117.Position = UDim2.new(0.05, 0, 0.05, 0)
        v117.BackgroundTransparency = 1
        v117.Text = vu50 and p114 and p114 or p113
        v117.TextColor3 = p115
        v117.Font = Enum.Font.GothamBold
        v117.TextSize = 16
        v117.TextXAlignment = Enum.TextXAlignment.Left
        v117.TextYAlignment = Enum.TextYAlignment.Top
        local v118 = vu10:Create(vu116, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, - 210, 1, - 70)
        })
        v118:Play()
        v118.Completed:Connect(function()
            task.delay(3, function()
                local v119 = vu10:Create(vu116, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.new(1, 210, 1, - 70)
                })
                v119:Play()
                v119.Completed:Connect(function()
                    vu116:Destroy()
                end)
            end)
        end)
    end
    local v121 = game.PlaceId
    local v122 = nil
    local vu123 = {}
    local v124 = nil
    local v125 = nil
    if v121 == 4442272183 then
        vu120("Success!\nBlox Fruits Mode ON(2nd)", "\230\136\144\229\138\159\227\129\151\227\129\190\227\129\151\227\129\159\239\188\129\n\227\131\150\227\131\173\227\131\131\227\130\175\227\130\185\227\131\149\227\131\171\227\131\188\227\131\132\227\131\162\227\131\188\227\131\137(\227\130\187\227\130\171\227\131\179\227\131\137)", Color3.fromRGB(255, 255, 255))
        vu123 = {
            Vector3.new(- 287, 305.9, 597.6),
            Vector3.new(2284.9, 14.9, 905.8),
            Vector3.new(923.2, 124.8, 32852.8),
            Vector3.new(- 6508.6, 82, - 132.8)
        }
        v124 = Vector3.new(- 287, 306.5, 597.9)
        v125 = Vector3.new(938, 252.7, 32888)
        vu21 = true
        v122 = "2nd"
    elseif v121 == 79091703265657 then
        vu120("Success!\nBlox Fruits Mode ON(2nd)", "\230\136\144\229\138\159\227\129\151\227\129\190\227\129\151\227\129\159\239\188\129\n\227\131\150\227\131\173\227\131\131\227\130\175\227\130\185\227\131\149\227\131\171\227\131\188\227\131\132\227\131\162\227\131\188\227\131\137(\227\130\187\227\130\171\227\131\179\227\131\137)", Color3.fromRGB(255, 255, 255))
        vu123 = {
            Vector3.new(- 287, 305.9, 597.6),
            Vector3.new(2284.9, 14.9, 905.8),
            Vector3.new(923.2, 124.8, 32852.8),
            Vector3.new(- 6508.6, 82, - 132.8)
        }
        v124 = Vector3.new(- 287, 306.5, 597.9)
        v125 = Vector3.new(938, 252.7, 32888)
        vu21 = true
        v122 = "2nd"
    elseif v121 == 7449423635 then
        vu120("Success!\nBlox Fruits Mode ON(3rd)", "\230\136\144\229\138\159\227\129\151\227\129\190\227\129\151\227\129\159\239\188\129\n\227\131\150\227\131\173\227\131\131\227\130\175\227\130\185\227\131\149\227\131\171\227\131\188\227\131\132\227\131\162\227\131\188\227\131\137(\227\130\181\227\131\188\227\131\137)", Color3.fromRGB(255, 255, 255))
        vu123 = {
            Vector3.new(- 12471, 374, - 7554),
            Vector3.new(5659, 1013, - 341),
            Vector3.new(- 5056, 315, - 3180),
            Vector3.new(- 12001, 332, - 8861),
            Vector3.new(5319, 23, - 93),
            Vector3.new(28286, 14897, 103)
        }
        v124 = Vector3.new(- 12471, 374, - 7554)
        v125 = Vector3.new(- 12560, 460, - 7482)
        vu21 = true
        v122 = "3rd"
    end
    local function vu138()
        local v126 = vu70
        local v127, v128, v129 = ipairs(v126:GetChildren())
        while true do
            local v130
            v129, v130 = v127(v128, v129)
            if v129 == nil then
                break
            end
            if v130:IsA("TextButton") then
                v130:Destroy()
            end
        end
        local v131 = vu9
        local v132, v133, v134 = ipairs(v131:GetPlayers())
        while true do
            local vu135
            v134, vu135 = v132(v133, v134)
            if v134 == nil then
                break
            end
            if vu135 ~= vu13 then
                local v136 = Instance.new("TextButton")
                v136.Size = UDim2.new(1, - 10, 0, 30)
                v136.Position = UDim2.new(0, 5, 0, 0)
                v136.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                v136.TextColor3 = Color3.new(1, 1, 1)
                v136.Text = vu135.Name
                v136.Font = Enum.Font.GothamBold
                v136.TextSize = 14
                v136.AutoButtonColor = true
                v136.Parent = vu70
                v136.MouseButton1Click:Connect(function()
                    vu22 = vu135
                    vu69.Text = "Target: " .. vu135.Name
                    vu70.Visible = false
                end)
            end
        end
        local v137 = vu70:FindFirstChildOfClass("UIListLayout")
        if not v137 then
            v137 = Instance.new("UIListLayout")
            v137.Parent = vu70
            v137.SortOrder = Enum.SortOrder.LayoutOrder
            v137.Padding = UDim.new(0, 4)
        end
        vu70.CanvasSize = UDim2.new(0, 0, 0, v137.AbsoluteContentSize.Y)
        vu70.Visible = false
    end
    vu69.MouseButton1Click:Connect(function()
        vu70.Visible = not vu70.Visible
    end)
    local function v150(p139, p140, p141, pu142)
        local v143 = Instance.new("Frame", p139)
        v143.Size = UDim2.new(1, - 10, 0, 30)
        v143.BackgroundTransparency = 0.5
        v143.BackgroundColor3 = Color3.new(0, 0, 0)
        Instance.new("UICorner", v143).CornerRadius = UDim.new(0, 13)
        local v144 = Instance.new("TextLabel", v143)
        v144.Size = UDim2.new(0.6, 0, 1, 0)
        v144.Position = UDim2.new(0, 0, 0, 0)
        v144.BackgroundTransparency = 1
        v144.Text = p140
        v144.TextXAlignment = Enum.TextXAlignment.Left
        v144.Font = Enum.Font.GothamBold
        v144.TextSize = 14
        v144.TextColor3 = Color3.new(1, 1, 1)
        local vu145 = Instance.new("Frame", v143)
        vu145.Size = UDim2.new(0, 50, 0, 24)
        vu145.Position = UDim2.new(1, - 60, 0.5, - 12)
        vu145.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        vu145.BackgroundTransparency = 0.3
        vu145.Name = "SwitchBase"
        Instance.new("UICorner", vu145).CornerRadius = UDim.new(1, 0)
        local vu146 = Instance.new("Frame", vu145)
        vu146.Size = UDim2.new(0, 20, 0, 20)
        vu146.Position = UDim2.new(0, 2, 0.5, - 10)
        vu146.BackgroundColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", vu146).CornerRadius = UDim.new(1, 0)
        local vu147 = p141 or false
        local function vu148()
            if vu147 then
                vu145.BackgroundColor3 = Color3.fromRGB(0, 40, 255)
                vu146:TweenPosition(UDim2.new(1, - 22, 0.5, - 10), "Out", "Quad", 0.2, true)
            else
                vu145.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                vu146:TweenPosition(UDim2.new(0, 2, 0.5, - 10), "Out", "Quad", 0.2, true)
            end
        end
        vu145.InputBegan:Connect(function(p149)
            if p149.UserInputType == Enum.UserInputType.MouseButton1 or p149.UserInputType == Enum.UserInputType.Touch then
                vu147 = not vu147
                vu148()
                if pu142 then
                    pu142(vu147)
                end
            end
        end)
        vu148()
        return v143
    end
    local function v154(p151, p152)
        local v153 = Instance.new("TextButton")
        v153.Size = UDim2.new(1, - 10, 0, 30)
        v153.BackgroundColor3 = Color3.fromRGB(0, 36, 195)
        v153.BackgroundTransparency = 0.3
        v153.TextColor3 = Color3.new(1, 1, 1)
        v153.Text = p152
        v153.Font = Enum.Font.GothamBold
        v153.TextSize = 14
        v153.Parent = p151
        Instance.new("UICorner", v153).CornerRadius = UDim.new(0, 13)
        return v153
    end
    local function v162(p155, p156, p157, pu158)
        local v159 = Instance.new("Frame", p155)
        v159.Size = UDim2.new(1, - 10, 0, 30)
        v159.BackgroundTransparency = 0.5
        v159.BackgroundColor3 = Color3.new(0, 0, 0)
        Instance.new("UICorner", v159).CornerRadius = UDim.new(0, 13)
        local v160 = Instance.new("TextLabel", v159)
        v160.Size = UDim2.new(0.6, 0, 1, 0)
        v160.Position = UDim2.new(0, 0, 0, 0)
        v160.BackgroundTransparency = 1
        v160.Text = p156
        v160.TextXAlignment = Enum.TextXAlignment.Left
        v160.Font = Enum.Font.GothamBold
        v160.TextSize = 14
        v160.TextColor3 = Color3.new(1, 1, 1)
        local vu161 = Instance.new("TextBox", v159)
        vu161.Size = UDim2.new(0, 50, 0, 24)
        vu161.Position = UDim2.new(1, - 60, 0.5, - 12)
        vu161.BackgroundColor3 = Color3.fromRGB(176, 176, 176)
        vu161.BackgroundTransparency = 0.3
        vu161.Text = p157 or ""
        vu161.Font = Enum.Font.GothamBold
        vu161.TextSize = 14
        vu161.TextColor3 = Color3.new(1, 1, 1)
        vu161.PlaceholderText = "enter..."
        vu161.ClearTextOnFocus = false
        Instance.new("UICorner", vu161).CornerRadius = UDim.new(1, 0)
        vu161.FocusLost:Connect(function()
            if pu158 then
                pu158(vu161.Text)
            end
        end)
        return v159
    end
    local vu163 = v154(vu65, "Refresh")
    vu163.MouseButton1Click:Connect(function()
        vu138()
    end)
    local function vu173()
        local v164 = vu13.Character
        if not (v164 and v164:FindFirstChild("HumanoidRootPart")) then
            return nil
        end
        local v165 = v164.HumanoidRootPart
        local v166 = math.huge
        local v167, v168, v169 = ipairs(workspace.Boats:GetDescendants())
        local v170 = nil
        while true do
            local v171
            v169, v171 = v167(v168, v169)
            if v169 == nil then
                break
            end
            if v171:IsA("VehicleSeat") then
                local v172 = (v171.Position - v165.Position).Magnitude
                if v172 < v166 then
                    v170 = v171
                    v166 = v172
                end
            end
        end
        return v170
    end
    local vu174 = v154(vu65, "Take Ship")
    vu174.MouseButton1Click:Connect(function()
        if vu22 and (vu22.Character or not vu21) then
            local v175 = vu173()
            if v175 and (v175.Occupant and v175.Occupant.Parent == vu13.Character) then
                local v176 = v175.Parent
                local v177 = v176 and v176:FindFirstChildWhichIsA("Seat")
                if v177 then
                    local v178 = v175.CFrame:ToObjectSpace(v177.CFrame)
                    local v179 = vu22.Character:FindFirstChild("HumanoidRootPart")
                    if v179 then
                        local v180 = v179.CFrame * v178:Inverse()
                        local v181 = vu13.Character
                        if v181 and v181:FindFirstChild("HumanoidRootPart") then
                            v181.HumanoidRootPart.CFrame = v180
                        end
                    end
                end
            end
        end
    end)
    local function vu188(pu182)
        if pu182.Character and pu182.Character:FindFirstChild("Head") then
            if not pu182.Character.Head:FindFirstChild("ESP") then
                local v183 = Instance.new("BillboardGui")
                v183.Name = "ESP"
                v183.Size = UDim2.new(0, 160, 0, 30)
                v183.StudsOffset = Vector3.new(0, 3, 0)
                v183.AlwaysOnTop = true
                v183.Adornee = pu182.Character.Head
                local vu184 = Instance.new("TextLabel", v183)
                vu184.AnchorPoint = Vector2.new(0.5, 0.5)
                vu184.Position = UDim2.new(0.5, 0, 0.5, 0)
                vu184.Size = UDim2.new(1, 0, 1, 0)
                vu184.BackgroundTransparency = 1
                vu184.TextColor3 = Color3.new(1, 0, 0)
                vu184.TextStrokeTransparency = 0.5
                vu184.Font = Enum.Font.Michroma
                vu184.TextScaled = true
                vu184.RichText = true
                v183.Parent = pu182.Character.Head
                local vu185 = pu182.Character:FindFirstChild("Humanoid")
                local function v187()
                    local v186 = not (vu13.Character and (vu13.Character:FindFirstChild("HumanoidRootPart") and vu185)) and 0 or (vu13.Character.HumanoidRootPart.Position - pu182.Character.HumanoidRootPart.Position).Magnitude
                    vu184.Text = string.format("<font color=\'rgb(255,255,255)\'>%s</font> <font color=\'rgb(0,255,0)\'> %.0f m </font>\n<font color=\'rgb(0,255,255)\'>[%d / %d]</font>", pu182.Name, v186, math.floor(vu185.Health), vu185.MaxHealth)
                end
                v187()
                vu55[pu182] = {
                    vu185.HealthChanged:Connect(v187),
                    vu11.RenderStepped:Connect(v187)
                }
            end
        else
            return
        end
    end
    local function vu193(p189, p190)
        if p189.Character and p189.Character:FindFirstChild("HumanoidRootPart") then
            local v191 = p189.Character.HumanoidRootPart
            if not v191:FindFirstChild("BoxESP") then
                local v192 = Instance.new("BoxHandleAdornment")
                v192.Name = "BoxESP"
                v192.Size = p190 and Vector3.new(45, 35, 0.1) or Vector3.new(4, 7, 2)
                v192.Color3 = p190 and Color3.new(0.4, 0.4, 0.4) or Color3.new(0, 0, 1)
                v192.Transparency = 0.5
                v192.AlwaysOnTop = true
                v192.ZIndex = 5
                v192.Adornee = v191
                v192.Parent = v191
            end
        else
            return
        end
    end
    task.spawn(function()
        while task.wait(0.1) do
            local vu194 = false
            local function v195()
                vu194 = true
            end
            if vu13.Character and vu13.Character:FindFirstChild("HumanoidRootPart") then
                local v196, v197 = vu16:WorldToViewportPoint(vu13.Character.HumanoidRootPart.Position)
                local v198 = vu9
                local v199, v200, v201 = ipairs(v198:GetPlayers())
                while true do
                    local v202
                    v201, v202 = v199(v200, v201)
                    if v201 == nil then
                        break
                    end
                    if v202 ~= vu13 then
                        local v203 = v202.Character
                        if v203 and (v203:FindFirstChild("HumanoidRootPart") and v203:FindFirstChild("Head")) then
                            local v204 = v203.HumanoidRootPart
                            local v205 = v203.Head
                            local v206 = v203:FindFirstChild("Humanoid")
                            if v206 and v206.Health <= 0 then
                                if v205:FindFirstChild("ESP") then
                                    v205.ESP:Destroy()
                                end
                                if v204:FindFirstChild("BoxESP") then
                                    v204.BoxESP:Destroy()
                                end
                                if vu54[v202] then
                                    vu54[v202]:Remove()
                                    vu54[v202] = nil
                                end
                                v195()
                            end
                            if vu29 then
                                vu188(v202)
                            end
                            if vu30 then
                                vu193(v202, false)
                            end
                            if vu31 then
                                vu193(v202, true)
                            end
                            if vu32 then
                                if not vu54[v202] then
                                    local v207 = Drawing.new("Line")
                                    v207.Thickness = 2
                                    v207.Color = Color3.fromRGB(222, 225, 255)
                                    vu54[v202] = v207
                                end
                                local v208, v209 = vu16:WorldToViewportPoint(v204.Position)
                                local v210 = vu54[v202]
                                if v197 and v209 then
                                    v210.From = Vector2.new(v196.X, v196.Y)
                                    v210.To = Vector2.new(v208.X, v208.Y)
                                    v210.Visible = true
                                else
                                    v210.Visible = false
                                end
                            elseif vu54[v202] then
                                vu54[v202]:Remove()
                                vu54[v202] = nil
                            end
                        end
                    end
                end
            end
            if vu194 then
                break
            end
        end
    end)
    local vu227 = v150(vu83, "Name ESP", false, function(p211)
        vu29 = p211
        if p211 then
            local v212 = vu9
            local v213, v214, v215 = ipairs(v212:GetPlayers())
            while true do
                local v216
                v215, v216 = v213(v214, v215)
                if v215 == nil then
                    break
                end
                if v216 ~= vu13 then
                    vu188(v216)
                end
            end
        else
            local v217 = vu9
            local v218, v219, v220 = ipairs(v217:GetPlayers())
            while true do
                local v221
                v220, v221 = v218(v219, v220)
                if v220 == nil then
                    break
                end
                if v221.Character and v221.Character:FindFirstChild("Head") then
                    local v222 = v221.Character.Head:FindFirstChild("ESP")
                    if vu55[v221] then
                        local v223, v224, v225 = ipairs(vu55[v221])
                        while true do
                            local v226
                            v225, v226 = v223(v224, v225)
                            if v225 == nil then
                                break
                            end
                            v226:Disconnect()
                        end
                        vu55[v221] = nil
                    end
                    if v222 then
                        v222:Destroy()
                    end
                end
            end
        end
    end)
    local vu240 = v150(vu83, "Box ESP V1", false, function(p228)
        vu30 = p228
        if p228 then
            vu31 = false
            local v229 = vu9
            local v230, v231, v232 = ipairs(v229:GetPlayers())
            while true do
                local v233
                v232, v233 = v230(v231, v232)
                if v232 == nil then
                    break
                end
                if v233 ~= vu13 then
                    vu193(v233, false)
                end
            end
        else
            local v234 = vu9
            local v235, v236, v237 = ipairs(v234:GetPlayers())
            while true do
                local v238
                v237, v238 = v235(v236, v237)
                if v237 == nil then
                    break
                end
                if v238.Character and v238.Character:FindFirstChild("HumanoidRootPart") then
                    local v239 = v238.Character.HumanoidRootPart:FindFirstChild("BoxESP")
                    if v239 then
                        v239:Destroy()
                    end
                end
            end
        end
    end)
    local vu253 = v150(vu83, "Box ESP V2", false, function(p241)
        vu31 = p241
        if p241 then
            vu30 = false
            local v242 = vu9
            local v243, v244, v245 = ipairs(v242:GetPlayers())
            while true do
                local v246
                v245, v246 = v243(v244, v245)
                if v245 == nil then
                    break
                end
                if v246 ~= vu13 then
                    vu193(v246, true)
                end
            end
        else
            local v247 = vu9
            local v248, v249, v250 = ipairs(v247:GetPlayers())
            while true do
                local v251
                v250, v251 = v248(v249, v250)
                if v250 == nil then
                    break
                end
                if v251.Character and v251.Character:FindFirstChild("HumanoidRootPart") then
                    local v252 = v251.Character.HumanoidRootPart:FindFirstChild("BoxESP")
                    if v252 then
                        v252:Destroy()
                    end
                end
            end
        end
    end)
    local vu265 = v150(vu83, "Tracer ESP", false, function(p254)
        vu32 = p254
        if p254 then
            local v255 = vu9
            local v256, v257, v258 = ipairs(v255:GetPlayers())
            while true do
                local v259
                v258, v259 = v256(v257, v258)
                if v258 == nil then
                    break
                end
                if v259 ~= vu13 and (not vu54[v259] and v259.Character) and v259.Character:FindFirstChild("HumanoidRootPart") then
                    local v260 = Drawing.new("Line")
                    v260.Thickness = 2
                    v260.Color = Color3.fromRGB(222, 225, 255)
                    vu54[v259] = v260
                end
            end
        else
            local v261, v262, v263 = pairs(vu54)
            while true do
                local v264
                v263, v264 = v261(v262, v263)
                if v263 == nil then
                    break
                end
                if v264 then
                    v264:Remove()
                end
                vu54[v263] = nil
            end
        end
    end)
    local vu267 = v150(vu65, "Move to Target", false, function(p266)
        vu23 = p266
    end)
    local vu269 = v150(vu65, "Tween Mode (TP/Tween)", true, function(p268)
        vu33 = p268
    end)
    local vu271 = v150(vu65, "Cam Lock", false, function(p270)
        vu24 = p270
    end)
    local vu273 = v150(vu65, "Player View", false, function(p272)
        vu25 = p272
    end)
    local vu275 = v150(vu65, "Random Target", false, function(p274)
        vu26 = p274
    end)
    local vu277 = v150(vu65, "Team Check", false, function(p276)
        vu27 = p276
    end)
    local vu279 = v150(vu65, "Random Type (Full/Near)", true, function(p278)
        vu28 = p278
    end)
    local vu281 = v150(vu65, "Wall Check", false, function(p280)
        vu20 = p280
    end)
    local function vu288()
        local v282 = vu9
        local v283, v284, v285 = pairs(v282:GetPlayers())
        while true do
            local v286
            v285, v286 = v283(v284, v285)
            if v285 == nil then
                break
            end
            if v286 ~= game.Players.LocalPlayer and v286.Character and v286.Character:FindFirstChild("HumanoidRootPart") then
                local v287 = v286.Character.HumanoidRootPart
                v287.Size = vu36
                v287.Transparency = vu37 and 0.9 or 1
                v287.BrickColor = BrickColor.new("Really blue")
                v287.Material = Enum.Material.Neon
                v287.CanCollide = false
            end
        end
    end
    local vu290 = v150(v89, "Hitbox Enabled", false, function(p289)
        if p289 then
            vu36 = vu38
        else
            vu36 = Vector3.new(2, 2, 1)
        end
        vu288()
    end)
    local vu293 = v162(v89, "Hitbox Size", "60", function(p291)
        local v292 = tonumber(p291)
        if v292 then
            vu36 = Vector3.new(v292, v292, v292)
            vu38 = Vector3.new(v292, v292, v292)
            vu288()
        end
    end)
    local vu295 = v150(v89, "Hitbox Visible", false, function(p294)
        vu37 = p294
        vu288()
    end)
    local vu303 = v150(v89, "Remove Animation", false, function(p296)
        vu47 = p296
        local v297 = (vu13.Character or vu13.CharacterAdded:Wait()):WaitForChild("Humanoid")
        if p296 then
            local v298, v299, v300 = ipairs(v297:GetPlayingAnimationTracks())
            while true do
                local v301
                v300, v301 = v298(v299, v300)
                if v300 == nil then
                    break
                end
                v301:Stop()
            end
            vu46 = v297.AnimationPlayed:Connect(function(p302)
                p302:Stop()
            end)
        elseif vu46 then
            vu46:Disconnect()
            vu46 = nil
        end
    end)
    vu13.CharacterAdded:Connect(function(p304)
        if vu47 and vu46 then
            vu46:Disconnect()
            vu46 = nil
            vu46 = p304:WaitForChild("Humanoid").AnimationPlayed:Connect(function(p305)
                p305:Stop()
            end)
        end
    end)
    local vu315 = v150(v89, "NoClip", false, function(p306)
        if vu45 then
            vu45:Disconnect()
        end
        if p306 then
            vu45 = vu11.Stepped:Connect(function()
                local v307, v308, v309 = ipairs(game.Players.LocalPlayer.Character:GetDescendants())
                while true do
                    local v310
                    v309, v310 = v307(v308, v309)
                    if v309 == nil then
                        break
                    end
                    if v310:IsA("BasePart") then
                        v310.CanCollide = false
                    end
                end
            end)
        else
            local v311, v312, v313 = ipairs(game.Players.LocalPlayer.Character:GetDescendants())
            while true do
                local v314
                v313, v314 = v311(v312, v313)
                if v313 == nil then
                    break
                end
                if v314:IsA("BasePart") then
                    v314.CanCollide = true
                end
            end
        end
    end)
    local vu316 = {}
    local vu332 = v150(v95, "Remove Lava", false, function(p317)
        if p317 then
            local v318, v319, v320 = ipairs({
                "CircleIsland",
                "GhostShipInterior"
            })
            while true do
                local v321
                v320, v321 = v318(v319, v320)
                if v320 == nil then
                    break
                end
                local v322 = workspace:WaitForChild("Map"):FindFirstChild(v321)
                if v322 then
                    local v323, v324, v325 = ipairs(v322:GetDescendants())
                    while true do
                        local v326
                        v325, v326 = v323(v324, v325)
                        if v325 == nil then
                            break
                        end
                        if v326.Name == "LavaParts" then
                            v326:Destroy()
                            vu120("Lava Removed!", "\227\131\158\227\130\176\227\131\158\227\130\146\229\137\138\233\153\164\227\129\151\227\129\190\227\129\151\227\129\159", Color3.fromRGB(255, 255, 255))
                        end
                    end
                end
                vu316[v321] = v322.ChildAdded:Connect(function(p327)
                    if p327.Name == "LavaParts" then
                        p327:Destroy()
                        vu120("Lava Removed!", "\227\131\158\227\130\176\227\131\158\227\130\146\232\135\170\229\139\149\229\137\138\233\153\164\227\129\151\227\129\190\227\129\151\227\129\159", Color3.fromRGB(255, 255, 255))
                    end
                end)
            end
        else
            local v328, v329, v330 = pairs(vu316)
            while true do
                local v331
                v330, v331 = v328(v329, v330)
                if v330 == nil then
                    break
                end
                vu316[v331]:Disconnect()
            end
            vu120("Lava Removal OFF", "\227\131\158\227\130\176\227\131\158\232\135\170\229\139\149\229\137\138\233\153\164\227\130\146\231\132\161\229\138\185\229\140\150\227\129\151\227\129\190\227\129\151\227\129\159", Color3.fromRGB(255, 255, 255))
        end
    end)
    local vu333 = v154(v87, "Fly Gui")
    vu333.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/iruka-kamone/iruka_hub/refs/heads/main/mendako"))()
    end)
    local vu334 = v154(v93, "PvpCheckList")
    vu334.MouseButton1Click:Connect(function()
        if not vu13.PlayerGui:FindFirstChild("PlayerListGUI") then
            local vu335 = Instance.new("ScreenGui")
            vu335.Name = "PlayerListGUI"
            vu335.ResetOnSpawn = false
            vu335.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            local v336 = Instance.new("Frame")
            v336.Size = UDim2.new(0, 250, 0, 320)
            v336.Position = UDim2.new(0, 20, 0.5, - 160)
            v336.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
            v336.BorderSizePixel = 0
            v336.Active = true
            v336.Draggable = true
            v336.Parent = vu335
            local v337 = Instance.new("TextLabel")
            v337.Size = UDim2.new(0.9, 0, 0, 40)
            v337.Position = UDim2.new(0.05, 0, 0, 0)
            v337.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            v337.Text = "Player Status"
            v337.TextColor3 = Color3.fromRGB(255, 255, 255)
            v337.TextScaled = true
            v337.TextXAlignment = Enum.TextXAlignment.Left
            v337.Font = Enum.Font.SourceSansBold
            v337.Parent = v336
            local v338 = Instance.new("TextButton")
            v338.Size = UDim2.new(0, 25, 0, 25)
            v338.Position = UDim2.new(1, - 35, 0, 10)
            v338.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            v338.Text = "\195\151"
            v338.TextScaled = true
            v338.TextColor3 = Color3.fromRGB(255, 255, 255)
            v338.Font = Enum.Font.SourceSansBold
            v338.Parent = v336
            v338.MouseButton1Click:Connect(function()
                vu335:Destroy()
            end)
            local vu339 = Instance.new("ScrollingFrame")
            vu339.Size = UDim2.new(1, - 10, 1, - 50)
            vu339.Position = UDim2.new(0, 5, 0, 45)
            vu339.CanvasSize = UDim2.new(0, 0, 0, 0)
            vu339.ScrollBarThickness = 6
            vu339.BackgroundTransparency = 1
            vu339.Parent = v336
            local vu340 = Instance.new("UIListLayout")
            vu340.Padding = UDim.new(0, 5)
            vu340.Parent = vu339
            local function vu349(p341)
                if not (p341.Character and p341.Character:FindFirstChild("HumanoidRootPart")) then
                    return false
                end
                local v342 = p341.Character.HumanoidRootPart
                local v343 = workspace:FindFirstChild("_WorldOrigin")
                if v343 then
                    v343 = workspace._WorldOrigin:FindFirstChild("SafeZones")
                end
                if not v343 then
                    return false
                end
                local v344, v345, v346 = ipairs(v343:GetChildren())
                while true do
                    local v347
                    v346, v347 = v344(v345, v346)
                    if v346 == nil then
                        break
                    end
                    local v348 = v347:FindFirstChild("Mesh")
                    if v348 and (v342.Position - v347.Position).Magnitude <= v347.Size.X * v348.Scale.X / 2 then
                        return true
                    end
                end
                return false
            end
            local function vu363()
                local v350 = vu339
                local v351, v352, v353 = pairs(v350:GetChildren())
                while true do
                    local v354
                    v353, v354 = v351(v352, v353)
                    if v353 == nil then
                        break
                    end
                    if v354:IsA("TextButton") then
                        v354:Destroy()
                    end
                end
                local v355, v356, v357 = pairs(game.Players:GetPlayers())
                while true do
                    local v358
                    v357, v358 = v355(v356, v357)
                    if v357 == nil then
                        break
                    end
                    local v359 = Instance.new("TextButton")
                    v359.Size = UDim2.new(1, - 10, 0, 30)
                    v359.TextScaled = true
                    v359.Font = Enum.Font.SourceSansBold
                    v359.TextColor3 = Color3.fromRGB(255, 255, 255)
                    v359.Parent = vu339
                    local v360 = v358:GetAttribute("PvpDisabled")
                    local v361 = vu349(v358)
                    local v362 = (v360 == nil or v360 == false) and ("[ON]" or "[OFF]") or "[OFF]"
                    v359.Text = v358.Name .. " " .. (v361 and "[SAFE]" or "[OUTSIDE]") .. " " .. v362
                    if v360 == true then
                        v359.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
                    elseif v361 then
                        v359.BackgroundColor3 = Color3.fromRGB(40, 40, 160)
                    else
                        v359.BackgroundColor3 = Color3.fromRGB(40, 160, 40)
                    end
                end
                vu339.CanvasSize = UDim2.new(0, 0, 0, vu340.AbsoluteContentSize.Y + 10)
            end
            vu11.Heartbeat:Connect(function()
                vu363()
            end)
            vu363()
        end
    end)
    local vu364 = v154(v87, "FPS Boost")
    vu364.MouseButton1Click:Connect(function()
        local vu365 = true
        local v366 = game
        local v367 = v366.Workspace
        local v368 = v366.Lighting
        local v369 = v367.Terrain
        sethiddenproperty(v368, "Technology", 2)
        sethiddenproperty(v369, "Decoration", false)
        v369.WaterWaveSize = 0
        v369.WaterWaveSpeed = 0
        v369.WaterReflectance = 0
        v369.WaterTransparency = 0
        v368.GlobalShadows = false
        v368.FogEnd = 9000000000
        v368.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"
        local function v371(p370)
            if p370:IsA("Part") or (p370:IsA("Union") or (p370:IsA("CornerWedgePart") or p370:IsA("TrussPart"))) then
                p370.Material = "Plastic"
                p370.Reflectance = 0
            elseif p370:IsA("Decal") or p370:IsA("Texture") and vu365 then
                p370.Transparency = 1
            elseif p370:IsA("ParticleEmitter") or p370:IsA("Trail") then
                p370.Lifetime = NumberRange.new(0)
            elseif p370:IsA("Explosion") then
                p370.BlastPressure = 1
                p370.BlastRadius = 1
            elseif p370:IsA("Fire") or (p370:IsA("SpotLight") or (p370:IsA("Smoke") or p370:IsA("Sparkles"))) then
                p370.Enabled = false
            elseif p370:IsA("MeshPart") then
                p370.Material = "Plastic"
                p370.Reflectance = 0
                p370.TextureID = 1.0385902758728956e16
            end
        end
        local v372, v373, v374 = pairs(v367:GetDescendants())
        while true do
            local v375
            v374, v375 = v372(v373, v374)
            if v374 == nil then
                break
            end
            if v375:IsA("Part") or (v375:IsA("Union") or (v375:IsA("CornerWedgePart") or (v375:IsA("TrussPart") or v375:IsA("MeshPart")))) then
                v371(v375)
            end
        end
        local v376, v377, v378 = pairs(v368:GetChildren())
        while true do
            local v379
            v378, v379 = v376(v377, v378)
            if v378 == nil then
                break
            end
            if v379:IsA("BlurEffect") or (v379:IsA("SunRaysEffect") or (v379:IsA("ColorCorrectionEffect") or (v379:IsA("BloomEffect") or v379:IsA("DepthOfFieldEffect")))) then
                v379.Enabled = false
            end
        end
    end)
    local vu382 = v150(v95, "TP Gui", false, function(p380)
        local v381 = vu13.PlayerGui:FindFirstChild("TPGui")
        if v381 then
            v381.Enabled = p380
        end
    end)
    local function v415(p383, p384, p385, pu386, pu387)
        local vu388 = Instance.new("TextButton")
        vu388.Name = p383
        vu388.Size = UDim2.new(0, 100, 0, 50)
        vu388.Position = p385
        vu388.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        vu388.Text = p384
        vu388.TextScaled = true
        vu388.Font = Enum.Font.SourceSansBold
        vu388.Parent = vu103
        local vu389 = false
        local vu390 = nil
        local vu391 = nil
        local vu392 = nil
        local function vu395(p393)
            local v394 = p393.Position - vu391
            vu388.Position = UDim2.new(vu392.X.Scale, vu392.X.Offset + v394.X, vu392.Y.Scale, vu392.Y.Offset + v394.Y)
        end
        vu388.InputBegan:Connect(function(pu396)
            if pu396.UserInputType == Enum.UserInputType.MouseButton1 or pu396.UserInputType == Enum.UserInputType.Touch then
                vu389 = true
                vu391 = pu396.Position
                vu392 = vu388.Position
                pu396.Changed:Connect(function()
                    if pu396.UserInputState == Enum.UserInputState.End then
                        vu389 = false
                    end
                end)
            end
        end)
        vu388.InputChanged:Connect(function(p397)
            if p397.UserInputType == Enum.UserInputType.MouseMovement or p397.UserInputType == Enum.UserInputType.Touch then
                vu390 = p397
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(p398)
            if p398 == vu390 and vu389 then
                vu395(p398)
            end
        end)
        vu388.MouseButton1Click:Connect(function()
            (vu13.Character or vu13.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(pu386)
            vu23 = false
            local v399 = vu65
            local v400, v401, v402 = ipairs(v399:GetChildren())
            while true do
                local v403
                v402, v403 = v400(v401, v402)
                if v402 == nil then
                    break
                end
                if v403:IsA("Frame") and (v403:FindFirstChild("SwitchBase") and (v403:FindFirstChildOfClass("TextLabel") and v403:FindFirstChildOfClass("TextLabel").Text == "Move to Target")) then
                    local v404 = v403:FindFirstChild("SwitchBase")
                    if v404 then
                        local v405 = v404:FindFirstChildOfClass("Frame")
                        if v405 then
                            v405:TweenPosition(UDim2.new(0, 2, 0.5, - 10), "Out", "Quad", 0.2, true)
                            v404.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        end
                    end
                end
            end
        end)
        game:GetService("UserInputService").InputBegan:Connect(function(p406, p407)
            if not p407 and p406.KeyCode == Enum.KeyCode[pu387] then
                (vu13.Character or vu13.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(pu386)
                vu23 = false
                local v408 = vu65
                local v409, v410, v411 = ipairs(v408:GetChildren())
                while true do
                    local v412
                    v411, v412 = v409(v410, v411)
                    if v411 == nil then
                        break
                    end
                    if v412:IsA("Frame") and (v412:FindFirstChild("SwitchBase") and (v412:FindFirstChildOfClass("TextLabel") and v412:FindFirstChildOfClass("TextLabel").Text == "Move to Target")) then
                        local v413 = v412:FindFirstChild("SwitchBase")
                        if v413 then
                            local v414 = v413:FindFirstChildOfClass("Frame")
                            if v414 then
                                v414:TweenPosition(UDim2.new(0, 2, 0.5, - 10), "Out", "Quad", 0.2, true)
                                v413.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            end
                        end
                    end
                end
            end
        end)
    end
    if vu21 and v122 == "2nd" then
        v415("Dolphin", "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189", UDim2.new(0, 10, 0, 10), v124, "H")
        v415("Anchor", "\226\154\147", UDim2.new(0, 120, 0, 10), v125, "G")
    elseif vu21 and v122 == "3rd" then
        v415("Mansion", "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189", UDim2.new(0, 10, 0, 10), v124, "H")
        v415("Tiki", "\226\154\147", UDim2.new(0, 120, 0, 10), v125, "G")
    end
    local vu416 = v154(v93, "Change Team")
    vu416.MouseButton1Click:Connect(function()
        if vu13.Team.Name ~= "Pirates" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
        else
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
        end
    end)
    local vu418 = v150(v95, "Walk Water", false, function(p417)
        if p417 then
            game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
        else
            game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
        end
    end)
    local vu420 = v150(v95, "Aimbot Enabled", false, function(p419)
        vu35 = p419
    end)
    spawn(function()
        while task.wait() do
            local v421 = vu13.Character
            if not (v421 and v421:FindFirstChild("HumanoidRootPart")) then
                vu34 = nil
                return
            end
            local v422 = v421.HumanoidRootPart.Position
            local v423 = math.huge
            local v424 = vu9
            local v425, v426, v427 = ipairs(v424:GetPlayers())
            local v428 = nil
            while true do
                local v429
                v427, v429 = v425(v426, v427)
                if v427 == nil then
                    break
                end
                if v429 ~= vu13 then
                    local v430 = v429.Character
                    if v430 and v430:FindFirstChild("HumanoidRootPart") then
                        local v431 = (v430.HumanoidRootPart.Position - v422).Magnitude
                        if v431 < v423 then
                            v428 = v430
                            v423 = v431
                        end
                    end
                end
            end
            if v428 then
                vu34 = v428.HumanoidRootPart.Position
            else
                vu34 = nil
            end
        end
    end)
    pcall(function()
        spawn(function()
            local v432 = getrawmetatable(game)
            local vu433 = v432.__namecall
            setreadonly(v432, false)
            v432.__namecall = newcclosure(function(...)
                local v434 = getnamecallmethod()
                local v435 = {
                    ...
                }
                if tostring(v434) ~= "FireServer" or (tostring(v435[1]) ~= "RemoteEvent" or (tostring(v435[2]) == "true" or (tostring(v435[2]) == "false" or not vu35))) then
                    return vu433(...)
                end
                if type(v435[2]) ~= "vector" then
                    v435[2] = CFrame.new(vu34)
                else
                    v435[2] = vu34
                end
                return vu433(unpack(v435))
            end)
        end)
    end)
    local function vu438(p436)
        if not p436 then
            return false
        end
        local v437 = p436:FindFirstChild("Humanoid")
        if v437 then
            v437 = v437.Health > 0
        end
        return v437
    end
    local function vu455(p439, p440)
        local v441 = game:GetService("Workspace").Enemies:GetChildren()
        local v442 = game:GetService("Players"):GetPlayers()
        local v443 = p439:GetPivot().Position
        local v444, v445, v446 = ipairs(v441)
        local v447 = {}
        while true do
            local v448
            v446, v448 = v444(v445, v446)
            if v446 == nil then
                break
            end
            local v449 = v448:FindFirstChild("HumanoidRootPart")
            if v449 and (vu438(v448) and (v449.Position - v443).Magnitude <= p440) then
                table.insert(v447, v448)
            end
        end
        local v450, v451, v452 = ipairs(v442)
        while true do
            local v453
            v452, v453 = v450(v451, v452)
            if v452 == nil then
                break
            end
            if v453 ~= vu13 and v453.Character then
                local v454 = v453.Character:FindFirstChild("HumanoidRootPart")
                if v454 and (vu438(v453.Character) and (v454.Position - v443).Magnitude <= p440) then
                    table.insert(v447, v453.Character)
                end
            end
        end
        return v447
    end
    local function vu481()
        local v456 = vu13.Character
        local v457 = v456:FindFirstChild("HumanoidRootPart")
        if not v457 then
            return
        end
        local v458, v459, v460 = ipairs(v456:GetChildren())
        local v461 = nil
        while true do
            local v462
            v460, v462 = v458(v459, v460)
            if v460 == nil then
                v462 = v461
                break
            end
            if v462:IsA("Tool") then
                break
            end
        end
        if v462 then
            if v457:FindFirstChild("Buddha") and vu44 then
                vu43 = 1000
            else
                vu43 = 60
            end
            local v463 = vu455(v456, vu43)
            if v462:FindFirstChild("LeftClickRemote") then
                local v464, v465, v466 = ipairs(v463)
                local v467 = 1
                while true do
                    local v468, v469 = v464(v465, v466)
                    if v468 == nil then
                        break
                    end
                    v466 = v468
                    local v470 = v469:FindFirstChild("HumanoidRootPart")
                    if v470 then
                        local v471 = (v470.Position - v456:GetPivot().Position).Unit
                        v462.LeftClickRemote:FireServer(v471, v467)
                        v467 = v467 + 1
                    end
                end
            else
                local v472, v473, v474 = ipairs(v463)
                local vu475 = {}
                local vu476 = nil
                while true do
                    local v477
                    v474, v477 = v472(v473, v474)
                    if v474 == nil then
                        break
                    end
                    if not v477:GetAttribute("IsBoat") then
                        local v478 = v477:FindFirstChild("Head")
                        if v478 then
                            table.insert(vu475, {
                                v477,
                                v478
                            })
                            vu476 = v478
                        end
                    end
                end
                if vu476 then
                    local vu479 = vu12:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
                    local vu480 = vu12:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
                    pcall(function()
                        vu479:FireServer(0.4)
                        vu480:FireServer(vu476, vu475)
                    end)
                end
            end
        end
    end
    local vu482 = false
    task.spawn(function()
        while task.wait(0.1) do
            if vu482 then
                vu481()
            end
        end
    end)
    local vu484 = v150(v95, "Fast Attack", false, function(p483)
        vu482 = p483
    end)
    local vu486 = v150(v95, "Super Range(Buddha Only)", false, function(p485)
        vu44 = p485
    end)
    local vu487 = nil
    local function vu490()
        local v488 = vu13.Character
        local vu489 = v488 and v488:FindFirstChildOfClass("Humanoid")
        if vu489 then
            if vu40 and vu39 then
                if vu487 then
                    vu487:Disconnect()
                end
                vu489.WalkSpeed = vu39
                vu487 = vu489:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                    if vu40 then
                        vu489.WalkSpeed = vu39
                    end
                end)
            else
                vu489.WalkSpeed = 16
                if vu487 then
                    vu487:Disconnect()
                end
            end
        end
    end
    local vu492 = v150(v89, "Speed Hack", false, function(p491)
        vu40 = p491
        vu490()
    end)
    local vu495 = v162(v89, "Speed Value", "16", function(p493)
        local v494 = tonumber(p493)
        if v494 and 0 <= v494 then
            vu39 = v494
            vu490()
        end
    end)
    local vu496 = nil
    local function vu499()
        local v497 = vu13.Character
        local vu498 = v497 and v497:FindFirstChildOfClass("Humanoid")
        if vu498 then
            if vu42 and vu41 then
                if vu496 then
                    vu496:Disconnect()
                end
                vu498.UseJumpPower = true
                vu498.JumpPower = vu41
                print(vu41)
                vu496 = vu498:GetPropertyChangedSignal("JumpPower"):Connect(function()
                    if vu42 then
                        vu498.JumpPower = vu41
                    end
                end)
            else
                vu498.JumpPower = 50
                if vu496 then
                    vu496:Disconnect()
                end
            end
        end
    end
    local vu501 = v150(v89, "Jump Hack", false, function(p500)
        vu42 = p500
        vu499()
    end)
    local vu504 = v162(v89, "Jump Value", "50", function(p502)
        local v503 = tonumber(p502)
        if v503 and 0 <= v503 then
            vu41 = v503
            vu499()
        end
    end)
    local vu510 = v150(v89, "Stats Gui", false, function(p505)
        vu104.Enabled = p505
        vu11.Heartbeat:Connect(function()
            vu52 = vu52 + 1
            local v506 = tick()
            if v506 - vu51 >= 1 then
                vu53 = vu52 / (v506 - vu51)
                vu52 = 0
                vu51 = v506
            end
            local v507 = vu13.Character and (vu13.Character:FindFirstChild("HumanoidRootPart") and vu13.Character.HumanoidRootPart.Position) or Vector3.new(0, 0, 0)
            local v508 = vu13
            local v509 = math.floor(v508:GetNetworkPing() * 1000)
            vu106.Text = string.format("FPS: %d | Ping: %dms | POS: (%.1f, %.1f, %.1f)", vu53, v509, v507.X, v507.Y, v507.Z)
        end)
    end)
    local vu511 = v154(v93, "Fightings Shop Gui(not working)")
    vu511.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/iruka-kamone/iruka_hub/refs/heads/main/sirokuma"))()
    end)
    local vu512 = v154(v93, "Raid Kill Aura Gui")
    vu512.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/iruka-kamone/iruka_hub/refs/heads/main/azarasi"))()
    end)
    local vu513 = v154(v93, "Fix CameraShake")
    vu513.MouseButton1Click:Connect(function()
        local v514 = vu12:WaitForChild("Util", 5)
        local v515 = v514 and v514:FindFirstChild("CameraShaker")
        if v515 then
            require(v515):Stop()
        end
    end)
    task.spawn(function()
        while true do
            task.wait(0.1)
            pcall(function()
                if vu48 then
                    game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
                end
            end)
        end
    end)
    local vu517 = v150(v95, "Auto V3", false, function(p516)
        vu48 = p516
    end)
    task.spawn(function()
        local v518 = 0
        while true do
            repeat
                task.wait(0.1)
            until vu49
            local v519 = tick()
            if v519 - v518 >= 0.5 then
                local v520 = game.Players.LocalPlayer.Character
                if v520 and (v520:FindFirstChild("RaceEnergy") and (v520.RaceEnergy.Value >= 1 and not v520.RaceTransformed.Value)) then
                    local v521 = game:GetService("VirtualInputManager")
                    v521:SendKeyEvent(true, "Y", false, game)
                    task.wait(0.1)
                    v521:SendKeyEvent(false, "Y", false, game)
                    v518 = v519
                else
                    v518 = v519
                end
            end
        end
    end)
    local vu523 = v150(v95, "Auto V4", false, function(p522)
        vu49 = p522
    end)
    if not vu21 then
        local v524, v525, v526 = ipairs({
            vu174,
            vu332,
            vu382,
            vu420,
            vu511,
            vu512,
            vu484,
            vu486,
            vu513,
            vu416,
            vu418,
            vu517,
            vu523,
            vu334
        })
        while true do
            local v527, v528 = v524(v525, v526)
            if v527 == nil then
                break
            end
            v526 = v527
            if v528:FindFirstChild("SwitchBase") then
                v528.SwitchBase.Visible = false
                v528.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                v528.Active = false
                v528.TextLabel.Text = "Bloxfruits only"
                v528.TextLabel.TextTransparency = 0.5
            else
                v528.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                v528.Active = false
                v528.Text = "Bloxfruits only"
                v528.TextTransparency = 0.5
            end
        end
    end
    local vu529 = {
        "Head",
        "Torso",
        "Legs"
    }
    local vu530 = "Head"
    local v531 = Instance.new("Frame", vu65)
    v531.Size = UDim2.new(1, - 10, 0, 40)
    v531.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    v531.BackgroundTransparency = 0.3
    Instance.new("UICorner", v531).CornerRadius = UDim.new(0, 8)
    local vu532 = Instance.new("TextLabel", v531)
    vu532.Size = UDim2.new(1, - 20, 1, 0)
    vu532.Position = UDim2.new(0, 10, 0, 0)
    vu532.BackgroundTransparency = 1
    vu532.Text = "Look Part: " .. vu530
    vu532.Font = Enum.Font.GothamBold
    vu532.TextSize = 14
    vu532.TextColor3 = Color3.new(1, 1, 1)
    vu532.TextXAlignment = Enum.TextXAlignment.Left
    v531.InputBegan:Connect(function(p533)
        if p533.UserInputType == Enum.UserInputType.MouseButton1 or p533.UserInputType == Enum.UserInputType.Touch then
            vu530 = vu529[table.find(vu529, vu530) % # vu529 + 1]
            vu532.Text = "Look Part: " .. vu530
            vu15 = vu530
        end
    end)
    local v534 = vu66
    vu66.GetPropertyChangedSignal(v534, "AbsoluteContentSize"):Connect(function()
        vu65.CanvasSize = UDim2.new(0, 0, 0, vu66.AbsoluteContentSize.Y + 20)
    end)
    vu65.CanvasSize = UDim2.new(0, 0, 0, vu66.AbsoluteContentSize.Y + 40)
    local function vu540(p535)
        if not (p535.Character and p535.Character:FindFirstChild("HumanoidRootPart")) then
            return false
        end
        if not (vu13.Character and vu13.Character:FindFirstChild("HumanoidRootPart")) then
            return false
        end
        local v536 = vu13.Character.HumanoidRootPart.Position
        local v537
        if vu15 ~= "Head" or not p535.Character:FindFirstChild("Head") then
            if vu15 ~= "Torso" or not p535.Character:FindFirstChild("HumanoidRootPart") then
                if vu15 ~= "Legs" or not p535.Character:FindFirstChild("HumanoidRootPart") then
                    v537 = p535.Character.HumanoidRootPart.Position
                else
                    v537 = p535.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
                end
            else
                v537 = p535.Character.HumanoidRootPart.Position
            end
        else
            v537 = p535.Character.Head.Position
        end
        local v538 = v537 - v536
        local v539 = RaycastParams.new()
        v539.FilterDescendantsInstances = {
            vu13.Character,
            p535.Character
        }
        v539.FilterType = Enum.RaycastFilterType.Blacklist
        return not workspace:Raycast(v536, v538, v539)
    end
    local function vu552()
        local v541 = vu9
        local v542, v543, v544 = ipairs(v541:GetPlayers())
        local v545 = {}
        while true do
            local v546
            v544, v546 = v542(v543, v544)
            if v544 == nil then
                break
            end
            if v546 ~= vu13 and v546.Character and (v546.Character:FindFirstChild("Humanoid") and (v546.Character.Humanoid.Health > 0 and (vu27 or (not vu13.Team or v546.Team ~= vu13.Team))) and (not vu20 or vu540(v546))) then
                table.insert(v545, v546)
            end
        end
        if # v545 ~= 0 then
            if vu28 then
                table.sort(v545, function(p547, p548)
                    if not (p547.Character and p547.Character:FindFirstChild("HumanoidRootPart")) then
                        return false
                    end
                    if not (p548.Character and p548.Character:FindFirstChild("HumanoidRootPart")) then
                        return true
                    end
                    local v549 = p547.Character.HumanoidRootPart.Position
                    local v550 = p548.Character.HumanoidRootPart.Position
                    local v551 = vu13.Character and (vu13.Character:FindFirstChild("HumanoidRootPart") and vu13.Character.HumanoidRootPart.Position) or Vector3.new()
                    return (v549 - v551).Magnitude < (v550 - v551).Magnitude
                end)
                vu22 = v545[1]
            else
                if vu22 and vu22.Character and (vu22.Character:FindFirstChild("Humanoid") and vu22.Character.Humanoid.Health > 0) then
                    return
                end
                vu22 = v545[math.random(1, # v545)]
            end
            if vu22 then
                vu69.Text = "Target: " .. vu22.Name
            end
        else
            vu22 = nil
            vu69.Text = "Select Player"
        end
    end
    vu138()
    v63.MouseButton1Click:Connect(function()
        local vu553 = Instance.new("Frame")
        vu553.Size = UDim2.new(0, 250, 0, 120)
        vu553.Position = UDim2.new(0.5, - 125, 0.5, - 60)
        vu553.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        vu553.BorderSizePixel = 0
        vu553.Parent = vu59
        vu553.ZIndex = 10
        local v554 = Instance.new("TextLabel", vu553)
        v554.Size = UDim2.new(1, - 20, 0, 50)
        v554.Position = UDim2.new(0, 10, 0, 10)
        v554.BackgroundTransparency = 1
        v554.Text = "Really Close?"
        v554.TextColor3 = Color3.new(1, 1, 1)
        v554.Font = Enum.Font.GothamBold
        v554.TextSize = 18
        v554.TextWrapped = true
        v554.ZIndex = 11
        local v555 = Instance.new("TextButton", vu553)
        v555.Size = UDim2.new(0.4, 0, 0, 40)
        v555.Position = UDim2.new(0.05, 0, 0.6, 0)
        v555.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        v555.TextColor3 = Color3.new(1, 1, 1)
        v555.Text = "Yes"
        v555.Font = Enum.Font.GothamBold
        v555.TextSize = 16
        v555.ZIndex = 11
        local v556 = Instance.new("TextButton", vu553)
        v556.Size = UDim2.new(0.4, 0, 0, 40)
        v556.Position = UDim2.new(0.55, 0, 0.6, 0)
        v556.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        v556.TextColor3 = Color3.new(1, 1, 1)
        v556.Text = "No"
        v556.Font = Enum.Font.GothamBold
        v556.TextSize = 16
        v556.ZIndex = 11
        v555.MouseButton1Click:Connect(function()
            vu59:Destroy()
            vu58()
        end)
        v556.MouseButton1Click:Connect(function()
            vu553:Destroy()
        end)
    end)
    local function vu560(p557)
        if vu13.Character then
            local v558 = vu13.Character:FindFirstChild("HumanoidRootPart")
            if v558 then
                if not (vu17 and vu17.Parent) then
                    vu57(v558.Position - Vector3.new(0, 2.5, 0))
                end
                if vu18 then
                    vu18:Cancel()
                    vu18 = nil
                end
                if vu33 then
                    local v559 = (p557 - vu17.Position).Magnitude / vu14
                    vu18 = vu10:Create(vu17, TweenInfo.new(v559, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Position = p557
                    })
                    if vu17 and (vu17.Parent and v558.Parent) then
                        v558.CFrame = CFrame.new(vu17.Position + Vector3.new(0, 2.5, 0))
                    end
                    vu18:Play()
                else
                    v558.CFrame = CFrame.new(p557 + Vector3.new(0, 2.5, 0))
                end
            end
        else
            return
        end
    end
    local function vu569(p561)
        local v562 = math.huge
        local v563, v564, v565 = ipairs(vu123)
        local v566 = nil
        while true do
            local v567
            v565, v567 = v563(v564, v565)
            if v565 == nil then
                break
            end
            local v568 = (p561 - v567).Magnitude
            if v568 < v562 then
                v566 = v567
                v562 = v568
            end
        end
        return v566, v562
    end
    vu11.Heartbeat:Connect(function()
        local v570 = workspace.CurrentCamera
        if vu25 and (vu22 and vu22.Character) and vu22.Character:FindFirstChild("Humanoid") then
            v570.CameraSubject = vu22.Character:FindFirstChild("Humanoid")
        elseif vu24 and (vu22 and vu22.Character) then
            local v571 = nil
            if vu15 ~= "Head" or not vu22.Character:FindFirstChild("Head") then
                if vu15 ~= "Torso" or not vu22.Character:FindFirstChild("HumanoidRootPart") then
                    if vu15 == "Legs" and vu22.Character:FindFirstChild("HumanoidRootPart") then
                        v571 = vu22.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
                    end
                else
                    v571 = vu22.Character.HumanoidRootPart.Position
                end
            else
                v571 = vu22.Character.Head.Position
            end
            if v571 then
                v570.CFrame = CFrame.new(v570.CFrame.Position, v571)
            end
        elseif vu9.LocalPlayer.Character and vu9.LocalPlayer.Character:FindFirstChild("Head") then
            v570.CameraSubject = vu9.LocalPlayer.Character:FindFirstChild("Humanoid")
        end
    end)
    local vu572 = nil
    vu11.Heartbeat:Connect(function()
        if vu26 and vu28 then
            vu552()
        end
        if vu23 and (vu22 and vu22.Character) and vu22.Character:FindFirstChild("HumanoidRootPart") then
            local v573 = vu13.Character
            if v573 then
                v573 = vu13.Character:FindFirstChild("HumanoidRootPart")
            end
            if v573 then
                local v574 = vu22.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
                local v575 = (v573.Position - v574).Magnitude
                if vu21 then
                    local v576, v577 = vu569(v574)
                    if v576 and v577 < (v573.Position - v574).Magnitude then
                        v573.CFrame = CFrame.new(v576)
                        vu58()
                        vu560(v574)
                        vu572 = v575
                        return
                    end
                    if vu572 and v575 - vu572 > 2000 then
                        if v576 and v577 < (v573.Position - v574).Magnitude then
                            v573.CFrame = CFrame.new(v576)
                            vu58()
                            vu560(v574)
                            vu572 = v575
                        else
                            vu58()
                            vu23 = false
                            vu572 = nil
                        end
                    end
                end
                vu560(v574)
                vu572 = v575
            end
        else
            vu58()
            vu572 = nil
        end
    end)
    local vu578 = nil
    vu578 = v150(v101, "Change Language(En/Jp)", false, function(p579)
        vu50 = p579
        vu78.Text = vu50 and "\227\131\161\227\130\164\227\131\179" or "Home"
        vu79.Text = vu50 and "ESP" or "ESP"
        vu80.Text = vu50 and "\227\129\157\227\129\174\228\187\150" or "Other"
        vu81.Text = vu50 and "BL" or "BF"
        vu82.Text = vu50 and "\232\168\173\229\174\154" or "Config"
        vu69.Text = vu50 and "\227\130\191\227\131\188\227\130\178\227\131\131\227\131\136\233\129\184\230\138\158" or "Select Player"
        vu163.Text = vu50 and "\227\131\151\227\131\172\227\130\164\227\131\164\227\131\188\230\155\180\230\150\176" or "Refresh"
        vu174.Text = vu50 and "\232\136\185\227\129\171\233\128\163\227\130\140\227\129\166\227\129\132\227\129\143" or "Take Ship"
        vu333.Text = vu50 and "\233\163\155\232\161\140\227\131\156\227\130\191\227\131\179" or "Fly Gui"
        vu364.Text = vu50 and "\232\187\189\233\135\143\229\140\150" or "FPS Boost"
        vu416.Text = vu50 and "\227\131\129\227\131\188\227\131\160\229\164\137\230\155\180" or "Change Team"
        vu511.Text = vu50 and "\230\160\188\233\151\152\227\130\183\227\131\167\227\131\131\227\131\151" or "Fightings Shop Gui"
        vu512.Text = vu50 and "\227\131\172\227\130\164\227\131\137\232\135\170\229\139\149" or "Raid Kill Aura Gui"
        vu513.Text = vu50 and "\227\130\171\227\131\161\227\131\169\227\129\174\230\143\186\227\130\140\231\132\161\229\138\185" or "Fix CameraShake"
        vu109.Text = vu50 and "\227\130\185\227\131\148\227\131\188\227\131\137:" or "Speed:"
        vu293.TextLabel.Text = vu50 and "\227\131\146\227\131\131\227\131\136\227\131\156\227\131\131\227\130\175\227\130\185\227\130\181\227\130\164\227\130\186" or "Hitbox Size"
        vu495.TextLabel.Text = vu50 and "\227\130\185\227\131\148\227\131\188\227\131\137" or "Speed Value"
        vu504.TextLabel.Text = vu50 and "\227\130\184\227\131\163\227\131\179\227\131\151\229\138\155" or "Jump Value"
        vu227.TextLabel.Text = vu50 and "\229\144\141\229\137\141ESP" or "Name ESP"
        vu240.TextLabel.Text = vu50 and "\227\131\156\227\131\131\227\130\175\227\130\185ESPV1" or "Box ESP V1"
        vu253.TextLabel.Text = vu50 and "\227\131\156\227\131\131\227\130\175\227\130\185ESPV2" or "Box ESP V2"
        vu265.TextLabel.Text = vu50 and "\227\131\136\227\131\169\227\131\131\227\130\171\227\131\188ESP" or "Tracer ESP"
        vu267.TextLabel.Text = vu50 and "\232\191\189\229\176\190" or "Move to Target"
        vu269.TextLabel.Text = vu50 and "\232\191\189\229\176\190\227\131\162\227\131\188\227\131\137(\227\131\134\227\131\172\227\131\157\227\131\188\227\131\136/Tweem)" or "Tween Mode (TP/Tween)"
        vu271.TextLabel.Text = vu50 and "\227\130\171\227\131\161\227\131\169\227\131\173\227\131\131\227\130\175" or "Cam Lock"
        vu273.TextLabel.Text = vu50 and "\232\166\179\230\136\166" or "Player View"
        vu275.TextLabel.Text = vu50 and "\227\131\169\227\131\179\227\131\128\227\131\160\227\130\191\227\131\188\227\130\178\227\131\131\227\131\136" or "Random Target"
        vu277.TextLabel.Text = vu50 and "\227\131\129\227\131\188\227\131\160\231\162\186\232\170\141" or "Team Check"
        vu279.TextLabel.Text = vu50 and "\227\131\169\227\131\179\227\131\128\227\131\160\227\131\162\227\131\188\227\131\137(\227\130\181\227\131\188\227\131\144\227\131\188/\232\191\145\227\129\132\233\160\134)" or "Random Type (Full/Near)"
        vu281.TextLabel.Text = vu50 and "\229\163\129\231\162\186\232\170\141" or "Wall Check"
        vu290.TextLabel.Text = vu50 and "\227\131\146\227\131\131\227\131\136\227\131\156\227\131\131\227\130\175\227\130\185\230\156\137\229\138\185\229\140\150" or "Hitbox Enabled"
        vu295.TextLabel.Text = vu50 and "\227\131\146\227\131\131\227\131\136\227\131\156\227\131\131\227\130\175\227\130\185\232\161\168\231\164\186" or "Hitbox Visible"
        vu303.TextLabel.Text = vu50 and "\227\130\162\227\131\139\227\131\161\227\131\188\227\130\183\227\131\167\227\131\179\231\132\161\229\138\185" or "Remove Animation"
        vu315.TextLabel.Text = vu50 and "\229\163\129\230\138\156\227\129\145" or "NoClip"
        vu332.TextLabel.Text = vu50 and "\227\131\158\227\130\176\227\131\158\231\132\161\229\138\185" or "Remove Lava"
        vu382.TextLabel.Text = vu50 and "\227\131\134\227\131\172\227\131\157\227\131\188\227\131\136\227\131\156\227\130\191\227\131\179" or "TP Gui"
        vu418.TextLabel.Text = vu50 and "\230\176\180\227\129\174\228\184\138\227\130\146\230\173\169\227\129\143" or "Walk Water"
        vu420.TextLabel.Text = vu50 and "\227\130\170\227\131\188\227\131\136\227\130\168\227\130\164\227\131\160\230\156\137\229\138\185\229\140\150" or "Aimbot Enabled"
        vu484.TextLabel.Text = vu50 and "\227\131\149\227\130\161\227\130\185\227\131\136\227\130\162\227\130\191\227\131\131\227\130\175" or "Fast Attack"
        vu486.TextLabel.Text = vu50 and "\230\174\180\227\130\138\231\175\132\229\155\178\232\182\133\230\139\161\229\164\167(\229\164\167\228\187\143\227\129\174\227\129\191)" or "Super Range(Buddha Only)"
        vu492.TextLabel.Text = vu50 and "\227\130\185\227\131\148\227\131\188\227\131\137\229\164\137\230\155\180" or "Speed Hack"
        vu501.TextLabel.Text = vu50 and "\227\130\184\227\131\163\227\131\179\227\131\151\227\131\145\227\131\175\227\131\188\229\164\137\230\155\180" or "Jump Hack"
        vu510.TextLabel.Text = vu50 and "\227\130\185\227\131\134\227\131\188\227\130\191\227\130\185\232\161\168\231\164\186" or "Stats Gui"
        vu578.TextLabel.Text = vu50 and "\232\139\177\232\170\158\227\129\171\229\164\137\230\155\180" or "Change To Japanese"
        if not vu21 then
            local v580 = {
                vu174,
                vu332,
                vu382,
                vu420,
                vu511,
                vu512,
                vu484,
                vu486,
                vu513,
                vu416,
                vu418,
                vu517,
                vu523,
                vu334
            }
            local v581, v582, v583 = ipairs(v580)
            while true do
                local v584
                v583, v584 = v581(v582, v583)
                if v583 == nil then
                    break
                end
                if v584:FindFirstChild("SwitchBase") then
                    v584.TextLabel.Text = vu50 and "\227\131\150\227\131\173\227\131\131\227\130\175\227\130\185\227\131\149\227\131\171\227\131\188\227\131\132\233\153\144\229\174\154" or "Bloxfruits only"
                else
                    v584.Text = vu50 and "\227\131\150\227\131\173\227\131\131\227\130\175\227\130\185\227\131\149\227\131\171\227\131\188\227\131\132\233\153\144\229\174\154" or "Bloxfruits only"
                end
            end
        end
    end)
    task.spawn(function()
        while wait(0.1) do
            if getgenv().AntiAFK then
                local vu585 = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:connect(function()
                    vu585:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    wait(1)
                    vu585:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                end)
            end
        end
    end)
end
if v6 then
    vu586()
else
    local vu587 = Instance.new("ScreenGui", v2)
    vu587.Name = "PasswordGui"
    local v588 = Instance.new("Frame", vu587)
    v588.Size = UDim2.new(0, 300, 0, 120)
    v588.Position = UDim2.new(0.5, - 150, 0.5, - 60)
    v588.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    v588.BorderSizePixel = 0
    local vu589 = Instance.new("TextBox", v588)
    vu589.Size = UDim2.new(1, - 20, 0, 40)
    vu589.Position = UDim2.new(0, 10, 0, 10)
    vu589.PlaceholderText = "enter password..."
    vu589.ClearTextOnFocus = false
    vu589.Text = ""
    vu589.TextColor3 = Color3.new(1, 1, 1)
    vu589.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    vu589.Font = Enum.Font.Gotham
    vu589.TextSize = 18
    vu589.TextXAlignment = Enum.TextXAlignment.Center
    local v590 = Instance.new("TextButton", v588)
    v590.Size = UDim2.new(0, 100, 0, 40)
    v590.Position = UDim2.new(1, - 110, 1, - 50)
    v590.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    v590.TextColor3 = Color3.new(1, 1, 1)
    v590.Text = "check key"
    v590.Font = Enum.Font.GothamSemibold
    v590.TextSize = 18
    local vu591 = Instance.new("TextLabel", v588)
    vu591.Size = UDim2.new(1, - 20, 0, 20)
    vu591.Position = UDim2.new(0, 10, 1, - 25)
    vu591.BackgroundTransparency = 1
    vu591.Text = ""
    vu591.TextColor3 = Color3.fromRGB(255, 100, 100)
    vu591.Font = Enum.Font.Gotham
    vu591.TextSize = 14
    vu591.TextXAlignment = Enum.TextXAlignment.Center
    local function vu592()
        if vu589.Text ~= vu7 then
            vu591.Text = "not valid"
        else
            vu587:Destroy()
            vu586()
        end
    end
    v590.MouseButton1Click:Connect(vu592)
    vu589.FocusLost:Connect(function(p593)
        if p593 then
            vu592()
        end
    end)
end
