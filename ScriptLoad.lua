UniverseId, LinkKey,  LinkDiscord = tostring(game.GameId), "", ""
if UniverseId == "2316994223" then --DaNeko
	loadstring(game:HttpGet'https://raw.githubusercontent.com/abcxyzawe/script-load/main/DaNekoLoader')()
	return
end
LinkKey = "https://hohohubv-ac90f67762c4.herokuapp.com/get"
LinkDiscord = "discord.gg/hohohub"

local Hoho_Key = Instance.new("ScreenGui")
local Keyshadow = Instance.new("ImageLabel")
local Keyframe = Instance.new("Frame")
local KeyframeUICorner = Instance.new("UICorner")
local Text_Key_Design_B = Instance.new("TextLabel")
local HowToGetKey_Button = Instance.new("TextButton")
local HowToGetKey_ButtonUICorner = Instance.new("UICorner")
local OutlinKeyFrame_Outline = Instance.new("Frame")
local Key_Frame_Icon = Instance.new("ImageLabel")
local Keyframe_Top_Frame = Instance.new("Frame")
local EnteryourkeyFrame = Instance.new("Frame")
local EnteryourkeyFrameUICorner = Instance.new("UICorner")
local Key_Text = Instance.new("TextBox")
local CheckKey = Instance.new("TextButton")
local CheckKeyUICorner = Instance.new("UICorner")
local Text_Key_Design_A = Instance.new("TextLabel")
local Discord_Link = Instance.new("TextLabel")
local OldVersionButton = Instance.new("TextButton")
local CheckKeyUICorner_2 = Instance.new("UICorner")
local CloseGuiButton = Instance.new("TextButton")
local CheckKeyUICorner_3 = Instance.new("UICorner")
local Current_Key_String = Instance.new("TextLabel")

Hoho_Key.Name = "Hoho_Key"
Hoho_Key.Parent = game.CoreGui
Hoho_Key.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Keyshadow.Name = "Keyshadow"
Keyshadow.Parent = Hoho_Key
Keyshadow.AnchorPoint = Vector2.new(0.5, 0.5)
Keyshadow.BackgroundTransparency = 1.000
Keyshadow.BorderSizePixel = 0
Keyshadow.Position = UDim2.new(0.5, 0, 0.522031844, 0)
Keyshadow.Size = UDim2.new(0, 472, 0, 186)
Keyshadow.Image = "rbxassetid://1316045217"
Keyshadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Keyshadow.ImageTransparency = 0.400
Keyshadow.ScaleType = Enum.ScaleType.Slice
Keyshadow.SliceCenter = Rect.new(10, 10, 118, 118)

Keyframe.Name = "Keyframe"
Keyframe.Parent = Keyshadow
Keyframe.BackgroundColor3 = Color3.fromRGB(12, 11, 21)
Keyframe.Position = UDim2.new(0, 6, 0, 6)
Keyframe.Size = UDim2.new(0, 460, 0, 172)

KeyframeUICorner.CornerRadius = UDim.new(0, 2)
KeyframeUICorner.Name = "KeyframeUICorner"
KeyframeUICorner.Parent = Keyframe

local KeyframeUIStroke = Instance.new("UIStroke")
KeyframeUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
KeyframeUIStroke.Color = Color3.fromRGB(185, 1, 41)
KeyframeUIStroke.LineJoinMode = Enum.LineJoinMode.Round
KeyframeUIStroke.Thickness = 2
KeyframeUIStroke.Transparency = 0.5
KeyframeUIStroke.Parent = Keyframe

Text_Key_Design_B.Name = "Text_Key_Design_B"
Text_Key_Design_B.Parent = Keyframe
Text_Key_Design_B.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_Key_Design_B.BackgroundTransparency = 1.000
Text_Key_Design_B.BorderSizePixel = 0
Text_Key_Design_B.Position = UDim2.new(0, 34, 0, 10)
Text_Key_Design_B.Size = UDim2.new(0, 160, 0, 14)
Text_Key_Design_B.ZIndex = 3
Text_Key_Design_B.Font = Enum.Font.GothamBold
Text_Key_Design_B.Text = "HoHo Hub | Key System"
Text_Key_Design_B.TextColor3 = Color3.fromRGB(220, 220, 220)
Text_Key_Design_B.TextSize = 14.000
Text_Key_Design_B.TextXAlignment = Enum.TextXAlignment.Left

HowToGetKey_Button.Name = "HowToGetKey_Button"
HowToGetKey_Button.Parent = Keyframe
HowToGetKey_Button.BackgroundColor3 = Color3.fromRGB(185, 1, 41)
HowToGetKey_Button.BorderSizePixel = 0
HowToGetKey_Button.Position = UDim2.new(0, 202, 0, 4)
HowToGetKey_Button.Size = UDim2.new(0, 130, 0, 26)
HowToGetKey_Button.ZIndex = 3
HowToGetKey_Button.AutoButtonColor = false
HowToGetKey_Button.Font = Enum.Font.GothamMedium
HowToGetKey_Button.Text = "Get Key"
HowToGetKey_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
HowToGetKey_Button.TextSize = 14.000

HowToGetKey_ButtonUICorner.CornerRadius = UDim.new(0, 2)
HowToGetKey_ButtonUICorner.Name = "HowToGetKey_ButtonUICorner"
HowToGetKey_ButtonUICorner.Parent = HowToGetKey_Button

OutlinKeyFrame_Outline.Name = "OutlinKeyFrame_Outline"
OutlinKeyFrame_Outline.Parent = Keyframe
OutlinKeyFrame_Outline.BackgroundColor3 = Color3.fromRGB(185, 1, 41)
OutlinKeyFrame_Outline.BackgroundTransparency = 0.500
OutlinKeyFrame_Outline.BorderSizePixel = 0
OutlinKeyFrame_Outline.Position = UDim2.new(0, 0, 0, 34)
OutlinKeyFrame_Outline.Size = UDim2.new(0, 460, 0, 2)
OutlinKeyFrame_Outline.ZIndex = 2

Key_Frame_Icon.Name = "Key_Frame_Icon"
Key_Frame_Icon.Parent = Keyframe
Key_Frame_Icon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Key_Frame_Icon.BackgroundTransparency = 1.000
Key_Frame_Icon.BorderSizePixel = 0
Key_Frame_Icon.Position = UDim2.new(0, 6, 0, 6)
Key_Frame_Icon.Size = UDim2.new(0, 22, 0, 22)
Key_Frame_Icon.ZIndex = 3
Key_Frame_Icon.Image = "http://www.roblox.com/asset/?id=6034687957"
Key_Frame_Icon.ImageColor3 = Color3.fromRGB(185, 1, 41)

Keyframe_Top_Frame.Name = "Keyframe_Top_Frame"
Keyframe_Top_Frame.Parent = Keyframe
Keyframe_Top_Frame.BackgroundColor3 = Color3.fromRGB(12, 11, 21)
Keyframe_Top_Frame.BorderSizePixel = 0
Keyframe_Top_Frame.Size = UDim2.new(0, 460, 0, 34)
Keyframe_Top_Frame.ZIndex = 2

EnteryourkeyFrame.Name = "EnteryourkeyFrame"
EnteryourkeyFrame.Parent = Keyframe
EnteryourkeyFrame.BackgroundColor3 = Color3.fromRGB(12, 11, 21)
EnteryourkeyFrame.BorderSizePixel = 0
EnteryourkeyFrame.Position = UDim2.new(0, 10, 0, 66)
EnteryourkeyFrame.Size = UDim2.new(0, 442, 0, 30)
EnteryourkeyFrame.ZIndex = 2

EnteryourkeyFrameUICorner.CornerRadius = UDim.new(0, 2)
EnteryourkeyFrameUICorner.Name = "EnteryourkeyFrameUICorner"
EnteryourkeyFrameUICorner.Parent = EnteryourkeyFrame

local EnteryourkeyFrameUIStroke = Instance.new("UIStroke")
EnteryourkeyFrameUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
EnteryourkeyFrameUIStroke.Color = Color3.fromRGB(185, 1, 41)
EnteryourkeyFrameUIStroke.LineJoinMode = Enum.LineJoinMode.Round
EnteryourkeyFrameUIStroke.Thickness = 2
EnteryourkeyFrameUIStroke.Transparency = 0.8
EnteryourkeyFrameUIStroke.Parent = EnteryourkeyFrame

Key_Text.Name = "Key_Text"
Key_Text.Parent = EnteryourkeyFrame
Key_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Key_Text.BackgroundTransparency = 1.000
Key_Text.Position = UDim2.new(0, 10, 0, 0)
Key_Text.Size = UDim2.new(0, 410, 0, 30)
Key_Text.ZIndex = 3
Key_Text.ClearTextOnFocus = false
Key_Text.Font = Enum.Font.GothamMedium
Key_Text.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
Key_Text.PlaceholderText = "Go to website to take your key with script"
Key_Text.Text = ""
Key_Text.TextColor3 = Color3.fromRGB(220, 220, 220)
Key_Text.TextSize = 14.000
Key_Text.TextXAlignment = Enum.TextXAlignment.Left
Key_Text.TextScaled = true

CheckKey.Name = "CheckKey"
CheckKey.Parent = Keyframe
CheckKey.BackgroundColor3 = Color3.fromRGB(185, 1, 41)
CheckKey.BorderSizePixel = 0
CheckKey.Position = UDim2.new(0, 336, 0, 104)
CheckKey.Size = UDim2.new(0, 116, 0, 26)
CheckKey.ZIndex = 3
CheckKey.AutoButtonColor = false
CheckKey.Font = Enum.Font.GothamMedium
CheckKey.Text = ""
CheckKey.TextColor3 = Color3.fromRGB(220, 220, 220)
CheckKey.TextSize = 14.000
CheckKey.Visible = false

CheckKeyUICorner.CornerRadius = UDim.new(0, 2)
CheckKeyUICorner.Name = "CheckKeyUICorner"
CheckKeyUICorner.Parent = CheckKey

Text_Key_Design_A.Name = "Text_Key_Design_A"
Text_Key_Design_A.Parent = Keyframe
Text_Key_Design_A.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_Key_Design_A.BackgroundTransparency = 1.000
Text_Key_Design_A.BorderSizePixel = 0
Text_Key_Design_A.Position = UDim2.new(0, 10, 0, 44)
Text_Key_Design_A.Size = UDim2.new(0, 156, 0, 14)
Text_Key_Design_A.ZIndex = 3
Text_Key_Design_A.Font = Enum.Font.GothamMedium
Text_Key_Design_A.Text = "1 User | 24 Hours Key"
Text_Key_Design_A.TextColor3 = Color3.fromRGB(220, 220, 220)
Text_Key_Design_A.TextSize = 14.000
Text_Key_Design_A.TextXAlignment = Enum.TextXAlignment.Left

Discord_Link.Name = "Discord_Link"
Discord_Link.Parent = Keyframe
Discord_Link.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Discord_Link.BackgroundTransparency = 1.000
Discord_Link.BorderSizePixel = 0
Discord_Link.Position = UDim2.new(0, 260, 0, 44)
Discord_Link.Size = UDim2.new(0, 192, 0, 14)
Discord_Link.ZIndex = 3
Discord_Link.Font = Enum.Font.GothamMedium
Discord_Link.Text = LinkDiscord
Discord_Link.TextColor3 = Color3.fromRGB(120, 120, 120)
Discord_Link.TextSize = 14.000
Discord_Link.TextXAlignment = Enum.TextXAlignment.Right

OldVersionButton.Name = "OldVersionButton"
OldVersionButton.Parent = Keyframe
OldVersionButton.BackgroundColor3 = Color3.fromRGB(185, 1, 41)
OldVersionButton.BorderSizePixel = 0
OldVersionButton.Position = UDim2.new(0, 202, 0, 138)
OldVersionButton.Size = UDim2.new(0, 250, 0, 26)
OldVersionButton.ZIndex = 3
OldVersionButton.AutoButtonColor = false
OldVersionButton.Font = Enum.Font.GothamMedium
OldVersionButton.Text = ""
OldVersionButton.TextColor3 = Color3.fromRGB(220, 220, 220)
OldVersionButton.TextSize = 14.000
OldVersionButton.Visible = false

CheckKeyUICorner_2.CornerRadius = UDim.new(0, 2)
CheckKeyUICorner_2.Name = "CheckKeyUICorner"
CheckKeyUICorner_2.Parent = OldVersionButton

CloseGuiButton.Name = "CloseGuiButton"
CloseGuiButton.Parent = Keyframe
CloseGuiButton.BackgroundColor3 = Color3.fromRGB(185, 1, 41)
CloseGuiButton.BorderSizePixel = 0
CloseGuiButton.Position = UDim2.new(0, 9, 0, 138)
CloseGuiButton.Size = UDim2.new(0, 186, 0, 26)
CloseGuiButton.ZIndex = 3
CloseGuiButton.AutoButtonColor = false
CloseGuiButton.Font = Enum.Font.GothamMedium
CloseGuiButton.Text = "Close"
CloseGuiButton.TextColor3 = Color3.fromRGB(220, 220, 220)
CloseGuiButton.TextSize = 14.000

CheckKeyUICorner_3.CornerRadius = UDim.new(0, 2)
CheckKeyUICorner_3.Name = "CheckKeyUICorner"
CheckKeyUICorner_3.Parent = CloseGuiButton

Current_Key_String.Name = "Current_Key_String"
Current_Key_String.Parent = Keyframe
Current_Key_String.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Current_Key_String.BackgroundTransparency = 1.000
Current_Key_String.BorderSizePixel = 0
Current_Key_String.Position = UDim2.new(0, 10, 0, 110)
Current_Key_String.Size = UDim2.new(0, 304, 0, 14)
Current_Key_String.ZIndex = 3
Current_Key_String.Font = Enum.Font.GothamMedium
Current_Key_String.Text = "Click 'Get Key' to take website link"
Current_Key_String.TextColor3 = Color3.fromRGB(220, 220, 220)
Current_Key_String.TextSize = 14.000
Current_Key_String.TextXAlignment = Enum.TextXAlignment.Left

function effectButton(object, NewText)
	local OldText = object.Text
	object.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(object, TweenInfo.new(0.2,Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0.3}):Play()
	end)
	object.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(object, TweenInfo.new(0.2,Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
	end)
	object.MouseButton1Down:Connect(function()
		game:GetService("TweenService"):Create(object, TweenInfo.new(0.2,Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0.6}):Play()
	end)
	object.MouseButton1Up:Connect(function()
		game:GetService("TweenService"):Create(object, TweenInfo.new(0.2,Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
	end)
	if NewText then
		object.MouseButton1Click:Connect(function()
			object.Text = NewText
			wait(1)
			object.Text = OldText
		end)
	end
end

effectButton(HowToGetKey_Button, "Copied*")
effectButton(CheckKey)
effectButton(CloseGuiButton)
effectButton(OldVersionButton)

HowToGetKey_Button.MouseButton1Click:Connect(function()
	setclipboard(LinkKey)
end)
CloseGuiButton.MouseButton1Click:Connect(function()
	Hoho_Key:Destroy()
end)

repeat task.wait() until _G.wl_key

Hoho_Key:Destroy()
