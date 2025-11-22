local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "W-azure|Banana|HoHo Hub",
    SubTitle = "Blox Fruit",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local CounterAutoCallback = {}

local obj = Instance.new("TextLabel")

function WindowZZZZ()
    local windowReturn = {}

    function windowReturn:Nof(msg)
        Fluent:Notify({
            Title = "Notification",
            Content = msg,
            Duration = 8
        })
    end

    function windowReturn:Ready()
        local Settings = Window:AddTab({ Title = "UI Settings", Icon = "settings" })
        InterfaceManager:SetLibrary(Fluent)

        InterfaceManager:SetFolder("FluentScriptHub")

        InterfaceManager:BuildInterfaceSection(Settings)

        Window:SelectTab(1)
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

    function windowReturn:PagesTab()
        local PagesTabReturn = {Object=obj, ToFrame=obj}
        function PagesTabReturn:CreateButtonToFrame(title,desc,icon_id)
            local CreateButtonToFrameReturn = {}

            local tab = Window:AddTab({ Title = title, Icon = icon_id })

            function CreateButtonToFrameReturn:CreateButtonToFrame(title,desc,_icon_id,_toggle,SyncWith,callback)
                local MiniCreateButtonToFrameReturn = {}
                tab:AddParagraph({
                    Title = "=============" .. title .. "=============",
                    Content = desc
                })
                local ToggleBTF = tab:AddToggle(title, {Title = title, Default = _toggle,
                    Callback = function(Value)
                        if not CounterAutoCallback[title] then
                            CounterAutoCallback[title] = true
                            return
                        end
                        callback(Value)
                    end
                })

                function MiniCreateButtonToFrameReturn:SelectorSingle(title,whichTab,__List,callback,deffault)
                    local Dropdown = tab:AddDropdown(title, {
                        Title = title,
                        Values = __List,
                        Multi = false,
                        Default = 1,
                        Callback = function(Value)
                            if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
                            callback(Value)
                        end
                    })                
                    local Config = {}
                    function Config:Refresh(_List)
                        Dropdown:SetValues(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Slider(title,whichTab,min,max,default_value,callback)
                    local Slider = tab:AddSlider(title, {
                        Title = title,
                        Description = title,
                        Default = default_value,
                        Min = min,
                        Max = max,
                        Rounding = .1,
                        Callback = function(Value)
                            if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
                            callback(Value)
                        end
                    })
                    local Config = {}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Checkbox(title,whichTab,default_value,callback)
                    local Toggle = tab:AddToggle(title, {Title = title, Default = default_value,
                        Callback = function(Value)
                            if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
                            callback(Value)
                        end
                    })
                    local Config = {}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox(title,whichTab,callback)
                    local Input = tab:AddInput(title, {
                        Title = title,
                        Default = "Default",
                        Placeholder = "Placeholder",
                        Numeric = false,
                        Finished = true,
                        Callback = function(Value)
                            if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
                            callback(Value)
                        end
                    })
                    local Config = {}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox2(title,whichTab,callback,default)
                    local Input = tab:AddInput(title, {
                        Title = title,
                        Default = tostring(default),
                        Placeholder = "Placeholder",
                        Numeric = false,
                        Finished = true,
                        Callback = function(Value)
                            if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
                            callback(Value)
                        end
                    })
                    local Config = {}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Paragraph(title,whichTab)
                    local label = tab:AddParagraph({
                        Title = "Paragraph",
                        Content = title
                    })
                    local Config = {}
                    function Config:ChangeText(newText)
                        label:SetDesc(newText)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Label(title,whichTab)
                    local label = tab:AddParagraph({
                        Title = "Paragraph",
                        Content = title
                    })
                    local Config = {}
                    function Config:ChangeText(newText)
                        label:SetDesc(newText)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Button(title,whichTab,callback)
                    tab:AddButton({
                        Title = title,
                        Description = title,
                        Callback = function()
                            callback()
                        end
                    })
                    local Config = {Object=obj, ToFrame=obj}
                    return Config
                end

                function MiniCreateButtonToFrameReturn:SelectorMultiple(title,whichTab,__List,callback, listhave)
                    local Dropdown = tab:AddDropdown(title, {
                        Title = title,
                        Values = __List,
                        Multi = true,
                        Default = {},
                        Callback = function(Value)
                            if not CounterAutoCallback[title] then
                                CounterAutoCallback[title] = true
                                return
                            end
                            callback(Value)
                        end
                    })                
                    local Config = {}
                    function Config:Refresh(_List)
                        Dropdown:SetValues(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:ButtonGroup(title,whichTab,__List)
                    tab:AddParagraph({
                        Title = "=============" .. title .. "=============",
                        Content = title
                    })
                    for i, v in pairs(__List) do
                        tab:AddButton({
                            Title = v[1],
                            Description = v[1],
                            Callback = function()
                                v[2]()
                            end
                        })
                    end
                    local Config = {Object=obj, ToFrame=obj}
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Image(title,whichTab,imgID)
                    local Config = {}
                    function Config:ChangeImage(newImageID,newTitle)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Header(title,whichTab)
                    local Config = {}
                    return Config
                end

                function MiniCreateButtonToFrameReturn:ColorPicker(title,whichTab,default_color,callback)
                    local Config = {}
					function Config:SetColor(Color)
					end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:KeyBind(title,whichTab,default_keybind,callback)
                    local Config = {}
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
return WindowZZZZ
