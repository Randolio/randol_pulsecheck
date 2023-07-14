local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('randol_medical:server:checkPulse', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(playerId)
	if not Target.PlayerData.metadata["isdead"] and not Target.PlayerData.metadata["inlaststand"] then return end
    if Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'police' then
        TriggerClientEvent('randol_medical:client:displayPulse', Target.PlayerData.source, tonumber(src))
    end
end)

RegisterNetEvent('randol_medical:server:playerResponse', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(data.id)
    if Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'police' then
        --QBCore.Functions.Notify(Player.PlayerData.source, "The Patient has "..data.response, 5000)
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'The Patient has '..data.response, 'error')
    end
end)
