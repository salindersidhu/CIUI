local addonName, Locale = ...

local function UpdateHotKeyText(self, bType)
    -- Obtain button text and hotkey
    local name = self:GetName()
    local hotkey = _G[name..'HotKey']

    -- Determine button type if current button type does not exist
    if (not bType) then
        if (name and not string.match(name, 'Stance')) then
            if (string.match(name, 'PetAction')) then
                bType = 'BONUSACTIONBUTTON'
            else
                bType = 'ACTIONBUTTON'
            end
        end
    end

    -- Obtain current HotKey binding text if it exists
    local text = bType and GetBindingText(GetBindingKey(bType..self:GetID())) or ''

    -- Modify HotKey text if text exists
    if (text and text ~= '') then
        -- Remove hypens
        text = string.gsub(text, '%-', '')
        -- change common key text
        text = string.gsub(text, KEY_SPACE, '_')
        text = string.gsub(text, KEY_HOME, 'Hm')
        text = string.gsub(text, KEY_PAGEUP, 'PU')
        text = string.gsub(text, KEY_DELETE, 'Del')
        text = string.gsub(text, KEY_INSERT, 'Ins')
        text = string.gsub(text, KEY_PAGEDOWN, 'PD')
        text = string.gsub(text, KEY_NUMLOCK, 'NuL')
        -- change common key modifer text
        text = string.gsub(text, ALT_KEY_TEXT, 'A')
        text = string.gsub(text, CTRL_KEY_TEXT, 'C')
        text = string.gsub(text, SHIFT_KEY_TEXT, 'S')
        -- change mouse button text
        text = string.gsub(text, KEY_BUTTON1, 'LM')
        text = string.gsub(text, KEY_BUTTON2, 'RM')
        text = string.gsub(text, KEY_BUTTON3, 'MM')
        text = string.gsub(text, KEY_MOUSEWHEELUP, 'MU')
        text = string.gsub(text, KEY_MOUSEWHEELDOWN, 'MD')
        for i = 1, 30 do
            text = string.gsub(text, _G['KEY_BUTTON'..i], 'M'..i)
        end
        -- Change Num pad key text
        text = string.gsub(text, KEY_NUMPADPLUS, 'Nu+')
        text = string.gsub(text, KEY_NUMPADMINUS, 'Nu-')
        text = string.gsub(text, KEY_NUMPADDIVIDE, 'Nu/')
        text = string.gsub(text, KEY_NUMPADDECIMAL, 'Nu.')
        text = string.gsub(text, KEY_NUMPADMULTIPLY, 'Nu*')
        for i = 1, 9 do
            text = string.gsub(text, _G['KEY_NUMPAD'..i], 'Nu'..i)
        end
        -- Update HotKey text
        hotkey:SetText(text)
    end
end

local function updateActionRange(self, elapsed)
    if (self.rangeTimer == TOOLTIP_UPDATE_TIME) then
        if (IsActionInRange(self.action) == false) then
            self.icon:SetVertexColor(1.0, 0.0, 0.0)
        else
            local canUse, amountMana = IsUsableAction(self.action)
            if (canUse) then
                self.icon:SetVertexColor(1.0, 1.0, 1.0)
            elseif (amountMana) then
                self.icon:SetVertexColor(0.5, 0.5, 1.0)
            else
                self.icon:SetVertexColor(0.4, 0.4, 0.4)
            end
        end
    end
end

local function EventHandler(self, event, ...)
    if (event == 'ADDON_LOADED') then
    end
end

-- Create a frame to register and bind events
local BarFrame = CreateFrame('Frame', nil, UIParent)
BarFrame:RegisterEvent('ADDON_LOADED')
BarFrame:SetScript('OnEvent', EventHandler)

-- Hook secure function to update HotKey text
hooksecurefunc('ActionButton_UpdateHotkeys', UpdateHotKeyText)
hooksecurefunc('ActionButton_OnUpdate', updateActionRange)
hooksecurefunc('ActionButton_OnEvent', function(self, event, ...)
    if (event=='PLAYER_ENTERING_WORLD') then
        ActionButton_UpdateHotkeys(self,self.buttonType)
	end
end)
