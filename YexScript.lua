-- // Loader
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/AikaV3rm/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "YexScript HUB",
   LoadingTitle = "YexScript HUB Loading...",
   LoadingSubtitle = "discord.gg/gAJSCeZT",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "YexScriptHub",
      FileName = "Settings"
   },
   Discord = {
      Enabled = true,
      Invite = "gAJSCeZT",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "YexScript HUB",
      Subtitle = "discord.gg/gAJSCeZT",
      Note = "Join discord server to get key!",
      FileName = "YexScriptKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"YexScript145"}
   }
})

-- Notification after Key
Rayfield:Notify({
   Title = "YexScript HUB",
   Content = "Successfully executed!",
   Duration = 6.5,
   Image = nil,
   Actions = {Ignore = {Name = "Okay", Callback = function() end}}
})

-- // Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

local SelectedWeapon = "Melee"
local AttackSpeed = 0.3
local AutoFarm = false

MainTab:CreateDropdown({
   Name = "Select Weapon",
   Options = {"Melee", "Sword", "Gun", "Fruit"},
   CurrentOption = "Melee",
   Callback = function(Value)
      SelectedWeapon = Value
   end,
})

MainTab:CreateSlider({
   Name = "Attack Speed",
   Range = {0.1, 1},
   Increment = 0.05,
   Suffix = "s",
   CurrentValue = 0.3,
   Callback = function(Value)
      AttackSpeed = Value
   end,
})

MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarm = Value
      while AutoFarm do
         pcall(function()
            local player = game.Players.LocalPlayer
            local level = player.Data.Level.Value
            -- Farming logic (quest, teleport, kill NPCs)
            -- Insert your island detection, quest taking, teleport, and combat here based on level
         end)
         task.wait(AttackSpeed)
      end
   end,
})

-- // Teleport Tab
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

TeleportTab:CreateButton({Name = "Teleport to First Sea", Callback = function() end})
TeleportTab:CreateButton({Name = "Teleport to Second Sea", Callback = function() end})
TeleportTab:CreateButton({Name = "Teleport to Third Sea", Callback = function() end})
-- Add all island teleport buttons

-- // ESP Tab
local ESPTab = Window:CreateTab("ESP", 4483362458)

ESPTab:CreateToggle({Name = "Fruit ESP", CurrentValue = false, Callback = function(Value) end})
ESPTab:CreateToggle({Name = "Flower ESP", CurrentValue = false, Callback = function(Value) end})

-- // Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateSlider({
   Name = "Farm Distance",
   Range = {5, 35},
   Increment = 1,
   CurrentValue = 20,
   Callback = function(Value) end,
})

MiscTab:CreateSlider({
   Name = "Tween Speed",
   Range = {50, 300},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value) end,
})

MiscTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 120},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- // Status Tab
local StatusTab = Window:CreateTab("Status", 4483362458)

local MirageLabel = StatusTab:CreateParagraph({Title = "Mirage Island", Content = "Checking..."})
local KitsuneLabel = StatusTab:CreateParagraph({Title = "Kitsune Island", Content = "Checking..."})
local FullMoonLabel = StatusTab:CreateParagraph({Title = "Full Moon", Content = "Checking..."})
local SwordDealerLabel = StatusTab:CreateParagraph({Title = "Legendary Sword Dealer", Content = "Checking..."})

task.spawn(function()
   while task.wait(3) do
      -- Insert real-time check logic here for Mirage, Kitsune, Full Moon, Dealer
   end
end)

-- // Devil Fruit Tab
local FruitTab = Window:CreateTab("Devil Fruit", 4483362458)

FruitTab:CreateToggle({
   Name = "Auto Random Fruit",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         -- Insert random fruit buy logic
      end
   end,
})

FruitTab:CreateToggle({
   Name = "Auto Store Fruit",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         -- Insert auto store logic
      end
   end,
})

FruitTab:CreateToggle({
   Name = "Auto Grab Spawned/Dropped Fruit",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         -- Tween to fruit if spawned, teleport if dropped
      end
   end,
})

-- // Settings Tab
local SettingTab = Window:CreateTab("Settings", 4483362458)

SettingTab:CreateInput({
   Name = "Teleport to Job ID",
   PlaceholderText = "Enter Job ID",
   RemoveTextAfterFocusLost = true,
   Callback = function(Value)
      game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Value)
   end,
})

SettingTab:CreateButton({
   Name = "Rejoin Server",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

SettingTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
      -- Insert server hop logic
   end,
})

SettingTab:CreateButton({
   Name = "Join Discord Server",
   Callback = function()
      -- This depends on executor
   end,
})
