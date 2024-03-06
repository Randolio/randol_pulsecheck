if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

function GetPlayer(id)
    return QBCore.Functions.GetPlayer(id)
end

function DoNotification(src, text, nType)
    TriggerClientEvent('QBCore:Notify', src, text, nType)
end

function GetCharacterName(Player)
    return Player.PlayerData.charinfo.firstname.. ' ' ..Player.PlayerData.charinfo.lastname
end

function isPlyDead(Player)
    return Player.PlayerData.metadata.inlaststand or Player.PlayerData.metadata.isdead
end

function isPoliceOrAmbulance(Player) -- Uses job types defined in qb-core/shared/jobs.lua
    return Player.PlayerData.job.type == 'ems' or Player.PlayerData.job.type == 'leo'
end