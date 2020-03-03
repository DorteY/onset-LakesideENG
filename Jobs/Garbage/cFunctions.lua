--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


function GetNearestGarbage()
    local x,y,z=GetPlayerLocation()
    for _,v in pairs(GetStreamedVehicles())do
        local x2,y2,z2=GetVehicleLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<350.0)then
			return v
		end
    end
    return 0
end

AddEvent("OnKeyPress",function(key)
    if(key==interactKey)then
        local NearestGarbage=GetNearestGarbage()
        if(NearestGarbage~=0)then
            CallRemoteEvent("interact:garbage",NearestGarbage)       
		end
	end
end)

AddRemoteEvent("open:garbageJobUI",function()
	ShowMouseCursor(true)
	if(Garbage_GUI)then
		Garbage_GUI.destroy()
	end
	SetInputMode(INPUT_UI)
	Garbage_GUI=UIDialog()
	Garbage_GUI.setTitle("Job")
	Garbage_GUI.appendTo(UIFramework)
	Garbage_GUI.setCanClose(true)
	Garbage_GUI.setMovable(false)
	Garbage_GUI.onClickClose(function(obj)
		obj.hide()
		disableJobUIFuncs()
	end)
	
	local text=UIText()
	text.setContent("Here you can start the 'Garbage' job to get Money.")
	text.appendTo(Garbage_GUI)
	
	local text2=UIText()
	text2.setContent("INFO: You get the Money at the Payday!")
	text2.appendTo(Garbage_GUI)
	
	local text3=UIText()
	text3.setContent("Vehicle supplied: <span style='color: #00a000;'>Yes</span>")
	text3.appendTo(Garbage_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Job start")
	Button1.onClick(function()
		CallRemoteEvent("start:job:garbage")
		Garbage_GUI.hide()
		disableJobUIFuncs()
	end)
	Button1.appendTo(Garbage_GUI)
end)

function disableJobUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end

local deliverBlip
local deliverBlip1
AddRemoteEvent("create:GarbageWaypoint",function(x,y,z)
	if(deliverBlip)then
		DestroyWaypoint(deliverBlip)
	end
	deliverBlip=CreateWaypoint(x,y,z,"Trash")
end)
AddRemoteEvent("destroy:GarbageWaypoint",function()
	if(deliverBlip)then
		DestroyWaypoint(deliverBlip)
	end
end)

AddRemoteEvent("create:GarbageWaypointDeliver",function(x,y,z)
	if(deliverBlip1)then
		DestroyWaypoint(deliverBlip1)
	end
	deliverBlip1=CreateWaypoint(x,y,z,"Trash Deliver")
end)
AddRemoteEvent("destroy:GarbageWaypointDeliver",function()
	if(deliverBlip1)then
		DestroyWaypoint(deliverBlip1)
	end
end)