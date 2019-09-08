--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\vehiclesystem\cVehicles.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\vehiclesystem
--Created Date: Thursday, September 5th 2019, 10:20:21 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]
function checkRights(player,veh)
    if veh:getData("owner") == player:getName() or veh:getData("owner") == player:getData("factionname") then
        return true
    else
        return false
    end
end

addEventHandler("onClientClick",getRootElement(),function(btn,st,ax,ay,x,y,z,ce)
    if btn == "left" and st == "down" then
        if ce then
            if getElementType(ce) == "vehicle" then
                print(1)
                if ce:getData("serverveh") then
                    print(2)
                    if checkRights(getLocalPlayer(),ce) then
                        triggerServerEvent("unlockVeh",getLocalPlayer(),ce)
                    end
                end
            end
        end
    end
end)