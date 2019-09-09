--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\ui\cLogin.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\ui
--Created Date: Tuesday, September 3rd 2019, 5:18:35 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]


loadstring(exports.dgs:dgsImportFunction())()
local dgs={
    window = {},
    label = {},
    edit = {},
    button = {},
    tabpanel = {},
    tab = {},
    radio = {},
    sound = {},
    sp = {}
}
--dgsCreateWindow(x,y,sx,sy,text,relative,barcolor,font,textColor,titleHeight,titleImage,titleColor,image,color,borderSize,noCloseButton)
--dgsCreateTabPanel(x,y,sx,sy,relative,parent,tabHeight,defbgColor)
--dgsCreateTab(text,tabpanel,textSizex,textSizey,textColor,bgImage,bgColor,tabnorimg,tabhovimg,tabcliimg,tabnorcolor,tabhovcolor,tabclicolor)
--dgsCreateLabel(0.5,0.11,0.49,0.89,"",true,dgs.tab[#],nil,nil,nil,nil,nil,nil,"center","top")
--dgsCreateButton(x,y,w,h,txt,rel,parent,txtcolor,scx,scy,defimg,selimg,cliimg,defcolor,selcolor,clicolor)
--dgsCreateEdit(x,y,w,h,txt,rel,parent,txtclr,scx,scy,imgbg,clrbg,selmod)

lp = getLocalPlayer()
lp:setData("adminduty",false)
lp:setData("reglog",false)
lp:setData("loggedin",false)
lp:setData("showhud",false)
function RegisterLoginWindow()
    dgs.sound[1] = playSound("res/sound/loginregister.mp3",true)
    setSoundVolume(dgs.sound[1],0.5)
    --SetCamera/Position etc.
    Camera.setMatrix(-2706,-5,12,-2706,96,8,2.5,180)
    fadeCamera(true)
    lp:setPosition(0,0,0)
    lp:setFrozen(true)
    lp:setDimension(200)
    guiSetInputMode("no_binds")
    --Dismiss Hud Components
    setPlayerHudComponentVisible("all",false)

    dgs.window[1] = dgsCreateWindow(0.35,0.25,0.3,0.5,"Registrieren / Einloggen",true, tocolor(50,100,200,255))
    local parent1 = dgs.window[1]
    dgs.tabpanel[1] = dgsCreateTabPanel(0,0,1,1,true,parent1,false,tocolor(0,0,200,255))
    dgs.tab[1] = dgsCreateTab("Wilkommen",dgs.tabpanel[1])
    dgs.tab[2] = dgsCreateTab("Einloggen", dgs.tabpanel[1])
    dgs.tab[3] = dgsCreateTab("Registrieren", dgs.tabpanel[1])
    --Wilkommen
    dgs.label[1] = dgsCreateLabel(0.01,0.01,0.99,0.1,"Herzlich Wilkommen auf VeRo Reallife!\nBitte Logge dich ein, oder Registriere dich um fortzufahren.",true,dgs.tab[1],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.sp[1] = dgsCreateScrollPane(0.01,0.11,0.525,0.8,true,dgs.tab[1])
    dgs.label[2] = dgsCreateLabel(0.1,0,0.8,1.8,"\n------------------------------------\nChangelog:\n(Verfolge die Entwicklung\nunseres Servers)\n------------------------------------\n03.09.2019(Ver. 0.01 InDev):\n- Development gestartet\n- Login/Register Fenster erstellt\n- Datenbankstruktur vorläufig erstellt\n- Datenbankverbindungen hergestellt\n- Datensätze hinzugefügt\n- Backend für Register/Login\n- Spawnpunkt ausgewählt\n- Script aufgeräumt/sortiert\n\n04/03.09.2019(Ver. 0.02 InDev)\n- Vorläufiges (Dev)HUD-Design\n(-> Nur zur Funktion )\n- Tabpanel hinzugefügt\n- Spielzeit ergänzt\n\n05.09.2019(Ver.0.03 InDev)\n- Benachrichtigungen eingebaut\n- Bugfix sowie minimale\nTab Panel änderung\n- Fraktionssystem hinzugefügt\n(Grundsystem)\n- Fahrzeugsystem hinzugefügt\n(Grundsystem)\n\n06.09.2019(Ver.0.03 InDev)\n- Fahrzeugsystem erweitert\n\n08.09.2019(Ver.0.031 InDev)\n- Fahrzeugmenü erstellt",true,dgs.sp[1],nil,nil,nil,nil,nil,nil,"center","top")
    dgs.label[3] = dgsCreateLabel(0.5,0.11,0.49,0.89,"\n------------------------------------\nServerstatus:\n------------------------------------\nDatenbankserver: \nOnline(Dev)\n\nWebserver: \nOnline(InDev)\n\n------------------------------------\nGeplante Neuerungen(ToDo):\n------------------------------------\n- Selfmenü(!)\n- Autosystem(...)\n- Fraktionen(!)",true,dgs.tab[1],nil,nil,nil,nil,nil,nil,"center","top")
    
    -----------
    --Einloggen
    dgs.label[4] = dgsCreateLabel(0.01,0.01,0.99,0.175,"Herzlich Wilkommen zurück '"..lp:getName().."'\nBitte gib deine Einloggdaten ein, um dich anzumelden.\nFalls du Fragen/Probleme haben solltest, melde dich bei unserem Support\ndort wird dir einer unserer Mitarbeiter weiterhelfen.",true,dgs.tab[2],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.label[5] = dgsCreateLabel(0,0.35,1,0.05,"Username",true,dgs.tab[2],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.edit[1] = dgsCreateEdit(0.3,0.405,0.4,0.05,lp:getName(),true,dgs.tab[2])
    dgsEditSetReadOnly(dgs.edit[1],true)
    dgs.label[6] = dgsCreateLabel(0,0.47,1,0.05,"Passwort",true,dgs.tab[2],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.edit[2] = dgsCreateEdit(0.3,0.525,0.4,0.05,"",true,dgs.tab[2])
    dgsEditSetMasked(dgs.edit[2],true)
    dgs.button[1] = dgsCreateButton(0.8,0.925,0.175,0.05,"Einloggen",true,dgs.tab[2])
    addEventHandler("onDgsMouseClick",getRootElement(),function(btn,st)
        if btn == "left" and st =="down" then
            if source == dgs.button[1] then
                triggerServerEvent("getDataFromClientLogin",lp,dgsGetText(dgs.edit[2]))
            end
            if source == dgs.tab[2] then
                dgsSetText(dgs.edit[2], "")
            end
        end
    end)

    ------------
    --Registrieren
    notification("Herzlich Wilkommen\nBei Fragen darfst du dich gerne\nbei uns melden.",5000)
    dgs.label[8] = dgsCreateLabel(0.01,0.01,0.99,0.175,"Herzlich Wilkommen '"..lp:getName().."'\nBitte fülle das Formular aus, um dich zu Registrieren.\nFalls du Fragen/Probleme haben solltest, melde dich bei unserem Support\ndort wird dir einer unserer Mitarbeiter weiterhelfen.",true,dgs.tab[3],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.button[2] = dgsCreateButton(0.8,0.925,0.175,0.05,"Registrieren",true,dgs.tab[3])
    dgs.label[7] = dgsCreateLabel(0,0.33,1,0.05,"Username",true,dgs.tab[3],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.edit[3] = dgsCreateEdit(0.3,0.385,0.4,0.05,lp:getName(),true,dgs.tab[3])
    dgsEditSetReadOnly(dgs.edit[3],true)
    dgs.label[8] = dgsCreateLabel(0,0.45,1,0.05,"Passwort",true,dgs.tab[3],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.edit[4] = dgsCreateEdit(0.3,0.505,0.4,0.05,"",true,dgs.tab[3])
    dgsEditSetMasked(dgs.edit[4],true)
    dgs.label[8] = dgsCreateLabel(0,0.57,1,0.05,"Passwort wiederholen",true,dgs.tab[3],nil,nil,nil,nil,nil,nil,"center","center")
    dgs.edit[5] = dgsCreateEdit(0.3,0.625,0.4,0.05,"",true,dgs.tab[3])
    dgsEditSetMasked(dgs.edit[5],true)
    dgs.radio[1] = dgsCreateRadioButton(0.3,0.695,0.4,0.05,"Männlich",true,dgs.tab[3])
        dgsRadioButtonSetSelected(dgs.radio[1],true)
    dgs.radio[2] = dgsCreateRadioButton(0.3,0.745,0.4,0.05,"Weiblich",true,dgs.tab[3])
    addEventHandler("onDgsMouseClick",getRootElement(),function(btn,st)
        if btn == "left" and st == "up" then
            if source == dgs.button[2] then
                local geschlecht = nil
                if dgsRadioButtonGetSelected(dgs.radio[1]) then
                    geschlecht = 1
                elseif dgsRadioButtonGetSelected(dgs.radio[2]) then 
                    geschlecht = 2
                end
               triggerServerEvent("getDataFromClientRegister",getLocalPlayer(),dgsGetText(dgs.edit[4]),dgsGetText(dgs.edit[5]),geschlecht)
               
          end
          if source == dgs.tab[3] then
            dgsSetText(dgs.edit[4], "")
            dgsSetText(dgs.edit[5], "")
          end
        end
    end)

    ------------    
    
    lp:setData("reglog", true)
    showCursor(false)
    showCursor(true)
    triggerServerEvent("checkServerLoginRegister",lp,lp)
end
RegisterLoginWindow()

bindKey("m","down",function()
    if lp:getData("reglog") == false then
        local cstate = not isCursorShowing()
        showCursor(cstate)
    end
end)

function closeRegisterLoginWindow()
    dgsCloseWindow(dgs.window[1])
    stopSound(dgs.sound[1])
    showCursor(false)
    guiSetInputMode("allow_binds")
    notification("Du hast dich erfolgreich eingeloggt",5000)
end
addEvent("closeClientRegisterLoginWindow",true)
addEventHandler("closeClientRegisterLoginWindow",getRootElement(),closeRegisterLoginWindow)

function disableRegisterLogin()
    dgsSetEnabled(dgs.tab[2],false)
    dgsSetEnabled(dgs.tab[3],false)
    dgsSetText(dgs.label[3],"\n------------------------------------\nServerstatus:\n------------------------------------\nDatenbankserver: \nOFFLINE\n( Anmeldung/Registrierung\nnicht möglich )\n\nWebserver: \nOnline(InDev)\n\n------------------------------------\nGeplante Änderungen:\n------------------------------------\n- Benachrichtigungen statt Chatbox\n- Speicherung des Standortes\nnach Ausloggen")
end

addEvent("disableClientRegisterLogin",true)
addEventHandler("disableClientRegisterLogin",getRootElement(),disableRegisterLogin)

