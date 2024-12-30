local addonName, addon = ...

addon.lastMoneyAmount = GetMoney()

function addon.handleMoney()
    local currentMoney = GetMoney() 
    if currentMoney > addon.lastMoneyAmount then
        addon.playSound("smb3_coin") 
    end
    addon.lastMoneyAmount = currentMoney 
end