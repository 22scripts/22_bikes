RegisterNetEvent('22bikes:addItem')
AddEventHandler('22bikes:addItem', function(modelName)
    local src      = source
    local canCarry = exports.ox_inventory:CanCarryItem(src, modelName, 1)
    if canCarry then
        exports.ox_inventory:AddItem(src, modelName, 1)
    else
        Bridge.NotifyPlayer(src, Config.Messages.InventoryFull, 'error')
        TriggerClientEvent('22bikes:respawnBike', src, modelName)
    end
end)

RegisterNetEvent('22bikes:removeItem')
AddEventHandler('22bikes:removeItem', function(modelName)
    exports.ox_inventory:RemoveItem(source, modelName, 1)
end)

Bridge.RegisterCallback('22bikes:canCarryItem', function(source, cb, item)
    cb(exports.ox_inventory:CanCarryItem(source, item, 1))
end)
