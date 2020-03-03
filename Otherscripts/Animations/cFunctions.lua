--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddEvent("OnKeyPress",function(key)
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		if(key=="F3")then
			ShowMouseCursor(true)
			SetInputMode(INPUT_UI)
			local Anim_GUI=UIDialog()
			Anim_GUI.setTitle("Animationpanel")
			Anim_GUI.appendTo(UIFramework)
			Anim_GUI.setCanClose(true)
			Anim_GUI.setMovable(false)
			Anim_GUI.onClickClose(function(obj)
				obj.destroy()
				SetInputMode(INPUT_GAME)
				SetIgnoreLookInput(false)
				SetIgnoreMoveInput(false)
				ShowMouseCursor(false)
			end)
			
			local anim
			local animList=UIOptionList()
			animList.allowMultiselection(false)
			animList.appendOption("CROSSARMS","Cross arms")
			animList.appendOption("FACEPALM","Facepalm")
			animList.appendOption("HALTSTOP","Haltstop")
			animList.appendOption("HANDSUP_STAND","Handsup")
			animList.appendOption("HANDSHAKE","Handshake")
			animList.appendOption("LAUGH","Laugh")
			animList.appendOption("SMOKING","Smoking")
			animList.appendOption(nil,"--------------------")
			animList.appendOption("DANCE01","Dance 1")
			animList.appendOption("DANCE02","Dance 2")
			animList.appendOption("DANCE03","Dance 3")
			animList.appendOption("DANCE04","Dance 4")
			animList.appendOption("DANCE05","Dance 5")
			animList.appendOption("DANCE06","Dance 6")
			animList.appendOption("DANCE07","Dance 7")
			animList.appendOption("DANCE08","Dance 8")
			animList.appendOption("DANCE09","Dance 9")
			animList.appendOption("DANCE10","Dance 10")
			animList.appendOption("WAVE","Wave")
			animList.appendOption("WAVE2","Wave 2")
			animList.appendOption("WAVE3","Wave 3")
			animList.appendTo(Anim_GUI)
			animList.onChange(function(obj)
				for _,v in pairs(obj.getValue())do
					anim=v
				end
			end)
			
			local Button1=UIButton()
			Button1.setTitle("start animation")
			Button1.setType("primary")
			Button1.onClick(function()
				if(anim~="" and anim~=nil)then
					CallRemoteEvent("start_stop:animation","start",anim)
				end
			end)
			Button1.appendTo(Anim_GUI)
			
			local Button2=UIButton()
			Button2.setTitle("stop animation")
			Button2.setType("secondary")
			Button2.onClick(function()
				CallRemoteEvent("start_stop:animation","stop")
			end)
			Button2.appendTo(Anim_GUI)
		end
	end
end)