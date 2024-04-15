local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

type sliderConfigurationsType = {
	min: number,
	max: number,
	snapFactor: number
}

type extrasType = {
	TextBox: TextBox?,
	TextLabel: any,
	Decimals: number,
	DefaultValue: number,
}

type sliderFunctionsType = {
	Activate: (slider) -> (),
	__index: sliderFunctionsType
}

local Slider = {} :: slider

local SliderFunctions = {} :: sliderFunctionsType
SliderFunctions.__index = SliderFunctions

local function calculateScalePosFromScreenSize(frame: Frame): UDim2
	local abs = frame.AbsolutePosition
	local vps = workspace.CurrentCamera.ViewportSize

	return UDim2.new(abs.X / vps.X, 0, abs.Y / vps.Y, 0)
end

local function calculateScaleSizeFromScreenSize(frame: Frame): UDim2
	local abs = frame.AbsoluteSize
	local vps = workspace.CurrentCamera.ViewportSize
	
	return UDim2.new(abs.X / vps.X, 0, abs.Y / vps.Y, 0)
end

Slider.new = function(slidingBase: Frame, sliderMarker: Frame, sliderButton: TextButton | ImageButton, sliderConfigurations: sliderConfigurationsType, extras: extrasType?): slider
	local self = setmetatable({}, SliderFunctions) :: slider

	assert(sliderConfigurations.min, "sliderConfigurations need a min variable.")
	assert(sliderConfigurations.max, "sliderConfigurations need a max variable.")
	assert(sliderConfigurations.snapFactor, "sliderConfigurations need a snapFactor variable.")
	assert(
		slidingBase.AnchorPoint == Vector2.new(0.5, 0.5),
		"Set the AnchorPoint of " .. slidingBase.Name .. " to (0.5, 0.5)"
	)
	assert(sliderButton:IsDescendantOf(sliderMarker), "SliderButton needs to be a descendant of sliderMarker.")

	self.slidingBase = slidingBase :: Frame
	self.sliderMarker = sliderMarker :: Frame
	self.sliderButton = sliderButton :: TextButton | ImageButton
	self.min = sliderConfigurations.min :: number
	self.max = sliderConfigurations.max :: number
	self.snapFactor = sliderConfigurations.snapFactor :: number

	local slidingBaseSizeFromScreenSize: UDim2 = calculateScaleSizeFromScreenSize(slidingBase)
	local slidingBasePosFromScreenSize: UDim2 = calculateScalePosFromScreenSize(slidingBase)

	self.firstPartPos = UDim2.new(slidingBasePosFromScreenSize.X.Scale, 0, slidingBasePosFromScreenSize.Y.Scale, 0) :: UDim2
	self.lineSize = slidingBaseSizeFromScreenSize.X.Scale :: number

	if extras then
		self.TargetTextLabel = extras.TextBox
		self.TargetTextBox = extras.TextBox

		if extras.TextLabel then
			self.TargetTextLabel = extras.TextLabel
		end

		if extras.Decimals then
			self.Decimals = extras.Decimals
		end
		
		if extras.DefaultValue then
			self.DefaultValue = extras.DefaultValue
		end
	end

	self.InteractionBegan = Instance.new("BindableEvent") :: BindableEvent
	self.InteractionEnded = Instance.new("BindableEvent") :: BindableEvent
	self.ValueChanged = Instance.new("BindableEvent") :: BindableEvent
	
	self.DidSetup = false :: boolean
	self.Connections = {} :: {[number]: RBXScriptConnection}

	return self
end

export type slider = typeof(Slider.new(Instance.new("Frame"), Instance.new("Frame"), Instance.new("TextButton"), {} :: sliderConfigurationsType, {} :: extrasType))

local function decimalRound(num: number, places: number): number
	local power = 10 ^ places
	return math.round(num * power) / power
end

local function snap(self: slider, posInLine: number): number
	local val = math.clamp(math.floor(posInLine / self.snapFactor) * self.snapFactor, 0, 1)
	return val
end

local function getText(self: slider, snapN: number): number
	local ratio = 1 / self.snapFactor
	local step = (self.max - self.min) / ratio
	
	return decimalRound(self.min + (step * (snapN / self.snapFactor)), self.Decimals or 1)
end

function SliderFunctions:Activate()
	local runServiceEvent
	local previousValue = 0
	
	if not self.DidSetup and self.DefaultValue then
		previousValue = self.DefaultValue
		
		local scaleVal = (self.DefaultValue-self.min)/(self.max - self.min)
		self.sliderMarker.Position = UDim2.new(scaleVal, 0, self.sliderMarker.Position.Y.Scale, 0)
		self.CurrentValue = self.DefaultValue
		
		if self.TargetTextLabel then
			self.TargetTextLabel.Text = self.DefaultValue
		end
		
		self.DidSetup = true
	end
	
	self.Connections[#self.Connections+1] = self.sliderButton.MouseButton1Down:Connect(function()
		self.InteractionBegan:Fire()
		runServiceEvent = RunService.RenderStepped:Connect(function()
			local index = #self.Connections+1
			self.Connections[index] = runServiceEvent

			if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
				runServiceEvent:Disconnect()
				self.Connections[index] = nil
				self.InteractionEnded:Fire(self.CurrentValue)
				return
			end
			local slidingBasePosFromScreenSize: UDim2 = calculateScalePosFromScreenSize(self.slidingBase)
			self.firstPartPos = UDim2.new(slidingBasePosFromScreenSize.X.Scale, 0, slidingBasePosFromScreenSize.Y.Scale, 0) :: UDim2
			local vpX: number = workspace.Camera.ViewportSize.X
			local mouseLoc: Vector2 = UIS:GetMouseLocation()
			local xScale: number = math.clamp((mouseLoc.X - (self.firstPartPos.X.Scale :: number * vpX)) / vpX, 0, self.lineSize)

			if xScale > 0 then
				if xScale < 1 then
					self.sliderMarker.Position = UDim2.new(snap(self, xScale / self.lineSize), 0, self.sliderMarker.Position.Y.Scale, 0)
					self.CurrentValue = tostring(getText(self, snap(self, xScale / self.lineSize)))

					if self.TargetTextLabel then
						self.TargetTextLabel.Text = self.CurrentValue
					end

					if previousValue ~= self.CurrentValue then
						previousValue = self.CurrentValue
						self.ValueChanged:Fire(self.CurrentValue)
					end
				end
			else
				self.sliderMarker.Position = UDim2.new(0, 0, self.sliderMarker.Position.Y.Scale, 0)
				self.CurrentValue = getText(self, snap(self, xScale / self.lineSize))

				if self.TargetTextLabel then
					self.TargetTextLabel.Text = self.CurrentValue
				end
				
				if previousValue ~= self.CurrentValue then
					previousValue = self.CurrentValue
					self.ValueChanged:Fire(self.CurrentValue)
				end
			end
		end)
	end)

	if self.TargetTextBox then
		self.Connections[#self.Connections+1] = self.TargetTextBox.FocusLost:Connect(function()
			local currentText = tonumber(self.TargetTextBox.Text)

			if currentText then
				if currentText < self.max and currentText > self.min then
					self.CurrentValue = tostring(currentText)

					local scaleVal = (currentText - self.min) / (self.max - self.min)
					self.sliderMarker.Position = UDim2.new(scaleVal, 0, self.sliderMarker.Position.Y.Scale, 0)
					self.ValueChanged:Fire(self.CurrentValue)
					self.InteractionEnded:Fire(self.CurrentValue)
				else
					if self.CurrentValue then
						self.TargetTextBox.Text = self.CurrentValue
					end
				end
			end
		end)
	end
end

function SliderFunctions:Update(Value)
	Value = math.clamp(Value,self.min,self.max)
	local scaleVal = (Value-self.min)/(self.max - self.min)
	self.sliderMarker.Position = UDim2.new(scaleVal, 0, self.sliderMarker.Position.Y.Scale, 0)
	self.CurrentValue = Value
	if self.TargetTextLabel then
		self.TargetTextLabel.Text = self.CurrentValue
	end
end
function SliderFunctions:Deactivate()
	for _, connection: RBXScriptConnection in ipairs(self.Connections) do
		if connection.Connected then
			connection:Disconnect()
		end
	end

	self.Connections = {}
end

return Slider
