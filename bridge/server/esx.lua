if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

function GetPlayer(id)
    return ESX.GetPlayerFromId(id)
end

function DoNotification(src, text, nType)
    TriggerClientEvent('esx:showNotification', src, text, nType)
end

function GetCharacterName(xPlayer)
    return xPlayer.getName()
end

function isPlyDead(xPlayer)
    return PlayerData.metadata.inlaststand or PlayerData.metadata.isdead
end

function isPoliceOrAmbulance(xPlayer)
    return xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'police'
end