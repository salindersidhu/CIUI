Utils = {}

function Utils.modifyFont(frame, file, size, flags)
    -- Obtain the frame's default file size and flags
    local dFile, dSize, dFlags = frame:GetFont()
    -- Apply changes to font if parameters exist otherwise use default
    frame:SetFont(file and file or dFile, size and size or dSize, flags and flags or dFlags)
end

function Utils.modifyFrame(frame, anchor, parent, x, y, scale)
    -- Clear all previous points
    frame:ClearAllPoints()
    -- Set frame position
    if parent == nil then
        frame:SetPoint(anchor, x, y)
    else
        frame:SetPoint(anchor, parent, x, y)
    end
    -- Set frame scale
    if scale ~= nil then
        frame:SetScale(scale)
    end
end

function Utils.modifyFrameFixed(frame, anchor, parent, x, y, scale)
    -- Enable the frame to be moved
    frame:SetMovable(true)
    -- Modify frame
    Utils.modifyFrame(frame, anchor, parent, x, y, scale)
    -- Configure and lock the frame
    frame:SetUserPlaced(true)
    frame:SetMovable(false)
end
