--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local LastSoundPlayed=0

function PlayAudioFile(file,volume)
	DestroySound(LastSoundPlayed)

	LastSoundPlayed=CreateSound("Files/Sounds/"..file)
	SetSoundVolume(LastSoundPlayed,volume)
end
AddRemoteEvent("PlayAudioFile",PlayAudioFile)

AddEvent("OnKeyPress",function(key)
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		if(key=="F1")then
			if(GetPlayerPropertyValue(GetPlayerId(),"Tutorial")==1)then
				CallRemoteEvent("set:tutorial")
			end
			
			ShowMouseCursor(true)
			SetInputMode(INPUT_UI)
			local Helpmenu_GUI=UIDialog()
			Helpmenu_GUI.setTitle("Helpmenu")
			Helpmenu_GUI.appendTo(UIFramework)
			Helpmenu_GUI.setCanClose(true)
			Helpmenu_GUI.setMovable(false)
			Helpmenu_GUI.onClickClose(function(obj)
				obj.destroy()
				SetInputMode(INPUT_GAME)
				SetIgnoreLookInput(false)
				SetIgnoreMoveInput(false)
				ShowMouseCursor(false)
			end)
			
			local text=UIText()
			text.setContent([[
				Hello and Welcome to <span style="color: #ff5000;">Lakeside</span>.<br>
				<span style="color: #ff5000;">Lakeside</span> is a Reallife/Roleplay Project from DorteY.<br>
				You need some help with the Server?<br>
				Then join our Discord https://discord.gg/CSwMYtV
				<br>
				<br>
				Binds:<br><br>
				M - open the MAP<br>
				K - start/stop vehicle engine or open/close trunk<br>
				R - turn on/off vehicleradio (Scroll Up/Down to change the radio)<br>
				P - interact vehicle trunk<br>
				L - turn on/off vehicle lights<br>
				U - lock/unlock vehicle<br>
				E - Interact to ATM<br>
				F2 - open the Spawnmenu<br>
				F3 - open the Animationpanel<br>
				F5 - open the Factionpanel<br>
				_____________________________<br>
				Commands:<br><br>
				/park - park your vehicle<br>
				/pay NAME AMOUNT - to give a user Money<br>
				/t - factionchat<br>
			]])
			text.appendTo(Helpmenu_GUI)
		elseif(key=="F2")then
			ShowMouseCursor(true)
			SetInputMode(INPUT_UI)
			local Selfmenu_GUI=UIDialog()
			Selfmenu_GUI.setTitle("Spawnmenu")
			Selfmenu_GUI.appendTo(UIFramework)
			Selfmenu_GUI.setCanClose(true)
			Selfmenu_GUI.setMovable(false)
			Selfmenu_GUI.onClickClose(function(obj)
				obj.destroy()
				SetInputMode(INPUT_GAME)
				SetIgnoreLookInput(false)
				SetIgnoreMoveInput(false)
				ShowMouseCursor(false)
			end)
			
			local spawnpoint
			local spawnList=UIOptionList()
			spawnList.allowMultiselection(false)
			spawnList.appendOption(0,"Spawn")
			spawnList.appendOption(1,"Current Position")
			if(GetPlayerPropertyValue(GetPlayerId(),"Faction")~="Civilian")then
				spawnList.appendOption(4,"Faction base")
			end
			spawnList.appendTo(Selfmenu_GUI)
			spawnList.onChange(function(obj)
				for _,v in pairs(obj.getValue())do
					spawnpoint=tonumber(v)
				end
			end)
			
			local Button1=UIButton()
			Button1.setTitle("Set spawnpoint")
			Button1.onClick(function()
				if(spawnpoint~="" and spawnpoint~=nil)then
					CallRemoteEvent("set:spawnpoint",spawnpoint)
				end
			end)
			Button1.appendTo(Selfmenu_GUI)
			
		end
	end
end)


AddRemoteEvent("call:atm",function(object)
	AtmIds=object
end)

function GetNearestATM()
	local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedPickups())do
		local x2,y2,z2=GetPickupLocation(v)
		local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<250.0)then
            for _,i in pairs(AtmIds)do
				if(v==i)then
					return v
				end
			end
		end
	end
	return 0
end

AddEvent("OnKeyPress",function(key)
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		if(key==interactKey)then
			local NearestATM=GetNearestATM()
			if(NearestATM~=0)then
				CallRemoteEvent("interact:atm",NearestATM)
			end
		end
	end
end)

local bankmoney
local handmoney
AddRemoteEvent("open:atmUI",function(cash,bank)
    handmoney=cash
	bankmoney=bank
	
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	local ATM_GUI=UIDialog()
	ATM_GUI.setTitle("ATM")
	ATM_GUI.appendTo(UIFramework)
	ATM_GUI.setCanClose(true)
	ATM_GUI.setMovable(false)
	ATM_GUI.onClickClose(function(obj)
        obj.destroy()
		SetInputMode(INPUT_GAME)
		SetIgnoreLookInput(false)
		SetIgnoreMoveInput(false)
		ShowMouseCursor(false)
    end)
	
	local text=UIText()
    text.setContent("Money: $"..handmoney)
    text.appendTo(ATM_GUI)
	
	local text2=UIText()
    text2.setContent("Bankmoney: $"..bankmoney)
    text2.appendTo(ATM_GUI)
	
	local amount=UITextField()
	amount.setPlaceholder("Amount")
	amount.setValue(1)
	amount.appendTo(ATM_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Deposit")
	Button1.onClick(function()
		if(amount.getValue()~="" and amount.getValue()~=nil)then
			CallRemoteEvent("pay:atm","in",amount.getValue())
		else
			MakeNotification("Enter a value!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end)
	Button1.appendTo(ATM_GUI)
	
	local Button2=UIButton()
	Button2.setTitle("Withdraw")
	Button2.onClick(function()
		if(amount.getValue()~="" and amount.getValue()~=nil)then
			CallRemoteEvent("pay:atm","out",amount.getValue())
		else
			MakeNotification("Enter a value!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end)
	Button2.appendTo(ATM_GUI)
end)



local function OnScriptError(message)
	AddPlayerChat(message)
end
AddEvent("OnScriptError",OnScriptError)

AddEvent("OnPlayerDeath",function()
	local clothing=GetPlayerPropertyValue(GetPlayerId(),"Clothing")
	if(clothing~=nil)then
		SetPlayerClothingPreset(GetPlayerId(),clothing)
	end	
end)
AddEvent("OnPlayerSpawn",function()
	local clothing=GetPlayerPropertyValue(GetPlayerId(),"Clothing")
	if(clothing~=nil)then
		SetPlayerClothingPreset(GetPlayerId(),clothing)
	end
end)


function setTimeOfClient(time)
	SetTime(time)
end
AddRemoteEvent("setTimeOfClient",setTimeOfClient)


--//Tutorial
local tutorialBlip
AddRemoteEvent("create:TutorialWaypoint",function(x,y,z)
	tutorialBlip=CreateWaypoint(x,y,z,"Tutorial")
end)
AddRemoteEvent("destroy:TutorialWaypoint",function()
	if(tutorialBlip)then
		DestroyWaypoint(tutorialBlip)
	end
end)