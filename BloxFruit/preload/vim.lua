local VirtualInputManager = Instance.new("VirtualInputManager")
_G.VIM = VirtualInputManager
_G.VIM_CLICK = function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.ButtonR2, false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.ButtonR2, false, game)
end
