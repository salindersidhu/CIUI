Utils = {}

-- Auxiliary function that returns a set constructed from a list.
local function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function Utils.UnitHasVehicleFrame(unit)
    return UnitVehicleSkin(unit) ~= nil and not Set({
        534043
    })[UnitVehicleSkin(unit)]
end

function Utils.ModifyFrameFont(frame, file, size, flags)
    -- Obtain the frame's default file size and flags
    local dFile, dSize, dFlags = frame:GetFont()
    -- Apply changes to font if parameters exist otherwise use default
    frame:SetFont(file and file or dFile, size and max(size, dSize) or dSize, flags and flags or dFlags)
end

function Utils.ModifyFrame(frame, anchor, parent, x, y, scale)
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

function Utils.ModifyFrameFixed(frame, anchor, parent, x, y, scale)
    -- Enable the frame to be moved
    frame:SetMovable(true)
    -- Modify frame
    Utils.ModifyFrame(frame, anchor, parent, x, y, scale)
    -- Configure and lock the frame
    frame:SetUserPlaced(true)
    frame:SetMovable(false)
end
