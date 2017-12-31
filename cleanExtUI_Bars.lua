local L=CleanExtUI

local function EventHandler(self, event, ...)
    if (event=="ADDON_LOADED") then
    end
end

-- Create a frame to register and bind events
local BarFrame=CreateFrame("Frame",nil,UIParent);
BarFrame:RegisterEvent("ADDON_LOADED");
BarFrame:SetScript("OnEvent", EventHandler);
