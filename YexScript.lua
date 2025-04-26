local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YexScript Hub | Blox Fruits",
   LoadingTitle = "YexScript Hub",
   LoadingSubtitle = "by YexBayona",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "YexScriptHub",
      FileName = "YexScriptSettings"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local StatusTab = Window:CreateTab("Status", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Global Settings
_G.AutoFarm = false
_G.AttackSpeed = 0.16

-- Functions
function StartAutoFarm()
   spawn(function()
      while _G.AutoFarm do
         pcall(function()
            local Level = game.Players.LocalPlayer.Data.Level.Value
            -- Detect island and quest
            -- Add your island and mob detection here based on Level
            -- Example for test:
            local TargetMob = workspace.Enemies:FindFirstChildOfClass("Model")
            if TargetMob then
               repeat task.wait(_G.AttackSpeed)
                  if TargetMob:FindFirstChild("Humanoid") and TargetMob.Humanoid.Health > 0 then
                     game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                  end
               until TargetMob.Humanoid.Health <= 0 or not _G.AutoFarm
            end
         end)
         task.wait(0.1)
      end
   end)
end

-- Auto Farm Toggle
MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
         StartAutoFarm()
      end
   end
})

-- Attack Speed Dropdown
MainTab:CreateDropdown({
   Name = "Attack Speed",
   Options = {"Normal (6/s)", "Fast (8/s)", "Super Fast (10/s)"},
   CurrentOption = "Normal (6/s)",
   Callback = function(Option)
      if Option == "Normal (6/s)" then
         _G.AttackSpeed = 0.16
      elseif Option == "Fast (8/s)" then
         _G.AttackSpeed = 0.125
      elseif Option == "Super Fast (10/s)" then
         _G.AttackSpeed = 0.1
      end
   end
})

-- Teleport by Sea
local Seas = {
   ["First Sea"] = {"Starter Island","Jungle Island","Pirate Village","Desert","Middle Town","Frozen Village","Marine Fortress","SkyLands","Prison","Colloseume","Magma village","Underwater city","Fountain city"},
   ["Second Sea"] = {"Kingdom of Rose","Ussop island","Cafe","Don swan mansion","Green Zone","GraveYard","Snow mountain","Hot and cold","Cursed ship","Ice Castle","Forgotten island","Dark Arena"},
   ["Third Sea"] = {"Port Town","Hydra Island","Great tree","Floating turtle","Castle on the sea","Hunted castle","Sea of treats","Tiki outpost"}
}

for sea, islands in pairs(Seas) do
   TeleportTab:CreateSection(sea)
   for _, island in ipairs(islands) do
      TeleportTab:CreateButton({
         Name = island,
         Callback = function()
            local Island = game.Workspace:FindFirstChild(island)
            if Island then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Island.CFrame
            end
         end
      })
   end
end

-- Status Tab
local MirageIsland = StatusTab:CreateParagraph({Title = "Mirage Island", Content = "Checking..."})
local KitsuneIsland = StatusTab:CreateParagraph({Title = "Kitsune Island", Content = "Checking..."})
local FullMoonStatus = StatusTab:CreateParagraph({Title = "Full Moon", Content = "Checking..."})
local SwordDealer = StatusTab:CreateParagraph({Title = "Legendary Sword Dealer", Content = "Checking..."})

spawn(function()
   while task.wait(5) do
      -- Update Status
      MirageIsland:Set({Content = workspace:FindFirstChild("Mirage Island") and "Found" or "Not Found"})
      KitsuneIsland:Set({Content = workspace:FindFirstChild("Kitsune Island") and "Found" or "Not Found"})
      FullMoonStatus:Set({Content = (game.Lighting.ClockTime > 18 or game.Lighting.ClockTime < 6) and "Yes" or "No"})
      if game.PlaceId == 4442272183 then -- Second Sea
         SwordDealer:Set({Content = workspace:FindFirstChild("Legendary Sword Dealer") and "Found" or "Not Found"})
      else
         SwordDealer:Set({Content = "Second Sea only"})
      end
   end
end)

-- Settings Tab
SettingsTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end
})

-- Toggle Key to Hide UI
game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
   if not isProcessed then
      if input.KeyCode == Enum.KeyCode.Y then
         if Rayfield.Enabled then
            Rayfield:Toggle()
         else
            Rayfield:Toggle()
         end
      end
   end
end)
