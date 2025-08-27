local function is_nan_inf(n)
    return type(n) == "number" and (n ~= n or n == math.huge or n == -math.huge)
end

local function format_value(v)
    if is_nan_inf(v) then
        return "nil"
    end
    local typ = typeof(v)
    if typ == "function" then
        local info = debug.getinfo(v)
        return string.format('"function [%s @ %s]"', info.name or "?", info.short_src or "?")
    elseif typ == "string" then
        return string.format("%q", v)
    elseif typ == "number" or typ == "boolean" or typ == "nil" then
        return tostring(v)
    elseif typ == "Vector3" then
        return string.format("Vector3.new(%f, %f, %f)", v.X, v.Y, v.Z)
    elseif typ == "Vector2" then
        return string.format("Vector2.new(%f, %f)", v.X, v.Y)
    elseif typ == "UDim2" then
        return string.format("UDim2.new(%f, %d, %f, %d)", v.X.Scale, v.X.Offset, v.Y.Scale, v.Y.Offset)
    elseif typ == "UDim" then
        return string.format("UDim.new(%f, %d)", v.Scale, v.Offset)
    elseif typ == "CFrame" then
        return string.format("CFrame.new(%s)", table.concat({v:GetComponents()}, ", "))
    elseif typ == "Color3" then
        return string.format("Color3.new(%f, %f, %f)", v.R, v.G, v.B)
    elseif typ == "BrickColor" then
        return string.format("BrickColor.new(%d)", v.Number)
    elseif typ == "EnumItem" then
        return tostring(v)
    elseif typ == "Instance" then
        return string.format("%q", v:GetFullName())
    else
        return string.format("%q", tostring(v))
    end
end

local function serialize_table(t, p, c, s)
    local str = ""
    local n = 0
    for _ in next, t do n += 1 end
    local ti = 1
    local e = n > 0
    c = c or {}
    p = p or 1
    s = s or string.rep
    local function localized_format(v, is_table)
        if is_nan_inf(v) then return "nil" end
        return (is_table and (c[v][2] >= p)) and serialize_table(v, p + 1, c, s) or format_value(v)
    end
    c[t] = {t, 0}
    for i, v in next, t do
        local typ_i, typ_v = type(i) == "table", type(v) == "table"
        c[i], c[v] = (not c[i] and typ_i) and {i, p} or c[i], (not c[v] and typ_v) and {v, p} or c[v]
        str ..= s("  ", p).."["..localized_format(i, typ_i).."] = "..localized_format(v, typ_v)..(ti < n and "," or "").."\n"
        ti += 1
    end
    return ("{"..(e and "\n" or ""))..str..(e and s("  ", p - 1) or "").."}"
end

local function deserialize_table(str)
    local f, err = loadstring("return "..str)
    if not f then error("Deserialize failed: "..err) end
    local ok, result = pcall(f)
    if not ok then error("Deserialize error: "..result) end
    return result
end

return {
    serialize = serialize_table,
    deserialize = deserialize_table
}
