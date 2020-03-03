--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("open:police_dutyUI",function()
	if(Duty_GUI)then
		Duty_GUI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	Duty_GUI=UIDialog()
	Duty_GUI.setTitle("Police")
	Duty_GUI.appendTo(UIFramework)
	Duty_GUI.setCanClose(true)
	Duty_GUI.setMovable(false)
	Duty_GUI.onClickClose(function(obj)
		obj.hide()
		disableDutyUiFuncs()
	end)
	
	local duty
	local genderList=UIOptionList()
	genderList.allowMultiselection(false)
	genderList.appendOption(0,"On duty")
	genderList.appendOption(1,"Off duty")
	genderList.appendTo(Duty_GUI)
	genderList.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			duty=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Go on/off duty")
	Button1.onClick(function()
		if(duty~="" and duty~=nil)then
			CallRemoteEvent("go:police_duty",duty)
		end
	end)
	Button1.appendTo(Duty_GUI)
end)


function disableDutyUiFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end