--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local FactionDepotIds
AddRemoteEvent("call:factiondepot",function(object)
    FactionDepotIds=object
end)

function GetNearestFactiondepotPed()
    local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedNPC())do
        local x2,y2,z2=GetNPCLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<150.0)then
            for _,i in pairs(FactionDepotIds)do
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
        local NearestFactiondepotPed=GetNearestFactiondepotPed()
        if(NearestFactiondepotPed~=0)then
            CallRemoteEvent("interact:factiondepot",NearestFactiondepotPed)       
		end
	end
end)

local facmoney
local facweed
local facmats
AddRemoteEvent("open:depotUI",function(typ,money,weed,mats)
	facmoney=tonumber(money)
	facweed=tonumber(weed)
	facmats=tonumber(mats)
	if(typ=="Faction")then
		ShowMouseCursor(true)
		if(Depot_GUI)then
			Depot_GUI.destroy()
		end
		SetInputMode(INPUT_UI)
		Depot_GUI=UIDialog()
		Depot_GUI.setTitle("Factiondepot ("..GetPlayerPropertyValue(GetPlayerId(),"Faction")..")")
		Depot_GUI.appendTo(UIFramework)
		Depot_GUI.setCanClose(true)
		Depot_GUI.setMovable(false)
		Depot_GUI.onClickClose(function(obj)
			obj.hide()
			SetInputMode(INPUT_GAME)
			SetIgnoreLookInput(false)
			SetIgnoreMoveInput(false)
			ShowMouseCursor(false)
		end)
		
		local text=UIText()
		text.setContent("Depot stats")
		text.appendTo(Depot_GUI)
		local text2=UIText()
		text2.setContent("Money: $"..facmoney.." Weed: x"..facweed.." Mats: x"..facmats)
		text2.appendTo(Depot_GUI)
		
		local moneytextfield=UITextField()
		moneytextfield.setPlaceholder("Money")
		moneytextfield.appendTo(Depot_GUI)
		local weedtextfield=UITextField()
		weedtextfield.setPlaceholder("Weed")
		weedtextfield.appendTo(Depot_GUI)
		local matstextfield=UITextField()
		matstextfield.setPlaceholder("Mats")
		matstextfield.appendTo(Depot_GUI)
		
		local Button1=UIButton()
		Button1.setTitle("pay in")
		Button1.setType("primary")
		Button1.onClick(function()
			if(matstextfield.getValue()~="" and matstextfield.getValue()~=nil)then
				CallRemoteEvent("payin_payout:factionitems","pay:in","Mats",matstextfield.getValue())
			end
			if(weedtextfield.getValue()~="" and weedtextfield.getValue()~=nil)then
				CallRemoteEvent("payin_payout:factionitems","pay:in","Weed",weedtextfield.getValue())
			end
			if(moneytextfield.getValue()~="" and moneytextfield.getValue()~=nil)then
				CallRemoteEvent("payin_payout:factionitems","pay:in","Money",moneytextfield.getValue())
			end
		end)
		Button1.appendTo(Depot_GUI)
		local Button2=UIButton()
		Button2.setTitle("pay out")
		Button2.setType("secondary")
		Button2.onClick(function()
			if(matstextfield.getValue()~="" and matstextfield.getValue()~=nil)then
				CallRemoteEvent("payin_payout:factionitems","pay:out","Mats",matstextfield.getValue())
			end
			if(weedtextfield.getValue()~="" and weedtextfield.getValue()~=nil)then
				CallRemoteEvent("payin_payout:factionitems","pay:out","Weed",weedtextfield.getValue())
			end
			if(moneytextfield.getValue()~="" and moneytextfield.getValue()~=nil)then
				CallRemoteEvent("payin_payout:factionitems","pay:out","Money",moneytextfield.getValue())
			end
		end)
		Button2.appendTo(Depot_GUI)
	elseif(typ=="Company")then
		--todo
	end
end)


local FactionWeaponDepotIds
AddRemoteEvent("call:factionweapondepot",function(object)
    FactionWeaponDepotIds=object
end)

function GetNearestFactionWeapondepotPed()
    local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedNPC())do
        local x2,y2,z2=GetNPCLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<150.0)then
            for _,i in pairs(FactionWeaponDepotIds)do
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
        local NearestFactiondepotPed=GetNearestFactionWeapondepotPed()
        if(NearestFactiondepotPed~=0)then
            CallRemoteEvent("interact:factionweapondepot",NearestFactiondepotPed)       
		end
	end
end)

AddRemoteEvent("open:weapondepotUI",function()
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	Weapondepot_GUI=UIDialog()
	Weapondepot_GUI.setTitle("Weapondepot ("..GetPlayerPropertyValue(GetPlayerId(),"Faction")..")")
	Weapondepot_GUI.appendTo(UIFramework)
	Weapondepot_GUI.setCanClose(true)
	Weapondepot_GUI.setMovable(false)
	Weapondepot_GUI.onClickClose(function(obj)
		obj.destroy()
		SetInputMode(INPUT_GAME)
		SetIgnoreLookInput(false)
		SetIgnoreMoveInput(false)
		ShowMouseCursor(false)
	end)
	
	local item
	local itemList=UIOptionList()
	itemList.allowMultiselection(false)
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Factionrank"))==0)then
		itemList.appendOption(1,"Pistol01 Mats(x"..prices.faction.shop.weapon.Pistol01..") Ammo(x"..prices.faction.shop.weapon.ammo.Pistol01..")")
	elseif(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Factionrank"))==1)then
		itemList.appendOption(2,"Pistol04 Mats(x"..prices.faction.shop.weapon.Pistol04..") Ammo(x"..prices.faction.shop.weapon.ammo.Pistol04..")")
	elseif(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Factionrank"))==2)then
		itemList.appendOption(2,"Pistol04 Mats(x"..prices.faction.shop.weapon.Pistol04..") Ammo(x"..prices.faction.shop.weapon.ammo.Pistol04..")")
		itemList.appendOption(3,"SMG02 Mats(x"..prices.faction.shop.weapon.SMG02..") Ammo(x"..prices.faction.shop.weapon.ammo.SMG02..")")
	elseif(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Factionrank"))==3)then
		itemList.appendOption(2,"Pistol04 Mats(x"..prices.faction.shop.weapon.Pistol04..") Ammo(x"..prices.faction.shop.weapon.ammo.Pistol04..")")
		itemList.appendOption(4,"SMG03 Mats(x"..prices.faction.shop.weapon.SMG03..") Ammo(x"..prices.faction.shop.weapon.ammo.SMG03..")")
	elseif(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Factionrank"))==4)then
		itemList.appendOption(2,"Pistol04 Mats(x"..prices.faction.shop.weapon.Pistol04..") Ammo(x"..prices.faction.shop.weapon.ammo.Pistol04..")")
		itemList.appendOption(4,"SMG03 Mats(x"..prices.faction.shop.weapon.SMG03..") Ammo(x"..prices.faction.shop.weapon.ammo.SMG03..")")
		itemList.appendOption(5,"Rifle01 Mats(x"..prices.faction.shop.weapon.Rifle01..") Ammo(x"..prices.faction.shop.weapon.ammo.Rifle01..")")
	elseif(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Factionrank"))==5)then
		itemList.appendOption(2,"Pistol04 Mats(x"..prices.faction.shop.weapon.Pistol04..") Ammo(x"..prices.faction.shop.weapon.ammo.Pistol04..")")
		itemList.appendOption(4,"SMG03 Mats(x"..prices.faction.shop.weapon.SMG03..") Ammo(x"..prices.faction.shop.weapon.ammo.SMG03..")")
		itemList.appendOption(6,"Rifle04 Mats(x"..prices.faction.shop.weapon.Rifle04..") Ammo(x"..prices.faction.shop.weapon.ammo.Rifle04..")")
	end
	itemList.appendTo(Weapondepot_GUI)
	itemList.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			item=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Buy item")
	Button1.onClick(function()
		CallRemoteEvent("buy:facweapon",item)
	end)
	Button1.appendTo(Weapondepot_GUI)
end)