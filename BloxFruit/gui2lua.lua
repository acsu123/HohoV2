--[[
    GUI to Lua Converter Function
    Converts a GUI instance to Lua code
    
    Usage:
    local code = GuiToLua(guiInstance, "game.CoreGui.MyGui")
    print(code)
]]

local function GuiToLua(target, pathString)
    -- Validate input
    if not target or not target:IsA("GuiBase") then
        error("Target must be a valid GUI object")
    end
    
    pathString = pathString or "game"
    
    -- Configuration
    local config = {
        convertLocalScripts = true,
        includeServerScripts = false
    }
    
    -- Properties to ignore
    local IGNORED_PROPS = {
        "Archivable", "ClassName", "Parent", "Children",
        "RobloxLocked", "AbsolutePosition", "AbsoluteRotation",
        "AbsoluteSize", "Source", "Adornee"
    }
    
    -- Type formatters
    local FORMATTERS = {
        string = function(v) return string.format("%q", v) end,
        Content = function(v) return string.format("%q", v) end,
        Color3 = function(v) 
            return string.format("Color3.fromRGB(%d,%d,%d)",
                math.floor(v.R*255.5), math.floor(v.G*255.5), math.floor(v.B*255.5))
        end,
        Vector2 = function(v) 
            return string.format("Vector2.new(%.7g,%.7g)", v.X, v.Y)
        end,
        Vector3 = function(v) 
            return string.format("Vector3.new(%.7g,%.7g,%.7g)", v.X, v.Y, v.Z)
        end,
        UDim2 = function(v) 
            return string.format("UDim2.new(%.7g,%d,%.7g,%d)",
                v.X.Scale, v.X.Offset, v.Y.Scale, v.Y.Offset)
        end,
        Rect = function(v) 
            return string.format("Rect.new(%.7g,%.7g,%.7g,%.7g)",
                v.Min.X, v.Min.Y, v.Max.X, v.Max.Y)
        end,
        EnumItem = function(v) 
            return string.format("Enum.%s.%s", tostring(v.EnumType), tostring(v.Name))
        end,
        NumberSequence = function(v) 
            local points = {}
            for _, k in ipairs(v.Keypoints) do
                table.insert(points, string.format(
                    "NumberSequenceKeypoint.new(%.7g,%.7g,%.7g)",
                    k.Time, k.Value, k.Envelope
                ))
            end
            return string.format("NumberSequence.new({%s})", table.concat(points, ","))
        end,
        ColorSequence = function(v) 
            local points = {}
            for _, k in ipairs(v.Keypoints) do
                local c = k.Value
                table.insert(points, string.format(
                    "ColorSequenceKeypoint.new(%.7g,Color3.fromRGB(%d,%d,%d))",
                    k.Time, math.floor(c.R*255.5), math.floor(c.G*255.5), math.floor(c.B*255.5)
                ))
            end
            return string.format("ColorSequence.new({%s})", table.concat(points, ","))
        end,
        Instance = function() 
            return "nil --[[Instance Reference]]--"
        end
    }
    
    local function FormatValue(v)
        local formatter = FORMATTERS[typeof(v)]
        return formatter and formatter(v) or tostring(v)
    end
    
    -- Variable name generation
    local varMap = {}
    local usedNames = {}
    
    local function GetVarName(inst)
        if varMap[inst] then 
            return varMap[inst] 
        end
        
        local base = inst.Name:match("^[%a_][%w_]*$") and inst.Name or inst.ClassName
        local name = base
        local counter = 1
        
        while usedNames[name] do
            counter = counter + 1
            name = base .. "_" .. tostring(counter)
        end
        
        usedNames[name] = true
        varMap[inst] = name
        return name
    end
    
    -- Code generation
    local function GenerateCode(inst, indentLevel)
        -- Skip server-side scripts
        if not config.includeServerScripts then
            if inst:IsA("Script") or inst:IsA("ModuleScript") then
                return ""
            end
        end
        
        local varName = GetVarName(inst)
        local indent = string.rep("    ", indentLevel)
        local lines = {}
        
        -- Create instance
        table.insert(lines, string.format(
            "%slocal %s = Instance.new(\"%s\")",
            indent, varName, inst.ClassName
        ))
        
        -- Set properties
        local properties = {}
        local defaultInst = Instance.new(inst.ClassName)
        
        table.insert(properties, string.format(
            '%s%s.Name = %q',
            indent, varName, inst.Name
        ))
        
        pcall(function()
            for propName, _ in pairs(inst:GetProperties()) do
                if not table.find(IGNORED_PROPS, propName) then
                    local success, defaultValue = pcall(function()
                        return defaultInst[propName]
                    end)
                    
                    if success and inst[propName] ~= defaultValue then
                        table.insert(properties, string.format(
                            "%s%s.%s = %s",
                            indent, varName, propName, FormatValue(inst[propName])
                        ))
                    end
                end
            end
        end)
        
        defaultInst:Destroy()
        table.insert(lines, table.concat(properties, "\n"))
        
        -- Handle LocalScript source
        -- if config.convertLocalScripts and inst:IsA("LocalScript") then
        --     local hasDecompiler = typeof(decompile) == 'function'
        --     local source = ""
            
        --     if hasDecompiler then
        --         local ok, result = pcall(decompile, inst)
        --         if ok and result and result ~= "" then
        --             source = result
        --             table.insert(lines, indent .. "--// Source decompiled")
        --         else
        --             source = inst.Source
        --             table.insert(lines, indent .. "--// Decompilation failed, using raw source")
        --         end
        --     else
        --         source = inst.Source
        --     end
            
        --     if source and source ~= "" then
        --         table.insert(lines, string.format(
        --             "%s%s.Source = [[\n%s\n]]",
        --             indent, varName, source
        --         ))
        --     end
        -- end
        
        -- Process children
        local children = inst:GetChildren()
        if #children > 0 then
            for _, child in ipairs(children) do
                local childCode = GenerateCode(child, indentLevel)
                if childCode ~= "" then
                    table.insert(lines, childCode)
                end
            end
            
            table.insert(lines, "")
            
            -- Parent children
            for _, child in ipairs(children) do
                if not (child:IsA("Script") or child:IsA("ModuleScript")) or config.includeServerScripts then
                    table.insert(lines, string.format(
                        "%s%s.Parent = %s",
                        indent, GetVarName(child), varName
                    ))
                end
            end
        end
        
        return table.concat(lines, "\n")
    end
    
    -- Build final output
    local output = {}
    
    -- Header
    table.insert(output, "--// Generated by GUI to Lua Converter")
    table.insert(output, string.format("--// Path: %s", pathString))
    table.insert(output, string.format("--// Time: %s", os.date("!%Y-%m-%dT%H:%M:%SZ")))
    table.insert(output, "")
    table.insert(output, "return function()")
    
    -- Main code
    table.insert(output, GenerateCode(target, 1))
    
    -- Return statement
    table.insert(output, "")
    table.insert(output, string.format("    return %s", GetVarName(target)))
    table.insert(output, "end")
    
    return table.concat(output, "\n")
end

return GuiToLua
