-- Noob_x Hub for Anime Fighters Simulator
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Noob_x = library.CreateLib("Noob_x Hub", "Ocean")

-- AutoFarm Tab
local autoFarm = Noob_x:NewTab("AutoFarm")
local autoFarmSection = autoFarm:NewSection("Farming & Killing")

autoFarmSection:NewToggle("Auto Kill Nearby", "Kills nearby enemies automatically", function(state)
    _G.AutoKill = state
end)

autoFarmSection:NewToggle("Auto Click Damage", "Clicks to deal damage automatically", function(state)
    _G.AutoClick = state
end)

autoFarmSection:NewToggle("Auto Collect Yen", "Collects Yen automatically", function(state)
    _G.AutoYen = state
end)

autoFarmSection:NewTextBox("Target Enemy Name", "Enter enemy name to auto kill", function(txt)
    _G.TargetEnemy = txt
end)

autoFarmSection:NewButton("Refresh Enemies", "Refresh enemy list", function()
    print("Enemy list refreshed")
end)

autoFarmSection:NewToggle("Auto Meteor", "Collects meteors automatically", function(state)
    _G.AutoMeteor = state
end)

autoFarmSection:NewToggle("Auto Time Trial", "Starts time trial automatically", function(state)
    _G.AutoTrial = state
end)

autoFarmSection:NewToggle("Auto Skip Room", "Skips trial rooms automatically", function(state)
    _G.AutoSkip = state
end)

-- Egg Tab
local eggTab = Noob_x:NewTab("Egg")
local eggSection = eggTab:NewSection("Egg Opening")

eggSection:NewDropdown("Select Egg Type", "Choose egg to open", {"Basic", "Legendary", "Mythic"}, function(choice)
    _G.EggType = choice
end)

eggSection:NewToggle("Auto Open Eggs", "Opens eggs automatically", function(state)
    _G.AutoEgg = state
end)

-- Teleport Tab
local teleportTab = Noob_x:NewTab("Teleport")
local teleportSection = teleportTab:NewSection("Teleport Zones")

teleportSection:NewButton("Teleport to Spawn", "Teleports to spawn area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
end)

teleportSection:NewButton("Teleport to Boss", "Teleports to boss area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1000, 5, 1000)
end)

teleportSection:NewButton("Teleport to Trial", "Teleports to time trial", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2000, 5, 2000)
end)

teleportSection:NewButton("Teleport to Meteor Zone", "Teleports to meteor zone", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3000, 5, 3000)
end)

-- Misc Tab
local miscTab = Noob_x:NewTab("Misc")
local miscSection = miscTab:NewSection("Performance & Settings")

miscSection:NewToggle("Low Graphics Mode", "Improves performance by reducing effects", function(state)
    if state then
        for _, v in pairs(game.Lighting:GetChildren()) do
            v.Enabled = false
        end
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 100000
    else
        print("Graphics reset manually")
    end
end)

miscSection:NewButton("Anti AFK", "Prevents being kicked for inactivity", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)



local SettingsTab = Window:MakeTab({
    Name = "الإعدادات / Settings",
    Icon = "rbxassetid://7734053494",
    PremiumOnly = false
})

local currentLanguage = "Arabic"

local function updateLanguage()
    if currentLanguage == "Arabic" then
        AutoFarmTab:SetName("الفارم التلقائي")
        EggTab:SetName("البيض")
        TeleportTab:SetName("النقل")
        MiscTab:SetName("متفرقات")
        SettingsTab:SetName("الإعدادات")
    else
        AutoFarmTab:SetName("AutoFarm")
        EggTab:SetName("Egg")
        TeleportTab:SetName("Teleport")
        MiscTab:SetName("Misc")
        SettingsTab:SetName("Settings")
    end
end

SettingsTab:AddDropdown({
    Name = "اختر اللغة / Select Language",
    Default = "Arabic",
    Options = {"Arabic", "English"},
    Callback = function(Value)
        currentLanguage = Value
        updateLanguage()
    end
})
