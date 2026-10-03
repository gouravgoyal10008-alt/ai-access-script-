local R = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local W = R:CreateWindow({Name = "G.G Ninja Gaming | Hub", LoadingTitle = "Loading...", LoadingSubtitle = "by G.G Ninja", ConfigurationSaving = {Enabled = false}, KeySystem = false})
local function n(t, c) R:Notify({Title = t, Content = c, Duration = 3}) end
local function safeLoad(u, name)
local s = pcall(function() loadstring(game:HttpGet(u))() end)
n(s and "Success" or "Error", name..(s and " loaded!" or " failed!"))
end
local function c(cls, props)
local obj = Instance.new(cls)
for i, v in pairs(props or {}) do obj[i] = v end
return obj
end

local M = W:CreateTab("MM2 Scripts", 4483362458)
M:CreateSection("Utility & Visuals")

M:CreateButton({Name = "Invisible GUI", Callback = function()
if _G.a then for _, v in pairs(_G.a) do v:Disconnect() end _G.a = nil end
local player = game.Players.LocalPlayer
local character, humanoid, rootPart, isEnabled, parts = nil, nil, nil, false, {}
local function updateCharacterData()
character = player.Character or player.CharacterAdded:Wait()
humanoid = character:WaitForChild("Humanoid")
rootPart = character:WaitForChild("HumanoidRootPart")
parts = {}
for _, v in pairs(character:GetDescendants()) do if v:IsA("BasePart") and v.Transparency == 0 then table.insert(parts, v) end end
end
local function createStyledGui()
local sg = c("ScreenGui", {Parent = player:WaitForChild("PlayerGui"), Name = "InvisibleGuiSystem_Pro", ResetOnSpawn = false})
local mainFrame = c("Frame", {Parent = sg, Size = UDim2.new(0, 160, 0, 70), Position = UDim2.new(0.5, -80, 0.1, 0), BackgroundColor3 = Color3.fromRGB(18, 18, 24), BorderSizePixel = 0, Active = true})
c("UICorner", {Parent = mainFrame, CornerRadius = UDim.new(0, 12)})
c("UIStroke", {Parent = mainFrame, Color = Color3.fromRGB(45, 45, 60), Thickness = 1.5})
c("TextLabel", {Parent = mainFrame, Size = UDim2.new(1, -55, 0, 22), Position = UDim2.new(0, 8, 0, 4), BackgroundTransparency = 1, Text = "Invisible GUI", TextColor3 = Color3.fromRGB(150, 150, 175), Font = Enum.Font.GothamBold, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left})
local lockBtn = c("TextButton", {Parent = mainFrame, Size = UDim2.new(0, 50, 0, 20), Position = UDim2.new(1, -54, 0, 5), BackgroundColor3 = Color3.fromRGB(28, 28, 38), Text = "unlock 🔓", TextColor3 = Color3.fromRGB(180, 180, 200), Font = Enum.Font.GothamBold, TextSize = 9, AutoButtonColor = false})
c("UICorner", {Parent = lockBtn, CornerRadius = UDim.new(0, 6)})
local btn = c("TextButton", {Parent = mainFrame, Size = UDim2.new(1, -16, 0, 36), Position = UDim2.new(0, 8, 0, 26), BackgroundColor3 = Color3.fromRGB(28, 28, 38), Text = "OFF", TextColor3 = Color3.fromRGB(255, 75, 75), Font = Enum.Font.GothamBold, TextSize = 13, AutoButtonColor = false})
c("UICorner", {Parent = btn, CornerRadius = UDim.new(0, 8)})
local btnStroke = c("UIStroke", {Parent = btn, Color = Color3.fromRGB(255, 75, 75), Thickness = 1.5})
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos, isLocked = false, nil, nil, nil, false
lockBtn.MouseButton1Click:Connect(function()
isLocked = not isLocked
lockBtn.Text = isLocked and "lock 🔐" or "unlock 🔓"
lockBtn.TextColor3 = isLocked and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 255, 120)
end)
mainFrame.InputBegan:Connect(function(input)
if isLocked then return end
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging, dragStart, startPos = true, input.Position, mainFrame.Position
input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
end
end)
mainFrame.InputChanged:Connect(function(input)
if not isLocked and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then dragInput = input end
end)
UIS.InputChanged:Connect(function(input)
if not isLocked and input == dragInput and dragging then
local delta = input.Position - dragStart
mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)
local function toggle()
isEnabled = not isEnabled
btn.Text = isEnabled and "ACTIVE" or "OFF"
btn.TextColor3 = isEnabled and Color3.fromRGB(75, 255, 120) or Color3.fromRGB(255, 75, 75)
btnStroke.Color = isEnabled and Color3.fromRGB(75, 255, 120) or Color3.fromRGB(255, 75, 75)
btn.BackgroundColor3 = isEnabled and Color3.fromRGB(20, 45, 28) or Color3.fromRGB(28, 28, 38)
for _, v in pairs(parts) do v.Transparency = isEnabled and 0.5 or 0 end
end
btn.MouseButton1Click:Connect(toggle)
return toggle
end
updateCharacterData()
createStyledGui()
local h = {}
h[1] = game:GetService("RunService").Heartbeat:Connect(function()
if isEnabled and rootPart and humanoid then
local oldCF, oldOffset = rootPart.CFrame, humanoid.CameraOffset
local hideCF = oldCF * CFrame.new(0, -200000, 0)
rootPart.CFrame = hideCF
humanoid.CameraOffset = hideCF:ToObjectSpace(CFrame.new(oldCF.Position)).Position
game:GetService("RunService").RenderStepped:Wait()
rootPart.CFrame, humanoid.CameraOffset = oldCF, oldOffset
end
end)
player.CharacterAdded:Connect(function() isEnabled = false task.wait(1) updateCharacterData() end)
_G.a = h
n("Success", "Invisible GUI loaded!")
end})

M:CreateButton({Name = "Fly v2", Callback = function() safeLoad("https://rawscripts.net/raw/Universal-Script-Flyv2-30617", "Fly v2") end})

M:CreateButton({Name = "Fling v2", Callback = function()
local RS, RService, Players = game:GetService("ReplicatedStorage"), game:GetService("RunService"), game:GetService("Players")
local lp = Players.LocalPlayer
local sg = c("ScreenGui", {Parent = lp:WaitForChild("PlayerGui"), ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ResetOnSpawn = false})
local frame = c("Frame", {Parent = sg, BackgroundColor3 = Color3.fromRGB(34,34,34), BorderSizePixel = 0, Position = UDim2.new(0.388,0,0.427,0), Size = UDim2.new(0,158,0,110), ClipsDescendants = true, Active = true, Draggable = true})
local f2 = c("Frame", {Parent = frame, BackgroundColor3 = Color3.fromRGB(50,50,50), BorderSizePixel = 0, Size = UDim2.new(0,158,0,25)})
c("TextLabel", {Parent = f2, BackgroundTransparency = 1, Position = UDim2.new(0.05,0,0,0), Size = UDim2.new(0,95,0,25), Font = Enum.Font.Sarpanch, Text = "Touch Fling", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left})
local minBtn = c("TextButton", {Parent = f2, BackgroundColor3 = Color3.fromRGB(70,70,70), BorderSizePixel = 0, Position = UDim2.new(0.68,0,0.1,0), Size = UDim2.new(0,20,0,20), Font = Enum.Font.SourceSansBold, Text = "-", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 18})
local clsBtn = c("TextButton", {Parent = f2, BackgroundColor3 = Color3.fromRGB(180,40,40), BorderSizePixel = 0, Position = UDim2.new(0.83,0,0.1,0), Size = UDim2.new(0,20,0,20), Font = Enum.Font.SourceSansBold, Text = "X", TextColor3 = Color3.fromRGB(255,255,255), TextSize = 16})
local tBtn = c("TextButton", {Parent = frame, BackgroundColor3 = Color3.fromRGB(255,255,255), BorderSizePixel = 0, Position = UDim2.new(0.113,0,0.418,0), Size = UDim2.new(0,121,0,37), Font = Enum.Font.SourceSansItalic, Text = "OFF", TextColor3 = Color3.fromRGB(0,0,0), TextSize = 20})
if not RS:FindFirstChild("juisdfj0i32i0eidsuf0iok") then c("Decal", {Name = "juisdfj0i32i0eidsuf0iok", Parent = RS}) end
local hiddenfling, highlight, isMin = false, nil, false
local function setHL(state)
if state then
if not highlight or not highlight.Parent then highlight = c("Highlight", {Name = "FlingGlowEffect", FillTransparency = 1, OutlineColor = Color3.fromRGB(255,0,0), OutlineTransparency = 0}) end
if lp.Character then highlight.Parent = lp.Character end
else
if highlight then highlight:Destroy() highlight = nil end
if lp.Character then local ex = lp.Character:FindFirstChild("FlingGlowEffect") if ex then ex:Destroy() end end
end
end
lp.CharacterAdded:Connect(function() if hiddenfling then task.wait(0.1) setHL(true) end end)
tBtn.MouseButton1Click:Connect(function()
hiddenfling = not hiddenfling
tBtn.Text = hiddenfling and "ON" or "OFF"
tBtn.BackgroundColor3 = hiddenfling and Color3.fromRGB(100,255,100) or Color3.fromRGB(255,255,255)
setHL(hiddenfling)
if hiddenfling then
task.spawn(function()
local cObj, hrp, vel, movel = nil, nil, nil, 0.1
while hiddenfling do
RService.Heartbeat:Wait()
cObj = lp.Character
hrp = cObj and cObj:FindFirstChild("HumanoidRootPart")
if hrp then
vel = hrp.Velocity
hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
RService.RenderStepped:Wait()
hrp.Velocity = vel
RService.Stepped:Wait()
hrp.Velocity = vel + Vector3.new(0, movel, 0)
movel = -movel
end
end
end)
end
end)
minBtn.MouseButton1Click:Connect(function()
isMin = not isMin
frame.Size = isMin and UDim2.new(0, 158, 0, 25) or UDim2.new(0, 158, 0, 110)
tBtn.Visible = not isMin
minBtn.Text = isMin and "+" or "-"
end)
clsBtn.MouseButton1Click:Connect(function() hiddenfling = false setHL(false) sg:Destroy() end)
n("Success", "Fling v2 loaded!")
end})

M:CreateButton({Name = "Anti Fling", Callback = function() safeLoad("https://rawscripts.net/raw/Universal-Script-anti-fling-script-241540", "Anti Fling") end})

M:CreateButton({Name = "Reset-TP", Callback = function()
local Players, CoreGui, TweenService, UserInputService = game:GetService("Players"), game:GetService("CoreGui"), game:GetService("TweenService"), game:GetService("UserInputService")
local lp = Players.LocalPlayer
if CoreGui:FindFirstChild("MobileResetMenu") then CoreGui.MobileResetMenu:Destroy() end
local screenGui = c("ScreenGui", {Name = "MobileResetMenu", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
pcall(function() screenGui.Parent = CoreGui end)
if not screenGui.Parent then screenGui.Parent = lp:WaitForChild("PlayerGui") end
local rBtn = c("TextButton", {Name = "ResetButton", Size = UDim2.new(0, 130, 0, 50), Position = UDim2.new(0.05, 0, 0.4, 0), BackgroundColor3 = Color3.fromRGB(30, 30, 35), BackgroundTransparency = 0.2, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Font = Enum.Font.GothamBold, Text = "⚡ DOUBLE TAP", AutoButtonColor = false, Parent = screenGui})
c("UICorner", {CornerRadius = UDim.new(0, 12), Parent = rBtn})
local uiStroke = c("UIStroke", {Color = Color3.fromRGB(220, 50, 50), Thickness = 2, Parent = rBtn})
local function animateButton(tSize, tColor) TweenService:Create(rBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = tSize, BackgroundColor3 = tColor}):Play() end
local dragging, dragInput, dragStart, startPos, isDragging = false, nil, nil, nil, false
rBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging, isDragging, dragStart, startPos = true, false, input.Position, rBtn.Position
animateButton(UDim2.new(0, 124, 0, 48), Color3.fromRGB(50, 50, 60))
input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false animateButton(UDim2.new(0, 130, 0, 50), Color3.fromRGB(30, 30, 35)) end end)
end
end)
rBtn.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then isDragging = true end
rBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)
local oneTimeTeleportCFrame, armedByButton = nil, false
local function setupCharacter(char)
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
if oneTimeTeleportCFrame then
task.defer(function()
task.wait(0.1)
if char and char:FindFirstChild("HumanoidRootPart") then char:SetPrimaryPartCFrame(oneTimeTeleportCFrame) end
oneTimeTeleportCFrame = nil
end)
end
hum.Died:Connect(function() if armedByButton and root and root.Parent then oneTimeTeleportCFrame = root.CFrame armedByButton = false end end)
end
lp.CharacterAdded:Connect(setupCharacter)
if lp.Character then setupCharacter(lp.Character) end
local lastTapTick, doubleTapThreshold = 0, 0.35
rBtn.MouseButton1Click:Connect(function()
if isDragging then return end
local curTick = tick()
if (curTick - lastTapTick) <= doubleTapThreshold then
lastTapTick = 0
rBtn.Text = "💀 RESETTING..."
uiStroke.Color = Color3.fromRGB(0, 255, 100)
task.delay(0.5, function() if rBtn and rBtn.Parent then rBtn.Text = "⚡ DOUBLE TAP" uiStroke.Color = Color3.fromRGB(220, 50, 50) end end)
local char = lp.Character
if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then armedByButton = true hum.Health = 0 end end
else
lastTapTick = curTick
rBtn.Text = "⏳ TAP AGAIN!"
uiStroke.Color = Color3.fromRGB(255, 200, 0)
task.delay(doubleTapThreshold, function() if lastTapTick ~= 0 and rBtn and rBtn.Parent then lastTapTick = 0 rBtn.Text = "⚡ DOUBLE TAP" uiStroke.Color = Color3.fromRGB(220, 50, 50) end end)
end
end)
n("Success", "Reset-TP loaded!")
end})

M:CreateButton({Name = "MM2 67", Callback = function() safeLoad("https://raw.smokingscripts.org/vertex.lua", "MM2 67") end})
M:CreateButton({Name = "Delete Menu", Callback = function() R:Destroy() end})

local U = W:CreateTab("Universal~S", 4483362458)
U:CreateSection("Universal Tools")
U:CreateButton({Name = "All-Emotes", Callback = function() safeLoad("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024", "All-Emotes") end})
U:CreateButton({Name = "Delete Menu", Callback = function() R:Destroy() end})

local E = W:CreateTab("Menu Management", 4483345998)
E:CreateSection("UI Controls")
E:CreateButton({Name = "Delete Menu", Callback = function() R:Destroy() end})
