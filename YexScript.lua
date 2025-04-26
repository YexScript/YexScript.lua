local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "YexScript Hub | Blox Fruits",
    LoadingTitle = "YexScript Hub",
    LoadingSubtitle = "by Yex",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "YexScriptHub",
        FileName = "YexScriptConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "gAJSCezt", -- Correct invite
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "YexScript Key System",
        Subtitle = "Join Discord: discord.gg/gAJSCezt",
        Note = "Join our Discord server to get the key!",
        FileName = "YexScriptKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"YexScript145"}
    }
})

local attackSpeed = 0.16 -- Default Attack Speed

local MainTab = Window:CreateTab("Main", 4483362458)

local ToggleFarm = MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        while _G.AutoFarm do
            pcall(function()
                local level = game.Players.LocalPlayer.Data.Level.Value
                -- Auto Quest + Kill NPC logic here
            end)
            wait(1)
        end
    end
})

local AttackSpeedDropdown = MainTab:CreateDropdown({
    Name = "Attack Speed",
    Options = {"Normal (6/sec)", "Fast (8/sec)", "Super Fast (10/sec)"},
    CurrentOption = "Normal (6/sec)",
    Callback = function(Option)
        if Option == "Normal (6/sec)" then
            attackSpeed = 0.16
        elseif Option == "Fast (8/sec)" then
            attackSpeed = 0.12
        elseif Option == "Super Fast (10/sec)" then
            attackSpeed = 0.1
        end
    end
})

local WeaponSelector = MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Gun", "Fruit"},
    CurrentOption = "Melee",
    Callback = function(Value)
        _G.SelectedWeapon = Value
    end
})

local DevilFruitTab = Window:CreateTab("Devil Fruit", 4483362458)

DevilFruitTab:CreateButton({
    Name = "Auto Teleport To Fruit (Spawned)",
    Callback = function()
        -- Teleport Tween to Fruit Logic
    end
})

DevilFruitTab:CreateButton({
    Name = "Auto Grab Dropped Fruit (Bypass)",
    Callback = function()
        -- Auto grab dropped fruits bypass logic
    end
})

DevilFruitTab:CreateButton({
    Name = "Auto Store Fruit",
    Callback = function()
        -- Auto Store Fruit
    end
})

DevilFruitTab:CreateButton({
    Name = "Auto Random Fruit",
    Callback = function()
        -- Auto Random Fruit
    end
})

local TeleportTab = Window:CreateTab("Teleport", 4483362458)

TeleportTab:CreateButton({
    Name = "Teleport to Starter Island",
    Callback = function()
        -- Teleport Logic
    end
})

TeleportTab:CreateButton({
    Name = "Teleport to Jungle",
    Callback = function()
        -- Teleport Logic
    end
})

local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
    Name = "Farm Distance",
    Range = {5, 35},
    Increment = 1,
    CurrentValue = 15,
    Callback = function(Value)
        _G.FarmDistance = Value
    end
})

MiscTab:CreateSlider({
    Name = "Tween Speed",
    Range = {1, 300},
    Increment = 1,
    CurrentValue = 150,
    Callback = function(Value)
        _G.TweenSpeed = Value
    end
})

MiscTab:CreateSlider({
    Name = "Bring Mob Distance",
    Range = {10, 300},
    Increment = 5,
    CurrentValue = 100,
    Callback = function(Value)
        _G.BringMobDistance = Value
    end
})

local StatusTab = Window:CreateTab("Status", 4483362458)

StatusTab:CreateParagraph({
    Title = "Real-Time Status",
    Content = "Mirage: Checking...\nKitsune Island: Checking...\nFull Moon: Checking...\nSword Dealer: Checking..."
})

spawn(function()
    while true do
        -- Real-time check logic
        wait(5)
    end
end)

local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})

SettingsTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        -- Server Hop logic
    end
})

SettingsTab:CreateInput({
    Name = "Join Job ID",
    PlaceholderText = "Enter Job ID",
    RemoveTextAfterFocusLost = false,
    Callback = function(Value)
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Value)
    end
})

SettingsTab:CreateButton({
    Name = "Join Discord",
    Callback = function()
        Rayfield:Notify({
            Title = "Discord Join",
            Content = "Join Discord: discord.gg/gAJSCezt",
            Duration = 5
        })
    end
})
