Bridge = {}

if Config.Framework == 'esx' then
    if Config.ESXMode == 'old' then
        ESX = nil
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    else
        ESX = exports['es_extended']:getSharedObject()
    end
else
    QBCore = exports['qb-core']:GetCoreObject()
end

function Bridge.Notify(message, notifyType)
    if Config.Framework == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Framework == 'qbox' then
        exports.ox_lib:notify({ description = message, type = notifyType or 'inform' })
    else
        QBCore.Functions.Notify(message, notifyType or 'primary')
    end
end

function Bridge.TriggerCallback(name, cb, ...)
    if Config.Framework == 'esx' then
        ESX.TriggerServerCallback(name, cb, ...)
    else
        QBCore.Functions.TriggerCallback(name, cb, ...)
    end
end
