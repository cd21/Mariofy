local addonName, addon = ...

local lastDamageTs = 0
local damageSubEvents = {"SWING_DAMAGE", "SPELL_DAMAGE", "RANGE_DAMAGE"}

function addon.handleCombatLogEvent()
    local args = {CombatLogGetCurrentEventInfo()} 
    local subEvent = args[2] 
    local destGUID = args[8]
    local indexShift = ternary(subEvent == damageSubEvents[2], 3, 0)
    local critical = args[18 + indexShift]

    if isDamageSubEvent(subEvent) then
        if destGUID == UnitGUID("player") and (lastDamageTs == 0 or timestamp - lastDamageTs > 1) then
            lastDamageTs = timestamp
            local rando = math.random(1, 3)
            addon.playSound("hurt" .. rando)
        elseif destGUID == UnitGUID("target") then
            addon.playSound("damageTo_" .. UnitCreatureType("target"))
        end
    end
end

function isDamageSubEvent(subEvent)
    return tableContains(damageSubEvents, subEvent)
end

