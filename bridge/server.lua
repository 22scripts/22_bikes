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

function Bridge.NotifyPlayer(source, message, notifyType)
    if Config.Framework == 'esx' then
        TriggerClientEvent('esx:showNotification', source, message)
    elseif Config.Framework == 'qbox' then
        TriggerClientEvent('ox_lib:notify', source, { description = message, type = notifyType or 'inform' })
    else
        TriggerClientEvent('QBCore:Notify', source, message, notifyType or 'primary')
    end
end

function Bridge.RegisterCallback(name, cb)
    if Config.Framework == 'esx' then
        ESX.RegisterServerCallback(name, cb)
    else
        QBCore.Functions.CreateCallback(name, cb)
    end
end
