ActionBarModule = classes.class(Module)

local map = {
    ["Middle Mouse"] = "M3",
    ["Mouse Wheel Down"] = "DWN",
    ["Mouse Wheel Up"] = "UP",
    ["Home"] = "Hm",
    ["Insert"] = "Ins",
    ["Page Down"] = "PD",
    ["Page Up"] = "PU",
    ["Spacebar"] = "SpB",
}

local patterns = {
    ["Mouse Button "] = "M",
    ["Num Pad "] = "N",
    ["a%-"] = "A",
    ["c%-"] = "C",
    ["s%-"] = "S",
}

local bars = {
    "ActionButton",
    "MultiBarBottomLeftButton",
    "MultiBarBottomRightButton",
    "MultiBarLeftButton",
    "MultiBarRightButton",
}

local function UpdateHotkey(self, actionButtonType)
    local hotkey = self.HotKey
    local text = hotkey:GetText()
    for k, v in pairs(patterns) do
        text = text:gsub(k, v)
    end
    hotkey:SetText(map[text] or text)
end

local function actionButtonOnUpdate(self)
    -- If action is not within range set action bar icon color to red
    if IsActionInRange(self.action) == false then
        self.icon:SetVertexColor(1.0, 0.0, 0.0)
    else
        -- If action is within range and usable set icon color to white
        self.icon:SetVertexColor(1.0, 1.0, 1.0)
    end
end

hooksecurefunc("ActionButton_UpdateRangeIndicator", actionButtonOnUpdate)

for _, bar in pairs(bars) do
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        hooksecurefunc(_G[bar..i], "UpdateHotkeys", UpdateHotkey)
    end
end

function ActionBarModule:init()
    self.super:init()
    self:setEvents({"ADDON_LOADED"})
end

function ActionBarModule:eventHandler(event, ...) end