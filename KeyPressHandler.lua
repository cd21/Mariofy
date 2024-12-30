local addonName, addon = ...

function addon.onKeyPress(self, key)
    if key == "SPACE" and not IsFalling() then
        addon.playSound("jump")
    end
end
