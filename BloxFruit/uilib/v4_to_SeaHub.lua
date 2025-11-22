local uilibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/LiterallyATrueClown/SeaHubFake/main/SeaHubUILIBFake.lua", true))()
local CounterAutoCallback = {}
function Window()
    local windowReturn = {}

	local windowz = uilibrary:CreateWindow("Sea Hub - HoHo Hub: Blox Fruit", true)

    function windowReturn:Nof(msg)
        return lib:Nof(msg, 6)
    end

    local CoreGui = game:GetService("StarterGui")

    function windowReturn:Nof(msg)
        CoreGui:SetCore("SendNotification", {
            Title = "Notification";
            Text = msg;
            Duration = 8;
        })
    end

    function windowReturn:HomeTab()
    end

    function windowReturn:CreditsTab()
    end

    function windowReturn:Debug()
        local debugReturn = {}
        function debugReturn:Item(txt)
            return Instance.new("TextLabel")
        end
        return debugReturn
    end

	local obj = Instance.new("TextLabel")

    function windowReturn:PagesTab()
        local PagesTabReturn = {}
        function PagesTabReturn:CreateButtonToFrame(title,desc,icon_id)
            local CreateButtonToFrameReturn = {Object=obj, ToFrame=obj}

			local Page1 = windowz:CreatePage(title)

            function CreateButtonToFrameReturn:CreateButtonToFrame(title,desc,_icon_id,_toggle,SyncWith,callback)
                local MiniCreateButtonToFrameReturn = {Object=obj, ToFrame=obj}
				local Section1 = Page1:CreateSection(title)
				Section1:CreateToggle(title, {Toggled = _toggle , Description = desc}, function(Value)
					if not CounterAutoCallback[title] then
						CounterAutoCallback[title] = true
						return
					end
					callback(Value)
				end)

                function MiniCreateButtonToFrameReturn:SelectorSingle(title,whichTab,__List,callback,deffault)
                    local drop = Section1:CreateDropdown(title, {
						List = __List,
						Default = "None"}, function(value)
							if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
						callback(value)
					end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:Refresh(_List)
						drop:Clear()
						drop:Add(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Slider(title,whichTab,min,max,default_value,callback)
                    local slider = Section1:CreateSlider(title, {Min = min, Max = max, DefaultValue = default_value}, function(Value)
						if not CounterAutoCallback[title] then
							CounterAutoCallback[title] = true
							return
						end
						callback(Value)
					end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Checkbox(title,whichTab,default_value,callback)
                    local toggle = Section1:CreateToggle(title, {Toggled = default_value , Description = title}, function(Value)
						if not CounterAutoCallback[title] then
							CounterAutoCallback[title] = true
							return
						end
						callback(Value)
					end)					
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox(title,whichTab,callback)
                    local txtbox = Section1:CreateTextbox(title, false, function (vv)
						if not CounterAutoCallback[title] then
							CounterAutoCallback[title] = true
							return
						end
						callback(vv)
					end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox2(title,whichTab,callback,default)
                    local txtbox = Section1:CreateTextbox(title, false, function (vv)
						if not CounterAutoCallback[title] then
							CounterAutoCallback[title] = true
							return
						end
						callback(vv)
					end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Paragraph(title,whichTab)
                    local label = Section1:CreateButton(title, function () end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:ChangeText(newText)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Label(title,whichTab)
                    local label = Section1:CreateButton(title, function () end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:ChangeText(newText)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Button(title,whichTab,callback)
                    Section1:CreateButton(title, function ()
						callback()
					 end)
                end

                function MiniCreateButtonToFrameReturn:SelectorMultiple(title,whichTab,__List,callback, listhave)
                    local drop = Section1:CreateDropdown(title, {
						List = __List,
						Default = "None"}, function(value)
							if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
						callback({value})
					end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:Refresh(_List)
						drop:Clear()
						drop:Add(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:ButtonGroup(title,whichTab,__List)
                    for i, v in pairs(__List) do
						Section1:CreateButton(title .. ":" .. v[1], function ()
							v[2]()
						 end)
                    end
                end

                function MiniCreateButtonToFrameReturn:Image(title,whichTab,imgID)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:ChangeImage(newImageID,newTitle)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Header(title,whichTab)
                    local Config = {Object=obj, ToFrame=obj}
                    return Config
                end

                function MiniCreateButtonToFrameReturn:ColorPicker(title,whichTab,default_color,callback)
                    local Config = {Object=obj, ToFrame=obj}
					function Config:SetColor(Color)
					end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:KeyBind(title,whichTab,default_keybind,callback)
                    local Config = {Object=obj, ToFrame=obj}
					function Config:SetKey(value)
					end
                    return Config
                end

                return MiniCreateButtonToFrameReturn
            end
            return CreateButtonToFrameReturn
        end
        return PagesTabReturn
    end
    return windowReturn
end
return Window
