local function RequestAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
end

local function SpawnVehicle(model, coords, heading, cb)
    local hash = type(model) == 'string' and GetHashKey(model) or model
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    local vehicle = CreateVehicle(hash, coords.x, coords.y, coords.z, heading, false, false)
    SetModelAsNoLongerNeeded(hash)
    if cb then cb(vehicle) end
end

local function isBike(vehicle)
    if not DoesEntityExist(vehicle) then return false end
    local model = GetEntityModel(vehicle)
    for _, bikeName in ipairs(Config.BikeModels) do
        if model == GetHashKey(bikeName) then return true end
    end
    return false
end

exports('useItem', function(data, slot)
    TriggerServerEvent('22bikes:removeItem', slot.name)
    local playerPed = PlayerPedId()
    RequestAnim(Config.Animations.Dict)
    TaskPlayAnim(playerPed, Config.Animations.Dict, Config.Animations.Name, 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(Config.Animations.Duration.Spawn)
    ClearPedTasks(playerPed)
    local coords  = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    SpawnVehicle(slot.name, coords, heading, function(vehicle)
        SetVehicleOnGroundProperly(vehicle)
        Wait(Config.Delays.VehicleStabilization)
    end)
    return false
end)

exports.ox_target:addGlobalVehicle({
    {
        name        = Config.Target.Name,
        icon        = Config.Target.Icon,
        label       = Config.Target.Label,
        canInteract = function(entity)
            if not entity or not DoesEntityExist(entity) then return false end
            Wait(Config.Delays.EntityLoadCheck)
            local model = GetEntityModel(entity)
            if not model or model == 0 then return false end
            if not IsVehicleSeatFree(entity, -1) then return false end
            return isBike(entity)
        end,
        onSelect = function(data)
            if IsPedInAnyVehicle(PlayerPedId(), false) then return end
            local vehicle = data.entity
            if not DoesEntityExist(vehicle) then return end
            local model = GetEntityModel(vehicle)
            if model == 0 then return end

            local modelName = nil
            for _, bikeName in ipairs(Config.BikeModels) do
                if GetHashKey(bikeName) == model then
                    modelName = bikeName
                    break
                end
            end
            if not modelName then return end

            Bridge.TriggerCallback('22bikes:canCarryItem', function(canCarry)
                if canCarry then
                    DeleteEntity(vehicle)
                    TriggerServerEvent('22bikes:addItem', modelName)
                    local playerPed = PlayerPedId()
                    RequestAnim(Config.Animations.Dict)
                    TaskPlayAnim(playerPed, Config.Animations.Dict, Config.Animations.Name, 8.0, -8.0, -1, 1, 0, false, false, false)
                    Wait(Config.Animations.Duration.Pickup)
                    ClearPedTasks(playerPed)
                else
                    Bridge.Notify(Config.Messages.InventoryFull, 'error')
                end
            end, modelName)
        end
    }
})

RegisterNetEvent('22bikes:respawnBike')
AddEventHandler('22bikes:respawnBike', function(bikeModel)
    if type(bikeModel) ~= 'string' then return end
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local newCoords = vector3(
        coords.x + forward.x * Config.Respawn.Distance,
        coords.y + forward.y * Config.Respawn.Distance,
        coords.z
    )
    SpawnVehicle(bikeModel, newCoords, GetEntityHeading(playerPed), function(vehicle)
        SetVehicleOnGroundProperly(vehicle)
        Wait(Config.Delays.VehicleStabilization)
    end)
    Bridge.Notify(Config.Messages.BikeRespawned, 'error')
end)
