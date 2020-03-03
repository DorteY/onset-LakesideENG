--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local WeaponDealerIds
AddRemoteEvent("call:weapondealer",function(object)
    WeaponDealerIds=object
end)

function GetNearestWDealer()
    local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedNPC())do
        local x2,y2,z2=GetNPCLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<200.0)then
            for _,i in pairs(WeaponDealerIds)do
				if(v==i)then
					return v
				end
			end
		end
	end
	return 0
end

AddEvent("OnKeyPress",function(key)
    if(key=="E")then
        local NearestWeaponDealer=GetNearestWDealer()
        if(NearestWeaponDealer~=0)then
            CallRemoteEvent("interact:weapondealer",NearestWeaponDealer)       
		end
	end
end)

AddRemoteEvent("open:weaponshopUI",function()
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	local Weaponshop_GUI=UIDialog()
	Weaponshop_GUI.setTitle("Ammunation (Weaponshop)")
	Weaponshop_GUI.appendTo(UIFramework)
	Weaponshop_GUI.setCanClose(true)
	Weaponshop_GUI.setMovable(false)
	Weaponshop_GUI.onClickClose(function(obj)
        obj.destroy()
		SetInputMode(INPUT_GAME)
		SetIgnoreLookInput(false)
		SetIgnoreMoveInput(false)
		ShowMouseCursor(false)
    end)
	
	
	local item
	local itemList=UIOptionList()
	itemList.allowMultiselection(false)
	itemList.appendOption(0,"Pistol01 ($"..prices.shop.weapon.Pistol01..") Ammo(x"..prices.shop.weapon.ammo.Pistol01..")")
	itemList.appendOption(1,"Pistol02 ($"..prices.shop.weapon.Pistol02..") Ammo(x"..prices.shop.weapon.ammo.Pistol02..")")
	itemList.appendOption(2,"Pistol04 ($"..prices.shop.weapon.Pistol04..") Ammo(x"..prices.shop.weapon.ammo.Pistol04..")")
	itemList.appendOption(3,"Shotgun01 ($"..prices.shop.weapon.Shotgun01..") Ammo(x"..prices.shop.weapon.ammo.Shotgun01..")")
	itemList.appendOption(4,"Shotgun02 ($"..prices.shop.weapon.Shotgun02..") Ammo(x"..prices.shop.weapon.ammo.Shotgun02..")")
	itemList.appendOption(5,"SMG01 ($"..prices.shop.weapon.SMG01..") Ammo(x"..prices.shop.weapon.ammo.SMG01..")")
	itemList.appendOption(6,"SMG02 ($"..prices.shop.weapon.SMG02..") Ammo(x"..prices.shop.weapon.ammo.SMG02..")")
	itemList.appendOption(7,"SMG03 ($"..prices.shop.weapon.SMG03..") Ammo(x"..prices.shop.weapon.ammo.SMG03..")")
	itemList.appendOption(8,"M4 ($"..prices.shop.weapon.Rifle01..") Ammo(x"..prices.shop.weapon.ammo.Rifle01..")")
	itemList.appendOption(9,"AK-47 ($"..prices.shop.weapon.Rifle02..") Ammo(x"..prices.shop.weapon.ammo.Rifle02..")")
	itemList.appendOption(10,"Rifle03 ($"..prices.shop.weapon.Rifle03..") Ammo(x"..prices.shop.weapon.ammo.Rifle03..")")
	itemList.appendOption(11,"Rifle05 ($"..prices.shop.weapon.Rifle05..") Ammo(x"..prices.shop.weapon.ammo.Rifle05..")")
	itemList.appendOption(12,"Rifle07 ($"..prices.shop.weapon.Rifle07..") Ammo(x"..prices.shop.weapon.ammo.Rifle07..")")
	itemList.appendOption(13,"Sniper ($"..prices.shop.weapon.Sniper01..") Ammo(x"..prices.shop.weapon.ammo.Sniper01..")")
	itemList.appendOption(18,"Armor ($"..prices.shop.weapon.Armor..") Ammo(x1)")
	itemList.appendTo(Weaponshop_GUI)
	itemList.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			item=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Buy selected item/weapon")
	Button1.onClick(function()
		if(item~="" and item~=nil)then
			CallRemoteEvent("buy:weapon",item)
		end
	end)
	Button1.appendTo(Weaponshop_GUI)
end)