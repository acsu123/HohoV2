local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local DraggableObject 		= {}
DraggableObject.__index 	= DraggableObject

function DraggableObject.new(Object,dragObject)
	local self 			= {}
	self.Object			= Object
	self.dragObject		= dragObject or Object
	self.DragStarted	= nil
	self.DragEnded		= nil
	self.Dragged		= nil
	self.Dragging		= false

	setmetatable(self, DraggableObject)

	return self
end


function DraggableObject:Enable()
	local object			= self.Object
	local dragObject		= self.dragObject
	local dragInput			= nil
	local dragStart			= nil
	local startPos			= nil
	local preparingToDrag	= false


	local function update(input)
		local delta 		= input.Position - dragStart
		local newPosition	= UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		TweenService:Create(object,TweenInfo.new(.1),{Position = newPosition}):Play()

		return newPosition
	end

	self.InputBegan = dragObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or (input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Begin ) then
			preparingToDrag = true
			if self.DragStarted then
				self.DragStarted()
			end
			
			
			dragStart 		= input.Position
			startPos 		= object.Position

			local connection 
			connection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End and (self.Dragging or preparingToDrag) then
					self.Dragging = false
					connection:Disconnect()

					if self.DragEnded and not preparingToDrag then
						self.DragEnded()
					end
					
					preparingToDrag = false
				end
			end)
			
		end
	end)

	self.InputChanged = object.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or (input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Change) then
			dragInput = input
		end
	end)

	self.InputChanged2 = UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or (input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Change) then
			if object.Parent == nil then
				self:Disable()
				return
			end

			if preparingToDrag then
				preparingToDrag = false

				if self.DragStarted then
					self.DragStarted()
				end

				self.Dragging	= true
				dragStart 		= input.Position
				startPos 		= object.Position
			end

			if input == dragInput and self.Dragging then
				local newPosition = update(input)
				if self.Dragged then
					self.Dragged(newPosition)
				end
			end
		end
	end)
	
end




function DraggableObject:Disable()
	self.InputBegan:Disconnect()
	self.InputChanged:Disconnect()
	self.InputChanged2:Disconnect()
	if self.Dragging then
		self.Dragging = false

		if self.DragEnded then
			self.DragEnded()
		end
	end
end

return DraggableObject
