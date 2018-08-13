local modules = {
    BagModule.New(),
    ChatModule.New(),
    MinimapModule.New(),
    MicroMenuModule.New(),
    MultiActionModule.New(),
    PartyFrameModule.New(),
    PlayerFrameModule.New(),
    TargetFrameModule.New()
}

local function LoadModules(modules)
    for _, m in ipairs(modules) do
        -- Create a frame for each module
        local f = CreateFrame("Frame")
        -- Register events to frame
        for _, e in ipairs(m:GetEvents()) do
            f:RegisterEvent(e)
        end
        -- Set frame event handler
        f:SetScript("OnEvent", m:GetEventHandler())
    end
end

local function CreateInterfaceOptions()
    local Options = CreateFrame("Frame")
    Options.name = "CIUI"
    InterfaceOptions_AddCategory(Options)
end

LoadModules(modules)
CreateInterfaceOptions()
