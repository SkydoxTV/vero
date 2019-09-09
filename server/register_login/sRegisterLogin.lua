--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\register_login\sRegisterLogin.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\server\register_login
--Created Date: Tuesday, September 3rd 2019, 5:19:09 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]

function setLogRegDatas(datas,player)
    local result = datas
    local source = player
    source:setData("reglog",false)
    source:setData("loggedin",true)
    source:setData("showhud",true)
    source:setData("money",result[1]["money"])
    source:setData("status",result[1]["status"])
    source:setData("telnr",result[1]["number"])
    source:setData("bankmoney",result[1]["bankmoney"])
    source:setData("adminlvl",result[1]["adminlvl"])
    source:setData("playtime",result[1]["time"])
    source:setData("factionlvl",result[1]["factionlvl"])
    source:setData("factionid",result[1]["factionid"])
    source:setData("logins",result[1]["logins"])
    source:setData("b",result[1]["b"])
    source:setData("a",result[1]["a"])
    source:setData("c",result[1]["c"])
    source:setData("d",result[1]["d"])
    source:setData("e",result[1]["e"])
    source:setData("ap",result[1]["ap"])
    source:setData("hc",result[1]["hc"])
end
function generatePhoneNumber()
    local phonenumber = math.random(111111,999999)
    local result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE number = ?",phonenumber),-1)
    if result[1] then
        phonenumber = math.random(1111111,9999999) 
        result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE number = ?",phonenumber),-1)
        if result[1] then 
            phonenumber = math.random(11111111,99999999) 
            return phonenumber   
        else
            return phonenumber
        end
    else
        return phonenumber
    end
end


function utilizeRegisterData(pwd,pwd2,geschlecht)
    local maleSkins = {0, 1, 2, 7, 14, 15, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 306, 307, 308, 309, 310, 311, 312}
    local femaleSkins = {9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 298, 304}
    local player = source
    local skinid = 0
    if geschlecht == 1 then
        skinid = maleSkins[math.random(1,#maleSkins)]
    else
        skinid = femaleSkins[math.random(1,#femaleSkins)]
    end
        if pwd == pwd2 then
        if #pwd2 == 0 then
            notification(player,"Dein Passwort ist zu kurz.",5000,tocolor(182,50,50,255))
        elseif #pwd2 > 16 then
            notification(player,"Dein Passwort ist zu lang.",5000,tocolor(182,50,50,255))
        else
            
            local result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE username=?",player:getName()),-1)
            if result[1] then
                notification(player,"Der Benutzer existiert berreits.",5000,tocolor(182,50,50,255))
            else 
                local result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE serial=?",player:getSerial()),-1)
                if result[1] then
                    notification(player,"Du hast berreits einen Account "..result[1]["username"],5000,tocolor(182,50,50,255))
                else
                    local pw = passwordHash(pwd2,"bcrypt",{})
                    local number = generatePhoneNumber()
                    local result = dbPoll(dbQuery(dbCon,"INSERT INTO user (username,password,serial,skin,number) VALUES (?,?,?,?,?)",player:getName(),pw,player:getSerial(),skinid,number),-1)
                    source:setHudComponentVisible("radar",true)
                    triggerClientEvent(source,"closeClientRegisterLoginWindow",source)
                    source:setCameraTarget(source)
                    local result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE username=?",player:getName()),-1)
                    spawnPlayer(source,result[1]["x"],result[1]["y"],result[1]["z"],result[1]["rot"],result[1]["skin"],result[1]["int"],result[1]["dim"])
                    setLogRegDatas(result,source)
                    print(result[1]["time"])
                    local time = getRealTime()
                    source:setData("startTime",time.timestamp)
                end
            end
        end
    else
        notification(source,"Die Passwörter stimmen nicht überein.",5000,tocolor(182,50,50,255))
    end
end
addEvent("getDataFromClientRegister",true)
addEventHandler("getDataFromClientRegister",getRootElement(),utilizeRegisterData)

function utilizeLoginData(pwd)
    local result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE username=?",source:getName()),-1)
    if result[1] then
        if passwordVerify(pwd,result[1]["password"]) then
            source:setHudComponentVisible("radar",true)
            triggerClientEvent(source,"closeClientRegisterLoginWindow",source)
            source:setCameraTarget(source)
            local result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE username=?",source:getName()),-1)
            spawnPlayer(source,result[1]["x"],result[1]["y"],result[1]["z"],result[1]["rot"],result[1]["skin"],result[1]["int"],result[1]["dim"])
            setLogRegDatas(result,source)
            dbPoll(dbQuery(dbCon,"UPDATE user SET logins = ? WHERE username = ?",result[1]["logins"]+1,source:getName()),-1)
            local result2 = dbPoll(dbQuery(dbCon,"SELECT * FROM factions WHERE id = ?",source:getData("factionid")),-1)
            if result2[1] then
                source:setData("factionname",result2[1]["name"])
            else
                source:setData("factionname","Keine")
            end
            local time = getRealTime()
            source:setData("startTime",time.timestamp)
        else
            notification(source,"Das angegeben Passwort ist falsch.",5000,tocolor(182,50,50,255))
        end
    else
        notification(source,"Der Account '"..source:getName().."' existiert nicht.",5000,tocolor(182,50,50,255))
    end
end
addEvent("getDataFromClientLogin",true)
addEventHandler("getDataFromClientLogin",getRootElement(),utilizeLoginData)

addEventHandler("onPlayerQuit",getRootElement(),function()
    if source:getData("loggedin") then
        dbPoll(dbQuery(dbCon,"UPDATE user SET money=?,bankmoney=?,time=?,status=? WHERE username=?",source:getData("money"),source:getData("bankmoney"),source:getData("playtime"),source:getData("status"),source:getName()),-1)
    end
end)

addEventHandler("onResourceStop",getResourceRootElement(getThisResource()),function()
    for v,k in pairs(getElementsByType("player")) do
        if k:getData("loggedin") then
            dbPoll(dbQuery(dbCon,"UPDATE user SET money=?,bankmoney=?,time=?,status=? WHERE username=?",k:getData("money"),k:getData("bankmoney"),k:getData("playtime"),k:getData("status"),k:getName()),-1)
            outputDebugString("[Datenbank] Userdaten #"..v.." gespeichert!")
        end
    end
end)

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),function()
    for n,e in pairs(getElementsByType("player")) do
        for k,v in pairs(getAllElementData(e)) do
            setElementData(e,k,nil)
        end
    end
end)

addEvent("onClientPasswordChangeRequest",true)
addEventHandler("onClientPasswordChangeRequest",getRootElement(),function(player,old,new)
    local result = dbPoll(dbQuery(dbCon,"SELECT * FROM user WHERE username = ?",player:getName()),-1)
    if result[1] then
        if passwordVerify(old,result[1]["password"]) then
            dbPoll(dbQuery(dbCon,"UPDATE user SET password = ? WHERE username = ?",passwordHash(new,"bcrypt",{}),player:getName()),-1)
            notification(player,"Dein Passwort wurde erfolgreich\ngeändert.",5000)
        else
            notification(player,"Dein Passwort ist falsch\nPasswort vergessen? Melde dich bei unserem Team.",5000,tocolor(182,50,50,255))
        end
    end
end)