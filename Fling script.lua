-- Touch Fling GUI (Fixed Minimize & Close Cleanup)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.388, 0, 0.427, 0)
Frame.Size = UDim2.new(0, 158, 0, 110)
Frame.ClipsDescendants = true

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Size = UDim2.new(0, 158, 0, 25)

TextLabel.Parent = Frame_2
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.05, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 95, 0, 25)
TextLabel.Font = Enum.Font.Sarpanch
TextLabel.Text = "Touch Fling"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 18.000
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Parent = Frame_2
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0.68, 0, 0.1, 0)
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18.000

CloseButton.Parent = Frame_2
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.83, 0, 0.1, 0)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16.000

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.113, 0, 0.418, 0)
TextButton.Size = UDim2.new(0, 121, 0, 37)
TextButton.Font = Enum.Font.SourceSansItalic
TextButton.Text = "OFF"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 20.000

local function MAIN_SCRIPT()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer

    local toggleButton = TextButton
    local hiddenfling = false
    local highlight = nil
    local isMinimized = false

    Frame.Active = true
    Frame.Draggable = true

    if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
        local detection = Instance.new("Decal")
        detection.Name = "juisdfj0i32i0eidsuf0iok"
        detection.Parent = ReplicatedStorage
    end

    local function setHighlight(state)
        if state then
            if not highlight or not highlight.Parent then
                highlight = Instance.new("Highlight")
                highlight.Name = "FlingGlowEffect"
                highlight.FillTransparency = 1
                highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineTransparency = 0
            end
            if lp.Character then
                highlight.Parent = lp.Character
            end
        else
            if highlight then
                highlight:Destroy()
                highlight = nil
            end
            if lp.Character then
                local existingGlow = lp.Character:FindFirstChild("FlingGlowEffect")
                if existingGlow then
                    existingGlow:Destroy()
                end
            end
        end
    end

    lp.CharacterAdded:Connect(function(char)
        if hiddenfling then
            task.wait(0.1)
            setHighlight(true)
        end
    end)

    local function fling()
        local c, hrp, vel, movel = nil, nil, nil, 0.1

        while hiddenfling do
            RunService.Heartbeat:Wait()
            c = lp.Character
            hrp = c and c:FindFirstChild("HumanoidRootPart")

            if hrp then
                vel = hrp.Velocity
                hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                RunService.RenderStepped:Wait()
                hrp.Velocity = vel
                RunService.Stepped:Wait()
                hrp.Velocity = vel + Vector3.new(0, movel, 0)
                movel = -movel
            end
        end
    end

    toggleButton.MouseButton1Click:Connect(function()
        hiddenfling = not hiddenfling
        toggleButton.Text = hiddenfling and "ON" or "OFF"
        toggleButton.BackgroundColor3 = hiddenfling and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 255, 255)

        setHighlight(hiddenfling)

        if hiddenfling then
            local flingThread = coroutine.create(fling)
            coroutine.resume(flingThread)
        end
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            Frame.Size = UDim2.new(0, 158, 0, 25)
            TextButton.Visible = false
            MinimizeButton.Text = "+"
        else
            Frame.Size = UDim2.new(0, 158, 0, 110)
            TextButton.Visible = true
            MinimizeButton.Text = "-"
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        hiddenfling = false
        setHighlight(false)
        ScreenGui:Destroy()
    end)
end

coroutine.wrap(MAIN_SCRIPT)()
