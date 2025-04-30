local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
repeat task.wait() until Rayfield

local Window = Rayfield:CreateWindow({
   Name = "YexScript Hub | Blox Fruits",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "Please wait",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "YexScript",
      FileName = "YexHub"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Main", 4483362458)
Tab:CreateLabel("YexScript is loaded successfully!")
