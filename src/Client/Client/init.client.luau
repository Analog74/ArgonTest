-- Services
local Camera = workspace.CurrentCamera

local Players = game:GetService('Players')
local Replicated = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')

local UIS = game:GetService('UserInputService')

-- Character
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local Animator = Humanoid:WaitForChild('Animator')
local RootPart = Character:WaitForChild('HumanoidRootPart')

local Mouse = Player:GetMouse()

-- Assets
local Assets = Replicated.Assets
local Remote = Assets.Remotes.FireRain

-- Variables
local Pressed = true

local CreateVel = require(Replicated.Modules.Shared.Velocity)

------Logic

--// Ability 1
UIS.InputBegan:Connect(function(Input)
	if UIS:GetFocusedTextBox() then return end

	if Input.KeyCode == Enum.KeyCode.Two then
		Remote:FireServer('Lightning', Mouse.Hit)
	end
end)


--//Ability 2
UIS.InputBegan:Connect(function(Input)
	if UIS:GetFocusedTextBox() then return end
		
	if Input.KeyCode == Enum.KeyCode.One then
		Remote:FireServer('Amber', Mouse.Hit)
	end
end)

workspace.Effects.ChildAdded:Connect(function(Child)
	if Child.Name == 'AmberServer' then
		local Connection
		
		local Start = Assets.Particles.Amber.AmberStart:Clone()
		Start.Position = Child.Position
		Start.Parent = workspace.Effects
		Start.Attachment.Gradient:Emit(1)
		game:GetService('Debris'):AddItem(Start, 0.65)
		
		local Arrow = Assets.Meshes.Amber.Arrow:Clone()
		Arrow.Size = Vector3.new(0.85, 0.85, 1)
		Arrow.CFrame = Child.CFrame * CFrame.Angles(math.rad(-90), 0, 0)
		Arrow.Parent = workspace.Effects
		TweenService:Create(Arrow, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(0.75, 0.75, 5)}):Play()
		
		Connection = RunService.Heartbeat:Connect(function()
			if Child.Parent then
				TweenService:Create(Arrow, TweenInfo.new(0.005, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = Child.Position}):Play()
			else
				TweenService:Create(Arrow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = Arrow.CFrame * CFrame.new(0, 0, -10)}):Play()
				
				Arrow.Specs.Enabled = false
				
				game:GetService('Debris'):AddItem(Arrow, 1)
				Connection:Disconnect()
				return
			end
		end)
	end
end)