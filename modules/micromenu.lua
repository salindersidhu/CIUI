local _, L = ...

-- CREATE FRAMES --
local MicroMenuModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES --
MicroMenuModule:RegisterEvent("PLAYER_ENTERING_WORLD")

local function ModifyMicroMenuButtons(parent, anchor, x, y, stacked, scale)
    for _, button in next, {
        EJMicroButton,
        LFDMicroButton,
        StoreMicroButton,
        GuildMicroButton,
        TalentMicroButton,
        MainMenuMicroButton,
        QuestLogMicroButton,
        CharacterMicroButton,
        SpellbookMicroButton,
        CollectionsMicroButton,
        AchievementMicroButton,
    } do
        button:SetScale(scale)
    end
    -- Use existing API to move the micromenu buttons
    MoveMicroButtons(anchor, parent, anchor, x, y, stacked)
end

local function Hook_MoveMicroButtons(a, aT, rT, x, y, stacked)
    if HasOverrideActionBar() then
        ModifyMicroMenuButtons(aT, rT, x, y, stacked, 1)
    else
        ModifyMicroMenuButtons(UIParent, "BOTTOMRIGHT", -257, -1, false, 0.85)
    end
end

-- ACTION BAR FRAME EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ModifyMicroMenuButtons(UIParent, "BOTTOMRIGHT", -257, -1, false, 0.85)
    end
end

-- SET FRAME SCRIPTS
MicroMenuModule:SetScript("OnEvent", EventHandler)

-- HOOK SECURE FUNCTIONS
hooksecurefunc("MoveMicroButtons", Hook_MoveMicroButtons)
