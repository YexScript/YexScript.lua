local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "YexScript Hub",
	LoadingTitle = "YexScript",
	LoadingSubtitle = "by Yexbayona",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "YexScriptHub",
		FileName = "YexConfig"
	},
        Discord = {
        	Enabled = false,
        	Invite = "", 
        	RememberJoins = true
        },
	KeySystem = false,
	KeySettings = {
		Title = "YexScript Hub",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided",
		FileName = "YexKey",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = "yexhub"
	}
})

local MainTab = Window:CreateTab("Main", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local ESPTab = Window:CreateTab("ESP", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)
local StatusTab = Window:CreateTab("Status", 4483362458)
local DevilFruitTab = Window:CreateTab("Devil Fruit", 4483362458)

MainTab:CreateToggle({
	Name = "Auto Farm Level",
	CurrentValue = false,
	Flag = "AutoFarmLevel",
	Callback = function(Value)
		_G.AutoFarm = Value
		while _G.AutoFarm do
			task.wait()
			-- Auto Farm logic here
		end
	end,
})

MainTab:CreateDropdown({
	Name = "Select Weapon",
	Options = {"Melee", "Sword", "Gun", "Fruit"},
	CurrentOption = "Melee",
	Flag = "WeaponSelector",
	Callback = function(Option)
		SelectedWeapon = Option
	end,
})

MainTab:CreateToggle({
	Name = "Auto Raid",
	CurrentValue = false,
	Flag = "AutoRaid",
	Callback = function(Value)
		_G.AutoRaid = Value
		while _G.AutoRaid do
			task.wait()
			-- Auto Raid logic
		end
	end,
})

TeleportTab:CreateDropdown({
	Name = "Teleport by Sea",
	Options = {
		"Starter Island", "Jungle Island", "Pirate Village", "Desert", "Middle Town", "Frozen Village", "Marine Fortress", "SkyLands", "Prison", "Colloseume", "Magma village", "Underwater city", "Fountain city",
		"Kingdom of Rose", "Ussop island", "Cafe", "Don swan mansion", "Green Zone", "GraveYard", "Snow mountain", "Hot and cold", "Cursed ship", "Ice Castle", "Forgotten island", "Dark Arena",
		"Port Town", "Hydra Island", "Great tree", "Floating turtle", "Castle on the sea", "Hunted castle", "Sea of treats", "Tiki outpost"
	},
	CurrentOption = "Starter Island",
	Flag = "TeleportSea",
	Callback = function(Option)
		-- Teleport logic here
	end,
})

ESPTab:CreateToggle({
	Name = "ESP Fruits",
	CurrentValue = false,
	Flag = "ESPFruits",
	Callback = function(Value)
		-- ESP Fruit logic
	end,
})

ESPTab:CreateToggle({
	Name = "ESP Flowers",
	CurrentValue = false,
	Flag = "ESPFlowers",
	Callback = function(Value)
		-- ESP Flowers logic
	end,
})

MiscTab:CreateSlider({
	Name = "Farm Distance",
	Range = {0, 35},
	Increment = 1,
	CurrentValue = 10,
	Flag = "FarmDistance",
	Callback = function(Value)
		FarmDistance = Value
	end,
})

MiscTab:CreateSlider({
	Name = "Tween Speed",
	Range = {0, 300},
	Increment = 10,
	CurrentValue = 100,
	Flag = "TweenSpeed",
	Callback = function(Value)
		TweenSpeed = Value
	end,
})

MiscTab:CreateSlider({
	Name = "Bring Mob Distance",
	Range = {0, 300},
	Increment = 10,
	CurrentValue = 100,
	Flag = "BringMobDistance",
	Callback = function(Value)
		BringMobDistance = Value
	end,
})

MiscTab:CreateSlider({
	Name = "Walk Speed",
	Range = {16, 200},
	Increment = 1,
	CurrentValue = 16,
	Flag = "WalkSpeed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end,
})

StatusTab:CreateParagraph({Title = "Game Status", Content = "Mirage Island: False\nKitsune Island: False\nFull Moon: False\nLegendary Sword Dealer (Second Sea): False"})

DevilFruitTab:CreateToggle({
	Name = "Auto Random Fruit",
	CurrentValue = false,
	Flag = "AutoRandomFruit",
	Callback = function(Value)
		-- Auto random fruit logic
	end,
})

DevilFruitTab:CreateToggle({
	Name = "Auto Teleport to Fruit",
	CurrentValue = false,
	Flag = "AutoTPFruit",
	Callback = function(Value)
		-- Auto teleport logic
	end,
})

DevilFruitTab:CreateToggle({
	Name = "Auto Store Fruit",
	CurrentValue = false,
	Flag = "AutoStoreFruit",
	Callback = function(Value)
		-- Auto store logic
	end,
})
