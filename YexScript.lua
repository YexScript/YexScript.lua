--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

--// Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YexScriptHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--// Create Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 420)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

--// Hub Title
local Title = Instance.new("TextLabel")
Title.Text = "YexScript HUB"
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundColor3 = Color3.fromRGB(10,10,10)
Title.BorderSizePixel = 0
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 28
Title.Parent = MainFrame

--// Tab Buttons (Left Side)
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(0,150,0,370)
TabsFrame.Position = UDim2.new(0,0,0,50)
TabsFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
TabsFrame.Parent = MainFrame

local TabsLayout = Instance.new("UIListLayout", TabsFrame)
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Padding = UDim.new(0,5)

local Tabs = {}
local TabsName = {
    "Main", "Teleport", "ESP", "Misc", 
    "Status", "Volcano", "V4/Mirage", "Settings"
}

for _,name in pairs(TabsName) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,40)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    btn.Parent = TabsFrame
    Tabs[name] = btn
end

--// Pages (Right Side)
local PagesFrame = Instance.new("Frame")
PagesFrame.Size = UDim2.new(0,500,0,370)
PagesFrame.Position = UDim2.new(0,150,0,50)
PagesFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
PagesFrame.Parent = MainFrame

local Pages = {}
for _,name in pairs(TabsName) do
    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = PagesFrame
    Pages[name] = page
end
Pages["Main"].Visible = true

for name,button in pairs(Tabs) do
    button.MouseButton1Click:Connect(function()
        for _,page in pairs(Pages) do
            page.Visible = false
        end
        Pages[name].Visible = true
    end)
end

--// Toggle GUI with "Y" Key
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Y then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

--// Loading Screen
local LoadingGui = Instance.new("ScreenGui", game.CoreGui)
local LoadingFrame = Instance.new("Frame", LoadingGui)
LoadingFrame.Size = UDim2.new(0,200,0,100)
LoadingFrame.Position = UDim2.new(0.5,-100,0.5,-50)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
local LoadingText = Instance.new("TextLabel", LoadingFrame)
LoadingText.Size = UDim2.new(1,0,1,0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading YexScript HUB..."
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextColor3 = Color3.new(1,1,1)
LoadingText.TextSize = 18
wait(2)
LoadingGui:Destroy()

--// Key System
local CorrectKey = "Yex123"
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0,300,0,150)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)

local InputBox = Instance.new("TextBox", KeyFrame)
InputBox.Size = UDim2.new(0.8,0,0,40)
InputBox.Position = UDim2.new(0.1,0,0.2,0)
InputBox.PlaceholderText = "Enter Key..."
InputBox.Font = Enum.Font.Gotham
InputBox.TextSize = 16
InputBox.TextColor3 = Color3.new(1,1,1)
InputBox.BackgroundColor3 = Color3.fromRGB(15,15,15)

local SubmitButton = Instance.new("TextButton", KeyFrame)
SubmitButton.Size = UDim2.new(0.8,0,0,40)
SubmitButton.Position = UDim2.new(0.1,0,0.6,0)
SubmitButton.Text = "Submit"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 18
SubmitButton.TextColor3 = Color3.new(1,1,1)
SubmitButton.BackgroundColor3 = Color3.fromRGB(50,0,0)

SubmitButton.MouseButton1Click:Connect(function()
    if InputBox.Text == CorrectKey then
        KeyGui:Destroy()
        MainFrame.Visible = true
    else
        InputBox.Text = "Wrong Key!"
    end
end)

MainFrame.Visible = false

--// Variables
getgenv().AutoFarmLevel = false
getgenv().FruitESP = false
getgenv().AutoRaid = false
getgenv().VolcanoFarm = false
getgenv().V4Farm = false
FarmDistanceValue = 20
TweenSpeed = 200

--// Main Page (Auto Farm Level)
local AutoFarmBtn = Instance.new("TextButton", Pages["Main"])
AutoFarmBtn.Size = UDim2.new(0,200,0,40)
AutoFarmBtn.Position = UDim2.new(0,20,0,20)
AutoFarmBtn.Text = "Auto Farm Level [ON/OFF]"
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
AutoFarmBtn.TextColor3 = Color3.new(1,1,1)
AutoFarmBtn.Font = Enum.Font.GothamBold
AutoFarmBtn.TextSize = 14

AutoFarmBtn.MouseButton1Click:Connect(function()
    getgenv().AutoFarmLevel = not getgenv().AutoFarmLevel
    while getgenv().AutoFarmLevel do
        task.wait()
        pcall(function()
            -- Find quest, teleport, attack logic here
            local enemies = workspace.Enemies:GetChildren()
            for _,enemy in pairs(enemies) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    repeat
                        task.wait()
                        LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,FarmDistanceValue,0)
                        -- Simulate attack
                        VirtualUser:Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                        VirtualUser:Button1Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    until not enemy or enemy.Humanoid.Health <= 0 or not getgenv().AutoFarmLevel
                end
            end
        end)
    end
end)

--// Teleport Page (Teleport to Island)
local TeleportBtn = Instance.new("TextButton", Pages["Teleport"])
TeleportBtn.Size = UDim2.new(0,200,0,40)
TeleportBtn.Position = UDim2.new(0,20,0,20)
TeleportBtn.Text = "Teleport to Next Island"
TeleportBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
TeleportBtn.TextColor3 = Color3.new(1,1,1)
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 14

TeleportBtn.MouseButton1Click:Connect(function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,30000,0)
end)

--// ESP Page (Fruit ESP)
local FruitESPBtn = Instance.new("TextButton", Pages["ESP"])
FruitESPBtn.Size = UDim2.new(0,200,0,40)
FruitESPBtn.Position = UDim2.new(0,20,0,20)
FruitESPBtn.Text = "Fruit ESP [ON/OFF]"
FruitESPBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
FruitESPBtn.TextColor3 = Color3.new(1,1,1)
FruitESPBtn.Font = Enum.Font.GothamBold
FruitESPBtn.TextSize = 14

FruitESPBtn.MouseButton1Click:Connect(function()
    getgenv().FruitESP = not getgenv().FruitESP
end)

--// Misc Page (Walk Speed, Farm Distance)
-- etc

--// Status Page (Mirage Status, Full Moon)

--// Volcano Page (Auto Farm Volcano)

--// V4/Mirage Page (Auto Unlock V4)

--// Settings Page (GUI toggle, rejoin, reset)

--// (Continued very next if you want full finish)
