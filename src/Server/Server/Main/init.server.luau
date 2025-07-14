-- Services
local Replicated = game:GetService('ReplicatedStorage')

-- Assets
local Assets = Replicated.Assets
local Remote = Assets.Remotes.FireRain
local FXRemote = Assets.Remotes.FX

-- Modules
local Hitbox = require(script.Hitbox)
local MockPart = require(Replicated.Modules.Shared.MockPart)

Remote.OnServerEvent:Connect(function(Player, Input, ...)
	
	-- Player is the user who triggered the event, Input is the ability activated.
	-- ... is a table that holds an infinite amount of arguments.
	
	local Character = Player.Character
	local RootPart = Character.HumanoidRootPart
	local Humanoid = Character.Humanoid
	
	local Params = {...}
		
	if Input == 'Amber' then
		local Circle = Assets.Meshes.Amber.AmberCircle:Clone()
		Circle.CFrame = CFrame.new(Params[1].X, 0, Params[1].Z)
		Circle.Size = Vector3.new(75, 0.001, 75)
		Circle.Decal.Transparency = 1
		Circle.Parent = workspace.Effects
		Circle.Attachment.Gradient:Emit(1)
		
		task.wait(0.5)
		
		game:GetService('TweenService'):Create(Circle.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0}):Play()
		game:GetService('TweenService'):Create(Circle, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Orientation = Circle.Orientation + Vector3.new(0, 360, 0)}):Play()
		
		task.wait(0.75)
		
		for _ = 1, 15 do
			coroutine.wrap(function()
				local Part = MockPart.new(CFrame.new(Params[1].X, 38.5, Params[1].Z) * CFrame.new(math.random(-13.5, 13.5), 0, math.random(-13.5, 13.5)))
				Part.Name = 'AmberServer'
				
				for k = 0, 1, 0.00275 do
					Part.CFrame = Part.CFrame:Lerp(Part.CFrame * CFrame.new(0, -40, 0), k)

					local Hit = Hitbox:Start(Part.Position, Part.CFrame.UpVector * 1.5, {Character, Part})

					if Hit then
						FXRemote:FireAllClients('AmberHit', Hit.Position)
						Part:Destroy()
						break
					end

					task.wait(0.01)
				end
			end)()
			
			task.wait(0.185)
		end
		
		task.wait(0.5)
		game:GetService('TweenService'):Create(Circle.Decal, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
		game:GetService('TweenService'):Create(Circle.PointLight, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0}):Play()
		game:GetService('Debris'):AddItem(Circle, 1)
	end
	
	--------Ability
	if Input == 'Lightning' then
		FXRemote:FireAllClients('Lightning', Params[1])
	end
	
end)


