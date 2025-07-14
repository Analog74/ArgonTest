-- Services
local Replicated = game:GetService('ReplicatedStorage')

-- Assets
local Remote = Replicated.Assets.Remotes.FX

Remote.OnClientEvent:Connect(function(Module, ...)
	local ModuleF = require(Replicated.Modules.Templates.Abilities:FindFirstChild(Module)) or warn('Module does not exist in folder Templates!')
	ModuleF(...)
end)