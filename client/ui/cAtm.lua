--[[
--Filename: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\ui\cAtm.lua
--Path: c:\Program Files (x86)\MTA San Andreas 1.5\server\mods\deathmatch\resources\vero\client\ui
--Created Date: Monday, September 9th 2019, 7:48:27 pm
--Author: gamer
--
--Copyright (c) 2019 VeRo
--]]

atm = {
    --[#] = {x,y,z,rx,ry,rz,location}
    [1] = {-2765.3000488281,372.29998779297,5.9000000953674,0,0,90},
    [2] = {-2765.3000488281,378.29998779297,5.9000000953674,0,0,90}
}
atmui = {
    wdw = {},
    lbl = {},
    btn = {},
    edit = {},
    tp = {},
    tab = {}
}
lp:setData("inwindow",false)
for i = 1, #atm do
    local atms = createObject(2942,atm[i][1],atm[i][2],atm[i][3],atm[i][4],atm[i][5],atm[i][6])
    addEventHandler("onClientClick",getRootElement(),function(btn,st,ax,ay,wx,wy,wz,ce)
        if ce then
            if btn == "left" and st == "down" then
                if ce == atms then
                    if not atmactive then
                        if not lp:getData("inwindow") then
                            atmactive = false
                            atmui.wdw[1] = dgsCreateWindow(0.4,0.35,0.2,0.3,"Bankautomat",true,tocolor(50,182,50,255))
                            guiSetInputMode("no_binds")
                            lp:setData("inwindow",true)
                            dgsWindowSetSizable(atmui.wdw[1],false)
                            dgsWindowSetMovable(atmui.wdw[1],false)
                            atmui.tp[1] = dgsCreateTabPanel(0,0,1,1,true,atmui.wdw[1])
                            atmui.tab[1] = dgsCreateTab("Kontoübersicht",atmui.tp[1],nil,nil,nil,nil,tocolor(255,255,255,50))
                                atmui.lbl[1] = dgsCreateLabel(0,0,1,0.35,"Kontoübersicht\nHerzlich Wilkommen bei der Bank of San Fierro.\nHier haben Sie eine Übersicht,Ihrer\naktuell Finanziell verfügbaren Mittel.",true,atmui.tab[1],tocolor(0,0,0,255),nil,nil,nil,nil,nil,"center","center")
                                atmui.lbl[2] = dgsCreateLabel(0,0.45,1,0.2,"Aktuelles Bargeld:\n"..lp:getData("money").."$\n\nAktuelles Kontguthaben\n(ohne Abzüge):\n"..lp:getData("bankmoney").."$",true,atmui.tab[1],tocolor(0,0,0,255),nil,nil,nil,nil,nil,"center","center")
                                
                            atmui.tab[2] = dgsCreateTab("Einzahlung",atmui.tp[1])
                                atmui.lbl[3] = dgsCreateLabel(0,0,1,0.35,"Einzahlungsberreich\nHier kannst du Bargeld auf dein Konto buchen.",true,atmui.tab[2],nil,nil,nil,nil,nil,nil,"center","center")    
                                atmui.lbl[4] = dgsCreateLabel(0.2,0.35,0.6,0.1,"Einzahlungsbetrag:",true,atmui.tab[2])
                                atmui.edit[1] = dgsCreateEdit(0.2,0.45,0.6,0.1,"",true,atmui.tab[2])
                                atmui.btn[1] = dgsCreateButton(0.2,0.575,0.6,0.1,"Einzahlen",true,atmui.tab[2])
                            atmui.tab[3] = dgsCreateTab("Auszahlung",atmui.tp[1])
                                atmui.lbl[5] = dgsCreateLabel(0,0,1,0.35,"Auszahlungsberreich\nHier kannst du Bargeld von deinem Konto abheben.",true,atmui.tab[3],nil,nil,nil,nil,nil,nil,"center","center")    
                                atmui.lbl[6] = dgsCreateLabel(0.2,0.35,0.6,0.1,"Auszahlungsbetrag:",true,atmui.tab[3])
                                atmui.edit[2] = dgsCreateEdit(0.2,0.45,0.6,0.1,"",true,atmui.tab[3])
                                atmui.btn[2] = dgsCreateButton(0.2,0.575,0.6,0.1,"Auszahlen",true,atmui.tab[3])
                            atmui.tab[4] = dgsCreateTab("Überweisung",atmui.tp[1])

                                atmui.btn[100] = dgsCreateButton(0.8,0.8,0.1,0.1,"X",true,atmui.tab[1])
                                atmui.btn[101] = dgsCreateButton(0.8,0.8,0.1,0.1,"X",true,atmui.tab[2])
                                atmui.btn[102] = dgsCreateButton(0.8,0.8,0.1,0.1,"X",true,atmui.tab[3])
                                atmui.btn[103] = dgsCreateButton(0.8,0.8,0.1,0.1,"X",true,atmui.tab[4])
                                addEventHandler("onDgsMouseClick",getRootElement(),function(btn,st)
                                    if btn == "left" and st == "up" then
                                        if (source == atmui.btn[100] or source == atmui.btn[101] or source == atmui.btn[102] or source == atmui.btn[103])then
                                            dgsCloseWindow(atmui.wdw[1])
                                            lp:setData("inwindow",false)
                                        end
                                        if source == atmui.btn[1] then
                                            if tonumber(dgsGetText(atmui.edit[1])) <= lp:getData("money") then
                                                lp:setData("bankmoney",lp:getData("bankmoney")+tonumber(dgsGetText(atmui.edit[1])))
                                                lp:setData("money",lp:getData("money")-tonumber(dgsGetText(atmui.edit[1])))
                                                notification("Einzahlung erfolgreich:\nDu hast erfolgreich "..dgsGetText(atmui.edit[1]).."$ eingezahlt",5000,tocolor(50,182,50,255))
                                            else
                                                notification("Fehler:\nDu hast nicht so viel Bargeld.",5000,tocolor(182,50,50,255))
                                            end
                                        end
                                        if source == atmui.btn[2] then
                                            if tonumber(dgsGetText(atmui.edit[2])) <= lp:getData("bankmoney") then
                                                lp:setData("money",lp:getData("money")+tonumber(dgsGetText(atmui.edit[2])))
                                                lp:setData("bankmoney",lp:getData("bankmoney")-tonumber(dgsGetText(atmui.edit[2])))
                                                notification("Auszahlung erfolgreich:\nDu hast erfolgreich "..dgsGetText(atmui.edit[2]).."$ abgehoben",5000,tocolor(50,182,50,255))
                                            else
                                                notification("Fehler:\nDu hast nicht so viel Guthaben.",5000,tocolor(182,50,50,255))
                                            end
                                        end
                                    end
                                end)

                        end
                    end
                end
            end
        end
    end)
end