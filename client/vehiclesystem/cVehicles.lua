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

local car ={
    window = {},
    label = {},
    btn = {}
}
--dgsCreateWindow(x,y,sx,sy,text,relative,barcolor,font,textColor,titleHeight,titleImage,titleColor,image,color,borderSize,noCloseButton)
--dgsCreateTabPanel(x,y,sx,sy,relative,parent,tabHeight,defbgColor)
--dgsCreateTab(text,tabpanel,textSizex,textSizey,textColor,bgImage,bgColor,tabnorimg,tabhovimg,tabcliimg,tabnorcolor,tabhovcolor,tabclicolor)
--dgsCreateLabel(0.5,0.11,0.49,0.89,"",true,dgs.tab[#],nil,nil,nil,nil,nil,nil,"center","top")
--dgsCreateButton(x,y,w,h,txt,rel,parent,txtcolor,scx,scy,defimg,selimg,cliimg,defcolor,selcolor,clicolor)
--dgsCreateEdit(x,y,w,h,txt,rel,parent,txtclr,scx,scy,imgbg,clrbg,selmod)
local carwindow = false
function toggleCarWindow(veh)
    if not carwindow then 
        carwindow = not carwindow
        car.window[1] = dgsCreateWindow(0.01,0.4,0.2,0.2,"Fahrzeugmenü",true,tocolor(20,50,150,255))
        car.btn[1] = dgsCreateButton(0,0,0.5,0.5,"Informationen",true,car.window[1])
        car.btn[2] = dgsCreateButton(0.5,0,0.5,0.5,"Schlüssel",true,car.window[1])
        local dstate = "Öffnen"
        if veh:isLocked() then 
            dstate = "Öffnen" 
        else 
            dstate = "Schließen"
        end
        car.btn[3] = dgsCreateButton(0,0.43,0.5,0.5,"Fahrzeug\n"..dstate,true,car.window[1])
        car.btn[4] = dgsCreateButton(0.5,0.43,0.5,0.5,"Schließen",true,car.window[1])
        addEventHandler("onDgsMouseClick",getRootElement(),function(btn,st)
        if btn == "left" and st == "up" then
            if source == car.btn[4] then
                toggleCarWindow()
            end
            if source == car.btn[3] then
                clientunlock(veh)
                local dstate = "Öffnen"
                if veh:isLocked() then 
                    dstate = "Öffnen" 
                else 
                    dstate = "Schließen"
                end
                dgsSetText(car.btn[3],"Fahrzeug\n"..dstate)
            end
        end        
        end)
    else
        dgsCloseWindow(car.window[1])
        showCursor(false)
        carwindow = not carwindow
    end
end
function clientunlock(veh)
    if checkRights(getLocalPlayer(),veh) then
        triggerServerEvent("unlockVeh",getLocalPlayer(),veh)
    end
end

addEventHandler("onClientClick",getRootElement(),function(btn,st,ax,ay,x,y,z,ce)
    if btn == "right" and st == "down" then
        if ce then
            if getElementType(ce) == "vehicle" then
                if ce:getData("serverveh") then
                    clientunlock(ce)
                end
            end
        end
    end
    if btn == "left" and st == "down" then
        if ce then
            if getElementType(ce) == "vehicle" then
                if ce:getData("serverveh") then  
                    if lp:getData("adminlvl") > 3 or checkRights(getLocalPlayer(),ce) then
                        toggleCarWindow(ce)
                    end
                end
            end
        end
    end
end)

local airplanes = {592,577,511,512,593,520,553,476,519,460,513}
local helicopters = {548,425,417,487,488,497,563,447,469}
local boats = {572,473,493,595,484,430,453,452,446,454}
local bikes = {581,509,481,462,521,463,510,522,461,448,468,586}
local buses = {431,437}
local lkws = {407,544,433,427,499,609,498,524,532,578,573,455,403,423,414,443,515,514,456}

addEventHandler("onClientVehicleStartEnter",getRootElement(),function(player,seat,door)
    if not lp:getData("adminduty") then
        if seat == 0 then
            local airplane = false
            local helicopter = false
            local boat = false
            local bike = false
            local bus = false
            local lkw = false
            for k,v in pairs(airplanes) do
                if not airplane then 
                    if v == source:getModel() then
                        airplane = true

                    else
                        airplane = false
                    end
                end
            end
            for k,v in pairs(helicopters) do
                if not helicopter then
                    if v == source:getModel() then
                        helicopter = true
                    else
                        helicopter = false
                    end
                end
            end
            for k,v in pairs(boats) do
                if not boat then
                    if v == source:getModel() then
                        boat = true
                        
                    else
                        boat = false
                    end
                end
            end
            for k,v in pairs(bikes) do
                if not bike then 
                    if v == source:getModel() then
                        bike = true
                    else
                        bike = false
                    end
                end
            end
            for k,v in pairs(buses) do
                if not bus then
                    if v == source:getModel() then
                        bus = true
                    else
                        bus = false
                    end
                end
            end
            for k,v in pairs(lkws) do
                if not lkw then
                    if v == source:getModel() then
                        lkw = true
                    else
                        lkw = false
                    end
                end
            end


            if (not airplane and not helicopter and not boat and not bike and not bus and not lkw) then
                if lp:getData("b") == 0 then
                    cancelEvent()
                    notification("Du hast noch keinen Führerschein der Klasse 'B'",5000,tocolor(182,50,50,255))
                end
            elseif (bus) then
                if lp:getData("d") == 0 then
                    cancelEvent()
                    notification("Du hast noch keinen Führerschein der Klasse 'D'",5000,tocolor(182,50,50,255))
                end
            elseif (boat) then
                if lp:getData("e") == 0 then
                    cancelEvent()
                    notification("Du hast noch keinen Führerschein der Klasse 'E'",5000,tocolor(182,50,50,255))
                end
            elseif (lkw) then
                if lp:getData("c") == 0 then
                    cancelEvent()
                    notification("Du hast noch keinen Führerschein der Klasse 'C'",5000,tocolor(182,50,50,255))
                end
            elseif (bike) then
                if lp:getData("a") == 0 then
                    cancelEvent()
                    notification("Du hast noch keinen Führerschein der Klasse 'A'",5000,tocolor(182,50,50,255))
                end
            elseif (airplane) then
                if lp:getData("ap") == 0 then
                    cancelEvent()
                    notification("Du hast noch keinen Führerschein der Klasse 'AP'",5000,tocolor(182,50,50,255))
                end
            elseif (helicopter) then
                print(111)
                if lp:getData("hc") == 0 then
                    cancelEvent()
                    notification("Du hast noch keinen Führerschein der Klasse 'HC'",5000,tocolor(182,50,50,255))
                end
            end
        end
    end
end)
