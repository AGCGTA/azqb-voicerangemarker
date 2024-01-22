local pressed = false
local animTime = 0

local function InOutSine(t, t0, tp, x0, xp)--正弦波
    local x = (xp - x0) * (math.sin( (math.pi / 2)*(t - t0)/(tp - t0) )) ^ 2 + x0
    return x
end

RegisterCommand('+showvoicerange', function()
	pressed = true
end, false)

RegisterCommand('-showvoicerange', function()
    pressed = false
end, false)

RegisterKeyMapping('+showvoicerange', 'Show voice range', 'keyboard', 'OEM_4')

CreateThread(function()
    while true do
        coords = GetEntityCoords(PlayerPedId())
        voice = LocalPlayer.state['proximity'].distance
        if pressed then
            if animTime < 150 then
                animTime = animTime + 5
            end
        else
            if animTime > 0 then
                animTime = animTime - 1
            end
        end
        alpha = math.floor(InOutSine(animTime, 0, 150, 0, 180))
        DrawMarker(1, coords.x, coords.y, coords.z - 0.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, voice, voice, 2.0, 255, 139, 99, alpha, false, true, 2, nil, nil, false)
        Wait(0)
    end
end)