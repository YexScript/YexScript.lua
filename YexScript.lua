local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create Window
local Window = Library.CreateLib("YexScript Hub", "DarkTheme")

-- LOADING SCREEN
local LoadingScreen = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

LoadingScreen.Name = "YexLoading"
LoadingScreen.Parent = game.CoreGui

Frame.Parent = LoadingScreen
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0.35, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 300, 0, 100)
Frame.BorderSizePixel = 0

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "YexScript Hub Loading..."
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.SourceSansBold

wait(3)
LoadingScreen:Destroy()

-- TABS
local MainTab = Window:NewTab("Main")
local VolcanoTab = Window:NewTab("Volcano")
local V4Tab = Window:NewTab("V4/Mirrage")
local ESPTab = Window:NewTab("ESP")
local RaidTab = Window:NewTab("Raid/Devil Fruit")
local TeleportTab = Window:NewTab("Teleport")
local MiscTab = Window:NewTab("Misc")

local VolcanoTab = MainTab:CreateTab("Volcano", 4483362458) -- Volcano Tab

-- Section for finding and navigating to Prehistoric Island
VolcanoTab:CreateSection("Prehistoric Island")

-- Auto find Prehistoric Island and sail to it
VolcanoTab:CreateButton("Auto Find Prehistoric Island", function()
    local TikiOutpost = game:GetService("Workspace").TikiOutpost -- Find the Tiki Outpost
    local Boat = game.Players.LocalPlayer.Character:FindFirstChild("Boat") -- Check for Boat
    if not Boat then
        -- Buy Boat from Tiki Outpost and sail straight
        game:GetService("ReplicatedStorage").Remotes.BuyBoat:FireServer("Tiki Outpost")
        wait(2) -- Wait for purchase
    end
    
    -- Sail to Prehistoric Island and avoid other sea events
    local target = game:GetService("Workspace").PrehistoricIsland -- Find Prehistoric Island in workspace
    local boatPosition = Boat.PrimaryPart.Position
    local targetPosition = target.Position
    game:GetService("TweenService"):Create(Boat.PrimaryPart, TweenInfo.new(10), {Position = targetPosition}):Play()

    -- Notify when Prehistoric Island spawns
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Prehistoric Island", Text = "Prehistoric Island Spawned!"})
end)

-- Section for completing the Prehistoric Island event
VolcanoTab:CreateSection("Auto Complete Prehistoric Island")

-- Start Event, Fix Volcano, and Kill Lava Golem
VolcanoTab:CreateButton("Auto Complete Prehistoric Island", function()
    local event = game:GetService("ReplicatedStorage").Remotes.StartPrehistoricEvent -- Start the event
    event:FireServer()

    -- Fix the volcano (repair NPC)
    local fixVolcanoNPC = game:GetService("Workspace").VolcanoNPC
    game:GetService("ReplicatedStorage").Remotes.FixVolcano:FireServer(fixVolcanoNPC)

    -- Instantly kill Lava Golem
    local lavaGolem = game:GetService("Workspace").LavaGolem
    lavaGolem:Destroy()  -- Destroy Lava Golem directly

    -- Notify when event is completed
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Event Completed", Text = "Prehistoric Island Event Completed!"})
end)

-- Section for collecting Dragon Bones and Dragon Eggs
VolcanoTab:CreateSection("Collect Dragon Bones & Eggs")

-- Auto collect Dragon Bones
VolcanoTab:CreateButton("Auto Collect Dragon Bones", function()
    local bones = game:GetService("Workspace").Bones
    for _, bone in pairs(bones:GetChildren()) do
        if bone:IsA("Part") then
            -- Collect bone
            fireclickdetector(bone.ClickDetector)
        end
    end
    -- Notify when bones are collected
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Bones Collected", Text = "All Bones Collected!"})
end)

-- Auto collect Dragon Eggs
VolcanoTab:CreateButton("Auto Collect Dragon Eggs", function()
    local eggs = game:GetService("Workspace").DragonEggs
    for _, egg in pairs(eggs:GetChildren()) do
        if egg:IsA("Part") then
            -- Collect egg
            fireclickdetector(egg.ClickDetector)
        end
    end
    -- Notify when eggs are collected
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Eggs Collected", Text = "All Eggs Collected!"})
end)

local V4Tab = MainTab:CreateTab("V4/Mirrage", 4483362458)

-- === V4 Section ===
V4Tab:CreateSection("V4")

-- Teleport to Temple of Time
V4Tab:CreateButton("Teleport to Temple of Time", function()
    local temple = workspace:FindFirstChild("TempleOfTime")
    if temple then
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = temple.CFrame + Vector3.new(0, 5, 0)
    end
end)

-- Auto Teleport to Trial Door
V4Tab:CreateButton("Auto Teleport Trial Door", function()
    local race = game.Players.LocalPlayer.Data.Race.Value
    local door = workspace:FindFirstChild(race.."Door")
    if door then
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = door.CFrame + Vector3.new(0, 3, 0)
    end
end)

-- Auto Complete Trial
V4Tab:CreateButton("Auto Complete Trial", function()
    local race = game.Players.LocalPlayer.Data.Race.Value
    local trial = workspace:FindFirstChild(race.."Trial")
    if trial and trial:FindFirstChild("Lever") then
        fireclickdetector(trial.Lever.ClickDetector)
        wait(1)
        trial.Door:Destroy()
    end
end)

-- Auto Kill Player After Trial
V4Tab:CreateButton("Auto Kill Player After Trial", function()
    local Players = game:GetService("Players")
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= Players.LocalPlayer then
            local char = target.Character
            if char and char:FindFirstChild("Humanoid") then
                repeat
                    game:GetService("ReplicatedStorage").Remotes.Attack:FireServer(char)
                    wait(0.2)
                until not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0
            end
        end
    end
end)

-- === MIRRAGE Section ===
V4Tab:CreateSection("MIRRAGE")

-- Teleport to Mirage Island
V4Tab:CreateButton("Teleport to Mirage Island", function()
    local mirage = workspace:FindFirstChild("MirageIsland")
    if mirage then
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        game:GetService("TweenService"):Create(hrp, TweenInfo.new(5), {CFrame = mirage.CFrame + Vector3.new(0, 200, 0)}):Play()
    else
        game.StarterGui:SetCore("SendNotification", {Title = "Mirage Island", Text = "Not spawned in this server."})
    end
end)

-- Lock Camera on Moon
V4Tab:CreateButton("Lock Camera on Moon", function()
    local moon = workspace:FindFirstChild("Moon")
    if moon then
        local cam = workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame = CFrame.lookAt(cam.CFrame.Position, moon.Position)
    end
end)

-- Auto Find Blue Gear
V4Tab:CreateButton("Auto Find Blue Gear", function()
    local gear = workspace:FindFirstChild("BlueGear")
    if gear then
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        game:GetService("TweenService"):Create(hrp, TweenInfo.new(3), {CFrame = gear.CFrame}):Play()
    end
end)

-- Teleport to Advanced Fruit Dealer
V4Tab:CreateButton("Teleport to Advanced Fruit Dealer", function()
    local advDealer = workspace:FindFirstChild("AdvancedFruitDealer")
    if advDealer then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = advDealer.CFrame + Vector3.new(0, 3, 0)
    end
end)

local ESPTab = MainTab:CreateTab("ESP", 4483362458)

ESPTab:CreateSection("ESP Options")

-- ESP: Devil Fruits
ESPTab:CreateToggle("Fruit ESP", nil, function(state)
    _G.FruitESP = state
    while _G.FruitESP do
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                if v.ToolTip == "Devil Fruit" and not v.Handle:FindFirstChild("FruitESP") then
                    local esp = Instance.new("BillboardGui", v.Handle)
                    esp.Name = "FruitESP"
                    esp.Size = UDim2.new(0, 100, 0, 40)
                    esp.AlwaysOnTop = true
                    local label = Instance.new("TextLabel", esp)
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.Text = v.Name
                    label.TextColor3 = Color3.new(1, 0, 0)
                    label.TextStrokeTransparency = 0
                end
            end
        end
        wait(3)
    end
end)

-- ESP: Flowers
ESPTab:CreateToggle("Flower ESP (Red, Blue, Yellow)", nil, function(state)
    _G.FlowerESP = state
    while _G.FlowerESP do
        for _,flowerName in pairs({"Red Flower", "Blue Flower", "Yellow Flower"}) do
            for _,v in pairs(workspace:GetDescendants()) do
                if v.Name == flowerName and not v:FindFirstChild("FlowerESP") then
                    local esp = Instance.new("BillboardGui", v)
                    esp.Name = "FlowerESP"
                    esp.Size = UDim2.new(0, 100, 0, 40)
                    esp.AlwaysOnTop = true
                    local label = Instance.new("TextLabel", esp)
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.Text = flowerName
                    label.TextColor3 = Color3.new(0, 1, 0)
                    label.TextStrokeTransparency = 0
                end
            end
        end
        wait(2)
    end
end)

-- ESP: Chests
ESPTab:CreateToggle("Chest ESP", nil, function(state)
    _G.ChestESP = state
    while _G.ChestESP do
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name:find("Chest") and not v:FindFirstChild("ChestESP") then
                local esp = Instance.new("BillboardGui", v)
                esp.Name = "ChestESP"
                esp.Size = UDim2.new(0, 100, 0, 40)
                esp.AlwaysOnTop = true
                local label = Instance.new("TextLabel", esp)
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = v.Name
                label.TextColor3 = Color3.new(1, 1, 0)
                label.TextStrokeTransparency = 0
            end
        end
        wait(3)
    end
end)

local RaidTab = MainTab:CreateTab("Raid / Devil Fruit", 4483362458)

RaidTab:CreateSection("Raids")

-- Auto Raid
RaidTab:CreateToggle("Auto Start Raid", nil, function(state)
    _G.AutoRaid = state
    while _G.AutoRaid do
        local args = {
            [1] = "RaidsNpc",
            [2] = "Select",
            [3] = "Flame" -- Replace with your desired raid type
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

        wait(10)
        local start = {
            [1] = "RaidsNpc",
            [2] = "Start"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(start))
        wait(30)
    end
end)

RaidTab:CreateSection("Devil Fruit")

-- Auto Random Fruit
RaidTab:CreateButton("Buy Random Fruit", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
end)

-- Auto Store Fruit
RaidTab:CreateToggle("Auto Store Fruit", nil, function(state)
    _G.AutoStore = state
    while _G.AutoStore do
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.ToolTip == "Devil Fruit" then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v.Name)
            end
        end
        wait(5)
    end
end)

-- Auto Teleport to Fruit
RaidTab:CreateToggle("Auto Teleport to Nearest Fruit", nil, function(state)
    _G.AutoTPFruit = state
    while _G.AutoTPFruit do
        for i,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Tool") and v.ToolTip == "Devil Fruit" and v:FindFirstChild("Handle") then
                game.Players.LocalPlayer.Character:PivotTo(v.Handle.CFrame + Vector3.new(0,5,0))
                break
            end
        end
        wait(5)
    end
end)

local TeleportTab = MainTab:CreateTab("Teleport", 4483362458)

TeleportTab:CreateSection("First Sea Islands")

local FirstSeaIslands = {
    ["Starter Island"] = Vector3.new(0, 20, 0),
    ["Jungle"] = Vector3.new(-1337, 40, 3416),
    ["Pirate Village"] = Vector3.new(-1121, 16, 3856),
    ["Desert"] = Vector3.new(1094, 16, 4193),
    ["Middle Island"] = Vector3.new(-655, 7, 4987),
    ["Frozen Village"] = Vector3.new(1140, 16, -1218),
    ["Marine Fortress"] = Vector3.new(-4505, 16, 4268),
    ["Skylands"] = Vector3.new(-4922, 295, 3813),
    ["Colosseum"] = Vector3.new(-2036, 8, -2836),
    ["Magma Village"] = Vector3.new(-5233, 18, 8461),
    ["Underwater City"] = Vector3.new(3854, 10, -1899),
    ["Fountain City"] = Vector3.new(5289, 38, 4056)
}

for name, pos in pairs(FirstSeaIslands) do
    TeleportTab:CreateButton(name, function()
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(pos))
    end)
end

TeleportTab:CreateSection("Second Sea Islands")

local SecondSeaIslands = {
    ["Kingdom of Rose"] = Vector3.new(-393, 73, 665),
    ["Green Zone"] = Vector3.new(-2205, 72, -2054),
    ["Dark Arena"] = Vector3.new(3800, 100, -3000),
    ["Hot and Cold"] = Vector3.new(-5478, 15, -5296),
    ["Cursed Ship"] = Vector3.new(902, 124, 32815),
    ["Ice Castle"] = Vector3.new(5400, 70, -6200),
    ["Forgotten Island"] = Vector3.new(-3055, 30, -10175),
    ["Usoap's Island"] = Vector3.new(500, 20, 1200)
}

for name, pos in pairs(SecondSeaIslands) do
    TeleportTab:CreateButton(name, function()
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(pos))
    end)
end

TeleportTab:CreateSection("Third Sea Islands")

local ThirdSeaIslands = {
    ["Port Town"] = Vector3.new(-2997, 72, 100),
    ["Hydra Island"] = Vector3.new(5220, 70, -1100),
    ["Great Tree"] = Vector3.new(2445, 400, -6800),
    ["Castle on the Sea"] = Vector3.new(-5500, 320, -2800),
    ["Haunted Castle"] = Vector3.new(-9500, 140, 6000),
    ["Sea of Treats"] = Vector3.new(-10800, 400, -800)
}

for name, pos in pairs(ThirdSeaIslands) do
    TeleportTab:CreateButton(name, function()
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(pos))
    end)
end

TeleportTab:CreateSection("Server Hop")

TeleportTab:CreateTextbox("Join Job ID", "Enter Job ID", true, function(jobId)
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
end)

local MiscTab = MainTab:CreateTab("Misc", 4483362458)

MiscTab:CreateSection("Movement")

MiscTab:CreateSlider("Walk Speed", 16, 200, game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

MiscTab:CreateSlider("Tween Speed", 50, 300, 120, function(value)
    getgenv().TweenSpeed = value
end)

MiscTab:CreateSection("Farming")

MiscTab:CreateSlider("Farm Distance", 1, 35, 20, function(value)
    getgenv().FarmDistance = value
end)

MiscTab:CreateSlider("Bring Mob Distance", 50, 300, 150, function(value)
    getgenv().BringMobDistance = value
end)

