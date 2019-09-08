--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\ui\cHud.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\ui
--Created Date: Tuesday, September 3rd 2019, 8:39:43 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]

local sx,sy = guiGetScreenSize()
local dx,dy = 1600,900
local x,y = (sx/dx),(sy/dy)


local function dxRec(lx,ly,lw,lh,clr,pgui)
    dxDrawRectangle(x*lx,y*ly,x*lw,y*lh,clr,pgui)
end

local function dxTxt(txt,lx,ly,lw,lh,clr,scl,fnt,hz,vt,e,z,d,v,f)
    dxDrawText(txt,x*lx,y*ly,x*lw,y*lh,clr,scl,fnt,hz,vt,e,z,d,v,f)
end
local function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end
local function mathround(number)
    return number - number % 1
end

addEventHandler("onClientRender",getRootElement(),function()
    if lp:getData("loggedin") then
        if lp:getData("showhud") then
            local time = getRealTime()
            local hour = time.hour
            local minute = time.minute
            dxRec(1298, 10, 292, 43, tocolor(0, 0, 0, 154), false)
            dxRec(1298, 10, 292, 6, tocolor(18, 101, 149, 252), false)
            dxTxt("Name: "..lp:getName(), 1298, 16, 1444, 53, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
            dxTxt("Uhrzeit: "..hour..":"..minute, 1444, 16, 1590, 53, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
            dxRec(1298, 63, 292, 43, tocolor(0, 0, 0, 154), false)
            dxRec(1298, 63, 292, 6, tocolor(15, 173, 41, 255), false)
            dxTxt("BAR: "..lp:getData("money").."$ | BANK: "..lp:getData("bankmoney").."$", 1298, 69, 1590, 106, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
            dxRec(1298, 116, 292, 43, tocolor(0, 0, 0, 154), false)
            dxRec(1308, 120, 272, 6, tocolor(0, 0, 0, 154), false)
            dxRec(1308, 120, 272/100*lp:getHealth(), 6, tocolor(235, 0, 0, 255), false)
            dxRec(1308, 134, 272, 6, tocolor(0, 0, 0, 154), false)
            dxRec(1308, 134, 272/100*lp:getArmor(), 6, tocolor(0, 221, 234, 255), true)
            dxRec(1308, 149, 272, 6, tocolor(0, 0, 0, 154), false)
            dxRec(1308, 149, 272/1000*lp:getOxygenLevel(), 6, tocolor(169, 250, 255,255), true)
            if lp:isInVehicle() then
                dxRec(1319, 769, 259, 108, tocolor(0, 0, 0, 151), false)
                dxRec(1319, 769, 259, 6, tocolor(20, 224, 145, 144), false)
                if lp:getOccupiedVehicle():getEngineState() then 
                    dxTxt(mathround(getElementSpeed(lp:getOccupiedVehicle(),1)), 1319, 775, 1421, 877, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
                else
                    dxTxt("---", 1319, 775, 1421, 877, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
                end
                dxTxt("KM/h", 1421, 779, 1463, 877, tocolor(255, 255, 255, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)        
            end
        end
    end
end)

bindKey("x","down",function()
    local state = not lp:getOccupiedVehicle():getEngineState()
    lp:getOccupiedVehicle():setEngineState(state)
end)

--- tabpanel


--dgsCreateWindow(x,y,sx,sy,text,relative,barcolor,font,textColor,titleHeight,titleImage,titleColor,image,color,borderSize,noCloseButton)
--dgsCreateTabPanel(x,y,sx,sy,relative,parent,tabHeight,defbgColor)
--dgsCreateTab(text,tabpanel,textSizex,textSizey,textColor,bgImage,bgColor,tabnorimg,tabhovimg,tabcliimg,tabnorcolor,tabhovcolor,tabclicolor)
--dgsCreateLabel(0.5,0.11,0.49,0.89,"",true,dgs.tab[#],nil,nil,nil,nil,nil,nil,"center","top")
--dgsCreateButton(x,y,w,h,txt,rel,parent,txtcolor,scx,scy,defimg,selimg,cliimg,defcolor,selcolor,clicolor)
--dgsCreateEdit(x,y,w,h,txt,rel,parent,txtclr,scx,scy,imgbg,clrbg,selmod)
tab = {
    window = {},
    label = {},
    sp = {}
}
local infotab
local currentinfo = 2
local function minutesToClock(minutes)
    local minutes = tonumber(minutes)
    if minutes <= 0 then
      return "00:00";
    else
      hours = string.format("%02.f", math.floor(minutes/60));
      mins = string.format("%02.f", math.floor(minutes - (hours*60)));
      return hours..":"..mins
    end
  end


function showTab()
            tab.window[1] = dgsCreateWindow(0.35,0.2,0.3,0.6,"VeRo Reallife - Spielerliste",true,tocolor(50,90,132,255))
            cparent = tab.window[1]
            tab.sp[1] = dgsCreateScrollPane(0,0,1,1,true,cparent)
            cparent = tab.sp[1]

            tab.label[1] = dgsCreateLabel(0.05,0.015,0.3,0.045,"Spielername",true,cparent,nil,nil,nil,nil,nil,nil,"center","top")
            tab.label[2] = dgsCreateLabel(0.35,0.015,0.3,0.045,"Status",true,cparent,nil,nil,nil,nil,nil,nil,"center","top")
            tab.label[3] = dgsCreateLabel(0.65,0.015,0.3,0.045,"Spielzeit",true,cparent,nil,nil,nil,nil,nil,nil,"center","top") 
            for k,v in pairs(getElementsByType("player")) do
            local wert = (k*0.065)
                 if v:getData("status") == "Developer" then
                    color = tocolor(150,30,10,255)
                    name = "[VeRo]"..getPlayerName(v)
                else
                    name = getPlayerName(v)
                    color = nil
                end
                tab.label[1000+k] = dgsCreateLabel(0.05,wert,0.3 ,0.05,name,true,cparent,color,nil,nil,nil,nil,nil,"center","top")
                tab.label[2000+k] = dgsCreateLabel(0.35,wert,0.3 ,0.05,getElementData(v,"status"),true,cparent,color,nil,nil,nil,nil,nil,"center","top")
                tab.label[3000+k] = dgsCreateLabel(0.65,wert,0.3 ,0.05,minutesToClock(getElementData(v,"playtime")),true,cparent,color,nil,nil,nil,nil,nil,"center","top")
            end

end

function closeTab()
    dgsCloseWindow(tab.window[1])
end

bindKey("tab", "both",function(key,state)
    if lp:getData("loggedin") then
        if lp:getData("showhud") then
            if state == "down" then
                showTab()
            else
                closeTab()
            end
        end
    end
end)

setTimer(function()
    if getElementData(getLocalPlayer(),"loggedin") then
        local time = getRealTime()
        --print((getElementData(getLocalPlayer(),"playtime")+( (time.timestamp/60)-(getElementData(getLocalPlayer(),"startTime")/60))))
        setElementData(getLocalPlayer(),"playtime",getElementData(getLocalPlayer(),"playtime")+( (time.timestamp/60)-(getElementData(getLocalPlayer(),"startTime")/60) ))
        setElementData(getLocalPlayer(),"startTime", time.timestamp)
    end
end,1000,0)

bindKey("b","down",function()
    enableHud(not isHudEnabled())
end)

function enableHud(bool)
    setElementData(getLocalPlayer(),"showhud",bool)
    if bool == false then 
    triggerEvent("onClientHudDisable",getRootElement())
    end
end

local notifications = {
    window = {},
    label = {},
    timer = {},
}

function notification(text,duration)
    if isElement(notifications.window[1]) then
        dgsCloseWindow(notifications.window[1])
        killTimer(notifications.timer[1])
    end

    notifications.window[1] = dgsCreateWindow(0.7519,0.8167,0.2344,0.1556,"Benachrichtigung",true)
    notifications.label[1] = dgsCreateLabel(0,0,1,1,text,true,notifications.window[1],nil,nil,nil,nil,nil,nil,"center","center")
    playSound("res/sound/notifi.ogg")
    notifications.timer[1] = setTimer(function()
        if isElement(notifications.window[1]) then
            dgsCloseWindow(notifications.window[1])
        end
    end,duration,1)
end

addEvent("receiveNotification",true)
addEventHandler("receiveNotification",getRootElement(),notification)

function isHudEnabled()
    return getElementData(getLocalPlayer(),"showhud")
end

function onHudDisable()
    if isElement(tab.window[1]) then
        dgsCloseWindow(tab.window[1])
    end
end
addEvent("onClientHudDisable",true)
addEventHandler("onClientHudDisable",getRootElement(),onHudDisable)
local self = {
    window = {},
    image = {},
    
}
local selfactive = false
local settingactive = false 
local useractive = false
addEventHandler("onClientClick",getRootElement(),function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
    if button == "left" and state == "up" then
        if clickedElement then
            if clickedElement == getLocalPlayer() then
                if lp:getData("loggedin") then
                    if lp:getData("showhud") then
                        if selfactive then
                            dgsCloseWindow(self.window[1])
                            selfactive = false
                            removeEventHandler("onDgsMouseClick",getRootElement(),selfmenue_tabs)
                        else
                            self.window[1] = dgsCreateWindow(0.4,0.01,0.2,0.0967,"Eigenmenü",true,tocolor(20,50,135,255))
                            selfactive = true
                            self.image[1] = dgsCreateImage(0.1,0,0.2,1,"res/img/user.png",true,self.window[1])
                            self.image[2] = dgsCreateImage(0.4,0,0.2,1,"res/img/settings.jpg",true,self.window[1])
                            self.image[3] = dgsCreateImage(0.7,0,0.2,1,"res/img/close.png",true,self.window[1])
                            addEventHandler("onDgsMouseClick",getRootElement(),selfmenue_tabs)
                        end
                    end
                end
            end
        end
    end
end)

function selfmenue_tabs(btn,st)
        if btn == "left" and st=="up" then
            if source == self.image[3] then
                removeEventHandler("onDgsMouseClick",getRootElement(),selfmenue_tabs)
                dgsCloseWindow(self.window[1])
                selfactive = false
                if settingactive then
                    dgsCloseWindow(self.window[2])
                    settingactive = false 
                    self.window[2] = nil
                end
                if useractive then
                    dgsCloseWindow(self.window[3])
                    useractive = false 
                    self.window[3] = nil
                end
            end
            if source == self.image[2] then
                print(2)
                if useractive then
                    dgsCloseWindow(self.window[3])
                    useractive = false 
                end
                if settingactive then
                    dgsCloseWindow(self.window[2])
                    settingactive = false 
                elseif not settingactive then 
                     self.window[2] = dgsCreateWindow(0.4,0.1067,0.2,0.3,"Einstellungen",true,tocolor(20,50,135,255))
                     settingactive = true
                end
            end
            if source == self.image[1] then
                if settingactive then
                    dgsCloseWindow(self.window[2])
                    settingactive = false 
                end
                if useractive then
                    dgsCloseWindow(self.window[3])
                    useractive = false 
                elseif not useractive then 
                     self.window[3] = dgsCreateWindow(0.4,0.1067,0.2,0.3,"Benutzermenü",true,tocolor(20,50,135,255))
                     useractive = true
                end
            end
        end
    end