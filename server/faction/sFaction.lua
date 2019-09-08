--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\faction\sFaction.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\faction
--Created Date: Thursday, September 5th 2019, 9:10:25 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]

function createFactionFunction(player,cmd,factionName)
    if player:getData("adminlvl") > 3 then 
        if factionName == nil then
            player:outputChat("Du hast keinen Namen angegeben!",255,0,0)
        else
            if #factionName > 16 then
                player:outputChat("Der Name darf maximal 16 Zeichen lang sein!",255,0,0)
            else
                fname = tostring(factionName)
                local result = dbPoll(dbQuery(dbCon,"SELECT * FROM factions WHERE name = ?",fname),-1)
                if result[1] then
                    notification(player,"Diese Fraktion existiert berreits!",5000)
                else
                    dbPoll(dbQuery(dbCon,"INSERT INTO factions(name,creator) VALUES (?,?)",fname,player:getName()),-1)
                    local result = dbPoll(dbQuery(dbCon,"SELECT * FROM factions WHERE name = ?",fname),-1)
                    dbPoll(dbQuery(dbCon,"UPDATE user SET ??=?, ??=? WHERE ??=?","factionlvl",5,"factionid",result[#result]["id"],"username",player:getName()),-1)
                    notification(player,"Die Fraktion '"..fname.."' wurde\nerfolgreich erstellt!",5000)
                    player:setData("factionid",result[#result]["id"])
                    player:setData("factionname",fname)
                    player:setData("factionlvl",5)
                end
            end
        end
    end
end
addCommandHandler("createfaction",createFactionFunction)

