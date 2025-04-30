local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/iiPR0T0TYPEUI/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("YexScript Hub", "DarkTheme")

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Farm")
MainSection:NewButton("Auto Farm Level", "Farms your level", function()
    print("Auto Farm Started")
end)

local MiscTab = Window:NewTab("Misc")
local MiscSection = MiscTab:NewSection("Settings")
MiscSection:NewSlider("Tween Speed", "Sets tween speed", 300, 1, function(v)
    print("Tween Speed:", v)
end)
