local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YexScript HUB ",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "YexScript ",
   LoadingSubtitle = "Loading please wait",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "https://discord.gg/hsRQNYtx", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "YexScript| Key System",
      Subtitle = "Key System",
      Note = "join discord to get key", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/eQZjuxk1"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)

local SelectedWeapon = "Melee"
MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Fruit", "Gun"},
    CurrentOption = "Melee",
    Callback = function(Value)
        SelectedWeapon = Value
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoFarmLevel = state
        while getgenv().AutoFarmLevel do
            task.wait()
            -- Call your level farming function with selected weapon
        end
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Bone",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoFarmBones = state
        while getgenv().AutoFarmBones do
            task.wait()
            -- Auto bone farming function
        end
    end
})

MainTab:CreateToggle({
    Name = "Auto Farm Chest",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoChest = state
        while getgenv().AutoChest do
            task.wait()
            -- Chest farming logic
        end
    end
})

MainTab:CreateToggle({
    Name = "Auto Attack (Click)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoAttack = state
        while getgenv().AutoAttack do
            task.wait()
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    game:service('VirtualInputManager'):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    game:service('VirtualInputManager'):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                end
            end)
        end
    end
})
