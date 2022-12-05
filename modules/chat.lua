ChatModule = classes.class(Module)

local numTotalChatTabs = NUM_CHAT_WINDOWS

local function modifyChatWindowTab(tabID, tabName)
    -- Obtain details on the chat window
    local window = _G["ChatFrame"..tabID]:GetName()
    local _, size, _, _, _, _, _, _, _ = GetChatWindowInfo(tabID)

    -- Modify chat font
    Utils.ModifyFrameFont(_G[window], nil, size, "THINOUTLINE")
    _G[window]:SetShadowOffset(1, -1)
    _G[window]:SetShadowColor(0, 0, 0, 0.6)
end

local function modifyChatUI()
    -- Modify edit box font
    Utils.ModifyFrameFont(ChatFontNormal, nil, 16, "THINOUTLINE")
    ChatFontNormal:SetShadowOffset(1, -1)
    ChatFontNormal:SetShadowColor(0, 0, 0, 0.6)

    -- Apply changes to every chat window tab
    for i = 1, numTotalChatTabs do
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

function onCloseChatTab()
    -- Remove chat window from total when they are closed
    if numTotalChatTabs > NUM_CHAT_WINDOWS then
        numTotalChatTabs = numTotalChatTabs - 1
    end
end

hooksecurefunc("FCF_Close", onCloseChatTab)

function ChatModule:init()
    self.super:init()
    self:setEvents({
        "ADDON_LOADED",
        "CHAT_MSG_WHISPER",
        "PET_BATTLE_OPENING_START"
    })
end

function ChatModule:eventHandler(event, ...)
    if event == "ADDON_LOADED" then
        modifyChatUI()
        modifyChatStrings()
    end
    if event == "CHAT_MSG_WHISPER" or event == "PET_BATTLE_OPENING_START" then
        -- Increment total number of chat tabs
        numTotalChatTabs = numTotalChatTabs + 1
        -- Modify Chat UI
        modifyChatUI()
    end
end
