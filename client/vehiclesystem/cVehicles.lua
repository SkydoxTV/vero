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