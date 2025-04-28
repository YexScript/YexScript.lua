-- PART 1 START

-- YexScript HUB
-- Loading Screen + Key System + GUI Setup

local YexGui = Instance.new("ScreenGui")
YexGui.Name = "YexScriptHUB"
YexGui.ResetOnSpawn = false
YexGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = YexGui
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "YexScript HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 30
Title.Parent = MainFrame

local TabsHolder = Instance.new("Frame")
TabsHolder.Size = UDim2.new(0, 150, 1, -50)
TabsHolder.Position = UDim2.new(0, 0, 0, 50)
TabsHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabsHolder.BorderSizePixel = 0
TabsHolder.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -150, 1, -50)
ContentFrame.Position = UDim2.new(0, 150, 0, 50)
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local TabsList = {}

local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.BackgroundTransparency = 1
    TabButton.Text = name
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 18
    TabButton.Parent = TabsHolder

    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false
    TabFrame.Parent = ContentFrame

    TabButton.MouseButton1Click:Connect(function()
        for i, v in pairs(ContentFrame:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    TabsList[name] = TabFrame
end

-- Tabs
CreateTab("Main")
CreateTab("Teleport")
CreateTab("Misc")
CreateTab("Status")
CreateTab("Volcano")
CreateTab("V4/Mirage")
CreateTab("Settings")

-- PART 2 START

-- Variables for Auto Functions
local AutoFarmEnabled = false
local AutoRaidEnabled = false
local AutoFixVolcano = false
local AutoTrialEnabled = false
local AutoKillPlayer = false
local AutoPrehistoricRaid = false

-- Helper Functions
local function Notify(msg)
    game.StarterGui:SetCore("SendNotification", {
        Title = "YexScript Hub";
        Text = msg;
        Duration = 5;
    })
end

-- Main Tab Features
local MainTab = TabsList["Main"]

local AutoFarmButton = Instance.new("TextButton")
AutoFarmButton.Size = UDim2.new(0, 200, 0, 40)
AutoFarmButton.Position = UDim2.new(0, 10, 0, 10)
AutoFarmButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoFarmButton.Text = "Auto Farm Level (Toggle)"
AutoFarmButton.Font = Enum.Font.Gotham
AutoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmButton.TextSize = 14
AutoFarmButton.Parent = MainTab

AutoFarmButton.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    Notify("Auto Farm Level: " .. (AutoFarmEnabled and "Enabled" or "Disabled"))
end)

local AutoRaidButton = Instance.new("TextButton")
AutoRaidButton.Size = UDim2.new(0, 200, 0, 40)
AutoRaidButton.Position = UDim2.new(0, 10, 0, 60)
AutoRaidButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoRaidButton.Text = "Auto Raid (Toggle)"
AutoRaidButton.Font = Enum.Font.Gotham
AutoRaidButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoRaidButton.TextSize = 14
AutoRaidButton.Parent = MainTab

AutoRaidButton.MouseButton1Click:Connect(function()
    AutoRaidEnabled = not AutoRaidEnabled
    Notify("Auto Raid: " .. (AutoRaidEnabled and "Enabled" or "Disabled"))
end)

-- Teleport Tab Features
local TeleportTab = TabsList["Teleport"]

local function CreateTeleportButton(name, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Parent = TeleportTab
    return btn
end

local tpMirage = CreateTeleportButton("Teleport to Mirage Island", UDim2.new(0, 10, 0, 10))
local tpPrehistoric = CreateTeleportButton("Teleport to Prehistoric Island", UDim2.new(0, 10, 0, 60))

tpMirage.MouseButton1Click:Connect(function()
    Notify("Teleporting to Mirage Island...")
    -- Teleport code here
end)

tpPrehistoric.MouseButton1Click:Connect(function()
    Notify("Teleporting to Prehistoric Island...")
    -- Teleport code here
end)

-- PART 2 END
