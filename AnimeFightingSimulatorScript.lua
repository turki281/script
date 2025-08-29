-- واجهة GUI باستخدام مكتبة Roblox
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local killBotsButton = Instance.new("TextButton")
local dailyQuestsButton = Instance.new("TextButton")
local autoKillButton = Instance.new("TextButton")
local fastTrialButton = Instance.new("TextButton")
local openGateButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 200, 0, 250)

local buttons = {
    {killBotsButton, "قتل البوتات القريبة"},
    {dailyQuestsButton, "تنفيذ المهام اليومية"},
    {autoKillButton, "أوتو قتل البوتات"},
    {fastTrialButton, "إنهاء التريل"},
    {openGateButton, "فتح البوابة الثانية"}
}

for i, btnData in ipairs(buttons) do
    local btn, text = unpack(btnData)
    btn.Parent = Frame
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 45)
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- الوظائف
function killNearbyBots()
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
            if enemy.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame
                wait(0.2)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
            end
        end
    end
end

function completeDailyQuests()
    for _, quest in pairs(workspace.Quests:GetChildren()) do
        if quest:FindFirstChild("Complete") then
            quest.Complete:FireServer()
        end
    end
end

function autoKillLoop()
    while autoKillEnabled do
        killNearbyBots()
        wait(3)
    end
end

function finishTrial()
    local trial = workspace.Trials:FindFirstChild("CurrentTrial")
    if trial then
        trial:Destroy()
    end
end

function pressGateButton()
    local gateButton = workspace:FindFirstChild("GateButton2")
    if gateButton and gateButton:IsA("ClickDetector") then
        fireclickdetector(gateButton)
    end
end

-- ربط الأزرار بالوظائف
killBotsButton.MouseButton1Click:Connect(killNearbyBots)
dailyQuestsButton.MouseButton1Click:Connect(completeDailyQuests)
autoKillEnabled = false
autoKillButton.MouseButton1Click:Connect(function()
    autoKillEnabled = not autoKillEnabled
    if autoKillEnabled then
        autoKillButton.Text = "إيقاف أوتو قتل"
        spawn(autoKillLoop)
    else
        autoKillButton.Text = "تشغيل أوتو قتل"
    end
end)
fastTrialButton.MouseButton1Click:Connect(finishTrial)
openGateButton.MouseButton1Click:Connect(pressGateButton)
