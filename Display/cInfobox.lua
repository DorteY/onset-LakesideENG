--|| Project: Lakeside RL/RP (Onset) ||--
--||     Developer: Frederic2ec      ||--
--||         Lake-Gaming.com         ||--


local NotificationHud

AddEvent("OnPackageStart",function()
    NotificationHud = CreateWebUI(0,0,0,0,0,32)
    SetWebAlignment(NotificationHud,0.0,0.0)
    SetWebAnchors(NotificationHud,0.0,0.0,1.0,1.0)
    LoadWebFile(NotificationHud,"http://asset/"..GetPackageName().."/Files/Notification/notification.html")
    SetWebVisibility(NotificationHud,WEB_HITINVISIBLE)
end)

function MakeNotification(text, color)
    ExecuteWebJS(NotificationHud,'makeNotification("' ..text.. '", "' ..color.. '")')
    --PlayAudioFile("notification.mp3")
end
AddRemoteEvent("MakeNotification",MakeNotification)