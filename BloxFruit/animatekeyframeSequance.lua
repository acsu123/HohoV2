local module = {}
module.__index = module


local TS = game:GetService("TweenService")
local function PoseStyleToEasingStyle(poseEasing)
	local get = string.gsub(tostring(poseEasing),"Enum.PoseEasingStyle.","")
	return Enum.EasingStyle[get]

end
local function PoseStyleToEasingDirection(poseDirection)
	local get = string.gsub(tostring(poseDirection),"Enum.PoseEasingDirection.","")
	return Enum.EasingDirection[get]

end
local function GetTrueMoveMotor6DCframeData(motorOffSet,data)
	return motorOffSet * data:Inverse()


end
local function setDataPossesToTable(poses,TimeLengh)
	for _,e in ipairs(poses) do

		table.insert(TimeLengh.Poses,TimeLengh.Poses[e.Name])
		TimeLengh.Poses[e.Name] = {}
		table.insert(TimeLengh.Poses[e.Name],TimeLengh.Poses[e.Name]["EasingStyle"])
		table.insert(TimeLengh.Poses[e.Name],TimeLengh.Poses[e.Name]["EasingDirection"])
		table.insert(TimeLengh.Poses[e.Name],TimeLengh.Poses[e.Name]["CFrame"])
		TimeLengh.Poses[e.Name]["EasingStyle"] = e.EasingStyle
		TimeLengh.Poses[e.Name]["EasingDirection"] = e.EasingDirection
		TimeLengh.Poses[e.Name]["CFrame"] = e.CFrame
		--table.insert(TimeLengh.Poses,e)

	end

end
local function GetFramesConvertData(dataFrames,GetFrames)

	for i,KeyFrame in ipairs(GetFrames) do
		local TimeLengh = {}

		table.insert(TimeLengh,TimeLengh["Poses"])
		TimeLengh["Poses"] = {}
		table.insert(TimeLengh,TimeLengh["Event"])
		TimeLengh["Event"] = {}
		table.insert(TimeLengh,TimeLengh["KeyFrameTimeLengh"])
		table.insert(TimeLengh,TimeLengh["Time"])
		TimeLengh["KeyFrameTimeLengh"] = 0
		TimeLengh.Time = GetFrames[i].Time


		if GetFrames[i+1] ~= nil then
			TimeLengh.KeyFrameTimeLengh = GetFrames[i+1].Time - GetFrames[i].Time

		end


		local poses = {}
		for _,Poses in ipairs(KeyFrame:GetDescendants()) do
			--Events (markers)
			if Poses:IsA("KeyframeMarker") then
				--------------
				table.insert(TimeLengh["Event"],TimeLengh["Event"]["Name"])
				TimeLengh["Event"]["Name"] = Poses.Name

				table.insert(TimeLengh["Event"],TimeLengh["Event"]["Value"])
				TimeLengh["Event"]["Value"] = Poses.Value

				table.insert(TimeLengh["Event"],TimeLengh["Event"]["Time"])
				TimeLengh["Event"]["Time"] = KeyFrame.Time
				--------------
			end
			--Pose
			if Poses:IsA("Pose") then

				table.insert(poses,Poses)
			end

		end

		--[[
		Adding all stuff related to poses
		
		
		]]
		setDataPossesToTable(poses,TimeLengh)
		--Remove Event if not exist
		if (next(TimeLengh["Event"]) == nil) then
			TimeLengh["Event"] = nil
		end


		table.insert(dataFrames,TimeLengh)
	end

end
local function SetToTable(model,motors,motorsOriginalOffset)

	for _,BodyPart in pairs(model:GetChildren()) do
		if BodyPart:IsA("BasePart") then
			if BodyPart:GetJoints() ~= nil then
				for _,Joint in pairs(BodyPart:GetJoints()) do
					if Joint.Part1 == BodyPart and Joint:IsA("Motor6D") then
						table.insert(motors,motors[BodyPart.Name])
						motors[BodyPart.Name] = Joint
						table.insert(motorsOriginalOffset,motorsOriginalOffset[BodyPart.Name])
						motorsOriginalOffset[BodyPart.Name] = Joint.C1 * CFrame.new(0,-0,0)


					end



				end




			end


		end

	end

end


--Get Basic R15Structure
function module.GetBasicR15(rig)
	local ModelData = {}
	local motors = {}
	local motorsOriginalOffset = {}
	local a
	local joint
	local function findJoint(bodyPartName,jointName)
		a = rig:FindFirstChild(bodyPartName)
		if a then
			joint = a:FindFirstChild(jointName)
			if joint then
				table.insert(motors,motors[a.Name])
				motors[a.Name] = joint
			end
		end
	end
	local function addOffset(name,offset)
		if motors[name] ~= nil then
			table.insert(motorsOriginalOffset,motorsOriginalOffset[name])
			motorsOriginalOffset[name] = offset
		end
	end
	findJoint("Head","Neck")
	findJoint("LeftFoot","LeftAnkle")
	findJoint("LeftHand","LeftWrist")
	findJoint("LeftLowerArm","LeftElbow")
	findJoint("LeftLowerLeg","LeftKnee")
	findJoint("LeftUpperArm","LeftShoulder")
	findJoint("LeftUpperLeg","LeftHip")
	findJoint("LowerTorso","Root")
	findJoint("RightFoot","RightAnkle")
	findJoint("RightHand","RightWrist")
	findJoint("RightLowerArm","RightElbow")
	findJoint("RightLowerLeg","RightKnee")
	findJoint("RightUpperArm","RightShoulder")
	findJoint("RightUpperLeg","RightHip")
	findJoint("UpperTorso","Waist")
	--=============================
	addOffset("Head",CFrame.new(0, -0.491300106, -0.000263773836, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("LeftFoot",CFrame.new(-1.80400747e-07, 0.106015436, -1.72411478e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("LeftHand",CFrame.new(0.000471446925, 0.131572768, 6.12894695e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("LeftLowerArm",CFrame.new(0.000479135837, 0.274824202, 7.65889566e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("LeftLowerLeg",CFrame.new(2.95890423e-08, 0.413189024, -1.56485186e-07, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("LeftUpperArm",CFrame.new(0.5005337, 0.418923318, 8.95738594e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("LeftUpperLeg",CFrame.new(5.91780847e-08, 0.471393436, -1.59454345e-07, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("LowerTorso",CFrame.new(-1.1920929e-07, -0.199972257, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	--Right
	addOffset("RightFoot",CFrame.new(0, 0.106015317, 7.65293444e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("RightHand",CFrame.new(3.52001166e-07, 0.131572768, 6.12894695e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("RightLowerArm",CFrame.new(1.19336448e-07, 0.274708718, 7.65889566e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("RightLowerLeg",CFrame.new(0, 0.413358927, 2.48585493e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("RightUpperArm",CFrame.new(-0.500534058, 0.418923318, 8.95738594e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("RightUpperLeg",CFrame.new(0, 0.471393555, -6.49150097e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	addOffset("UpperTorso",CFrame.new(-5.79121036e-08, -0.849000454, 1.19686121e-07, 1, 0, 0, 0, 1, 0, 0, 0, 1))
	--Motors offset
	table.insert(ModelData,ModelData["MotorsData"])
	ModelData["MotorsData"] = motors
	table.insert(ModelData,ModelData["Offsets"])
	ModelData["Offsets"] = motorsOriginalOffset
	a = nil
	joint = nil
	return ModelData
end
--Get Basic R6Structure
function module.GetBasicR6(rig)
	local ModelData = {}
	local motors = {}
	local motorsOriginalOffset = {}
	local a
	local joint
	local function findJoint(bodyPartName,jointName)
		a = rig:FindFirstChild(bodyPartName)
		if a then
			joint = rig:FindFirstChild("Torso"):FindFirstChild(jointName)
			if joint then
				table.insert(motors,motors[a.Name])
				motors[a.Name] = joint
			end
		end
	end
	local function addOffset(name,offset)
		if motors[name] ~= nil then
			table.insert(motorsOriginalOffset,motorsOriginalOffset[name])
			motorsOriginalOffset[name] = offset
		end
	end

	findJoint("Head","Neck")
	findJoint("Left Arm","Left Shoulder")
	findJoint("Left Leg","Left Hip")
	findJoint("Right Arm","Right Shoulder")
	findJoint("Right Leg","Right Hip")
	a = rig:FindFirstChild("Torso")
	if a then
		joint = rig:FindFirstChild("HumanoidRootPart"):FindFirstChild("RootJoint")
		table.insert(motors,motors[a.Name])
		motors[a.Name] = joint
	end
	addOffset("Head",CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0))
	addOffset("Left Arm",CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))
	addOffset("Left Leg",CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))
	addOffset("Right Arm",CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0))
	addOffset("Right Leg",CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0))
	addOffset("Torso",CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0))
	--Motors offset
	table.insert(ModelData,ModelData["MotorsData"])
	ModelData["MotorsData"] = motors
	table.insert(ModelData,ModelData["Offsets"])
	ModelData["Offsets"] = motorsOriginalOffset
	a = nil
	joint = nil
	return ModelData
end



function module.GetHumanoidRigType(rig)
	local rigType = Enum.HumanoidRigType.R6
	local hum = rig:FindFirstChildOfClass("Humanoid")
	if hum then
		rigType = hum.RigType
	end
	return rigType
end

function startPlay(selfA,OutSpeed,dataFrames,motors,motorsOriginalOffset)
	selfA.EventListener:Fire("AnimStatus","Start")
	local function AllCodeThatILazyToNameHelpMePlz(i)

		local Data = dataFrames[i]
		local offsetTime = os.clock() / Data.KeyFrameTimeLengh % 1 * Data.KeyFrameTimeLengh
		--event
		if (Data["Event"] ~= nil) then
			local Event = Data.Event
			selfA.EventListener:Fire("Event",Event.Name,Event.Value,Event.Time)
			Event = nil
		end
		--posses
		for Name,posesData in pairs(Data.Poses) do
			--Run and get motor 6d
			--print(posesData.CFrame)


			if motors[Name]--[[ ~= niland posesData.CFrame ~= CFrame.new(0,0,0)]]  then
				--print(Name)
				--print(Data.Time)
				--motors[Name].C1 = motors[Name].C1 * posesData.CFrame:Inverse()
				--print(motors[Name].C1 * posesData.CFrame:Inverse())
				local formula = GetTrueMoveMotor6DCframeData(motorsOriginalOffset[Name],posesData.CFrame)
				local timeTOWait = Data.KeyFrameTimeLengh/selfA.Speed
				if selfA.AcceptFrameDrop == true then
					timeTOWait = Data.KeyFrameTimeLengh/selfA.Speed-offsetTime
				end
				if selfA.Animated ~= false then

					selfA.Tween = TS:Create(motors[Name],TweenInfo.new(timeTOWait,PoseStyleToEasingStyle(posesData.EasingStyle),PoseStyleToEasingDirection(posesData.EasingDirection)),{C1 = formula})
					selfA.Tween:Play()
				else
					motors[Name].C1 = formula	
				end

			end







		end
		if selfA.AcceptFrameDrop == false then
			task.wait(Data.KeyFrameTimeLengh/selfA.Speed)
		else
			task.wait(Data.KeyFrameTimeLengh/selfA.Speed-offsetTime)
		end
		selfA.Frame += 1
		selfA.EventListener:Fire("AnimStatus","KeyframePassed")
	end
	--actually run this stuff ^^^^^
	if selfA.Reverse == true then
		if selfA.FrameIndex == 1 or selfA.FrameIndex == #dataFrames then
			for i = #dataFrames,1,-1 do
				AllCodeThatILazyToNameHelpMePlz(i)
			end

		else
			for i = selfA.FrameIndex,1,-1 do
				AllCodeThatILazyToNameHelpMePlz(i)
			end
		end
	else
		for i = selfA.FrameIndex,#dataFrames do
			AllCodeThatILazyToNameHelpMePlz(i)
		end
	end

	--Reset Posses
	selfA.EventListener:Fire("AnimStatus","AnimEnd")
	if OutSpeed ~= nil then

		for Name,Data in pairs(motors) do
			--Run and get motor 6d
			--print(posesData.CFrame)


			if motors[Name]--[[ ~= niland posesData.CFrame ~= CFrame.new(0,0,0)]]  then
				local tweenProps = {C1 = motorsOriginalOffset[Name]}
				selfA.Tween = TS:Create(motors[Name],TweenInfo.new(OutSpeed),tweenProps)
				selfA.Tween:Play()


				--motors[Name].C1 = motorsOriginalOffset[Name]





			end
		end
	end
	if selfA.Looped == false then
		selfA.Playing = false
	end
	selfA.EventListener:Fire("AnimStatus","End")




end



function module.SetOwnRigStructure(tableData)
	local ModelData = {}
	local motors = {}
	local motorsOriginalOffset = {}
	motors = tableData
	for i,v in pairs(motors) do
		table.insert(motorsOriginalOffset,motorsOriginalOffset[i])
		motorsOriginalOffset[i] = v.C1 * CFrame.new(0,-0,0)	
	end

	--Motors
	table.insert(ModelData,ModelData["MotorsData"])
	ModelData["MotorsData"] = motors

	--Motors offset
	table.insert(ModelData,ModelData["Offsets"])
	ModelData["Offsets"] = motorsOriginalOffset
	return ModelData
end

function module.OffSetTableReturn(model)
	local ModelData = {}
	local motors = {}
	local motorsOriginalOffset = {}
	SetToTable(model,motors,motorsOriginalOffset)

	--Motors
	table.insert(ModelData,ModelData["MotorsData"])
	ModelData["MotorsData"] = motors

	--Motors offset
	table.insert(ModelData,ModelData["Offsets"])
	ModelData["Offsets"] = motorsOriginalOffset


	return ModelData
end

function module.GenerateKeyframe(KeyFrameSequance) --[[convert keyframesequance into table]]
	local GetFrames = KeyFrameSequance:GetKeyframes()
	table.sort(GetFrames, function(a, b)
		return a.Time < b.Time
	end)
	local dataFrames = {}
	GetFramesConvertData(dataFrames,GetFrames)
	return dataFrames
end
function module.GenerateRig(model) --[[not recomended to use on default rigs]]
	local dataOfAnimation = {}
	local motors = {}
	local motorsOriginalOffset = {}
	SetToTable(model,motors,motorsOriginalOffset)
	--Motors
	table.insert(dataOfAnimation,dataOfAnimation["MotorsData"])
	dataOfAnimation["MotorsData"] = motors
	--Motors offset
	table.insert(dataOfAnimation,dataOfAnimation["Offsets"])
	dataOfAnimation["Offsets"] = motorsOriginalOffset
	--garbage collect
	motors = nil
	motorsOriginalOffset = nil
	--return anim
	return dataOfAnimation
end

local function deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

function module.new(ModelDataTable,KeyframeTable)
	local yeah = setmetatable({},module)
	local tableE = deepCopy(ModelDataTable)
	local tableK = deepCopy(KeyframeTable)
	table.insert(tableE,tableE["KeyFrames"])
	tableE["KeyFrames"] = tableK
	local eventListener = Instance.new("BindableEvent")
	--================================
	yeah.EventListener = eventListener
	yeah.Data = tableE
	yeah.Playing = false
	yeah.Frame = 1
	yeah.FrameIndex = 1
	yeah.Reverse = false
	yeah.AcceptFrameDrop = false
	yeah.Animated = true
	yeah.Process = nil
	yeah.ProcessOfLoop = nil
	yeah.Tween = nil
	yeah.Speed = 1
	yeah.Looped = false
	return yeah
end
function module:Print()
	print(self.Data)
end

function module:SetSpeed(speed)
	self.Speed = speed
end
function module:AddSpeed(speedAdd)
	self.Speed += speedAdd
end
function module:SubstractSpeed(speedSubstract)
	self.Speed -= speedSubstract
end
function module:Stop()
	self.Playing = false
	if typeof(self.Tween) == 'Instance' then
		self.Tween:Cancel()
	end
	if typeof(self.Process) == 'thread' then
		coroutine.close(self.Process)
	end
	if typeof(self.ProcessOfLoop) == 'thread' then
		coroutine.close(self.Process)
	end
	self.EventListener:Fire("AnimStatus","Stop")
end
function module:Cancel()
	self.Playing = false
	if typeof(self.Tween) == 'Instance' then
		self.Tween:Cancel()
	end
	if typeof(self.Process) == 'thread' then
		coroutine.close(self.Process)
	end
	if typeof(self.ProcessOfLoop) == 'thread' then
		coroutine.close(self.Process)
	end
	self.EventListener:Fire("AnimStatus","Cancel")
	local data = self.Data
	local motors = data["MotorsData"]
	local motorsOriginalOffset = data["Offsets"]
	task.wait()
	for Name,Data in pairs(motors) do
		Data.C1 = motorsOriginalOffset[Name]
	end
end
function module:ResetMotors()
	local data = self.Data
	local motors = data["MotorsData"]
	local motorsOriginalOffset = data["Offsets"]
	task.wait()
	for Name,Data in pairs(motors) do
		Data.C1 = motorsOriginalOffset[Name]
	end
	self.EventListener:Fire("AnimStatus","ResetMotors")
end
function module:SetFrame(numberOfFrame)
	local data = self.Data
	local dataFrames = data["KeyFrames"]
	local motors = data["MotorsData"]
	local motorsOriginalOffset = data["Offsets"]
	if numberOfFrame > #dataFrames then
		warn("The frame does not exist")
		return
	end
	local frame = dataFrames[numberOfFrame]
	for a,object in pairs(frame.Poses) do
		if motors[a] then
			motors[a].C1 = GetTrueMoveMotor6DCframeData(motorsOriginalOffset[a],object.CFrame)
		end
	end	
	self.EventListener:Fire("AnimStatus","PosSet")
end
function module:GetAmoutOfFrames()
	return #self.Data["KeyFrames"]
end
function module:GetFrames()
	return self.Data["KeyFrames"]
end

function module:Play(OutSpeed)
	self.Playing = true
	self.Frame = 1
	local EventListener = self.EventListener
	local data = self.Data
	local dataFrames = data["KeyFrames"]
	local motors = data["MotorsData"]
	local motorsOriginalOffset = data["Offsets"]

	self.Process = coroutine.create(function()
		startPlay(self,OutSpeed,dataFrames,motors,motorsOriginalOffset)
		self.Playing = false
	end)

	if self.Looped == false then
		coroutine.resume(self.Process)
	else
		self.ProcessOfLoop = coroutine.create(function()
			coroutine.resume(self.Process)
			local eventConnection
			eventConnection = self.EventListener.Event:Connect(function(animstat,en)
				if self.Looped == true then


					if animstat == "AnimStatus" and en == "End" then
						self.EventListener:Fire("AnimStatus","Loop")
						self.Process = coroutine.create(function()
							startPlay(self,OutSpeed,dataFrames,motors,motorsOriginalOffset)
						end)
						coroutine.resume(self.Process)


					end
				else
					--Self destroy
					eventConnection:Disconnect()
					coroutine.close(self.ProcessOfLoop)
					self.Playing = false
					self.EventListener:Fire("AnimStatus","LoopClosed")
				end
			end)


		end)
		coroutine.resume(self.ProcessOfLoop)
	end
end


return module
