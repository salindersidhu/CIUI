local L=CleanExtUI

local function updateHotKeyText(self, actionButtonType)
    -- Obtain HotKey frame and its text
    local hotkey=_G[self:GetName()..'HotKey'];
    local text=hotkey:GetText();

    -- Modify HotKey text (Capitalize and shorten specific key text)
    text=string.gsub(text,'(s%-)','S');
    text=string.gsub(text,'(a%-)','A');
    text=string.gsub(text,'(c%-)','C');
    text=string.gsub(text,'(Mouse Button )','M');
    text=string.gsub(text,'(Mouse Wheel Up)','MU');
    text=string.gsub(text,'(Mouse Wheel Down)','MD');
    text=string.gsub(text,'(Middle Mouse)','M3');
    text=string.gsub(text,'(Num Pad )','N');
    text=string.gsub(text,'(Page Up)','PU');
    text=string.gsub(text,'(Page Down)','PD');
    text=string.gsub(text,'(Spacebar)','SpB');
    text=string.gsub(text,'(Insert)','Ins');
    text=string.gsub(text,'(Home)','Hm');
    text=string.gsub(text,'(Delete)','Del');

    -- Do not modify range indicator
    if (hotkey:GetText()==RANGE_INDICATOR) then
        hotkey:SetText('');
    else
        hotkey:SetText(text);
    end
end

local function EventHandler(self, event, ...)
    if (event=="ADDON_LOADED") then
    end
end

-- Create a frame to register and bind events
local BarFrame=CreateFrame("Frame",nil,UIParent);
BarFrame:RegisterEvent("ADDON_LOADED");
BarFrame:SetScript("OnEvent", EventHandler);

hooksecurefunc("ActionButton_UpdateHotkeys",updateHotKeyText);
hooksecurefunc("ActionButton_OnEvent",function(self, event, ...)
    if (event=="PLAYER_ENTERING_WORLD") then
        ActionButton_UpdateHotkeys(self,self.buttonType);
	end
end);
