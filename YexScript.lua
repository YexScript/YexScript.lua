local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local discordLink = "https://discord.gg/gAJSCeZT"
local requiredKey = "YexPogi"

local window = Rayfield:CreateWindow({
    Name = "YexScript HUB",
    LoadingTitle = "YexScript Hub Loading",
    LoadingSubtitle = "Please wait...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "YexScript",
        FileName = "Settings"
    },
    Discord = {
        Enabled = true,
        Invite = discordLink,
        Version = "1.0.0"
    },
})

local function keyCheck()
    local keyInput = Rayfield:CreateInput({
        Name = "Enter Key",
        PlaceholderText = "Join our Discord for the Key",
        RemoveTextAfterFocus = true,
        DefaultText = "",
        TextColor = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        FocusTextColor = Color3.fromRGB(0, 255, 0),
    })
    
    Rayfield:CreateButton({
        Name = "Submit Key",
        Callback = function()
            if keyInput.Text == requiredKey then
                Rayfield:Notify({
                    Title = "YexScript HUB",
                    Content = "Successful Execution!",
                    Duration = 5
                })
                loadMainScript()
            else
                Rayfield:Notify({
                    Title = "Invalid Key",
                    Content = "The key you entered is incorrect. Please join the Discord and get the correct key.",
                    Duration = 5
                })
            end
        end
    })
end

local function loadMainScript()
    local mainTab = window:CreateTab("Main", 4483362458)
    local teleportTab = window:CreateTab("Teleport", 4483362458)
    local autoFarmTab = window:CreateTab("Auto Farm", 4483362458)
    local statusTab = window:CreateTab("Status", 4483362458)

    local islandNames = {
        "Starter Island", "Jungle Island", "Pirate Village", "Desert", "Middle Town", "Frozen Village", 
        "Marine Fortress", "SkyLands", "Prison", "Colloseum", "Magma village", "Underwater city", "Fountain city",
        "Kingdom of Rose", "Ussop island", "Cafe", "Don swan mansion", "Green Zone", "GraveYard", "Snow mountain", 
        "Hot and cold", "Cursed ship", "Ice Castle", "Forgotten island", "Dark Arena",
        "Port Town", "Hydra Island", "Great tree", "Floating turtle", "Castle on the sea", "Hunted castle", 
        "Sea of treats", "Tiki outpost"
    }

    local teleportDropDown = teleportTab:CreateDropdown({
        Name = "Select Island",
        Options = islandNames,
        Callback = function(option)
            Rayfield:Notify({
                Title = "Teleporting",
                Content = "Teleporting to " .. option,
                Duration = 3
            })
            -- Teleport logic based on the selected island
            -- Implement teleporting logic here
        end
    })
    
    -- Auto-Farm Logic
    local autoFarmToggle = autoFarmTab:CreateToggle({
        Name = "Auto Farm",
        Default = false,
        Callback = function(state)
            if state then
                Rayfield:Notify({
                    Title = "Auto Farm",
                    Content = "Auto farm enabled!",
                    Duration = 3
                })
                startAutoFarm()
            else
                Rayfield:Notify({
                    Title = "Auto Farm",
                    Content = "Auto farm disabled.",
                    Duration = 3
                })
                stopAutoFarm()
            end
        end
    })
    
    -- Attack Speed
    local attackSpeedDropDown = mainTab:CreateDropdown({
        Name = "Select Attack Speed",
        Options = {"Normal (6/s)", "Fast (8/s)", "Super Fast (10/s)"},
        Callback = function(option)
            if option == "Normal (6/s)" then
                -- Set to normal speed logic
            elseif option == "Fast (8/s)" then
                -- Set to fast speed logic
            elseif option == "Super Fast (10/s)" then
                -- Set to super fast speed logic
            end
        end
    })
    
    local function startAutoFarm()
        local playerLevel = game.Players.LocalPlayer.Data.Level.Value
        local questGiver = getQuestGiverForLevel(playerLevel)
        
        -- Logic to take the quest based on player level
        takeQuest(questGiver)
        
        -- Killing NPCs using selected attack method (Auto Attack)
        while autoFarmToggle.Enabled do
            -- Find and attack NPCs based on level and quest requirements
            local npcs = game.Workspace:FindPartsInRegion3(workspace.CurrentCamera.CFrame.Position, Vector3.new(50, 50, 50), nil)
            for _, npc in pairs(npcs) do
                if npc:IsA("Model") and npc:FindFirstChild("Humanoid") then
                    npc.Humanoid:TakeDamage(9999) -- Modify damage as needed
                end
            end
            wait(1)
        end
    end
    
    local function stopAutoFarm()
        -- Stop farming logic here
    end
    
    local function takeQuest(questGiver)
        -- Quest taking logic based on the quest giver
        if questGiver then
            questGiver.Talk:Fire()
        end
    end
    
    -- Update Status in Real-Time
    local function updateStatus()
        local statusLabel = statusTab:CreateLabel({
            Name = "Status",
            Content = "Mirage Island: Checking... | Kitsune Island: Checking... | Full Moon: Checking..."
        })

        while true do
            local mirageIslandStatus = "Not Available"
            local kitsuneIslandStatus = "Not Available"
            local fullMoonStatus = "Not Full Moon"
            local legendarySwordDealer = "Not Available"
            
            if game.Workspace:FindFirstChild("Mirage Island") then
                mirageIslandStatus = "Available"
            end
            if game.Workspace:FindFirstChild("Kitsune Island") then
                kitsuneIslandStatus = "Available"
            end
            if game.Workspace:FindFirstChild("Full Moon") then
                fullMoonStatus = "Full Moon"
            end
            if game.Workspace:FindFirstChild("Legendary Sword Dealer") then
                legendarySwordDealer = "Available"
            end

            statusLabel:SetContent("Mirage Island: " .. mirageIslandStatus .. " | Kitsune Island: " .. kitsuneIslandStatus .. " | Full Moon: " .. fullMoonStatus)

            Rayfield:Notify({
                Title = "Legendary Sword Dealer",
                Content = "Legendary Sword Dealer: " .. legendarySwordDealer,
                Duration = 5
            })

            wait(5)
        end
    end
    
    updateStatus()
end

keyCheck()
