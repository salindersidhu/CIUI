local function ModifyPartyFrameUI()
    for i = 1, 4 do
        _G["PartyMemberFrame"..i]:SetScale(1.6)
    end
end

PartyFrameModule = Classes.Class(Module)

function PartyFrameModule:Init()
    self.super:Init("PartyFrame")
end

function PartyFrameModule:GetEvents()
    return {"PLAYER_ENTERING_WORLD"}
end

function PartyFrameModule:GetEventHandler()
    return function (self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            ModifyPartyFrameUI()
            -- Modify PartyFrame position
            Utils.ModifyFrameFixed(PartyMemberFrame1, "LEFT", nil, 175, 125, nil)
        end
    end
end
