--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\admin\sAdmin.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\admin
--Created Date: Monday, September 9th 2019, 5:24:30 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]
local adutytbl = {}
function toggleAdminDuty(player)
    if player:getData("adminlvl") > 1 then 
        if not player:getData("adminduty") then
            player:setData("adminduty",true)
            for k,v in pairs(getElementsByType("player")) do
                if v:getData("loggedin") then
                    notification(v,"Globale Serverinformation\nDer Spieler '"..player:getName().."' hat\nden Adminmodus betreten.\nJegliches Deathmatch ist untersagt und wird streng geahndet.",10000,tocolor(245,237,88,255),true)
                    adutytbl[player] = {}
                    adutytbl[player]["skin"] = player:getModel()

                    player:setModel(16)
                end
            end
        else
            player:setData("adminduty",false)
            for k,v in pairs(getElementsByType("player")) do
                if v:getData("loggedin") then
                    notification(v,"Globale Serverinformation\nDer Spieler '"..player:getName().."' hat\nden Adminmodus verlassen.\nEr ist nun wieder als normaler Spieler zu behandeln.",10000,tocolor(245,237,88,255),true)
                    player:setModel(adutytbl[player]["skin"])
                end
            end
        end
    end
end
addEvent("serverToggleAdminDuty",true)
addEventHandler("serverToggleAdminDuty",getRootElement(),toggleAdminDuty)
