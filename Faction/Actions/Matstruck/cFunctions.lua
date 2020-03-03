--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("open:matstruckUI",function()
	ShowMouseCursor(true)
	if(Matstruck_GUI)then
		Matstruck_GUI.destroy()
	end
	SetInputMode(INPUT_UI)
	Matstruck_GUI=UIDialog()
	Matstruck_GUI.setTitle("Matstruck")
	Matstruck_GUI.appendTo(UIFramework)
	Matstruck_GUI.setCanClose(true)
	Matstruck_GUI.setMovable(false)
	Matstruck_GUI.onClickClose(function(obj)
		obj.hide()
		disableMatstruckUIFuncs()
	end)
	
	local text=UIText()
	text.setContent("Here you can start a Matstruck. Costs: $5000")
	text.appendTo(Matstruck_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Start Matstruck")
	Button1.onClick(function()
		CallRemoteEvent("action:matstruck")
		Matstruck_GUI.hide()
		disableMatstruckUIFuncs()
	end)
	Button1.appendTo(Matstruck_GUI)
end)

function disableMatstruckUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end

local deliverMTBlip
AddRemoteEvent("create:MatstruckWaypoint",function(x,y,z)
	if(deliverMTBlip)then
		DestroyWaypoint(deliverMTBlip)
	end
	deliverMTBlip=CreateWaypoint(x,y,z,"Matstruck Deliver")
end)
AddRemoteEvent("destroy:MatstruckWaypoint",function()
	if(deliverMTBlip)then
		DestroyWaypoint(deliverMTBlip)
	end
end)