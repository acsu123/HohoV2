local TopbarUI = {}
TopbarUI.__index = TopbarUI

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local sharedScreenGui = nil
local sharedContainer = nil
local buttons = {}
local isCollapsed = false
local collapseButton = nil

local function initSharedUI()
    if sharedScreenGui then return end

    sharedScreenGui = Instance.new("ScreenGui")
    sharedScreenGui.Name = "TopbarUIContainer"
    sharedScreenGui.ResetOnSpawn = false
    sharedScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sharedScreenGui.IgnoreGuiInset = true
    sharedScreenGui.Parent = CoreGui

    sharedContainer = Instance.new("Frame")
    sharedContainer.Name = "Container"
    sharedContainer.Size = UDim2.new(0, 0, 0, 65)
    sharedContainer.Position = UDim2.new(0.5, 0, 0, 5)
    sharedContainer.AnchorPoint = Vector2.new(0.5, 0)
    sharedContainer.BackgroundTransparency = 1
    sharedContainer.AutomaticSize = Enum.AutomaticSize.X
    sharedContainer.Parent = sharedScreenGui

    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Horizontal
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 3) 

    listLayout.Parent = sharedContainer

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.Parent = sharedContainer

    -- Tạo nút collapse
    createCollapseButton()
end

function createCollapseButton()
    collapseButton = Instance.new("Frame")
    collapseButton.Name = "CollapseButton"
    collapseButton.Size = UDim2.new(0, 30, 0, 50)
    collapseButton.BackgroundTransparency = 1
    collapseButton.BorderSizePixel = 0
    collapseButton.LayoutOrder = 999999 -- Always at the end
    collapseButton.Parent = sharedContainer

    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = "<"
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.TextSize = 20
    button.Font = Enum.Font.GothamBold
    button.Parent = collapseButton

    -- Caption
    local caption = Instance.new("Frame")
    caption.Name = "Caption"
    caption.Size = UDim2.new(0, 0, 0, 0)
    caption.Position = UDim2.new(0.5, 0, 1, 8)
    caption.AnchorPoint = Vector2.new(0.5, 0)
    caption.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    caption.BorderSizePixel = 0
    caption.Visible = false
    caption.AutomaticSize = Enum.AutomaticSize.XY
    caption.ZIndex = 100
    caption.Parent = collapseButton

    local captionCorner = Instance.new("UICorner")
    captionCorner.CornerRadius = UDim.new(0, 8)
    captionCorner.Parent = caption

    local captionStroke = Instance.new("UIStroke")
    captionStroke.Color = Color3.fromRGB(60, 60, 60)
    captionStroke.Thickness = 1
    captionStroke.Transparency = 0.5
    captionStroke.Parent = caption

    local captionText = Instance.new("TextLabel")
    captionText.Name = "Text"
    captionText.Size = UDim2.new(0, 100, 0, 0)
    captionText.Position = UDim2.new(0, 0, 0, 0)
    captionText.BackgroundTransparency = 1
    captionText.Text = "Collapse"
    captionText.TextColor3 = Color3.fromRGB(220, 220, 220)
    captionText.TextSize = 11
    captionText.Font = Enum.Font.Gotham
    captionText.TextXAlignment = Enum.TextXAlignment.Center
    captionText.TextYAlignment = Enum.TextYAlignment.Top
    captionText.TextWrapped = true
    captionText.AutomaticSize = Enum.AutomaticSize.Y
    captionText.Parent = caption

    local captionPadding = Instance.new("UIPadding")
    captionPadding.PaddingTop = UDim.new(0, 8)
    captionPadding.PaddingBottom = UDim.new(0, 8)
    captionPadding.PaddingLeft = UDim.new(0, 10)
    captionPadding.PaddingRight = UDim.new(0, 10)
    captionPadding.Parent = caption

    -- Hover effect
    button.MouseEnter:Connect(function()
        caption.Visible = true
        TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        caption.Visible = false
        TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            TextColor3 = Color3.fromRGB(200, 200, 200)
        }):Play()
    end)

    -- Click to toggle collapse
    button.MouseButton1Click:Connect(function()
        isCollapsed = not isCollapsed
        
        -- Update caption text and button text
        captionText.Text = isCollapsed and "Expand" or "Collapse"
        button.Text = isCollapsed and ">" or "<"
        
        -- Bounce effect
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
            TextSize = 24
        }):Play()
        task.wait(0.1)
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
            TextSize = 20
        }):Play()

        -- Hide/show other buttons
        for _, btn in ipairs(buttons) do
            if btn.frame then
                if isCollapsed then
                    -- Collapse: scale to 0
                    TweenService:Create(btn.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 0, 0, 50)
                    }):Play()
                    task.wait(0.3)
                    btn.frame.Visible = false
                else
                    -- Expand
                    btn.frame.Visible = true
                    TweenService:Create(btn.frame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                        Size = UDim2.new(0, 50, 0, 50)
                    }):Play()
                end
            end
        end
    end)
end

function TopbarUI.new()
    initSharedUI()

    local self = setmetatable({}, TopbarUI)

    self.button = nil
    self.frame = nil
    self.label = ""
    self.caption = ""
    self.imageId = ""
    self.position = "Mid"
    self.isOpen = false
    self.callbacks = {}
    self.layoutOrder = #buttons

    table.insert(buttons, self)

    self:_createUI()

    return self
end

function TopbarUI:_createUI()

    self.frame = Instance.new("Frame")
    self.frame.Name = "TopbarButton"
    self.frame.Size = UDim2.new(0, 50, 0, 50)
    self.frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    self.frame.BorderSizePixel = 0
    self.frame.LayoutOrder = self.layoutOrder
    self.frame.Parent = sharedContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = self.frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 60, 60)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = self.frame

    self.button = Instance.new("TextButton")
    self.button.Name = "Button"
    self.button.Size = UDim2.new(1, 0, 1, 0)
    self.button.BackgroundTransparency = 1
    self.button.Text = ""
    self.button.Parent = self.frame

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "Icon"
    imageLabel.Size = UDim2.new(0, 28, 0, 28)
    imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    imageLabel.BackgroundTransparency = 1
    imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    imageLabel.Parent = self.button

    local labelText = Instance.new("TextLabel")
    labelText.Name = "Label"
    labelText.Size = UDim2.new(1, -6, 0, 14)
    labelText.Position = UDim2.new(0.5, 0, 1, -16)
    labelText.AnchorPoint = Vector2.new(0.5, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = ""
    labelText.TextColor3 = Color3.fromRGB(200, 200, 200)
    labelText.TextSize = 9
    labelText.Font = Enum.Font.GothamMedium
    labelText.TextXAlignment = Enum.TextXAlignment.Center
    labelText.TextScaled = true
    labelText.Visible = false
    labelText.TextTransparency = 1
    labelText.Parent = self.frame

    local labelConstraint = Instance.new("UITextSizeConstraint")
    labelConstraint.MaxTextSize = 9
    labelConstraint.Parent = labelText

    local caption = Instance.new("Frame")
    caption.Name = "Caption"
    caption.Size = UDim2.new(0, 0, 0, 0)
    caption.Position = UDim2.new(0.5, 0, 1, 8)
    caption.AnchorPoint = Vector2.new(0.5, 0)
    caption.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    caption.BorderSizePixel = 0
    caption.Visible = false
    caption.AutomaticSize = Enum.AutomaticSize.XY
    caption.ZIndex = 100
    caption.Parent = self.frame

    local captionCorner = Instance.new("UICorner")
    captionCorner.CornerRadius = UDim.new(0, 8)
    captionCorner.Parent = caption

    local captionStroke = Instance.new("UIStroke")
    captionStroke.Color = Color3.fromRGB(60, 60, 60)
    captionStroke.Thickness = 1
    captionStroke.Transparency = 0.5
    captionStroke.Parent = caption

    local captionText = Instance.new("TextLabel")
    captionText.Name = "Text"
    captionText.Size = UDim2.new(0, 250, 0, 0)
    captionText.Position = UDim2.new(0, 0, 0, 0)
    captionText.BackgroundTransparency = 1
    captionText.Text = ""
    captionText.TextColor3 = Color3.fromRGB(220, 220, 220)
    captionText.TextSize = 11
    captionText.Font = Enum.Font.Gotham
    captionText.TextXAlignment = Enum.TextXAlignment.Center
    captionText.TextYAlignment = Enum.TextYAlignment.Top
    captionText.TextWrapped = true
    captionText.AutomaticSize = Enum.AutomaticSize.Y
    captionText.Parent = caption

    local captionPadding = Instance.new("UIPadding")
    captionPadding.PaddingTop = UDim.new(0, 8)
    captionPadding.PaddingBottom = UDim.new(0, 8)
    captionPadding.PaddingLeft = UDim.new(0, 10)
    captionPadding.PaddingRight = UDim.new(0, 10)
    captionPadding.Parent = caption

    -- Hover effect
    self.button.MouseEnter:Connect(function()
        if self.caption ~= "" then
            caption.Visible = true
        end

        if self.label ~= "" then
            labelText.Visible = true
            TweenService:Create(labelText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            local textService = game:GetService("TextService")
            local textSize = textService:GetTextSize(self.label, 9, Enum.Font.GothamMedium, Vector2.new(200, 20))
            local newWidth = math.max(50, math.min(80, textSize.X + 12))

            TweenService:Create(imageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, 0, 0, 8)
            }):Play()

            TweenService:Create(self.frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, newWidth, 0, 60),
                BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            }):Play()
        else
            TweenService:Create(self.frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            }):Play()
        end

        TweenService:Create(stroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Transparency = 0.2
        }):Play()
    end)

    self.button.MouseLeave:Connect(function()
        caption.Visible = false

        if self.label ~= "" then
            TweenService:Create(labelText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                TextTransparency = 1
            }):Play()

            TweenService:Create(imageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()

            task.wait(0.2)
            labelText.Visible = false
        end

        local targetColor = self.isOpen and Color3.fromRGB(50, 120, 255) or Color3.fromRGB(35, 35, 35)
        TweenService:Create(self.frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 50, 0, 50),
            BackgroundColor3 = targetColor
        }):Play()

        TweenService:Create(stroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Transparency = self.isOpen and 0 or 0.5
        }):Play()
    end)

    self.button.MouseButton1Click:Connect(function()
        self:toggle()
    end)

    return self
end

function TopbarUI:setLeft()
    self.position = "Left"
    return self
end

function TopbarUI:setMid()
    self.position = "Mid"
    return self
end

function TopbarUI:setRight()
    self.position = "Right"
    return self
end

function TopbarUI:setLabel(text)
    self.label = text
    local labelObj = self.frame:FindFirstChild("Label")
    if labelObj then
        labelObj.Text = text
    end
    return self
end

function TopbarUI:setCaption(text)
    self.caption = text
    local captionObj = self.frame:FindFirstChild("Caption")
    if captionObj then
        local textLabel = captionObj:FindFirstChild("Text")
        if textLabel then
            textLabel.Text = text
        end
    end
    return self
end

function TopbarUI:setImage(imageUrl)
    self.imageId = imageUrl
    local icon = self.button:FindFirstChild("Icon")
    if icon then
        icon.Image = imageUrl
    end
    return self
end

function TopbarUI:bindEvent(eventName, callback)
    self.callbacks[eventName] = callback
    return self
end

function TopbarUI:toggle()
    self.isOpen = not self.isOpen

    local stroke = self.frame:FindFirstChild("UIStroke")
    local icon = self.button:FindFirstChild("Icon")

    TweenService:Create(self.frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundColor3 = self.isOpen and Color3.fromRGB(50, 120, 255) or Color3.fromRGB(35, 35, 35)
    }):Play()

    if stroke then
        TweenService:Create(stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Color = self.isOpen and Color3.fromRGB(70, 140, 255) or Color3.fromRGB(60, 60, 60),
            Transparency = self.isOpen and 0 or 0.5
        }):Play()
    end

    if icon then
        TweenService:Create(icon, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 30, 0, 30)
        }):Play()
        task.wait(0.1)
        TweenService:Create(icon, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 28, 0, 28)
        }):Play()
    end

    if self.callbacks["toggled"] then
        self.callbacks["toggled"](self.isOpen)
    end
end

function TopbarUI:destroy()
    if self.frame then
        for i, btn in ipairs(buttons) do
            if btn == self then
                table.remove(buttons, i)
                break
            end
        end
        self.frame:Destroy()
    end
end

return TopbarUI
