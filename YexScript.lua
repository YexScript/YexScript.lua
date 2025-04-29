
local MainTab = Window:CreateTab("Main", 4483362458)

local SelectedWeapon = "Melee"
MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Fruit", "Gun"},
    CurrentOption = "Melee",
    Callback = function(Value)
        SelectedWeapon = Value
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoFarmLevel = state
        while getgenv().AutoFarmLevel do
            task.wait()
            -- Call your level farming function with selected weapon
        end
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Bone",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoFarmBones = state
        while getgenv().AutoFarmBones do
            task.wait()
            -- Auto bone farming function
        end
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Chest",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoChest = state
        while getgenv().AutoChest do
            task.wait()
            -- Chest farming logic
        end
    end
})

MainTab:CreateToggle({
    Name = "Auto Attack (Click)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoAttack = state
        while getgenv().AutoAttack do
            task.wait()
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    game:service('VirtualInputManager'):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    game:service('VirtualInputManager'):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                end
            end)
        end
    end
})

local TeleportTab = Window:CreateTab("Teleport", 4483362458)

TeleportTab:CreateDropdown({
    Name = "Select Sea",
    Options = {"First Sea", "Second Sea", "Third Sea"},
    CurrentOption = "First Sea",
    Callback = function(value)
        getgenv().SelectedSea = value
    end
})

TeleportTab:CreateInput({
    Name = "Teleport to Job ID",
    PlaceholderText = "Enter Job ID...",
    RemoveTextAfterFocusLost = false,
    Callback = function(jobId)
        if jobId and jobId ~= "" then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
        end
    end
})

TeleportTab:CreateButton({
    Name = "Teleport to Spawn Point",
    Callback = function()
        local SpawnPoint = game:GetService("Workspace").SpawnPoints:FindFirstChild("DefaultSpawn")
        if SpawnPoint then
            game.Players.LocalPlayer.Character:PivotTo(SpawnPoint.CFrame)
        end
    end
})

local ESPTab = Window:CreateTab("ESP", 4483362458)

-- Toggle ESP for Fruits
ESPTab:CreateToggle({
    Name = "ESP Fruits",
    CurrentValue = false,
    Callback = function(state)
        getgenv().FruitESP = state
        while getgenv().FruitESP do
            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") and not v:FindFirstChild("FruitESP") then
                    local esp = Instance.new("BillboardGui", v)
                    esp.Name = "FruitESP"
                    esp.Size = UDim2.new(0, 100, 0, 40)
                    esp.AlwaysOnTop = true
                    local text = Instance.new("TextLabel", esp)
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.Text = v.Name
                    text.TextColor3 = Color3.new(1, 0, 0)
                    text.BackgroundTransparency = 1
                end
            end
            task.wait(2)
        end
        -- Cleanup
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:FindFirstChild("FruitESP") then
                v:FindFirstChild("FruitESP"):Destroy()
            end
        end
    end
})

-- Toggle ESP for Flowers
ESPTab:CreateToggle({
    Name = "ESP Flowers",
    CurrentValue = false,
    Callback = function(state)
        getgenv().FlowerESP = state
        local function highlightFlower(flowerName)
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == flowerName and not v:FindFirstChild("FlowerESP") then
                    local esp = Instance.new("BillboardGui", v)
                    esp.Name = "FlowerESP"
                    esp.Size = UDim2.new(0, 100, 0, 40)
                    esp.AlwaysOnTop = true
                    local text = Instance.new("TextLabel", esp)
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.Text = flowerName
                    text.TextColor3 = Color3.new(0, 1, 0)
                    text.BackgroundTransparency = 1
                end
            end
        end
        while getgenv().FlowerESP do
            highlightFlower("Blue Flower")
            highlightFlower("Red Flower")
            task.wait(2)
        end
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:FindFirstChild("FlowerESP") then
                v:FindFirstChild("FlowerESP"):Destroy()
            end
        end
    end
})

local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Walk Speed Slider
MiscTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

-- Tween Speed (Used for teleport tweening)
MiscTab:CreateSlider({
    Name = "Tween Speed",
    Range = {1, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 100,
    Callback = function(Value)
        getgenv().TweenSpeed = Value
    end,
})

-- Farm Distance (how far from enemy during auto farm)
MiscTab:CreateSlider({
    Name = "Farm Distance",
    Range = {5, 35},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 15,
    Callback = function(Value)
        getgenv().FarmDistance = Value
    end,
})

-- Bring Mob Distance (how far enemies can be grouped)
MiscTab:CreateSlider({
    Name = "Bring Mob Distance",
    Range = {50, 300},
    Increment = 10,
    Suffix = "Studs",
    CurrentValue = 200,
    Callback = function(Value)
        getgenv().BringMobDistance = Value
    end,
})

local StatusTab = Window:CreateTab("Status", 4483362458)

-- Utility Function
local function CreateStatusLabel(name, checkFunction)
    StatusTab:CreateParagraph({
        Title = name,
        Content = checkFunction() and "True" or "False"
    })
end

-- Mirage Island Check
CreateStatusLabel("Mirage Island", function()
    for _, island in pairs(game:GetService("Workspace"):GetChildren()) do
        if island.Name:lower():find("mirage") then
            return true
        end
    end
    return false
end)

-- Kitsune Island Check
CreateStatusLabel("Kitsune Island", function()
    for _, island in pairs(game:GetService("Workspace"):GetChildren()) do
        if island.Name:lower():find("kitsune") then
            return true
        end
    end
    return false
end)

-- Full Moon Check
CreateStatusLabel("Full Moon", function()
    local Lighting = game:GetService("Lighting")
    return Lighting:GetMoonPhase and Lighting:GetMoonPhase() == Enum.MoonPhase.FullMoon
end)

-- Legendary Sword Dealer Check (only for Second Sea)
CreateStatusLabel("Legendary Sword Dealer", function()
    if game.PlaceId == 4442272183 then -- Second Sea
        for _, npc in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
            if npc.Name == "Legendary Sword Dealer" then
                return true
            end
        end
    end
    return false
end)

local DevilFruitTab = Window:CreateTab("Devil Fruit", 4483362458)

-- Auto Random Fruit
DevilFruitTab:CreateToggle({
    Name = "Auto Random Fruit",
    Default = false,
    Callback = function(Value)
        _G.AutoRandomFruit = Value
        while _G.AutoRandomFruit do
            local args = {
                [1] = "Cousin",
                [2] = "Buy"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            wait(300) -- Wait 5 mins before next purchase
        end
    end
})

-- Auto Teleport to Fruit
DevilFruitTab:CreateToggle({
    Name = "Auto Teleport to Fruit",
    Default = false,
    Callback = function(Value)
        _G.AutoTPFruit = Value
        while _G.AutoTPFruit do
            for _, fruit in pairs(game.Workspace:GetDescendants()) do
                if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = fruit.Handle.CFrame
                end
            end
            wait(5)
        end
    end
})

-- Auto Store Fruit
DevilFruitTab:CreateToggle({
    Name = "Auto Store Fruit",
    Default = false,
    Callback = function(Value)
        _G.AutoStoreFruit = Value
        while _G.AutoStoreFruit do
            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") and v.ToolTip == "Devil Fruit" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v.Name)
                end
            end
            wait(2)
        end
    end
})

local VolcanoTab = Window:CreateTab("Volcano", 4483362458)

-- Auto Teleport to Prehistoric Island
VolcanoTab:CreateToggle({
    Name = "Auto Teleport to Prehistoric Island",
    Default = false,
    Callback = function(Value)
        _G.AutoTPPrehistoric = Value
        while _G.AutoTPPrehistoric do
            local args = {
                [1] = "TravelPrehistoric"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            wait(10)
        end
    end
})

-- Auto Find Prehistoric Island (combined with TP)
VolcanoTab:CreateToggle({
    Name = "Auto Find Prehistoric Island",
    Default = false,
    Callback = function(Value)
        _G.AutoFindPrehistoric = Value
        while _G.AutoFindPrehistoric do
            for _, island in pairs(game.Workspace:GetChildren()) do
                if island.Name:find("Prehistoric") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = island:GetModelCFrame()
                end
            end
            wait(10)
        end
    end
})

-- Defend Volcano
VolcanoTab:CreateToggle({
    Name = "Defend Volcano (Prevent Eruption)",
    Default = false,
    Callback = function(Value)
        _G.DefendVolcano = Value
        while _G.DefendVolcano do
            local lavaParts = workspace:FindFirstChild("VolcanoDefendParts")
            if lavaParts then
                for _, part in pairs(lavaParts:GetChildren()) do
                    if part:IsA("BasePart") and part.BrickColor == BrickColor.new("Bright red") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 1)
                    end
                end
            end
            wait(1)
        end
    end
})

-- Auto Kill Golem
VolcanoTab:CreateToggle({
    Name = "Auto Kill Golem",
    Default = false,
    Callback = function(Value)
        _G.AutoKillGolem = Value
        while _G.AutoKillGolem do
            for _, mob in pairs(game.Workspace.Enemies:GetChildren()) do
                if mob.Name == "Magma Golem" and mob:FindFirstChild("HumanoidRootPart") then
                    repeat
                        pcall(function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                        end)
                        wait()
                    until not mob or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 or not _G.AutoKillGolem
                end
            end
            wait(1)
        end
    end
})

-- Auto Collect Dragon Egg
VolcanoTab:CreateToggle({
    Name = "Auto Collect Dragon Egg",
    Default = false,
    Callback = function(Value)
        _G.AutoCollectEgg = Value
        while _G.AutoCollectEgg do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "DragonEgg" and v:IsA("Tool") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                end
            end
            wait(5)
        end
    end
})

-- Auto Collect Bones
VolcanoTab:CreateToggle({
    Name = "Auto Collect Bones",
    Default = false,
    Callback = function(Value)
        _G.AutoCollectBones = Value
        while _G.AutoCollectBones do
            local args = {
                [1] = "Bones",
                [2] = "Check"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            wait(15)
        end
    end
})

local V4Tab = Window:CreateTab("V4 / Mirage", 4483362458)

-- Teleport to Temple of Time
V4Tab:CreateButton({
    Name = "Teleport to Temple of Time",
    Callback = function()
        local pos = CFrame.new(-12547, 340, -9908) -- example coordinates
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end
})

-- Teleport to Door Race
V4Tab:CreateButton({
    Name = "Teleport to Door Race",
    Callback = function()
        local pos = CFrame.new(-13300, 600, -10600) -- example coordinates
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end
})

-- Auto Complete Trial
V4Tab:CreateToggle({
    Name = "Auto Complete Trial",
    Default = false,
    Callback = function(Value)
        _G.AutoCompleteTrial = Value
        while _G.AutoCompleteTrial do
            local args = { [1] = "RaceTrial", [2] = "Start" }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            wait(10)
        end
    end
})

-- Auto Kill Player After Trial
V4Tab:CreateToggle({
    Name = "Auto Kill Player After Trial",
    Default = false,
    Callback = function(Value)
        _G.AutoKillPlayerAfterTrial = Value
        while _G.AutoKillPlayerAfterTrial do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p.Name ~= game.Players.LocalPlayer.Name then
                    local char = p.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    end
                end
            end
            wait(2)
        end
    end
})

-- Teleport to Mirage Island (if spawned)
V4Tab:CreateButton({
    Name = "Teleport to Mirage Island",
    Callback = function()
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "Mirage Island" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:GetModelCFrame() + Vector3.new(0, 150, 0)
                break
            end
        end
    end
})

-- Lock Moon
V4Tab:CreateToggle({
    Name = "Lock Moon View",
    Default = false,
    Callback = function(Value)
        _G.LockMoon = Value
        while _G.LockMoon do
            local moon = workspace:FindFirstChild("Moon") or workspace:FindFirstChildWhichIsA("MeshPart", true)
            if moon then
                game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, moon.Position)
            end
            wait(0.5)
        end
    end
})

-- Auto Find Blue Gear
V4Tab:CreateToggle({
    Name = "Auto Find Blue Gear",
    Default = false,
    Callback = function(Value)
        _G.AutoFindBlueGear = Value
        while _G.AutoFindBlueGear do
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Blue Gear" and v:IsA("MeshPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    break
                end
            end
            wait(5)
        end
    end
})

-- Teleport to Advanced Fruit Dealer
V4Tab:CreateButton({
    Name = "Teleport to Advanced Fruit Dealer",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Advanced Fruit Dealer" and v:IsA("Model") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame
                break
            end
        end
    end
})
