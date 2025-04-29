local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "YexScriptHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.5, -20)
toggleButton.Text = "Y"
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Parent = screenGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 400)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = screenGui

-- Dragging
local dragging = false
local dragInput, dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Tab Buttons Panel
local tabPanel = Instance.new("Frame")
tabPanel.Name = "TabPanel"
tabPanel.Size = UDim2.new(0, 120, 1, 0)
tabPanel.Position = UDim2.new(0, 0, 0, 0)
tabPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tabPanel.Parent = mainFrame

-- Container for Tab Content
local tabContent = Instance.new("Frame")
tabContent.Name = "TabContent"
tabContent.Size = UDim2.new(1, -120, 1, 0)
tabContent.Position = UDim2.new(0, 120, 0, 0)
tabContent.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tabContent.Parent = mainFrame

-- Toggle visibility
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Function to create tab buttons and frames
local tabs = {}
local function createTab(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Parent = tabPanel

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = false
    frame.BackgroundTransparency = 1
    frame.Parent = tabContent

    button.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.Frame.Visible = false
        end
        frame.Visible = true
    end)

    table.insert(tabs, {Name = name, Button = button, Frame = frame})
    return frame
end

-- Creating Tabs
local mainTab = createTab("Main")
local teleportTab = createTab("Teleport")
local espTab = createTab("ESP")
local miscTab = createTab("Misc")
local volcanoTab = createTab("Volcano")
local v4Tab = createTab("V4/Mirage")
local statusTab = createTab("Status")
local settingsTab = createTab("Settings")

local function startAutoFarmLevel()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/AutoFarmLevel.lua"))()
end

local function startAutoBonesFarm()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/AutoFarmBones.lua"))()
end

-- Volcano Tab Functions
local function startPrehistoricRaid()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/Volcano/AutoRaid.lua"))()
end

local function findPrehistoricIsland()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/Volcano/FindPrehistoricIsland.lua"))()
end

-- V4/Mirage Tab Functions
local function teleportTempleOfTime()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/V4/TempleTP.lua"))()
end

local function teleportRaceDoor()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/V4/RaceDoorTP.lua"))()
end

local function completeTrialForRace()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/V4/CompleteTrials.lua"))()
end

local function autoKillPlayersInTrial()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/V4/AutoKillPlayers.lua"))()
end

-- ESP Tab Functions
local function enableESP()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/ESP.lua"))()
end

-- Teleport Tab Functions
local function teleportToIsland(name)
    -- Use name input to teleport to specific island
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/Teleport.lua"))()(name)
end

-- Status Tab Functions
local function updateStatus()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/Status.lua"))()
end

-- Misc Tab Functions
local function setWalkSpeed(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end

local function setFarmDistance(value)
    _G.FarmDistance = value
end

local function setTweenSpeed(value)
    _G.TweenSpeed = value
end

local function setBringMobDistance(value)
    _G.BringMobDistance = value
end

-- Devil Fruit Tab Functions
local function autoRandomFruit()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/Fruit/AutoRandom.lua"))()
end

local function autoTPToFruit()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/Fruit/AutoTP.lua"))()
end

local function autoStoreFruit()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/Fruit/AutoStore.lua"))()
end

-- Auto Raid Function
local function startAutoRaid()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YexScript/Functions/main/AutoRaid.lua"))()
end

-- Toggle GUI
local toggleKey = Enum.KeyCode.Y
UIS.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == toggleKey then
        MainUI.Enabled = not MainUI.Enabled
    end
end)

-- Connect buttons to functions here
mainTab:Button("Auto Farm Level", startAutoFarmLevel)
mainTab:Button("Auto Farm Bones", startAutoBonesFarm)
volcanoTab:Button("Prehistoric Raid", startPrehistoricRaid)
volcanoTab:Button("Find Prehistoric Island", findPrehistoricIsland)
v4Tab:Button("TP Temple Of Time", teleportTempleOfTime)
v4Tab:Button("TP Race Door", teleportRaceDoor)
v4Tab:Button("Complete All Trials", completeTrialForRace)
v4Tab:Button("Auto Kill Trial Players", autoKillPlayersInTrial)
espTab:Button("Enable ESP", enableESP)
teleportTab:Button("Teleport to Island", function() teleportToIsland("UserInput") end)
statusTab:Button("Update Status", updateStatus)
miscTab:Slider("Walk Speed", 0, 200, 16, setWalkSpeed)
miscTab:Slider("Farm Distance", 0, 35, 20, setFarmDistance)
miscTab:Slider("Tween Speed", 0, 300, 100, setTweenSpeed)
miscTab:Slider("Bring Mob Distance", 0, 300, 150, setBringMobDistance)
dfTab:Button("Auto Random Fruit", autoRandomFruit)
dfTab:Button("Auto TP to Fruit", autoTPToFruit)
dfTab:Button("Auto Store Fruit", autoStoreFruit)
mainTab:Button("Auto Raid", startAutoRaid)
