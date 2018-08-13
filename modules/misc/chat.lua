local function modifyChatWindowTab(tabID, tabName)
    -- Obtain details on the chat window
    local window = _G["ChatFrame"..tabID]:GetName()
    local _, size, _, _, _, _, _, _, _ = GetChatWindowInfo(tabID)

    -- Remove screen clamping
    _G[window]:SetClampRectInsets(0, 0, 0, 0)
    _G[window]:SetMinResize(100, 50)
    _G[window]:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())

    -- Modify chat tab
    local tab = _G[window.."Tab"]
    tab:SetText(tabName and tabName or tab:GetText())

    -- Modify chat tab font
    local tabFont = tab:GetFontString()
    Utils.modifyFont(tabFont, nil, 12, "THINOUTLINE")
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
    _G[window.."EditBox"]:SetPoint("LEFT", _G[window], -5, 0)
    _G[window.."EditBox"]:SetPoint("RIGHT", _G[window], 10, 0)
    _G[window.."EditBox"]:SetPoint("BOTTOM", _G[window], "TOP", 0, window == "ChatFrame2" and 44 or 22)

    -- Modify chat font
    Utils.modifyFont(_G[window], nil, size, "THINOUTLINE")
    _G[window]:SetShadowOffset(1, -1)
    _G[window]:SetShadowColor(0, 0, 0, 0.6)
end

local function modifyChatUI()
    -- Hide Battle.net social button and toast
    local button = QuickJoinToastButton or FriendsMicroButton
    button:HookScript("OnShow", button.Hide)
    button:Hide()
    BNToastFrame:SetClampedToScreen(true)
    BNToastFrame:SetClampRectInsets(-15, 15, 15, -15)

    -- Modify edit box font
    Utils.modifyFont(ChatFontNormal, nil, 16, "THINOUTLINE")
    ChatFontNormal:SetShadowOffset(1, -1)
    ChatFontNormal:SetShadowColor(0, 0, 0, 0.6)

    -- Apply changes to every chat window tab
    for i = 1, NUM_CHAT_WINDOWS do
        modifyChatWindowTab(i, nil)
    end
end

local function modifyChatStrings()
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

ChatModule = classes.class(Module)

function ChatModule:init()
    self.super:init("Chat")
    self:setEvents({"ADDON_LOADED", "PET_BATTLE_OPENING_START"})
end

function ChatModule:getEventHandler()
    return function(self, event, ...)
        if event == "ADDON_LOADED" then
            modifyChatUI()
            modifyChatStrings()
        end
        if event == "PET_BATTLE_OPENING_START" then
            modifyChatWindowTab(11, "Pet Log")
        end
    end
end
