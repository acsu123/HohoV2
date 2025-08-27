local Serializer = {}

local function is_nan_inf(n)
	return type(n) == "number" and (n ~= n or n == math.huge or n == -math.huge)
end

local function escape_str(s)
	return string.format("%q", s)
end

local function serialize_value(v, visited)
	local t = typeof(v)
	if is_nan_inf(v) then
		return "nil"
	elseif t == "number" or t == "boolean" then
		return tostring(v)
	elseif t == "string" then
		return escape_str(v)
	elseif t == "Instance" then
		return string.format("Instance(%s)", escape_str(v:GetFullName()))
	elseif t == "CFrame" then
		return string.format("CFrame.new(%s)", table.concat({v:GetComponents()}, ","))
	elseif t == "Vector3" then
		return string.format("Vector3.new(%s,%s,%s)", v.X, v.Y, v.Z)
	elseif t == "Vector2" then
		return string.format("Vector2.new(%s,%s)", v.X, v.Y)
	elseif t == "UDim2" then
		return string.format("UDim2.new(%s,%s,%s,%s)", v.X.Scale, v.X.Offset, v.Y.Scale, v.Y.Offset)
	elseif t == "table" then
		if visited[v] then
			return "{}"
		end
		visited[v] = true
		local parts = {}
		for k, val in pairs(v) do
			table.insert(parts, "[" .. serialize_value(k, visited) .. "]=" .. serialize_value(val, visited))
		end
		return "{" .. table.concat(parts, ",") .. "}"
	else
		return escape_str(tostring(v))
	end
end

function Serializer.serialize(v)
	return serialize_value(v, {})
end

function Serializer.deserialize(str)
	local f = loadstring("return " .. str)
	if not f then return nil end
	local ok, res = pcall(f)
	if ok then return res end
	return nil
end

return Serializer
