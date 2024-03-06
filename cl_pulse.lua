AddEventHandler('randol_medical:client:targetPulse', function()
    if not isPoliceOrAmbulance() then return end
    
    local coords = GetEntityCoords(cache.ped)
    local player = lib.getClosestPlayer(coords, 2.0, false)
    if not player then return DoNotification('Nobody close enough to pulse check.', 'error') end

    local id = GetPlayerServerId(player)
    lib.requestAnimDict('amb@medic@standing@tendtodead@base', 2000)
    TaskPlayAnim(cache.ped, 'amb@medic@standing@tendtodead@base', 'base', 8.0, 1.0, -1, 01, 0, 0, 0, 0)

    if lib.progressCircle({
        duration = 3000,
        position = 'bottom',
        label = 'Checking for a pulse..',
        useWhileDead = false,
        canCancel = false,
        disable = { move = false, car = true, mouse = false, combat = false, },
    }) then
        lib.callback.await('randol_medical:server:checkPulse', false, id)
        ClearPedTasks(cache.ped)
    end
end)

RegisterNetEvent('randol_medical:client:displayPulse', function(senderId)
    if GetInvokingResource() or not senderId then return end

    local pulseCheck = 'pulse_check'
    local pcMenu = {
        id = pulseCheck,
        title = 'Pulse Check',
        options = {
            {
                title = 'No Pulse',
                description = 'Click to respond with no pulse.',
                icon = 'fa-solid fa-heart-circle-xmark',
                serverEvent = 'randol_medical:server:playerResponse',
                args = { response = 'NO PULSE.', id = senderId}
            },
            {
                title = 'Weak Pulse',
                description = 'Click to respond with a weak pulse.',
                icon = 'fa-solid fa-heart-circle-exclamation',
                serverEvent = 'randol_medical:server:playerResponse',
                args = { response = 'a WEAK pulse.', id = senderId}
            },
            {
                title = 'Strong Pulse',
                description = 'Click to respond with a strong pulse.',
                icon = 'fa-solid fa-heart-circle-check',
                serverEvent = 'randol_medical:server:playerResponse',
                args = { response = 'a STRONG pulse.', id = senderId}
            },
        }
    }
    lib.registerContext(pcMenu)
    lib.showContext(pulseCheck)
end)