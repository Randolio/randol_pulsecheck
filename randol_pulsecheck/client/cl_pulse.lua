local QBCore = exports['qb-core']:GetCoreObject()

--[[
    ===================================================================
    Add this to Config.GlobalPlayerOptions in qb-target/init.lua
    {
        type = "client",
        event = "randol_medical:client:targetPulse",
        icon = "fa-solid fa-hand-holding-medical",
        label = "Check Pulse",
        job = {["ambulance"] = 0, ["police"] = 0} -- Allows police and ems to check.
    },
    ===================================================================
]]

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

-- Event used for qb-target/radial menu
RegisterNetEvent('randol_medical:client:targetPulse', function()
    if PlayerJob.name == "police" or PlayerJob.name == "ambulance" then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 2.0 then
            local playerId = GetPlayerServerId(player)
            TriggerEvent('animations:client:EmoteCommandStart', {"medic2"}) -- replace with scully emote menu thing?
            QBCore.Functions.Progressbar("check_pulse", "Checking for a pulse..", 3000, false, true, {
                disableMovement = false,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = false,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent("randol_medical:server:checkPulse", playerId)
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"}) -- replace with scully emote menu thing?
                QBCore.Functions.Notify("You stopped what you were doing.", "error")
            end)
        else
            QBCore.Functions.Notify("Nobody close enough to pulse check.", "error")
        end
    else
        QBCore.Functions.Notify("You are not trained for this.", "error")
    end
end)


RegisterNetEvent('randol_medical:client:displayPulse', function(senderId)
    if not senderId then return end
    local pulseCheck = "pulse_check"
    local pcMenu = {
        id = pulseCheck,
        title = "Pulse Check",
        options = {
            {
                title = 'No Pulse',
                description = 'Click to respond with no pulse.',
                icon = "fa-solid fa-heart-circle-xmark",
                serverEvent = 'randol_medical:server:playerResponse',
                args = { response = "NO PULSE.", id = senderId}
            },
            {
                title = 'Weak Pulse',
                description = 'Click to respond with a weak pulse.',
                icon = "fa-solid fa-heart-circle-exclamation",
                serverEvent = 'randol_medical:server:playerResponse',
                args = { response = "a WEAK pulse.", id = senderId}
            },
            {
                title = 'Strong Pulse',
                description = 'Click to respond with a strong pulse.',
                icon = "fa-solid fa-heart-circle-check",
                serverEvent = 'randol_medical:server:playerResponse',
                args = { response = "a STRONG pulse.", id = senderId}
            },
        }
    }
    lib.registerContext(pcMenu)
    lib.showContext(pulseCheck)
end)