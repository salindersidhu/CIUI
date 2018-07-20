local _, L = ...

-- CREATE FRAMES
local PartyFrameModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES
PartyFrameModule:RegisterEvent("PLAYER_ENTERING_WORLD")

local function ModifyPartyFrameUI()
    for i = 1, 4 do
        _G["PartyMemberFrame"..i]:SetScale(1.6)
    end
end

-- UNIT EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ModifyPartyFrameUI()
        -- Modify PartyFrame position
        Utils.ModifyFrameFixed(PartyMemberFrame1, "LEFT", nil, 175, 125, nil)
    end
end

-- SET FRAME SCRIPTS
PartyFrameModule:SetScript("OnEvent", EventHandler)
