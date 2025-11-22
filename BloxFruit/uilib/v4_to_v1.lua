local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/refs/heads/main/hoho_lib.lua", true))()
local win = lib:Window("Blox Fruit","HoHo Hub V1",Color3.new(0.333333, 0.666667, 1))
local obj = Instance.new("TextLabel")

function Window()
    local windowReturn = {}

    function windowReturn:Nof(msg)
        return lib:Nof(msg, 6)
    end

    function windowReturn:Ready()
        print("ui ready!")
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
        local PagesTabReturn = {}
        function PagesTabReturn:CreateButtonToFrame(title,desc,icon_id)
            local CreateButtonToFrameReturn = {Object=obj, ToFrame=obj}

            local tab = win:Tab(title)

            function CreateButtonToFrameReturn:CreateButtonToFrame(title,desc,_icon_id,_toggle,SyncWith,callback)
                local MiniCreateButtonToFrameReturn = {Object=obj, ToFrame=obj}
                tab:Line()
                tab:Label(title, {})
                tab:Toggle(title, _toggle, function(val)
                    callback(val)
                end)

                function MiniCreateButtonToFrameReturn:SelectorSingle(title,whichTab,__List,callback,deffault)
                    local drop = tab:Dropdown(title, __List, function(val)
                        callback(val)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:Refresh(_List)
                        drop:NewDrop(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Slider(title,whichTab,min,max,default_value,callback)
                    local slider = tab:Slider(title,min,max,default_value,function(val)
                        callback(val)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Checkbox(title,whichTab,default_value,callback)
                    local toggle = tab:Toggle(title, default_value, function(val)
                        callback(val)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox(title,whichTab,callback)
                    local txtbox = tab:Textbox(title,"Text here",function(val)
                        callback(val)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox2(title,whichTab,callback,default)
                    local txtbox = tab:Textbox(title,default,function(val)
                        callback(val)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Paragraph(title,whichTab)
                    local label = tab:Label(title, {})
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:ChangeText(newText)
                        label:NewLabel(newText, {})
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Label(title,whichTab)
                    local label = tab:Label(title, {})
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:ChangeText(newText)
                        label:NewLabel(newText, {})
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Button(title,whichTab,callback)
                    tab:Button(title, function()
                        callback()
                    end)
                end

                function MiniCreateButtonToFrameReturn:SelectorMultiple(title,whichTab,__List,callback, listhave)
                    local drop = tab:Dropdown(title, __List, function(val)
                        callback({val})
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:Refresh(_List)
                        drop:NewDrop(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:ButtonGroup(title,whichTab,__List)
                    tab:Line()
                    tab:Label(title, {})
                    for i, v in pairs(__List) do
                        tab:Button(v[1], function()
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
