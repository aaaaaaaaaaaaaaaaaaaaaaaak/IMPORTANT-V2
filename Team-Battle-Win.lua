--[[Wait For Game]]--
if not game:IsLoaded() then
    game.Loaded:Wait()
end

--[[Loadstrings]]--
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/notificationtest"))();
local Notify = Notification.Notify;
loadstring(game:HttpGet("https://raw.githubusercontent.com/OMOHOTA/GeneralSB/main/Credit_owner.lua"))()
Notify({Description = "Made by " .. getgenv().CreditName.DisplayYoutube .. "/" .. getgenv().CreditName.SourceYoutube ; Title = "Script Credit!"; Duration = 5;});
 
for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game.Players.LocalPlayer and player.Name == "HotoMoma" then
		game.Players.LocalPlayer:kick("You cannot join this experience, please try again later, " .. game.Players.LocalPlayer.Name)
	end
end

RunService = cloneref(game:GetService("RunService"))
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

FLYING = false
QEfly = true
iyflyspeed = 1
vehicleflyspeed = 1

local velocityHandlerName = randomString()
local gyroHandlerName = randomString()
local mfly1
local mfly2

local unmobilefly = function(speaker)
	pcall(function()
		FLYING = false
		local root = getRoot(speaker.Character)
		root:FindFirstChild(velocityHandlerName):Destroy()
		root:FindFirstChild(gyroHandlerName):Destroy()
		speaker.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
		mfly1:Disconnect()
		mfly2:Disconnect()
	end)
end

local mobilefly = function(speaker, vfly)
	unmobilefly(speaker)
	FLYING = true

	local root = getRoot(speaker.Character)
	local camera = workspace.CurrentCamera
	local v3none = Vector3.new()
	local v3zero = Vector3.new(0, 0, 0)
	local v3inf = Vector3.new(9e9, 9e9, 9e9)

	local controlModule = require(speaker.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
	local bv = Instance.new("BodyVelocity")
	bv.Name = velocityHandlerName
	bv.Parent = root
	bv.MaxForce = v3zero
	bv.Velocity = v3zero

	local bg = Instance.new("BodyGyro")
	bg.Name = gyroHandlerName
	bg.Parent = root
	bg.MaxTorque = v3inf
	bg.P = 1000
	bg.D = 50

	mfly1 = speaker.CharacterAdded:Connect(function()
		local bv = Instance.new("BodyVelocity")
		bv.Name = velocityHandlerName
		bv.Parent = root
		bv.MaxForce = v3zero
		bv.Velocity = v3zero

		local bg = Instance.new("BodyGyro")
		bg.Name = gyroHandlerName
		bg.Parent = root
		bg.MaxTorque = v3inf
		bg.P = 1000
		bg.D = 50
	end)

	mfly2 = RunService.RenderStepped:Connect(function()
		root = getRoot(speaker.Character)
		camera = workspace.CurrentCamera
		if speaker.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild(velocityHandlerName) and root:FindFirstChild(gyroHandlerName) then
			local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
			local VelocityHandler = root:FindFirstChild(velocityHandlerName)
			local GyroHandler = root:FindFirstChild(gyroHandlerName)

			VelocityHandler.MaxForce = v3inf
			GyroHandler.MaxTorque = v3inf
			if not vfly then humanoid.PlatformStand = true end
			GyroHandler.CFrame = camera.CoordinateFrame
			VelocityHandler.Velocity = v3none

			local direction = controlModule:GetMoveVector()
			if direction.X > 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.X < 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.Z > 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.Z < 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
			end
		end
	end)
end

local gui = Instance.new("ScreenGui")
gui.Name = "FakeAdminGui"
gui.Parent = game.CoreGui

local BringButton = Instance.new("TextButton", gui)
BringButton.Size = UDim2.new(0.15, 0, 0.08, 0)
BringButton.Position = UDim2.new(0.5, 0, -0.07, 0)
BringButton.BackgroundColor3 = Color3.new(0, 1, 0)
BringButton.Text = "Bring"
BringButton.Name = "Bring"
BringButton.TextSize = 20
BringButton.TextColor3 = Color3.new(0.3, 0.3, 0.3)
local DBCorner = Instance.new("UICorner", BringButton)
DBCorner.CornerRadius = UDim.new(0, 6)

local ToucheyButton = Instance.new("TextButton", gui)
ToucheyButton.Size = UDim2.new(0.15, 0, 0.08, 0)
ToucheyButton.Position = UDim2.new(0.66, 0, -0.07, 0)
ToucheyButton.BackgroundColor3 = Color3.new(0, 1, 0)
ToucheyButton.Text = "touchey"
ToucheyButton.Name = "touchey"
ToucheyButton.TextSize = 20
ToucheyButton.TextColor3 = Color3.new(0.3, 0.3, 0.3)
local TBCorner = Instance.new("UICorner", ToucheyButton)
TBCorner.CornerRadius = UDim.new(0, 6)

local BombButton = Instance.new("TextButton", gui)
BombButton.Size = UDim2.new(0.3, 0, 0.08, 0)
BombButton.Position = UDim2.new(0.6, 0, 0.02, 0)
BombButton.BackgroundColor3 = Color3.new(.5, .5, 1)
BombButton.Text = "Auto Bomb (Disabled)"
BombButton.Name = "Bomb"
BombButton.TextSize = 18
BombButton.TextColor3 = Color3.new(0.3, 0.3, 0.3)
local TBCorner = Instance.new("UICorner", ToucheyButton)
TBCorner.CornerRadius = UDim.new(0, 6)

local JoinButton = Instance.new("TextButton", gui)
JoinButton.Size = UDim2.new(0.08, 0, 0.08, 0)
JoinButton.Position = UDim2.new(0.82, 0, -0.07, 0)
JoinButton.BackgroundColor3 = Color3.new(0, 1, 1)
JoinButton.Text = "Server-HOP"
JoinButton.Name = "SHOP"
JoinButton.TextSize = 10
local JBCorner = Instance.new("UICorner", JoinButton)
JBCorner.CornerRadius = UDim.new(0, 90)

local VLB = Instance.new("TextLabel", BombButton)
VLB.Size = UDim2.new(0.15, 0, 1, 0)
VLB.Position = UDim2.new(-0.32, 0, 0, 0)
VLB.BackgroundColor3 = Color3.new(1, 1, 1)
VLB.Text = "Blue"
VLB.BackgroundTransparency = 0 
VLB.TextColor3 = Color3.new(0, 0, 1)
VLB.TextSize = 15

local VLR = Instance.new("TextLabel", BombButton)
VLR.Size = UDim2.new(0.15, 0, 1, 0)
VLR.Position = UDim2.new(-0.16, 0, 0, 0)
VLR.BackgroundColor3 = Color3.new(1, 1, 1)
VLR.Text = "Red"
VLR.BackgroundTransparency = 0 
VLR.TextColor3 = Color3.new(1, 0, 0)
VLR.TextSize = 15

hiddenfling = false
local function NoTouchey(Value)
	if Value == true then
		 if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
			 hiddenfling = true
		 else
			 hiddenfling = true
			 detection = Instance.new("Decal")
			 detection.Name = "juisdfj0i32i0eidsuf0iok"
			 detection.Parent = game:GetService("ReplicatedStorage")
			 local function fling()
				 local hrp, c, vel, movel = nil, nil, nil, 0.1
				 while true do
					 game:GetService("RunService").Heartbeat:Wait()
					 if hiddenfling then
						 local lp = game.Players.LocalPlayer
						 while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
							 game:GetService("RunService").Heartbeat:Wait()
							 c = lp.Character
							 hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
						 end
						 if hiddenfling then
							 vel = hrp.Velocity
							 hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
							 game:GetService("RunService").RenderStepped:Wait()
							 if c and c.Parent and hrp and hrp.Parent then
								 hrp.Velocity = vel
							 end
							 game:GetService("RunService").Stepped:Wait()
							 if c and c.Parent and hrp and hrp.Parent then
								 hrp.Velocity = vel + Vector3.new(0, movel, 0)
								 movel = movel * -1
							 end
						 end
					 end
				 end
			 end 
			 fling()
		 end
	elseif Value == false then
		hiddenfling = false
	end
end

local function Bring(Value)
	Toggle = Value
	while Toggle == true do
	    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
	        if player ~= game.Players.LocalPlayer then
				if game.Players.LocalPlayer.Character:FindFirstChild("SelectionBox") and player.Character:FindFirstChild("SelectionBox") then
					if player.Character:FindFirstChild("SelectionBox").Color3 ~= game.Players.LocalPlayer.Character:FindFirstChild("SelectionBox").Color3 then
			            local RootPart = player.Character.HumanoidRootPart
			            if RootPart and RootPart.Parent then
			                RootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			                RootPart.Size = Vector3.new(10, 10, 10)
			                RootPart.Transparency = 0.9
							RootPart.CanCollide = false
			            end
					end
				end
			end
	    end
	
	    task.wait(.1)
	end
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local function BombTag(Value)
	TagEnabled = Value
	if TagEnabled == true and game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
	if game.Players.LocalPlayer == nil or game.Players.LocalPlayer.Character.Humanoid.Health == 0 then TagEnabled = false return end 
		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant.Name == "Detect" then
				descendant.Size = Vector3.new(2500, 2500, 2500)
			end
		end
	elseif TagEnabled == false and game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant.Name == "Detect" then
				descendant.Size = Vector3.new(10, 10, 10)
			end
		end
	end
end

BringButton.MouseButton1Down:Connect(function()
	if BringButton.BackgroundColor3 ~= Color3.new(1,0,0) then
		BringButton.BackgroundColor3 = Color3.new(1,0,0)
		BringButton.Text = "Bringing"
		if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
			mobilefly(game.Players.LocalPlayer, true)
		end
		Bring(true)
	else
		BringButton.BackgroundColor3 = Color3.new(0,1,0)
		BringButton.Text = "Bring"
		if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
			unmobilefly(game.Players.LocalPlayer, true)
		end
		Bring(false)
	end
end)

ToucheyButton.MouseButton1Down:Connect(function()
	if ToucheyButton.BackgroundColor3 ~= Color3.new(1,0,0) then
		ToucheyButton.BackgroundColor3 = Color3.new(1,0,0)
		ToucheyButton.Text = "no touchey"
		NoTouchey(true)
	else
		ToucheyButton.BackgroundColor3 = Color3.new(0,1,0)
		ToucheyButton.Text = "touchey"
		NoTouchey(false)
	end
end)

JoinButton.MouseButton1Down:Connect(function()
	game:GetService("TeleportService"):Teleport(12470531453)
end)


BombButton.MouseButton1Down:Connect(function()
	if BombButton.Text == "Auto Bomb (Disabled)" then
		BombButton.Text = "Auto Bomb (Enabled)"
		BombTag(true)
	else
		BombButton.Text = "Auto Bomb (Disabled)"
		BombTag(false)
	end
end)

local redIsland = game.Workspace["Red Island"]
local blueIsland = game.Workspace["Blue Island"]
local bombC4Red = redIsland.C4s["Bomb C4"]
local bombC4Blue = blueIsland.C4s["Bomb C4"]
if bombC4Red and bombC4Blue and bombC4Red.Percentage and bombC4Red.Percentage.TextLabel and bombC4Blue.Percentage and bombC4Blue.Percentage.TextLabel then
    RunService.Heartbeat:connect(function()
        VLR.Text = tostring(bombC4Red.Percentage.TextLabel.Text)
        VLB.Text = tostring(bombC4Blue.Percentage.TextLabel.Text)
    end)
end
