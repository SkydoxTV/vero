function enableHud(player,bool)
    setElementData(player,"showhud",bool)
end

function isHudEnabled(player)
    return getElementData(player,"showhud")
end

function notification(sendTo,text,duration,barcolor,global)
    triggerClientEvent(sendTo,"receiveNotification",sendTo,text,duration,barcolor,global)
end