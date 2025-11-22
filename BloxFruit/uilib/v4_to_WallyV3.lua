
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local obj = Instance.new("TextLabel")

function Window()
    local windowReturn = {}

    local isFirstTime = false
    local CoreGui = game:GetService("StarterGui")

    function windowReturn:Nof(msg)
        CoreGui:SetCore("SendNotification", {
            Title = "Notification";
            Text = msg;
            Duration = 8;
        })
    end

    function windowReturn:Ready()
        print("ui ready!")
        for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v:FindFirstChild("HiI'mSexyDon'tTouchMePls") then
                local count = 1
                for i, v in pairs(v:GetChildren()) do
                    print(v)
                    if v.Name == "Window" then
                        v.Position = UDim2.new(0, count, 0, 15)
                        count = count + 140
                    end
                end
                break
            end
        end
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

            local window = library:CreateWindow(isFirstTime and title or "HoHo Hub | " .. title)
            isFirstTime = true

            function CreateButtonToFrameReturn:CreateButtonToFrame(title,desc,_icon_id,_toggle,SyncWith,callback)
                local MiniCreateButtonToFrameReturn = {Object=obj, ToFrame=obj}

                local folder = window:CreateFolder(title)
                folder:Toggle(title,function(bool)
                    callback(bool)
                end)

                function MiniCreateButtonToFrameReturn:SelectorSingle(title,whichTab,__List,callback,deffault)
                    local drop = folder:Dropdown(title,__List,function(a)
                        callback(a)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:Refresh(_List)
                        drop:Refresh(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Slider(title,whichTab,min,max,default_value,callback)
                    local slider = folder:Slider(title,{
                        min = min;
                        max = max;
                        precise = false;
                    },function(value)
                        callback(value)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Checkbox(title,whichTab,default_value,callback)
                    local toggle = folder:Toggle(title,function(bool)
                        callback(bool)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetValue(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox(title,whichTab,callback)
                    local txtbox = folder:Box(title,"string",function(value)
                        callback(value)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Textbox2(title,whichTab,callback,default)
                    local txtbox = folder:Box(title,"string",function(value)
                        callback(value)
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:SetText(value)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Paragraph(title,whichTab)
                    local label = folder:Label(title,{
                        TextSize = 12;
                        TextColor = Color3.fromRGB(255,255,255); 
                        BgColor = Color3.fromRGB(69,69,69);
                        
                    }) 
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:ChangeText(newText)
                        label:Refresh(newText)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Label(title,whichTab)
                    local label = folder:Label(title,{
                        TextSize = 12;
                        TextColor = Color3.fromRGB(255,255,255); 
                        BgColor = Color3.fromRGB(69,69,69);
                        
                    }) 
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:ChangeText(newText)
                        label:Refresh(newText)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:Button(title,whichTab,callback)
                    folder:Button(title,function()
                        callback()
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    return Config
                end

                function MiniCreateButtonToFrameReturn:SelectorMultiple(title,whichTab,__List,callback, listhave)
                    local drop = folder:Dropdown(title,__List,function(a)
                        callback({a})
                    end)
                    local Config = {Object=obj, ToFrame=obj}
                    function Config:Refresh(_List)
                        drop:Refresh(_List)
                    end
                    return Config
                end

                function MiniCreateButtonToFrameReturn:ButtonGroup(title,whichTab,__List)
                    local label = folder:Label(title,{
                        TextSize = 12;
                        TextColor = Color3.fromRGB(255,255,255); 
                        BgColor = Color3.fromRGB(69,69,69);
                        
                    }) 
                    for i, v in pairs(__List) do
                        folder:Button(v[1],function()
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
