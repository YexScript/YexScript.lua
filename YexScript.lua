-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Screen GUI and loading screen
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "YexScriptHub"

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 300, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = ScreenGui

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 1, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "YexScript Hub Loading..."
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.TextScaled = true
loadingText.Font = Enum.Font.GothamBold
loadingText.Parent = loadingFrame

wait(2) -- simulate loading
loadingFrame:Destroy()

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 800, 0, 500)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Tab Buttons Container
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 150, 1, 0)
TabContainer.Position = UDim2.new(0, 0, 0, 0)
TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

-- Tab Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -150, 1, 0)
ContentContainer.Position = UDim2.new(0, 150, 0, 0)
ContentContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = MainFrame

-- Tab creation function
local tabs = {}
local function createTab(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Text = name
    button.Parent = TabContainer

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -10, 1, -10)
    content.Position = UDim2.new(0, 5, 0, 5)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.CanvasSize = UDim2.new(0, 0, 5, 0)
    content.Visible = false
    content.Parent = ContentContainer

    button.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.content.Visible = false
        end
        content.Visible = true
    end)

    tabs[#tabs + 1] = {button = button, content = content}
    return content
end

local tabs = {
	Main = createTab("Main"),
	Teleport = createTab("Teleport"),
	ESP = createTab("ESP"),
	Misc = createTab("Misc"),
	["V4 / Mirage"] = createTab("V4 / Mirage"),
	Volcano = createTab("Volcano"),
	Settings = createTab("Settings"),
}

-- Auto Farm Level
createToggle(tabs.Main, "Auto Farm Level", false, function(state)
	AutoFarmLevel = state
	while AutoFarmLevel do
		task.wait()
		pcall(function()
			local quest = getQuestForLevel()
			if quest then
				takeQuest(quest)
				attackQuestNPC(quest)
			end
		end)
	end
end)

-- Auto Farm Bones
createToggle(tabs.Main, "Auto Farm Bones", false, function(state)
	AutoFarmBones = state
	while AutoFarmBones do
		task.wait()
		autoFarmBonesLogic()
	end
end)

-- Weapon Selector
createDropdown(tabs.Main, "Weapon Type", {"Melee", "Sword", "Gun", "Fruit"}, "Melee", function(selected)
	SelectedWeaponType = selected
end)

-- Auto Raid
createToggle(tabs.Main, "Auto Raid", false, function(state)
	AutoRaid = state
	while AutoRaid do
		task.wait()
		handleAutoRaid()
	end
end)

-- ESP Features
createToggle(tabs.ESP, "ESP Fruit", false, function(state)
	ESPFruit = state
	handleESPFruit()
end)

createToggle(tabs.ESP, "ESP Flower", false, function(state)
	ESPFlower = state
	handleESPFlower()
end)

-- Teleport Tab
createDropdown(tabs.Teleport, "Select Sea", {"First Sea", "Second Sea", "Third Sea"}, "First Sea", function(selected)
	CurrentSea = selected
end)

createInput(tabs.Teleport, "Job ID", "", function(jobID)
	JobID = jobID
end)

createButton(tabs.Teleport, "Teleport to Job ID", function()
	teleportToJobID(JobID)
end)-- Misc Tab
createSlider(tabs.Misc, "Farm Distance", 1, 35, 20, function(value)
	FarmDistance = value
end)

createSlider(tabs.Misc, "Tween Speed", 1, 300, 100, function(value)
	TweenSpeed = value
end)

createSlider(tabs.Misc, "Bring Mob Distance", 1, 300, 100, function(value)
	BringMobDistance = value
end)

createSlider(tabs.Misc, "Walk Speed", 16, 100, 20, function(value)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

-- Devil Fruit Tab (Merged into Misc or create separate tab if needed)
createToggle(tabs.Misc, "Auto Random Fruit", false, function(state)
	AutoRandomFruit = state
	while AutoRandomFruit do
		task.wait(5)
		getRandomFruit()
	end
end)

createToggle(tabs.Misc, "Auto Store Fruit", false, function(state)
	AutoStoreFruit = state
	autoStoreFruit()
end)

createToggle(tabs.Misc, "Auto Teleport to Fruit", false, function(state)
	AutoTPFruit = state
	autoTPToNearestFruit()
end)

-- V4 / Mirage Tab
createButton(tabs["V4 / Mirage"], "Teleport Temple of Time", function()
	teleportToTempleOfTime()
end)

createButton(tabs["V4 / Mirage"], "Teleport to Race Door", function()
	teleportToRaceDoor()
end)

createToggle(tabs["V4 / Mirage"], "Auto Complete Trial", false, function(state)
	AutoTrial = state
	while AutoTrial do
		task.wait()
		autoCompleteTrial()
	end
end)

createToggle(tabs["V4 / Mirage"], "Auto Kill Player After Trial", false, function(state)
	KillPlayerPostTrial = state
	while KillPlayerPostTrial do
		task.wait()
		autoKillTrialPlayers()
	end
end)-- Volcano Tab
createToggle(tabs.Volcano, "Auto Find Prehistoric Island", false, function(state)
	AutoFindPrehistoricIsland = state
	while AutoFindPrehistoricIsland do
		task.wait(5)
		findPrehistoricIsland()
	end
end)

createToggle(tabs.Volcano, "Auto Start Prehistoric Raid", false, function(state)
	AutoStartPrehistoricRaid = state
	while AutoStartPrehistoricRaid do
		task.wait(10)
		startPrehistoricRaid()
	end
end)

createToggle(tabs.Volcano, "Auto Fix Lava", false, function(state)
	AutoFixLava = state
	while AutoFixLava do
		task.wait()
		fixLavaAutomatically()
	end
end)

createToggle(tabs.Volcano, "Auto Kill Lava Golem (Instant)", false, function(state)
	AutoKillLavaGolem = state
	while AutoKillLavaGolem do
		task.wait()
		killLavaGolemInstant()
	end
end)

createToggle(tabs.Volcano, "Low Pressure Always", false, function(state)
	KeepLowPressure = state
	while KeepLowPressure do
		task.wait()
		maintainLowPressure()
	end
end)

function getPlayerRace()
    local raceValue = game.Players.LocalPlayer:FindFirstChild("Data"):FindFirstChild("Race")
    return raceValue and raceValue.Value or "Unknown"
end

-- Auto Complete Trial
function autoCompleteTrial()
    local race = getPlayerRace()
    if race == "Shark" then
        spawn(killSeaBeast)
    elseif race == "Mink" then
        spawn(activateRedButton)
    elseif race == "Angel" then
        spawn(jumpSkyGreen)
    elseif race == "Human" then
        spawn(killHumanBoss)
    elseif race == "Cyborg" then
        spawn(waitCyborgBomb)
    elseif race == "Ghoul" then
        spawn(killGhoulNPC)
    end
end

-- Auto Kill Player on Trial
function autoKillTrialPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            repeat task.wait()
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(hrp.CFrame)
            until not AutoKillTrialPlayers or not player.Character:FindFirstChild("Humanoid") or player.Character.Humanoid.Health <= 0
        end
    end
end

-- Prehistoric Lava Functions
function startPrehistoricRaid()
    local btn = workspace:FindFirstChild("StartRaid")
    if btn and (btn.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(btn.Position))
        fireclickdetector(btn:FindFirstChildOfClass("ClickDetector"))
    end
end

function fixLavaAutomatically()
    for _, lava in pairs(workspace:GetDescendants()) do
        if lava.Name == "LavaLeak" then
            fireclickdetector(lava:FindFirstChildOfClass("ClickDetector"))
        end
    end
end

function maintainLowPressure()
    local valve = workspace:FindFirstChild("PressureValve")
    if valve and valve:FindFirstChildOfClass("ClickDetector") then
        fireclickdetector(valve:FindFirstChildOfClass("ClickDetector"))
    end
end

function killLavaGolemInstant()
    local golem = workspace.Enemies:FindFirstChild("Lava Golem")
    if golem and golem:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(golem.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
        wait(0.1)
        if AutoAttack then
            -- attack logic from auto attack will trigger
        end
    end
end

function findPrehistoricIsland()
    local islands = workspace:FindFirstChild("Islands")
    if islands then
        for _, island in pairs(islands:GetChildren()) do
            if island.Name:find("Prehistoric") then
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(island:FindFirstChild("TP"):GetModelCFrame())
            end
        end
    end
end

local YexHub = Instance.new("ScreenGui")
YexHub.Name = "YexHub"
YexHub.ResetOnSpawn = false
YexHub.DisplayOrder = 999
YexHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
YexHub.Parent = game:GetService("CoreGui")

-- [Continue from previous parts...]

-- Part 7: V4 / Mirage Tab
local V4Tab = TabHandler:AddTab("V4 / Mirage")

V4Tab:AddButton("Teleport: Temple of Time", function()
    -- Teleport to Temple of Time with bypass
end)

V4Tab:AddButton("Teleport: Race Door", function()
    -- Detect player race and teleport to correct race door
end)

V4Tab:AddToggle("Auto Complete Trial", false, function(state)
    -- Automatically complete trials for each race
    if state then
        local race = getPlayerRace()
        if race == "Shark" then
            autoKillSeaBeast()
        elseif race == "Mink" then
            completeMinkTrial()
        elseif race == "Angel" then
            completeAngelTrial()
        elseif race == "Human" then
            autoKillBoss()
        elseif race == "Cyborg" then
            standOnTopCyborg()
        elseif race == "Ghoul" then
            autoKillGhoulTrial()
        end
    end
end)

V4Tab:AddToggle("Auto Kill Player In Trial", false, function(enabled)
    -- Attack and kill other players in trial
end)
