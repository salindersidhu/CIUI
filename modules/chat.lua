local _, L = ...

-- CREATE FRAMES --
local ChatModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES --
ChatModule:RegisterEvent("ADDON_LOADED")

local function ModifyChatUI()
    -- Hide Battle.net social button and toast
    local button = QuickJoinToastButton or FriendsMicroButton
    button:HookScript("OnShow", button.Hide)
    button:Hide()
    BNToastFrame:SetClampedToScreen(true)
    BNToastFrame:SetClampRectInsets(-15, 15, 15, -15)

    -- Modify edit box font
    ChatFontNormal:SetFont(CHAT_FONT, 15, "THINOUTLINE")
    ChatFontNormal:SetShadowOffset(1, -1)
    ChatFontNormal:SetShadowColor(0, 0, 0, 0.6)

    -- Apply changes to every chat window
    for i = 1, NUM_CHAT_WINDOWS do
        -- Obtain details on the chat window
        local window = _G["ChatFrame"..i]:GetName()
        local _, size, _, _, _, _, _, _, _ = GetChatWindowInfo(i)

        -- Remove screen clamping
        _G[window]:SetClampRectInsets(0, 0, 0, 0)
        _G[window]:SetMinResize(100, 50)
        _G[window]:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())

        -- Modify chat tabs
        local tab = _G[window.."Tab"]
        local tabFont = tab:GetFontString()
        tabFont:SetFont(CHAT_FONT, 12, "THINOUTLINE")
        tabFont:SetShadowOffset(1, -1)
        tabFont:SetShadowColor(0, 0, 0, 0.6)

        -- Remove tab backgrounds
        _G[window.."TabLeft"]:SetTexture(nil)
        _G[window.."TabMiddle"]:SetTexture(nil)
        _G[window.."TabRight"]:SetTexture(nil)
        _G[window.."TabSelectedLeft"]:SetTexture(nil)
        _G[window.."TabSelectedMiddle"]:SetTexture(nil)
        _G[window.."TabSelectedRight"]:SetTexture(nil)
        tab:SetAlpha(1.0)

        -- Remove border around edit box
        _G[window.."EditBoxLeft"]:Hide()
        _G[window.."EditBoxMid"]:Hide()
        _G[window.."EditBoxRight"]:Hide()

        -- Enable arrow keys in edit box
        _G[window.."EditBox"]:SetAltArrowKeyMode(false)

        -- Modify edit box position
        _G[window.."EditBox"]:ClearAllPoints()
        if (window == "ChatFrame2") then
            -- Fix positioning for Combat Log tab
            _G[window.."EditBox"]:SetPoint("BOTTOM", _G[window], "TOP", 0, 44)
        else
            _G[window.."EditBox"]:SetPoint("BOTTOM", _G[window], "TOP", 0, 22)
        end
        _G[window.."EditBox"]:SetPoint("LEFT", _G[window], -5, 0)
        _G[window.."EditBox"]:SetPoint("RIGHT", _G[window], 10, 0)

        -- Modify chat font
        _G[window]:SetFont(CHAT_FONT, size, "THINOUTLINE")
        _G[window]:SetShadowOffset(1, -1)
        _G[window]:SetShadowColor(0, 0, 0, 0.6)
    end
end

local function ModifyChatStrings()
    -- Player communication
    CHAT_SAY_GET = "%s: "
    CHAT_YELL_GET = "%s: "
    CHAT_WHISPER_GET = "[W From] %s: "
    CHAT_BN_WHISPER_GET = "[W From] %s: "
    CHAT_WHISPER_INFORM_GET = "[W To] %s: "
    CHAT_BN_WHISPER_INFORM_GET = "[W To] %s: "
    -- Chat channels
    CHAT_RAID_GET = "|Hchannel:RAID|h[R]|h %s: "
    CHAT_GUILD_GET = "|Hchannel:GUILD|h[G]|h %s: "
    CHAT_PARTY_GET = "|Hchannel:PARTY|h[P]|h %s: "
    CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[O]|h %s: "
    CHAT_PARTY_GUIDE_GET = "|Hchannel:PARTY|h[PG]|h %s: "
    CHAT_RAID_LEADER_GET = "|Hchannel:RAID|h[RL]|h %s: "
    CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[PL]|h %s: "
    CHAT_INSTANCE_CHAT_GET = "|Hchannel:Battleground|h[I]|h %s: "
    CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:Battleground|h[IL]|h %s: "
end

-- CHAT FRAME EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        ModifyChatUI()
        ModifyChatStrings()
    end
end

-- SET FRAME SCRIPTS
ChatModule:SetScript("OnEvent", EventHandler)
