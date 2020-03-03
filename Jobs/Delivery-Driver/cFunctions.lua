--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local level
local expp
local exppp
local function openTruckerJobUI(lvl,exp,expppp)
	level=lvl
	expp=exp
	exppp=expppp
	ShowMouseCursor(true)
	if(Trucker_GUI)then
		Trucker_GUI.destroy()
	end
	SetInputMode(INPUT_UI)
	Trucker_GUI=UIDialog()
	Trucker_GUI.setTitle("Job")
	Trucker_GUI.appendTo(UIFramework)
	Trucker_GUI.setCanClose(true)
	Trucker_GUI.setMovable(false)
	Trucker_GUI.onClickClose(function(obj)
		obj.hide()
		disableJobUIFuncs()
	end)
	
	local text=UIText()
	text.setContent("Your Trucker level: "..level.." - exp: "..expp.."/"..exppp)
	text.appendTo(Trucker_GUI)
	
	local text2=UIText()
	text2.setContent("Here you can start the 'Delivery Driver' job to get Money.\nINFO: You get the Money at the Payday!")
	text2.appendTo(Trucker_GUI)
	
	local text3=UIText()
	text3.setContent("Vehicle supplied: <span style='color: #00a000;'>Yes</span>")
	text3.appendTo(Trucker_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Job start")
	Button1.onClick(function()
		CallRemoteEvent("start:job:trucker",0)
		Trucker_GUI.hide()
		disableJobUIFuncs()
	end)
	Button1.appendTo(Trucker_GUI)
	
	if(GetPlayerPropertyValue(GetPlayerId(),"LVL:Truck")>=1)then
		local Button2=UIButton()
		Button2.setTitle("Job start (lvl 1)")
		Button2.onClick(function()
			CallRemoteEvent("start:job:trucker",1)
			Trucker_GUI.hide()
			disableJobUIFuncs()
		end)
		Button2.appendTo(Trucker_GUI)
	end
	
	if(GetPlayerPropertyValue(GetPlayerId(),"LVL:Truck")>=2)then
		local Button3=UIButton()
		Button3.setTitle("Job start (lvl 2)")
		Button3.onClick(function()
			CallRemoteEvent("start:job:trucker",2)
			Trucker_GUI.hide()
			disableJobUIFuncs()
		end)
		Button3.appendTo(Trucker_GUI)
	end
end
AddRemoteEvent("open:lkwJobUI",openTruckerJobUI)

function disableJobUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end

local deliverBlip
AddRemoteEvent("create:TruckerWaypoint",function(x,y,z)
	if(deliverBlip)then
		DestroyWaypoint(deliverBlip)
	end
	deliverBlip=CreateWaypoint(x,y,z,"Truck Deliver")
end)
AddRemoteEvent("destroy:TruckerWaypoint",function()
	if(deliverBlip)then
		DestroyWaypoint(deliverBlip)
	end
end)