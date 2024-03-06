lib.callback.register('randol_medical:server:checkPulse', function(source, id)
    local src = source
    local Player = GetPlayer(src)
    local Target = GetPlayer(id)
    if not isPlyDead(Target) or not isPoliceOrAmbulance(Player) then return false end

    TriggerClientEvent('randol_medical:client:displayPulse', id, src)
end)

RegisterNetEvent('randol_medical:server:playerResponse', function(data)
    local src = source
    local Player = GetPlayer(data.id)

    if not isPoliceOrAmbulance(Player) then return end
    DoNotification(data.id, ('The Patient has %s'):format(data.response), 5000)
end)