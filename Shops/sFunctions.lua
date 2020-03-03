--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


ShopPedObjectsCached={}
local shopNPCpositions={
	{171080,203658,1417,180},
	{42685,137926,1584,80},
	{-15395,-2771,2065,90},
	{-169073,-39446,1150,80}
}
AddEvent("OnPackageStart",function()
	local NPC={}
	for i,v in pairs(shopNPCpositions)do
		v.NPC=CreateNPC(v[1],v[2],v[3],v[4])
		SetNPCHealth(v.NPC,999999999)
		
		SetNPCPropertyValue(v.NPC,"npc:clothing",14)
		
		CreateText3D("Shop\nPress '"..interactKey.."'",18,v[1],v[2],v[3]+120,0,0,0)
		table.insert(ShopPedObjectsCached,v.NPC)
	end
end)

AddEvent("OnPlayerJoin",function(player)
    CallRemoteEvent(player,"call:shopped",ShopPedObjectsCached)
end)

AddRemoteEvent("interact:shopped",function(player,object)
    local dealer=GetShopPedByObject(object)
	if(dealer)then
		local x,y,z=GetNPCLocation(dealer.NPC)
		local x2,y2,z2=GetPlayerLocation(player)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<200)then
			local cash=GetPlayerPropertyValue(player,"Money")
			CallRemoteEvent(player,"open:shopUI",cash)
		end
	end
end)
function GetShopPedByObject(object)
	for _,v in pairs(shopNPCpositions)do
		if(v.NPC==object)then
			return v
		end
	end
	return nil
end


AddRemoteEvent("buy:item",function(player,item)
	if(item==0)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.burger)then
			if(GetPlayerPropertyValue(player,"Burger")<30)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.burger,true)
				SetPlayerPropertyValue(player,"Burger",GetPlayerPropertyValue(player,"Burger")+1,true)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==6)then
					setTutorialQuests(player)
				end
				
				CallRemoteEvent(player,"MakeNotification","Burger successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Burger!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	elseif(item==1)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.donut)then
			if(GetPlayerPropertyValue(player,"Donut")<30)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.donut,true)
				SetPlayerPropertyValue(player,"Donut",GetPlayerPropertyValue(player,"Donut")+1,true)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==6)then
					setTutorialQuests(player)
				end
				
				CallRemoteEvent(player,"MakeNotification","Donut successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Donut!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	elseif(item==2)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.cola)then
			if(GetPlayerPropertyValue(player,"Cola")<30)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.cola,true)
				SetPlayerPropertyValue(player,"Cola",GetPlayerPropertyValue(player,"Cola")+1,true)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==6)then
					setTutorialQuests(player)
				end
				
				CallRemoteEvent(player,"MakeNotification","Cola successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Cola!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	elseif(item==3)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.sprite)then
			if(GetPlayerPropertyValue(player,"Sprite")<50)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.sprite,true)
				SetPlayerPropertyValue(player,"Sprite",GetPlayerPropertyValue(player,"Sprite")+1,true)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==6)then
					setTutorialQuests(player)
				end
				
				CallRemoteEvent(player,"MakeNotification","Sprite successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Sprite!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	elseif(item==5)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.repairkit)then
			if(GetPlayerPropertyValue(player,"Repairkit")<4)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.repairkit,true)
				SetPlayerPropertyValue(player,"Repairkit",GetPlayerPropertyValue(player,"Repairkit")+1,true)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==6)then
					setTutorialQuests(player)
				end
				
				CallRemoteEvent(player,"MakeNotification","Repairkit successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You cannot own more than x4 Repairkit!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	elseif(item==6)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.fuelcan)then
			if(GetPlayerPropertyValue(player,"Fuelcan")<2)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.fuelcan,true)
				SetPlayerPropertyValue(player,"Fuelcan",GetPlayerPropertyValue(player,"Fuelcan")+1,true)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==6)then
					setTutorialQuests(player)
				end
				
				CallRemoteEvent(player,"MakeNotification","Fuelcan successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You cannot own more than x2 Fuelcan!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	end
end)