local function modifyPartyFrameUI()
    for i = 1, 4 do
        _G["PartyMemberFrame"..i]:SetScale(1.6)
    end
end

PartyFrameModule = classes.class(Module)

function PartyFrameModule:init()
    self.super:init("PartyFrame")
    self:addEvent("PLAYER_ENTERING_WORLD")
end

function PartyFrameModule:eventHandler(event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        modifyPartyFrameUI()
        -- Modify PartyFrame position
        ModifyFrameFixed(PartyMemberFrame1, "LEFT", nil, 175, 125, nil)
    end
end
