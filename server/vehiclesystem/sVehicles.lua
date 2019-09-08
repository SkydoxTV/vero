--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\vehiclesystem\sVehicles.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\vehiclesystem
--Created Date: Thursday, September 5th 2019, 9:25:35 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]

function loadAllVehicles()
    local result = dbPoll(dbQuery(dbCon,"SELECT * FROM vehicles"),-1)
    for i = 1, #result do
            local veh = createVehicle(result[i]["model"],result[i]["x"],result[i]["y"],result[i]["z"],result[i]["rx"],result[i]["ry"],result[i]["rz"],result[i]["numberplate"])
            veh:setData("factionid",result[i]["factionid"])
            veh:setData("owner",result[i]["owner"])
            veh:setData("serverveh",true)
            veh:setData("vid",result[i]["vid"])
            veh:setData("fvid",result[i]["fvid"])
            veh:setColor(result[i]["r"],result[i]["g"],result[i]["b"])
            setElementDimension(veh,0)
            veh:setLocked(true)
            local vehd = dbPoll(dbQuery(dbCon,"SELECT * FROM vehicles WHERE owner = ?",result[i]["owner"]),-1)
            local vidtbl = {}
            for i = 1, #vehd do
                vidtbl[i] = vehd[i]["vid"]
            end
            for i = 1, #vehd do
                local update = dbPoll(dbQuery(dbCon,"UPDATE vehicles SET fvid = ? WHERE vid = ?",i,vidtbl[i]),-1)
                update = nil
            end
        end
end
loadAllVehicles()

function respawnFactionVeh(player,cmd,vehid)
    if vehid ~= nil then
        
    end
end

function createFactionVehicleFunction(player,cmd,modelid,r,g,b)
    if (r == nil or g == nil or b == nil) then
        r,g,b = 0,0,0
    end
    if player:getInterior() == 0 then
        if player:getData("factionlvl") > 3 then
            if getVehicleNameFromModel(modelid) ~= "" then
                local x,y,z = getElementPosition(player)
                local rx,ry,rz = getElementRotation(player)
                local result = dbPoll(dbQuery(dbCon,"SELECT * FROM factions WHERE id = ?",player:getData("factionid")),-1)
                local name = result[1]["name"]
                local veh = createVehicle(modelid,x,y+1,z,rx,ry,rz,result[1]["name"])
                veh:setData("factionid",result[1]["id"])
                veh:setData("owner",name)
                veh:setData("serverveh",true)
                
                local result = dbPoll(dbQuery(dbConInfo,"SELECT AUTO_INCREMENT FROM TABLES WHERE TABLE_SCHEMA = 'vero' AND TABLE_NAME = 'vehicles'"),-1)
                local vehd = dbPoll(dbQuery(dbCon,"SELECT * FROM vehicles WHERE owner = ?",name),-1)
                local vidtbl = {}
                for i = 1, #vehd do
                    vidtbl[i] = vehd[i]["vid"]
                end
                for i = 1, #vehd do
                    local update = dbPoll(dbQuery(dbCon,"UPDATE vehicles SET fvid = ? WHERE vid = ?",i,vidtbl[i]),-1)
                    update = nil
                end

                dbPoll(dbQuery(dbCon,"INSERT INTO vehicles (fvid,model,owner,factionid,numberplate,x,y,z,rx,ry,rz,r,g,b) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",#vehd+1,modelid,name,player:getData("factionid"),name,x,y,z,rx,ry,rz,r,g,b),-1)
                notification(player,"Fraktionsfahrzeug erfolgreich erstellt!",5000)
                veh:setData("vid",result[1]["AUTO_INCREMENT"])
                local vehd = dbPoll(dbQuery(dbCon,"SELECT * FROM vehicles WHERE vid = ?",result[1]["AUTO_INCREMENT"]),-1)
                veh:setData("fvid",vehd[1]["fvid"])
                veh:setColor(r,g,b)
                checkVehicles()
            end
        end
    end
end
addCommandHandler("createfactionvehicle",createFactionVehicleFunction)

function checkVehicles()
    for k,v in pairs(getElementsByType("vehicle")) do
        v:setData("fvid",false)
        local inDatabase = 0
        local abfrage = dbPoll(dbQuery(dbCon,"SELECT * FROM vehicles"),-1)
        for i = 1,#abfrage do
            if v:getData("vid") == abfrage[i]["vid"] then
                inDatabase = 1
            end
        end
        if inDatabase == 0 then
            destroyElement(v)
        elseif inDatabase == 1 then
            local vehd2 = dbPoll(dbQuery(dbCon,"SELECT * FROM vehicles WHERE vid = ?",v:getData("vid")),-1)
            if vehd2[1] then
                v:setData("fvid",vehd2[1]["fvid"])
            end
        end
    end
end

function checkRights(player,veh)
    if veh:getData("owner") == player:getName() or veh:getData("owner") == player:getData("factionname") then
        return true
    else
        return false
    end
end

addEvent("unlockVeh",true)
addEventHandler("unlockVeh",getRootElement(),function(veh)
    local state = not veh:isLocked()
    veh:setLocked(state)
    setVehicleOverrideLights(veh,2)
    setTimer(function()
        setVehicleOverrideLights(veh,1)
        setTimer(function()
            setVehicleOverrideLights(veh,2)
            setTimer(function()
                setVehicleOverrideLights(veh,1)
            end,250,1)
        end,250,1)
    end,250,1)

end)

function setParkPosition(player)
    if isPedInVehicle(player) then
        if checkRights(player,getPedOccupiedVehicle(player)) then
            local vx,vy,vz = getElementPosition(getPedOccupiedVehicle(player))
            local vrx,vry,vrz = getElementRotation(getPedOccupiedVehicle(player))
            dbPoll(dbQuery(dbCon,"UPDATE vehicles SET x=?,y=?,z=?,rx=?,ry=?,rz=? WHERE vid = ?",vx,vy,vz,vrx,vry,vrz,getPedOccupiedVehicle(player):getData("vid")),-1)
            notification(player,"Du hast dein Fahrzeug ( #"..getPedOccupiedVehicle(player):getData("vid").." ) geparkt!",5000)
        else
            notification(player,"Du hast keine Berechtigung\ndieses Fahrzeug zu parken",5000)
        end
    end
end
addCommandHandler("park",setParkPosition)