local pathfinding = {}

local SIZE = 3

local DIRECTIONS = {
	Vector3.xAxis;
	Vector3.zAxis;

	Vector3.xAxis * -1;
	Vector3.zAxis * -1;

	Vector3.zAxis + Vector3.xAxis;

	Vector3.xAxis * -1 + Vector3.zAxis;

	Vector3.xAxis + Vector3.zAxis * -1;
}

for i, dir in DIRECTIONS do
	DIRECTIONS[i] = dir * SIZE -- scale the directions with the grid size
end

local function RoundToNearest(v)
	return Vector3.new(
		math.round(v.X / SIZE) * SIZE,
		math.round(v.Y / SIZE) * SIZE,
		math.round(v.Z / SIZE) * SIZE
	)
end

local Params = OverlapParams.new()
local filterdDescendantsInstances = {}

local function CheckForHumanoids()
	for _, Object in ipairs(workspace:GetDescendants()) do
		if Object:IsA("Model") then
			if Object:FindFirstChildWhichIsA("Humanoid") then
				Params:AddToFilter(Object)
				Params.FilterType = Enum.RaycastFilterType.Exclude
			end
		end
	end
end

local function NodeIsTraversable(point: Vector3)
	local collisions = workspace:GetPartBoundsInBox(CFrame.new(point), Vector3.new(SIZE, 0, SIZE), Params)

	if collisions[1] then
		return false
	end
	return true
end

local D = math.sqrt(2) -- A constant

local function ConstructNode(worldPos: Vector3, target: Vector3)
	local function HeuristicFunction(a: Vector3, b: Vector3): number
		local D2 = 1

		local dx = math.abs(a.X - b.X)
		local dy = math.abs(a.Y - b.Y)
		local dz = math.abs(a.Z - b.Z)

		return D * math.min(dx, dy, dz) + (D2 - D) * math.max(0, dx + dy + dz - 2 * math.min(dx, dy, dz))		
	end

	local Object = setmetatable({
		Traversable = false;
		Position = worldPos;

		Costs = setmetatable({
			G = 0;
			H = 0;
		}, {
			__index = function(t, k)
				if k == 'F' then
					return rawget(t, 'H') + rawget(t, 'G') -- F is the sum of H and G
				end

				return rawget(t, k)
			end,	
		});

		HeapIndex = 0; -- For our new heap
		Parent = nil; -- No more storing Parents table
	}, {
		__sub = function(a, b)
			local compare = a.Costs.F - b.Costs.F -- Substract a's F and b's F

			if compare == 0 then -- If the F costs are equal, compare the H cost instead
				compare = a.Costs.H - b.Costs.H
			end

			return -compare -- Return the negated comparison
		end,

		__eq = function(a, b)
			return a.Position == b.Position
		end,
	})

	Object.Costs.G = (worldPos - target).Magnitude
	Object.Costs.H = HeuristicFunction and HeuristicFunction(worldPos, target) or 0 -- Heuristic is 0 if no function is set

	Object.Traversable = NodeIsTraversable(worldPos)

	return Object
end

local function roundToStep(pos : Vector3)
	return Vector3.new(math.floor(pos.X/3)*3+1.5,math.floor(pos.Y/3)*3+1.5, math.floor(pos.Z/3)*3+1.5)
end

Heap = loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/refs/heads/main/BloxFruit/Heap.lua"))()

local function FindPath(start: Vector3, target: Vector3)			
	start = RoundToNearest(start)
	target = RoundToNearest(target)

	local StartNode = ConstructNode(start, target)
	local TargetNode = ConstructNode(target, target)

	-- Safety precaution checks so we don't waste time computing the path
	assert(StartNode.Traversable, 'Starting Node is intraversable, thus path is intraversable')
	assert(TargetNode.Traversable, 'Target Node is intraversable, thus path is intraversable')

	local Grid = {[start] = StartNode, [target] = TargetNode}

	local OpenSet = Heap.new()-- :: Heap.Heap<typeof(ConstructNode(Vector3, Vector3))>
	local ClosedSet = {}

	OpenSet:Add(StartNode)

	while OpenSet:Count() > 0 do
		local CurrentNode = OpenSet:RemoveFirst()
		ClosedSet[CurrentNode.Position] = true

		local function RetracePath()
			local Path = {}
			local CurrentPathNode = TargetNode

			while CurrentPathNode ~= StartNode do
				table.insert(Path, 1, CurrentPathNode)
				CurrentPathNode = CurrentPathNode.Parent
			end

			return Path
		end

		if CurrentNode == TargetNode then
			return RetracePath()
		end

		for _, direction in DIRECTIONS do
			local NeighborPos = CurrentNode.Position + direction

			-- If neighbor already evaluated/not traversable, skip
			if ClosedSet[NeighborPos] or not NodeIsTraversable(NeighborPos) then
				continue
			end

			-- Get neighbor node
			local NeighborNode = Grid[NeighborPos] or ConstructNode(NeighborPos, target)
			Grid[NeighborPos] = NeighborNode

			-- Get new G cost to the neighbor
			local CostToNeighbor = CurrentNode.Costs.G + (CurrentNode.Position - NeighborPos).Magnitude

			-- If cost turns out to be better or not in openset
			if CostToNeighbor < NeighborNode.Costs.G or not OpenSet:Contains(NeighborNode) then
				NeighborNode.Costs.G = CostToNeighbor
				NeighborNode.Costs.H = (NeighborPos - target).Magnitude

				NeighborNode.Parent = CurrentNode

				if not OpenSet:Contains(NeighborNode) then -- If it doesn't have the neighbor node yet, add the node
					OpenSet:Add(NeighborNode)
				end
			end
		end
	end
end

local debugFinished = false

local allParts = 0

function debugParts(self, path)
end

pathfinding.roundToStep = function(pos)
	return roundToStep(pos)
end

pathfinding.Character = nil

pathfinding.new = function(startPos, goalPos)
	
	local newAStar = {}
	setmetatable(newAStar, {__index = pathfinding})
	
	newAStar.Service = workspace
	
	local debugPartsFolder
	
	if pathfinding.Character then
		if not pathfinding.Character:FindFirstChild("DebugParts") then
			debugPartsFolder = Instance.new("Folder", pathfinding.Character)
			debugPartsFolder.Name = "DebugParts"
		else
			debugPartsFolder = pathfinding.Character:FindFirstChild("DebugParts")
		end
	else
		if not workspace:FindFirstChild("DebugParts") then
			debugPartsFolder = Instance.new("Folder", workspace)
			debugPartsFolder.Name = "DebugParts"
		else
			debugPartsFolder = workspace:FindFirstChild("DebugParts")
		end
	end
	
	newAStar.debugPartsFold = debugPartsFolder
	
	newAStar.startPos = startPos
	newAStar.goalPos = goalPos
	
	return newAStar
end

pathfinding.debugParts = function(self: AStar, path)

	local DebugPartsFold = self.debugPartsFold

	for i, child in pairs(DebugPartsFold:GetChildren()) do
		if child.Name == tostring(i) then
			child:Destroy()
		end
	end

	debugFinished = false
	for _, node in pairs(path) do
		local nodePos = node.Position

		local a = Instance.new("Part", DebugPartsFold)
		a.Name = _
		a.Position = Vector3.new(nodePos.X, 0, nodePos.Z)
		a.Size = Vector3.new(1, 1, 1)
		a.Anchored = true
		a.CanCollide = false
		a.CanTouch = false
		a.CanQuery = false
	end
	debugFinished = true
end

pathfinding.FindPath = function(self: AStar, debug: boolean)
	local startPos = self.startPos
	local goalPos = self.goalPos
	
	task.spawn(CheckForHumanoids)
	
	local path = FindPath(startPos, goalPos)

	if debug then
		self:debugParts(path)
	end
	
	return path
end

type AStar = typeof(pathfinding.new(..., ...))

return pathfinding
