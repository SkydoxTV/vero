--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\mysql.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server
--Created Date: Tuesday, September 3rd 2019, 5:40:27 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]
dbConInfo = dbConnect( "mysql", "dbname=information_schema;host=127.0.0.1;charset=utf8", "root", "" )
dbCon = dbConnect( "mysql", "dbname=vero;host=127.0.0.1;charset=utf8", "root", "" )
local dbsucc = nil
if dbCon then
    dbsucc = true
    outputDebugString("[Datenbank] Verbindung hergestellt.")
else
    dbsucc = false
    outputDebugString("[Datenbank] Verbindung fehlerhaft.")
end

addEventHandler("onPlayerJoin",getRootElement(),function()
    serverDisableLoginRegister(source)
end)
function serverDisableLoginRegister(player)
    if dbsucc == nil then
        setTimer(function()
            if not dbsucc then
                triggerClientEvent(player,"disableClientRegisterLogin",player)
            end
        end,2000,1)
    elseif not dbsucc then
        triggerClientEvent(player,"disableClientRegisterLogin",player)
    end
end
addEvent("checkServerLoginRegister",true)
addEventHandler("checkServerLoginRegister",getRootElement(),serverDisableLoginRegister)