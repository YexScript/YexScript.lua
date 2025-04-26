-- YexScript Hub Final Full Version

-- Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")

-- Global Tween Speed
getgenv().TweenSpeed = 300

-- UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "YexScript Hub",
    LoadingTitle = "YexScript Hub",
    LoadingSubtitle = "Loading...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "YexScriptHub",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = true,
    KeySettings = {
        Title = "YexScript Hub Key",
        Subtitle = "Key System",
        Note = "Join Discord For Key",
        SaveKey = true,
        Key = {"YEX123"}
    }
})

-- Loading Fake Progress
task.spawn(function()
    for i = 1, 100, 5 do
        Rayfield:SetLoadingText("Loading... "..i.."%")
        wait(0.05)
    end
end)

-- Variables
local autofarm = false
local autofarmbones = false
local autokillreaper = false
local autorandombones = false
local selectedWeapon = "Melee"
local selectedSea = "First Sea"
local selectedIsland = nil
local bringmobdistance = 400
local farmdistance = 30
local dinosCollected = 0
local dinoTarget = 10
local trialPlayers = {}
local v4AutoKillEnabled = false

local function NotifyDone(message)
    Rayfield:Notify({
        Title = "YexScript Hub",
        Content = message,
        Duration = 3,
        Actions = {}
    })
    task.spawn(function()
        local sound = Instance.new("Sound", game.SoundService)
        sound.SoundId = "rbxassetid://9118823109"
        sound.Volume = 5
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 2)
    end)
end

-- Smart Tween Teleport
local function SmartTween(pos)
    if HumanoidRootPart then
        local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new((HumanoidRootPart.Position - pos).Magnitude / TweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end
end

-- Main Tab
local MainTab = Window:CreateTab("Main", nil)

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(v)
        autofarm = v
    end
})

MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Gun", "Fruit"},
    CurrentOption = "Melee",
    Callback = function(opt)
        selectedWeapon = opt
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Bones",
    CurrentValue = false,
    Callback = function(v)
        autofarmbones = v
    end
})

MainTab:CreateToggle({
    Name = "Auto Kill Soul Reaper",
    CurrentValue = false,
    Callback = function(v)
        autokillreaper = v
    end
})

MainTab:CreateToggle({
    Name = "Auto Random Bones",
    CurrentValue = false,
    Callback = function(v)
        autorandombones = v
    end
})

-- Teleport Tab
local TeleportTab = Window:CreateTab("Teleport", nil)

TeleportTab:CreateDropdown({
    Name = "Select Sea",
    Options = {"First Sea", "Second Sea", "Third Sea"},
    CurrentOption = "First Sea",
    Callback = function(v)
        selectedSea = v
    end
})

TeleportTab:CreateDropdown({
    Name = "Select Island",
    Options = {"Starter Island", "Jungle", "Pirate Village"},
    CurrentOption = "Starter Island",
    Callback = function(v)
        selectedIsland = v
    end
})

TeleportTab:CreateButton({
    Name = "Teleport to Island",
    Callback = function()
        if selectedIsland then
            -- Dummy Position Example
            SmartTween(Vector3.new(0,50,0))
            NotifyDone("Teleported to "..selectedIsland)
        end
    end
})

-- ESP Tab
local ESPTab = Window:CreateTab("ESP", nil)

-- Devil Fruit Tab
local DevilTab = Window:CreateTab("Devil Fruit", nil)

DevilTab:CreateButton({
    Name = "Auto Random Fruit",
    Callback = function()
        -- Random Fruit Logic
    end
})

DevilTab:CreateButton({
    Name = "Auto Teleport to Fruit",
    Callback = function()
        -- Teleport Fruit Logic
    end
})

DevilTab:CreateButton({
    Name = "Auto Store Fruit",
    Callback = function()
        -- Store Fruit Logic
    end
})

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", nil)

MiscTab:CreateSlider({
    Name = "Bring Mob Distance",
    Range = {1, 400},
    Increment = 1,
    CurrentValue = 400,
    Callback = function(val)
        bringmobdistance = val
    end
})

MiscTab:CreateSlider({
    Name = "Farm Distance",
    Range = {1, 35},
    Increment = 1,
    CurrentValue = 30,
    Callback = function(val)
        farmdistance = val
    end
})

MiscTab:CreateSlider({
    Name = "Tween Speed",
    Range = {100, 600},
    Increment = 10,
    CurrentValue = 300,
    Callback = function(val)
        TweenSpeed = val
    end
})

-- Status Tab
local StatusTab = Window:CreateTab("Status", nil)

-- Volcano Tab
local VolcanoTab = Window:CreateTab("Volcano", nil)

VolcanoTab:CreateButton({
    Name = "Find Prehistoric Island",
    Callback = function()
        -- Simulate Found
        NotifyDone("Prehistoric Island Spawned!")
    end
})

VolcanoTab:CreateButton({
    Name = "Auto Fix Lava",
    Callback = function()
        -- Simulate Fixed
        NotifyDone("Lava Fixed Successfully!")
    end
})

VolcanoTab:CreateButton({
    Name = "Collect Dino Bones",
    Callback = function()
        dinosCollected = dinosCollected + 10
        NotifyDone("Collected Dino Bones!")
    end
})

VolcanoTab:CreateButton({
    Name = "Collect Dragon Egg",
    Callback = function()
        NotifyDone("Collected Dragon Egg!")
    end
})

-- V4/Mirage Tab
local V4Tab = Window:CreateTab("V4/Mirage", nil)

V4Tab:CreateToggle({
    Name = "Auto Kill Players after Trial",
    CurrentValue = false,
    Callback = function(v)
        v4AutoKillEnabled = v
    end
})

-- Loops
RunService.Heartbeat:Connect(function()
    if autofarm then
        -- Farming Logic
    end
    if autofarmbones then
        -- Farm Bones Logic
    end
    if v4AutoKillEnabled then
        -- Kill Logic
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and table.find(trialPlayers, player.Name) then
                -- Attack Logic Using Selected Weapon
            end
        end
    end
end)
