CleanExtUI = {}

local function updateHotkeyText(self, actionButtonType)
	local hotkey = _G[self:GetName() .. 'HotKey']
	local text = hotkey:GetText()

    text = string.gsub(text, '(s%-)', 'S')
    text = string.gsub(text, '(a%-)', 'A')
    text = string.gsub(text, '(c%-)', 'C')
    text = string.gsub(text, '(Mouse Button )', 'M')
    text = string.gsub(text, '(Mouse Wheel Up)', 'MU')
    text = string.gsub(text, '(Mouse Wheel Down)', 'MD')
    text = string.gsub(text, '(Middle Mouse)', 'M3')
    text = string.gsub(text, '(Num Pad )', 'N')
    text = string.gsub(text, '(Page Up)', 'PU')
    text = string.gsub(text, '(Page Down)', 'PD')
    text = string.gsub(text, '(Spacebar)', 'SpB')
    text = string.gsub(text, '(Insert)', 'Ins')
    text = string.gsub(text, '(Home)', 'Hm')
    text = string.gsub(text, '(Delete)', 'Del')

    if hotkey:GetText() == RANGE_INDICATOR then
    	hotkey:SetText('')
    else
    	hotkey:SetText(text)
    end
end

hooksecurefunc("ActionButton_UpdateHotkeys", updateHotkeyText)
hooksecurefunc("ActionButton_OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD"
		then ActionButton_UpdateHotkeys(self, self.buttonType)
	end
end)
