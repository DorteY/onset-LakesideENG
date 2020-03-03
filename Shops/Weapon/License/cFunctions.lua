--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local GunlicensePedIds
AddRemoteEvent("call:gunlicense",function(object)
    GunlicensePedIds=object
end)

function GetNearestGunlicensePed()
    local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedNPC())do
        local x2,y2,z2=GetNPCLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<130.0)then
            for _,i in pairs(GunlicensePedIds)do
				if(v==i)then
					return v
				end
			end
		end
	end
	return 0
end

AddEvent("OnKeyPress",function(key)
    if(key==interactKey)then
        local NearstGunlicensePed=GetNearestGunlicensePed()
        if(NearstGunlicensePed~=0)then
            CallRemoteEvent("interact:gunlicense",NearstGunlicensePed)       
		end
	end
end)


local count=0
AddRemoteEvent("open:gunlicenseUI",function()
	count=0
	if(Gunlicense_GUI)then
		Gunlicense_GUI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	Gunlicense_GUI=UIDialog()
	Gunlicense_GUI.setTitle("Gunlicense test")
	Gunlicense_GUI.appendTo(UIFramework)
	Gunlicense_GUI.setCanClose(true)
	Gunlicense_GUI.setMovable(false)
	Gunlicense_GUI.onClickClose(function(obj)
		obj.hide()
		disableGunlicenseUIFuncs()
	end)
	
	local text=UIText()
	text.setContent("Here you start a Gunlicense test.")
	text.appendTo(Gunlicense_GUI)
	
	local text2=UIText()
	text2.setContent("WARNING: You need $"..prices.shop.weapon.gunlicense.." to buy after the test the license!")
	text2.appendTo(Gunlicense_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Start Gunlicense test ($500)")
	Button1.onClick(function()
		--disableGunlicenseUIFuncs()
		CallRemoteEvent("start:gunlicense:test")
	end)
	Button1.appendTo(Gunlicense_GUI)
end)

AddRemoteEvent("trigger:gunlicenseQuestionUI",function()
	count=count+1
	if(Gunlicense_GUI)then
		Gunlicense_GUI.destroy()
	end
	
	Gunlicense_GUI=UIDialog()
	if(count>=0 and count <=3)then
		Gunlicense_GUI.setTitle("Gunlicense test ("..count..")")
	else
		Gunlicense_GUI.setTitle("Gunlicense")
	end
	Gunlicense_GUI.appendTo(UIFramework)
	Gunlicense_GUI.setCanClose(true)
	Gunlicense_GUI.setMovable(false)
	Gunlicense_GUI.onClickClose(function(obj)
		obj.hide()
		disableGunlicenseUIFuncs()
		count=0
	end)
	
	local text=UIText()
	if(count==1)then
		text.setContent("When may you own a gun?")
	elseif(count==2)then
		text.setContent("When can I use weapons?")
	elseif(count==3)then
		text.setContent("What do you do if you find a weapon that is not registered?")
	end
	text.appendTo(Gunlicense_GUI)
	
	local item
	if(count>=0 and count<=3)then
		local list=UIOptionList()
		list.allowMultiselection(false)
		if(count==1)then
			list.appendOption(0,"If you have a gun license and the gun was obtained legally.")
			list.appendOption(1,"There are no laws.")
			list.appendOption(2,"If you feel like it.")
		elseif(count==2)then
			list.appendOption(0,"When you get jostled.")
			list.appendOption(1,"When you are threatened.")
			list.appendOption(2,"If you feel like it.")
		elseif(count==3)then
			list.appendOption(0,"Keep them and shoot up the ammunition.")
			list.appendOption(1,"Take her to the police.")
			list.appendOption(2,"Nothing.")
		end
		list.appendTo(Gunlicense_GUI)
		list.onChange(function(obj)
			for _,v in pairs(obj.getValue())do
				item=tonumber(v)
			end
		end)
	end
	
	if(count>=0 and count<=3)then
		local Button1=UIButton()
		Button1.setTitle("Next question")
		Button1.onClick(function()
			if(item~="" and item~=nil)then
				CallRemoteEvent("next:gunlicense:test",item,count)
			end
		end)
		Button1.appendTo(Gunlicense_GUI)
	else
		local Button1=UIButton()
		Button1.setTitle("Buy Weaponlicense ($"..prices.shop.weapon.gunlicense..")")
		Button1.onClick(function()
			CallRemoteEvent("buy:gunlicense")
			disableGunlicenseUIFuncs()
			Gunlicense_GUI.hide()
			count=0
		end)
		Button1.appendTo(Gunlicense_GUI)
	end
end)

AddRemoteEvent("destroy:gunlicenseQuestionUI",function()
	disableGunlicenseUIFuncs()
	Gunlicense_GUI.hide()
end)

function disableGunlicenseUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end