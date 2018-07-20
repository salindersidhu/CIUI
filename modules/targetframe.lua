local _, L = ...

-- CREATE FRAMES
local TargetFrameModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES
TargetFrameModule:RegisterEvent("PLAYER_ENTERING_WORLD")

local function ModifyTargetFrameUI()
    -- Obtain target's unit classification type
    local targetType = UnitClassification(TargetFrame.unit)

    -- Update Target's name
    TargetFrame.nameBackground:Hide()
    Utils.ModifyFont(TargetFrame.name, nil, 11, "OUTLINE")
    TargetFrame.name:SetPoint("LEFT", TargetFrame, 15, 36)

    -- Update Target's background
    TargetFrameBackground:SetSize(119, 42)
    TargetFrame.Background:SetSize(119, 42)
    TargetFrame.Background:SetPoint("BOTTOMLEFT", TargetFrame, "BOTTOMLEFT", 7, 35)

    -- Update Target's "dead" text
    TargetFrame.deadText:ClearAllPoints()
    TargetFrame.deadText:SetPoint("CENTER", TargetFrame.healthbar, "CENTER", 0, 0)

    -- Update Target's health bar
    TargetFrame.healthbar:ClearAllPoints()
    TargetFrame.healthbar:SetSize(119, 18)
    TargetFrame.healthbar:SetPoint("TOPLEFT", 5, -24)
    TargetFrame.healthbar.LeftText:ClearAllPoints()
    TargetFrame.healthbar.LeftText:SetPoint("LEFT", TargetFrame.healthbar, "LEFT", 5, 0)
    TargetFrame.healthbar.RightText:ClearAllPoints()
    TargetFrame.healthbar.RightText:SetPoint("RIGHT", TargetFrame.healthbar, "RIGHT", -3, 0)
    TargetFrame.healthbar.TextString:SetPoint("CENTER", TargetFrame.healthbar, "CENTER", 0, 0)

    -- Update Target's mana bar
    TargetFrame.manabar:ClearAllPoints()
    TargetFrame.manabar:SetSize(119, 18)
    TargetFrame.manabar:SetPoint("TOPLEFT", 5, -45)
    TargetFrame.manabar.LeftText:ClearAllPoints()
    TargetFrame.manabar.LeftText:SetPoint("LEFT", TargetFrame.manabar, "LEFT", 5, 0)
    TargetFrame.manabar.RightText:ClearAllPoints()
    TargetFrame.manabar.RightText:SetPoint("RIGHT", TargetFrame.manabar, "RIGHT", -5, 0)
    TargetFrame.manabar.TextString:SetPoint("CENTER", TargetFrame.manabar, "CENTER", 0, 0)

    -- Set texture based on target's unit classification type
    if targetType == "minus" then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET)
    elseif targetType == "worldboss" or targetType == "elite" then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET_ELITE)
    elseif targetType == "rareelite"  then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET_RARE_ELITE)
    elseif targetType == "rare" then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET_RARE)
    else
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET)
    end

    --  Set threat indicator for the "minus" classification type
    if TargetFrame.threatIndicator and targetType == "minus" then
        TargetFrame.threatIndicator:SetTexture(TEXTURE_UI_FRAME_TARGET_FLASH)
        TargetFrame.threatIndicator:SetTexCoord(0, 0.95, 0, 0.18)
        TargetFrame.threatIndicator:SetWidth(242)
        TargetFrame.threatIndicator:SetHeight(93)
        TargetFrame.threatIndicator:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", -24, 0)
    end

    -- Show quest icon if target is part of a quest
    if TargetFrame.questIcon and UnitIsQuestBoss(TargetFrame.unit) then
        TargetFrame.questIcon:Show()
    else
        TargetFrame.questIcon:Hide()
    end
end

-- EVENT HANDLER
local function EventHandler(self, event, arg1, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ModifyTargetFrameUI()
        -- Modify TargetFrame position
        Utils.ModifyFrameFixed(TargetFrame, "CENTER", nil, 265, -150, 1.3)
    end
end

-- SET FRAME SCRIPTS
TargetFrameModule:SetScript("OnEvent", EventHandler)

-- HOOK SECURE FUNCTIONS
hooksecurefunc("TargetFrame_CheckDead", ModifyTargetFrameUI)
hooksecurefunc("TargetFrame_Update", ModifyTargetFrameUI)
hooksecurefunc("TargetFrame_CheckFaction", ModifyTargetFrameUI)
hooksecurefunc("TargetFrame_CheckClassification", ModifyTargetFrameUI)
hooksecurefunc("TargetofTarget_Update", ModifyTargetFrameUI)
