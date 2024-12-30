local addonName, addon = ...

function addon.onKeyPress(self, key)
    if key == "SPACE" and not IsFalling() then
        addon.playSound("jump")
    end

    if key == "SPACE" then
        local playerName = UnitName("player")
        local x, y = UnitPosition("player")
        local lastAction = "Fireball" -- Replace with the actual last action
        local actionType = "Spell" -- Replace with the type of action (e.g., "Spell", "Melee", etc.)
        local playerStatus = "Alive" -- Replace with the actual player status (e.g., "Alive", "Dead", etc.)
        local health = UnitHealth("player")
        local mana = UnitPower("player")
        local timestamp = GetTime()

        local testMessage = string.format(
            "NAME:%s;POS_X:%.2f;POS_Y:%.2f;ACTION:%s;TYPE:%s;STATUS:%s;HEALTH:%d;MANA:%d;TIME:%.2f",
            playerName, x or 0, y or 0, lastAction, actionType, playerStatus, health, mana, timestamp
        )

        addon.sendAddonMessage(addon.prefix, testMessage)
    end
end
