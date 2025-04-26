local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "YexScript Hub",
    LoadingTitle = "YexScript Hub Loading...",
    LoadingSubtitle = "Join Discord: discord.gg/gAJSCeZT",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "YexScriptHub",
        FileName = "YexScriptConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "gAJSCeZT",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "YexScript Key System",
        Subtitle = "Join Discord: discord.gg/gAJSCeZT",
        Note = "Key = YexScript145",
        FileName = "YexScriptKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"YexScript145"}
    }
})

local MainTab = Window:CreateTab("Main")
local TeleportTab = Window:CreateTab("Teleport")
local DevilFruitTab = Window:CreateTab("Devil Fruit")
local MiscTab = Window:CreateTab("Misc")
local StatusTab = Window:CreateTab("Status")
local SettingsTab = Window:CreateTab("Settings")

-- Variables
local AttackSpeed = 0.15
local SelectedWeapon = "Melee"
local AutoFarm = false
local AutoAttack = false

-- Auto Farm Function
function StartAutoFarm()
    spawn(function()
        while AutoFarm do
            pcall(function()
                local playerLevel = game.Players.LocalPlayer.Data.Level.Value
                local QuestName, MobName, MobCFrame = nil, nil, nil

                for i,v in pairs(Quests) do
                    if playerLevel >= v.Level[1] and playerLevel <= v.Level[2] then
                        QuestName = v.QuestName
                        MobName = v.MobName
                        MobCFrame = v.CFrame
                        break
                    end
                end

                if QuestName and MobName then
                    if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                        local args = {
                            [1] = QuestName
                        }
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", unpack(args))
                    end

                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == MobName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat task.wait(AttackSpeed)
                                pcall(function()
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Attack",SelectedWeapon)
                                end)
                            until v.Humanoid.Health <= 0 or not AutoFarm
                        end
                    end
                end
            end)
            task.wait()
        end
    end)
end

-- Attack Speed
MainTab:CreateDropdown({
    Name = "Attack Speed",
    Options = {"Normal (6/sec)", "Fast (8/sec)", "Super Fast (10/sec)"},
    CurrentOption = "Normal (6/sec)",
    Callback = function(option)
        if option == "Normal (6/sec)" then
            AttackSpeed = 0.15
        elseif option == "Fast (8/sec)" then
            AttackSpeed = 0.12
        elseif option == "Super Fast (10/sec)" then
            AttackSpeed = 0.1
        end
    end
})

-- Weapon Selector
MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee","Sword","Gun","Fruit"},
    CurrentOption = "Melee",
    Callback = function(option)
        SelectedWeapon = option
    end
})

-- Auto Farm Toggle
MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(Value)
        AutoFarm = Value
        if AutoFarm then
            StartAutoFarm()
        end
    end
})

-- Teleport Tab
for Sea,Islands in pairs(IslandList) do
    TeleportTab:CreateSection(Sea)
    for i,v in pairs(Islands) do
        TeleportTab:CreateButton({
            Name = v.Name,
            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        })
    end
end

-- Devil Fruit Tab
DevilFruitTab:CreateButton({
    Name = "Teleport To Spawned Fruit",
    Callback = function()
        for i,v in pairs(game.Workspace:GetChildren()) do
            if string.find(v.Name, "Fruit") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end
})

DevilFruitTab:CreateToggle({
    Name = "Auto Store Fruits",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            spawn(function()
                while task.wait(1) do
                    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if string.find(v.Name, "Fruit") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v.Name)
                        end
                    end
                end
            end)
        end
    end
})

DevilFruitTab:CreateButton({
    Name = "Auto Random Fruit",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
    end
})

-- Misc Tab
MiscTab:CreateSlider({
    Name = "Farm Distance",
    Range = {0,35},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(Value)
        FarmDistance = Value
    end
})

MiscTab:CreateSlider({
    Name = "Tween Speed",
    Range = {1,300},
    Increment = 1,
    CurrentValue = 100,
    Callback = function(Value)
        TweenSpeed = Value
    end
})

MiscTab:CreateSlider({
    Name = "Bring Mob Distance",
    Range = {1,300},
    Increment = 1,
    CurrentValue = 100,
    Callback = function(Value)
        BringDistance = Value
    end
})

-- Status Tab
spawn(function()
    while task.wait(2) do
        local Mirage = game:GetService("ReplicatedStorage"):FindFirstChild("Mirage Island") ~= nil
        local Kitsune = game:GetService("ReplicatedStorage"):FindFirstChild("Kitsune Island") ~= nil
        local FullMoon = game.Lighting:FindFirstChild("FullMoon") ~= nil
        local Dealer = game:GetService("Workspace").NPCs:FindFirstChild("Legendary Sword Dealer") ~= nil

        StatusTab:CreateLabel("Mirage Island: " .. tostring(Mirage))
        StatusTab:CreateLabel("Kitsune Island: " .. tostring(Kitsune))
        StatusTab:CreateLabel("Full Moon: " .. tostring(FullMoon))
        StatusTab:CreateLabel("Sword Dealer (Second Sea): " .. tostring(Dealer))
    end
end)

-- Settings Tab
SettingsTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

SettingsTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local PlaceID = game.PlaceId
        local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
            if v.playing < v.maxPlayers then
                TeleportService:TeleportToPlaceInstance(PlaceID, v.id, game.Players.LocalPlayer)
                break
            end
        end
    end
})

SettingsTab:CreateButton({
    Name = "Join Discord Server",
    Callback = function()
        Rayfield:Notify({Title = "Discord", Content = "Join: discord.gg/gAJSCeZT"})
    end
})

SettingsTab:CreateInput({
    Name = "Join Job ID",
    PlaceholderText = "Paste JobId Here",
    RemoveTextAfterFocusLost = true,
    Callback = function(Input)
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Input, game.Players.LocalPlayer)
    end
})
