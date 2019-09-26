local modules = {
    ActionBarModule,
    BagBarModule,
    ChatModule,
    MinimapModule,
    PartyFrameModule,
    PlayerFrameModule,
    TargetFrameModule
}

local function loadModules(modules)
    for _, m in ipairs(modules) do
        -- Create an instance of the module
        mI = m.new()
        -- Create a frame for each module
        local f = CreateFrame("Frame")
        -- Register events to frame
        for _, e in ipairs(mI:getEvents()) do
            f:RegisterEvent(e)
        end
        -- Set frame event handler
        f:SetScript("OnEvent", mI:getEventHandler())
    end
end

local function createInterfaceOptions()
    local Options = CreateFrame("Frame")
    Options.name = "CIUI"
    InterfaceOptions_AddCategory(Options)
end

loadModules(modules)
createInterfaceOptions()
