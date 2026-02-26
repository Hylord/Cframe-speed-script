local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local HylordSpeedValue = 16
local IsSpeedActive = false
local SpeedConnection = nil

Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)

local HylordGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local SpeedInputBox = Instance.new("TextBox")
local ToggleSpeedBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local UICorner_Main = Instance.new("UICorner")
local UICorner_Btn = Instance.new("UICorner")
local UICorner_Input = Instance.new("UICorner")

HylordGui.Name = "HylordUniversalHub"
HylordGui.Parent = game.CoreGui or Player:WaitForChild("PlayerGui")
HylordGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = HylordGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -100)
MainFrame.Size = UDim2.new(0, 270, 0, 220)
MainFrame.ClipsDescendants = true

UICorner_Main.CornerRadius = UDim.new(0, 8)
UICorner_Main.Parent = MainFrame

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.Size = UDim2.new(1, 0, 0, 35)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Hylord Universal Hub v2.0"
Title.TextColor3 = Color3.fromRGB(90, 100, 255)
Title.TextSize = 16.000
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 16.000

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ContentFrame.BackgroundTransparency = 1.000
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.Size = UDim2.new(1, 0, 1, -35)

SpeedInputBox.Name = "SpeedInputBox"
SpeedInputBox.Parent = ContentFrame
SpeedInputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
SpeedInputBox.Position = UDim2.new(0.1, 0, 0.15, 0)
SpeedInputBox.Size = UDim2.new(0.8, 0, 0, 40)
SpeedInputBox.Font = Enum.Font.GothamSemibold
SpeedInputBox.PlaceholderText = "Enter CFrame Speed (Ex: 2)"
SpeedInputBox.Text = ""
SpeedInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInputBox.TextSize = 14.000
UICorner_Input.CornerRadius = UDim.new(0, 6)
UICorner_Input.Parent = SpeedInputBox

ToggleSpeedBtn.Name = "ToggleSpeedBtn"
ToggleSpeedBtn.Parent = ContentFrame
ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ToggleSpeedBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleSpeedBtn.Size = UDim2.new(0.8, 0, 0, 45)
ToggleSpeedBtn.Font = Enum.Font.GothamBold
ToggleSpeedBtn.Text = "ENABLE SPEED"
ToggleSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleSpeedBtn.TextSize = 15.000
UICorner_Btn.CornerRadius = UDim.new(0, 6)
UICorner_Btn.Parent = ToggleSpeedBtn

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = ContentFrame
StatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundTransparency = 1.000
StatusLabel.Position = UDim2.new(0, 0, 0.8, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "System: Standby"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 12.000

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

CloseBtn.MouseEnter:Connect(function() CloseBtn.BackgroundTransparency = 0 end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.BackgroundTransparency = 1 end)

CloseBtn.MouseButton1Click:Connect(function()
    if SpeedConnection then
        SpeedConnection:Disconnect()
    end
    HylordGui:Destroy()
end)

local function CFrameMovement()
    if Character and Humanoid and RootPart and IsSpeedActive then
        if Humanoid.MoveDirection.Magnitude > 0 then
            local moveVector = Humanoid.MoveDirection * (HylordSpeedValue / 10)
            RootPart.CFrame = RootPart.CFrame + moveVector
        end
    end
end

ToggleSpeedBtn.MouseButton1Click:Connect(function()
    IsSpeedActive = not IsSpeedActive
    
    if IsSpeedActive then
        local inputVal = tonumber(SpeedInputBox.Text)
        if inputVal then
            HylordSpeedValue = inputVal
        else
            HylordSpeedValue = 2 
            SpeedInputBox.Text = "2"
        end

        ToggleSpeedBtn.Text = "SPEED ACTIVE (CFrame: " .. tostring(HylordSpeedValue) .. ")"
        ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(45, 180, 90)
        StatusLabel.Text = "System: Bypassing Anti-Cheat..."
        StatusLabel.TextColor3 = Color3.fromRGB(90, 255, 90)

        if not SpeedConnection then
            SpeedConnection = RunService.RenderStepped:Connect(CFrameMovement)
        end
    else
        ToggleSpeedBtn.Text = "ENABLE SPEED"
        ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        StatusLabel.Text = "System: Normal Speed"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)

        if SpeedConnection then
            SpeedConnection:Disconnect()
            SpeedConnection = nil
        end
    end
end)

print("[Hylord Systems] Universal CFrame Hub Loaded.")