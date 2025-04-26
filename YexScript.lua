local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
Name = "YexScript Hub",
Icon = 0,
LoadingTitle = "YexScript Hub",
LoadingSubtitle = "by Yex",
Theme = "Dark",
DisableRayfieldPrompts = false,
DisableBuildWarnings = false,
ConfigurationSaving = {
Enabled = true,
FolderName = nil,
FileName = "YexScriptConfig"
},
Discord = {
Enabled = true,
Invite = "https://discord.gg/gAJSCeZT",
RememberJoins = true
},
KeySystem = true,
KeySettings = {
Title = "Access Key",
Subtitle = "Key System",
Note = "Join our Discord server and get the key",
FileName = "YexScriptKey",
SaveKey = true,
GrabKeyFromSite = false,
Key = {"YexScript145"}
}
})

local MainTab = Window:CreateTab("Main", 4483362458)

local AttackSpeed = MainTab:CreateDropdown("Select Attack Speed", {"Normal (6/s)", "Fast (8/s)", "Super Fast (10/s)"}, function(selected)
if selected == "Normal (6/s)" then
attackSpeed = 6
elseif selected == "Fast (8/s)" then
attackSpeed = 8
elseif selected == "Super Fast (10/s)" then
attackSpeed = 10
end
end)

local WeaponSelector = MainTab:CreateDropdown("Select Weapon", {"Melee", "Sword", "Gun", "Fruit"}, function(selected)
selectedWeapon = selected
end)

local AutoFarmToggle = MainTab:CreateToggle("Auto Farm", false, function(state)
autoFarmEnabled = state
if autoFarmEnabled then
AutoFarmLogic()
end
end)

local SettingsTab = Window:CreateTab("Settings", 4483362459)

SettingsTab:CreateButton("Rejoin Server", function()
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

SettingsTab:CreateButton("Server Hop", function()
local TeleportService = game:GetService("TeleportService")
TeleportService:Teleport(game.PlaceId)
end)

SettingsTab:CreateButton("Join Discord", function()
setclipboard("https://discord.gg/gAJSCeZT")
Rayfield:Notify({
Title = "Link Copied",
Content = "Join the Discord Server: https://discord.gg/gAJSCeZT",
Duration = 5
})
end)

local MiscTab = Window:CreateTab("Misc", 4483362460)

MiscTab:CreateSlider("Farm Distance", {min = 1, max = 35, default = 10, precise = true}, function(value)
farmDistance = value
end)

MiscTab:CreateSlider("Tween Speed", {min = 1, max = 300, default = 50, precise = true}, function(value)
tweenSpeed = value
end)

MiscTab:CreateSlider("Bring Mob Distance", {min = 1, max = 300, default = 10, precise = true}, function(value)
bringMobDistance = value
end)

MiscTab:CreateSlider("Walk Speed", {min = 1, max = 200, default = 16, precise = true}, function(value)
walkSpeed = value
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

local DevilFruitTab = Window:CreateTab("Devil Fruit", 4483362461)

DevilFruitTab:CreateButton("Auto Random Fruit", function()
end)

DevilFruitTab:CreateButton("Auto Store Fruit", function()
end)

DevilFruitTab:CreateButton("Auto Teleport to Fruit", function()
end)

function AutoFarmLogic()
while autoFarmEnabled do
local playerLevel = game.Players.LocalPlayer.Data.Level.Value
local questAvailable = nil
local questNPC = nil
local questMobs = nil

if playerLevel <= 10 then
questAvailable = "Quest1"
questNPC = game.Workspace.Quest1NPC
questMobs = game.Workspace.Mobs.Quest1Mobs
elseif playerLevel <= 50 then
questAvailable = "Quest2"
questNPC = game.Workspace.Quest2NPC
questMobs = game.Workspace.Mobs.Quest2Mobs
elseif playerLevel <= 100 then
questAvailable = "Quest3"
questNPC = game.Workspace.Quest3NPC
questMobs = game.Workspace.Mobs.Quest3Mobs
else
questAvailable = "Quest4"
questNPC = game.Workspace.Quest4NPC
questMobs = game.Workspace.Mobs.Quest4Mobs
end

if questAvailable and questNPC then
pcall(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = questNPC.HumanoidRootPart.CFrame
fireclickdetector(questNPC.ClickDetector)
end)

for _, mob in pairs(questMobs:GetChildren()) do
if mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
pcall(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, farmDistance, 0)
repeat wait(1/attackSpeed)
if selectedWeapon == "Melee" or selectedWeapon == "Sword" or selectedWeapon == "Gun" or selectedWeapon == "Fruit" then
local tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
if tool then
tool.Parent = game.Players.LocalPlayer.Character
tool:Activate()
end
end
until mob.Humanoid.Health <= 0 or not autoFarmEnabled
end)
end
end
else
Rayfield:Notify({
Title = "No Quest Available",
Content = "No quest found for your level.",
Duration = 5
})
end
wait(1)
end
end

local KeySystem = function()
local key = Rayfield:RequestKey()
if key == "YexScript145" then
Rayfield:Notify({
Title = "Key Valid",
Content = "YexScript Hub Loaded!",
Duration = 5
})
else
Rayfield:Notify({
Title = "Invalid Key",
Content = "Wrong Key!",
Duration = 5
})
end
end

KeySystem()
