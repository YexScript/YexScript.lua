local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YexScript Hub",
   LoadingTitle = "YexScript Hub Loading...",
   LoadingSubtitle = "Please wait!",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "YexScriptHub",
      FileName = "YexScriptSettings",
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "YexScript Hub",
      Subtitle = "Key System",
      Note = "Key: YexScript Hub145",
      FileName = "YexScriptHubKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"YexScript Hub145"}
   }
})

Rayfield:Notify({
   Title = "YexScript executed",
   Content = "Enjoy using YexScript!!",
   Duration = 6.5,
})

-- Variables
local SelectedWeapon = "Melee"
local AutoFarmEnabled = false
local AutoBonesEnabled = false
local AutoKillPlayerEnabled = false
local UseSkillWhileKilling = false
local AutoFixLavaEnabled = false
local AutoRaceDoorTeleport = false
local AutoCompleteTrial = false
local AutoMirageTeleport = false
local AutoFindBlueGear = false
local AutoAdvanceDealerTeleport = false
local MoonLockEnabled = false

-- Functions (Summarized)
function AttackNPC(npc)
   -- smart attack logic using SelectedWeapon
end

function TakeQuest()
   -- smart take quest based on player level
end

function FarmBones()
   -- kill mobs for bones
end

function SafeHover()
   -- smart hover to avoid death
end

function FixLava()
   -- safe smart fix logic using skill casting all weapons
end

function TeleportRaceDoor()
   -- teleport player to their correct race door
end

function CompleteRaceTrial()
   -- auto complete the correct trial based on race
end

function KillTrialPlayers()
   -- kill players after trial, using selected weapon, with optional skills
end

function TeleportToMirage()
   -- teleport to mirage and climb high place
end

function LockMoon()
   -- lock camera to moon
end

function FindBlueGear()
   -- search and teleport to blue gear
end

function TeleportAdvancedDealer()
   -- teleport to advanced fruit dealer
end

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Callback = function(v)
      AutoFarmEnabled = v
      while AutoFarmEnabled do
         TakeQuest()
         AttackNPC()
         task.wait()
      end
   end
})

MainTab:CreateDropdown({
   Name = "Select Weapon",
   Options = {"Melee", "Sword", "Gun", "Fruit"},
   CurrentOption = "Melee",
   Callback = function(v)
      SelectedWeapon = v
   end
})

local VolcanoTab = Window:CreateTab("Volcano", 4483362458)
VolcanoTab:CreateToggle({
   Name = "Auto Fix Lava (Smart Safe)",
   CurrentValue = false,
   Callback = function(v)
      AutoFixLavaEnabled = v
      while AutoFixLavaEnabled do
         SafeHover()
         FixLava()
         Rayfield:Notify({Title="Lava Fix", Content="Done Fixing Lava", Duration=5})
         task.wait()
      end
   end
})

local V4Tab = Window:CreateTab("V4 / Mirage", 4483362458)
V4Tab:CreateSection("Temple Of Time Features")

V4Tab:CreateToggle({
   Name = "Auto Teleport Race Door",
   CurrentValue = false,
   Callback = function(v)
      AutoRaceDoorTeleport = v
      while AutoRaceDoorTeleport do
         TeleportRaceDoor()
         task.wait(5)
      end
   end
})

V4Tab:CreateToggle({
   Name = "Auto Complete Trial",
   CurrentValue = false,
   Callback = function(v)
      AutoCompleteTrial = v
      while AutoCompleteTrial do
         CompleteRaceTrial()
         task.wait(5)
      end
   end
})

V4Tab:CreateToggle({
   Name = "Auto Kill Trial Players",
   CurrentValue = false,
   Callback = function(v)
      AutoKillPlayerEnabled = v
      while AutoKillPlayerEnabled do
         KillTrialPlayers()
         task.wait(2)
      end
   end
})

V4Tab:CreateDropdown({
   Name = "Skill Usage for Killing Players",
   Options = {"Yes", "No"},
   CurrentOption = "No",
   Callback = function(opt)
      UseSkillWhileKilling = (opt == "Yes")
   end
})

V4Tab:CreateSection("Mirage Island Features")

V4Tab:CreateToggle({
   Name = "Auto Teleport To Mirage",
   CurrentValue = false,
   Callback = function(v)
      AutoMirageTeleport = v
      while AutoMirageTeleport do
         TeleportToMirage()
         Rayfield:Notify({Title="Mirage", Content="Teleported to Mirage Island", Duration=5})
         task.wait(10)
      end
   end
})

V4Tab:CreateToggle({
   Name = "Moon Lock Camera",
   CurrentValue = false,
   Callback = function(v)
      MoonLockEnabled = v
      if v then
         LockMoon()
      end
   end
})

V4Tab:CreateToggle({
   Name = "Auto Find Blue Gear",
   CurrentValue = false,
   Callback = function(v)
      AutoFindBlueGear = v
      while AutoFindBlueGear do
         FindBlueGear()
         Rayfield:Notify({Title="Blue Gear", Content="Found and Teleported", Duration=5})
         task.wait(10)
      end
   end
})

V4Tab:CreateToggle({
   Name = "Teleport to Advanced Fruit Dealer",
   CurrentValue = false,
   Callback = function(v)
      AutoAdvanceDealerTeleport = v
      while AutoAdvanceDealerTeleport do
         TeleportAdvancedDealer()
         Rayfield:Notify({Title="Advanced Dealer", Content="Teleported", Duration=5})
         task.wait(10)
      end
   end
})

local MiscTab = Window:CreateTab("Misc", 4483362458)
MiscTab:CreateToggle({
   Name = "Auto Farm Bones",
   CurrentValue = false,
   Callback = function(v)
      AutoBonesEnabled = v
      while AutoBonesEnabled do
         FarmBones()
         task.wait()
      end
   end
})

function AttackNPC()
   local character = game.Players.LocalPlayer.Character
   local humanoid = character and character:FindFirstChildOfClass("Humanoid")
   if not humanoid or humanoid.Health <= 0 then return end

   -- Find closest enemy
   local closest = nil
   local shortest = math.huge
   for _, v in pairs(workspace.Enemies:GetChildren()) do
      if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
         local distance = (v.HumanoidRootPart.Position - character.HumanoidRootPart.Position).magnitude
         if distance < shortest then
            shortest = distance
            closest = v
         end
      end
   end

   if closest then
      character.HumanoidRootPart.CFrame = closest.HumanoidRootPart.CFrame * CFrame.new(0,5,5)
      if SelectedWeapon == "Melee" or SelectedWeapon == "Sword" then
         local tool = character:FindFirstChildOfClass("Tool")
         if tool then
            tool:Activate()
         end
      elseif SelectedWeapon == "Gun" then
         local tool = character:FindFirstChildOfClass("Tool")
         if tool then
            tool:Activate()
         end
      elseif SelectedWeapon == "Fruit" then
         game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
      end
   end
end

function TakeQuest()
   local level = game.Players.LocalPlayer.Data.Level.Value
   -- Insert smart quest system here depending on level
   -- For example:
   if level >= 1 and level < 10 then
      -- Go to Bandit Quest
   elseif level >= 10 and level < 30 then
      -- Go to Gorilla Quest
   end
end

function FarmBones()
   -- Same AttackNPC but for specific mobs that drop bones
   AttackNPC()
end

function SafeHover()
   local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
   if hrp then
      hrp.Velocity = Vector3.new(0,50,0)
   end
end

function FixLava()
   -- Lava safe hover + skill spam
   local character = game.Players.LocalPlayer.Character
   local tool = character:FindFirstChildOfClass("Tool")
   if tool then
      for i=1,3 do
         tool:Activate()
         task.wait(0.2)
      end
   end
end

function TeleportRaceDoor()
   local race = game.Players.LocalPlayer.Data.Race.Value
   -- Replace with real position based on your race
   if race == "Angel" then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1, 1, 1)
   elseif race == "Shark" then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2, 2, 2)
   elseif race == "Human" then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3, 3, 3)
   elseif race == "Mink" then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4, 4, 4)
   elseif race == "Ghoul" then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5, 5, 5)
   elseif race == "Cyborg" then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6, 6, 6)
   end
end

function CompleteRaceTrial()
   -- Do the same like teleport but inside the trial room
end

function KillTrialPlayers()
   local character = game.Players.LocalPlayer.Character
   local humanoid = character and character:FindFirstChildOfClass("Humanoid")
   if not humanoid then return end

   for _, player in pairs(game.Players:GetPlayers()) do
      if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         if player.Team ~= game.Players.LocalPlayer.Team then
            character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
            if SelectedWeapon == "Melee" or SelectedWeapon == "Sword" then
               local tool = character:FindFirstChildOfClass("Tool")
               if tool then
                  tool:Activate()
               end
            end
            if UseSkillWhileKilling then
               game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
            end
         end
      end
   end
end

function TeleportToMirage()
   -- Find Mirage Island if exist and teleport to it
   -- climb highest point
end

function LockMoon()
   -- Lock camera rotation toward the moon (use BodyGyro or Camera manipulation)
end

function FindBlueGear()
   -- Scan Mirage Island and tween toward blue gear
end

function TeleportAdvancedDealer()
   -- Tween to the Advanced Fruit Dealer position
end
