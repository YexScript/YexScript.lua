-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/ozstruck/Rayfield/main/source.lua"))()

-- Services
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Check if it's Blox Fruits
local isBloxFruits = game.PlaceId == 2753915549
if not isBloxFruits then
    warn("This script is designed to run only in Blox Fruits!")
    return
end

-- Islands Data (Updated with your provided islands per sea)
local islands = {
    FirstSea = {
        "Starter Island", "Jungle Island", "Pirate Village", "Desert", "Middle Town", 
        "Frozen Village", "Marine Fortress", "SkyLands", "Prison", "Colosseum", 
        "Magma Village", "Underwater City", "Fountain City"
    },
    SecondSea = {
        "Kingdom of Rose", "Ussop Island", "Cafe", "Don Swan Mansion", "Green Zone", 
        "Graveyard", "Snow Mountain", "Hot and Cold", "Cursed Ship", "Ice Castle", 
        "Forgotten Island", "Dark Arena"
    },
    ThirdSea = {
        "Port Town", "Hydra Island", "Great Tree", "Floating Turtle", "Castle on the Sea", 
        "Hunted Castle", "Sea of Treats", "Tiki Outpost"
    }
}

-- Rayfield Setup
Rayfield:CreateWindow({
    Name = "YexScript Hub",
    LoadingTitle = "Loading YexScript...",
    LoadingSubtitle = "Please Wait...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "YexScriptHub"
    },
    Discord = {Enabled = false, Invite = ""},
    KeySystem = false,
})

-- Create Tabs
local mainTab = Rayfield:CreateTab("Main", 4483362458)
local teleportTab = Rayfield:CreateTab("Teleport", 4483362458)
local espTab = Rayfield:CreateTab("ESP", 4483362458)
local miscTab = Rayfield:CreateTab("Misc", 4483362458)
local statusTab = Rayfield:CreateTab("Status", 4483362458)
local settingsTab = Rayfield:CreateTab("Settings", 4483362458)

-- Teleport Function (Updated with your provided island list)
local function teleportToIsland(island)
    local islandPos = game.Workspace:WaitForChild(island):FindFirstChild("HumanoidRootPart")
    if islandPos then
        player.Character:SetPrimaryPartCFrame(islandPos.CFrame)
    else
        warn("Island not found: " .. island)
    end
end

-- Add Teleport Buttons for each Sea
for seaName, seaIslands in pairs(islands) do
    local section = teleportTab:CreateSection(seaName)
    for _, island in ipairs(seaIslands) do
        teleportTab:CreateButton({
            Name = "Teleport to " .. island,
            Callback = function()
                teleportToIsland(island)
            end
        })
    end
end

-- ESP (Highlight Objects like Fruits, Players, etc.)
local function enableESP()
    for _, v in ipairs(game.Workspace:GetChildren()) do
        if v:IsA("Part") and v.Name == "Fruit" then
            local highlight = Instance.new("Highlight")
            highlight.Parent = v
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
        elseif v:IsA("Model") and v:FindFirstChild("Humanoid") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = v
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
        elseif v:IsA("Part") and v.Name == "Flower" then
            local highlight = Instance.new("Highlight")
            highlight.Parent = v
            highlight.FillColor = Color3.fromRGB(255, 255, 0)
        elseif v:IsA("Model") and v.Name:find("Island") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = v
            highlight.FillColor = Color3.fromRGB(0, 0, 255)
        end
    end
end

-- Enable ESP Button
espTab:CreateButton({
    Name = "Enable ESP",
    Callback = function()
        enableESP()
    end
})

-- Auto Farm Logic (With Weapon Selection)
local autoFarmEnabled = false
local selectedWeapon = "Melee"

local function startAutoFarm()
    -- Simplified: Targeting a basic NPC to farm.
    while autoFarmEnabled do
        -- Add NPC killing logic here using selected weapon
        print("Farming NPC with " .. selectedWeapon)
        wait(1)
    end
end

local function stopAutoFarm()
    autoFarmEnabled = false
    print("Auto Farm Stopped")
end

-- Auto Farm Toggle
mainTab:CreateToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(value)
        if value then
            autoFarmEnabled = true
            startAutoFarm()
        else
            stopAutoFarm()
        end
    end
})

-- Weapon Selection Dropdown
mainTab:CreateDropdown({
    Name = "Select Weapon",
    Default = "Melee",
    Options = {"Melee", "Sword", "Gun", "Fruit"},
    Callback = function(value)
        selectedWeapon = value
        print("Selected Weapon: " .. selectedWeapon)
    end
})

-- Misc Settings (Walk Speed, etc.)
miscTab:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Callback = function(value)
        player.Character.Humanoid.WalkSpeed = value
    end
})

-- Settings Tab (Reset settings or customize as needed)
settingsTab:CreateButton({
    Name = "Reset Settings",
    Callback = function()
        -- Reset settings to default (add logic)
    end
})

-- Status Tab (Displays Mirages, Full Moon, etc)
local function updateStatus()
    local statusText = "Mirage: " .. (game.ReplicatedStorage:WaitForChild("MirageIsland").Value and "Active" or "Inactive") .. "\n"
    statusText = statusText .. "Full Moon: " .. (game.ReplicatedStorage:WaitForChild("FullMoon").Value and "Active" or "Inactive") .. "\n"
    statusText = statusText .. "Sword Dealer: " .. (game.ReplicatedStorage:WaitForChild("SwordDealer").Value and "Available" or "Not Available")

    statusTab:CreateLabel({Name = statusText})
end

-- Update Status Every 5 seconds
RunService.Heartbeat:Connect(function()
    updateStatus()
end)

-- GUI Configurations
Rayfield:Init()

-- Ensure GUI is draggable
Rayfield:SetDraggable(true)
