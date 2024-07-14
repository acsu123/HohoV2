local Wave = {}
Wave.__index = Wave

local newCFrame = CFrame.new
local IdentityCFrame = newCFrame()
local EmptyVector2 = Vector2.new()
local math_noise = math.noise
local random = math.random
local setseed = math.randomseed

local Stepped = game:GetService("RunService").RenderStepped
local Player = game:GetService("Players").LocalPlayer

local default = {
	WaveLength = 85,
	Gravity = 1.5,
	Direction = Vector2.new(1,0), -- Must be a Vector2
	FollowPoint = nil, -- Alternative to Direction, the wave's direction will always push away from the part or Vector3.
	Steepness = 1,
	TimeModifier = 4,
	MaxDistance = 1500,
}

local function Gerstner(Position: Vector3,Wavelength: number,Direction: Vector2,Steepness: number,Gravity: number,Time: number)
	local k = (2 * math.pi) / Wavelength
	local a = Steepness/k
	local d = Direction.Unit
	local c = math.sqrt(Gravity / k)
	local f = k * d:Dot(Vector2.new(Position.X,Position.Z)) - c * Time
	local cosF = math.cos(f)

	--Displacement Vectors
	local dX = (d.X * (a * cosF))
	local dY = a * math.sin(f)
	local dZ = ( d.Y * (a * cosF))
	return Vector3.new(dX,dY,dZ)
end

local function CreateSettings(s: table,o: table)
	o = o or {}
	s = s or default
	local new = {
		WaveLength = s.WaveLength or o.WaveLength or default.WaveLength,
		Gravity = s.Gravity or o.Gravity or default.Gravity,
		Direction = s.Direction or o.Direction or default.Direction,
		PushPoint = s.PushPoint or o.PushPoint or default.PushPoint,
		Steepness = s.Steepness or o.Steepness or default.Steepness,
		TimeModifier = s.TimeModifier or o.TimeModifier or default.TimeModifier,
		MaxDistance = s.MaxDistance or o.MaxDistance or default.MaxDistance,
	}
	return new
end

local function GetDirection(Settings,WorldPos)
	local Direction = Settings.Direction
	local PushPoint = Settings.PushPoint

	if PushPoint then
		local PartPos = nil

		if PushPoint:IsA("Attachment") then
			PartPos = PushPoint.WorldPosition
		elseif PushPoint:IsA("BasePart") then
			PartPos = PushPoint.Position
		else
			warn("Invalid class for FollowPart, must be BasePart or Attachment")
			return
		end

		Direction = (PartPos-WorldPos).Unit
		Direction = Vector2.new(Direction.X,Direction.Z)
	end
	
	return Direction
end

function Wave.new(instance: instance, waveSettings: table | nil, bones: table | nil)
	-- Get bones on our own
	if bones == nil then
		bones = {}
		for _,v in pairs(instance:GetDescendants()) do
			if v:IsA("Bone") then
				table.insert(bones,v)
			end
		end
	end
	
	local Time = os.time()
	
	return setmetatable({
		_instance = instance,
		_bones = bones,
		_time = 0,
		_connections = {},
		_noise = {},
		_settings = CreateSettings(waveSettings)
	},Wave)
end

function Wave:Update()
	for _,v in pairs(self._bones) do
		local WorldPos = v.WorldPosition
		local Settings = self._settings
		local Direction = Settings.Direction
		
		if Direction == EmptyVector2 then
			-- Use Perlin Noise
			local Noise = self._noise[v]
			local NoiseX = Noise and self._noise[v].X
			local NoiseZ = Noise and self._noise[v].Z
			local NoiseModifier = 1 -- If you want more of a consistent direction, change this number to something bigger
			
			if not Noise then
				self._noise[v] = {}
				-- Uses perlin noise to generate smooth transitions between random directions in the waves
				NoiseX = math_noise(WorldPos.X/NoiseModifier,WorldPos.Z/NoiseModifier,1)
				NoiseZ = math_noise(WorldPos.X/NoiseModifier,WorldPos.Z/NoiseModifier,0)
				
				self._noise[v].X = NoiseX
				self._noise[v].Z = NoiseZ
			end
			
			Direction = Vector2.new(NoiseX,NoiseZ)
		else
			Direction = GetDirection(Settings,WorldPos)
		end
		
		v.Transform = newCFrame(Gerstner(WorldPos,Settings.WaveLength,Direction,Settings.Steepness,Settings.Gravity,self._time))
	end
end

function Wave:Refresh()
	for _,v in pairs(self._bones) do
		v.Transform = IdentityCFrame
	end
end

function Wave:UpdateSettings(waveSettings)
	self._settings = CreateSettings(waveSettings,self._settings)
end

function Wave:ConnectRenderStepped()
	local Connection = Stepped:Connect(function()
		if not game:IsLoaded() then return end
		local Character = Player.Character
		local Settings = self._settings
		if not Character or (Character.PrimaryPart.Position-self._instance.Position).Magnitude < Settings.MaxDistance then
			local Time = (DateTime.now().UnixTimestampMillis/1000)/Settings.TimeModifier
			self._time = Time
			self:Update()
		else
			self:Refresh()
		end
	end)
	table.insert(self._connections,Connection)
	return Connection
end

function Wave:Destroy()
	self._instance = nil
	for _,v in pairs(self._connections) do
		pcall(function()
			v:Disconnect()
		end)
	end
	self._bones = {}
	self._settings = {}
	self = nil
	-- Basically makes the wave impossible to use
end

return Wave
