--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local NormalShopIds
AddRemoteEvent("call:shopped",function(object)
    NormalShopIds=object
end)

function GetNearestShopPed()
    local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedNPC())do
        local x2,y2,z2=GetNPCLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<200.0)then
            for _,i in pairs(NormalShopIds)do
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
        local NearestShopPed=GetNearestShopPed()
        if(NearestShopPed~=0)then
            CallRemoteEvent("interact:shopped",NearestShopPed)       
		end
	end
end)

local handmoney
AddRemoteEvent("open:shopUI",function(cash)
	local handmoney=cash
	
	if(Shop_GUI)then
		Shop_GUI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	Shop_GUI=UIDialog()
	Shop_GUI.setTitle("Shop")
	Shop_GUI.appendTo(UIFramework)
	Shop_GUI.setCanClose(true)
	Shop_GUI.setMovable(false)
	Shop_GUI.onClickClose(function(obj)
		obj.hide()
		disableShopUIFuncs()
	end)
	
	local text=UIText()
	text.setContent("Here you can buy items.")
	text.appendTo(Shop_GUI)
	
	local text2=UIText()
	text2.setContent("Money: $"..handmoney)
	text2.appendTo(Shop_GUI)
	
	local item
	local shopList=UIOptionList()
	shopList.allowMultiselection(false)
	shopList.appendOption(0,"Burger ($"..prices.shop.burger..")")
	shopList.appendOption(1,"Donut ($"..prices.shop.donut..")")
	shopList.appendOption(2,"Cola ($"..prices.shop.cola..")")
	shopList.appendOption(3,"Sprite ($"..prices.shop.sprite..")")
	shopList.appendOption(5,"Repairkit ($"..prices.shop.repairkit..")")
	shopList.appendOption(6,"Fuelcan ($"..prices.shop.fuelcan..")")
	shopList.appendTo(Shop_GUI)
	shopList.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			item=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Buy item")
	Button1.onClick(function()
		CallRemoteEvent("buy:item",item)
	end)
	Button1.appendTo(Shop_GUI)
end)

function disableShopUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end


local function OnNPCStreamIn(npc)
	local clothing=GetNPCPropertyValue(npc,"npc:clothing")
	if(clothing~=nil)then
		SetNPCClothingPreset(npc,clothing)
	end
end
AddEvent("OnNPCStreamIn",OnNPCStreamIn)