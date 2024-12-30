local addonName, addon = ...

function tableContains(table, value)
    for i = 1,#table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end

function ternary ( cond , T , F )
    if cond then return T else return F end
end

function addon.isMario()
    local playerName = UnitName("player")
    return string.find(string.lower(playerName), "mario") ~= nil or string.find(string.lower(playerName), "samu") ~= nil
end

function addon.getDistanceToPosition(x, y)
    local x1, y1 = UnitPosition("player")
    return math.sqrt((x - x1)^2 + (y - y1)^2)
end
