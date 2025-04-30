local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "YexScript Hub | Blox Fruits",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "YexScript"
})

-- MAIN TAB
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
MainTab:AddButton({
    Name = "Auto Farm Level",
    Callback = function()
        print("Auto Farm Activated")
        -- Your farm logic here
    end
})

-- MISC TAB
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
MiscTab:AddSlider({
    Name = "Tween Speed",
    Min = 1,
    Max = 300,
    Default = 150,
    Increment = 1,
    Callback = function(Value)
        print("Tween Speed:", Value)
    end
})

-- ESP TAB
local ESPTab = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
ESPTab:AddToggle({
    Name = "Enable Fruit ESP",
    Default = false,
    Callback = function(Value)
        print("Fruit ESP:", Value)
    end
})

-- TELEPORT TAB
local TeleportTab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
TeleportTab:AddTextbox({
    Name = "Job ID",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Value)
    end
})

-- STATUS TAB
local StatusTab = Window:MakeTab({
    Name = "Status",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
StatusTab:AddParagraph("Mirage Island", "False")
StatusTab:AddParagraph("Full Moon", "False")

OrionLib:Init()
