--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local SkinShopMarker={
	[1]=CreatePickup(340,207923,175828,1260)
}
for i=1,#SkinShopMarker do
	SetPickupPropertyValue(SkinShopMarker[i],"shop:skin",true)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(not IsPlayerInVehicle(player))then
		if(GetPickupPropertyValue(Marker,"shop:skin")==true)then
			local cash=GetPlayerPropertyValue(player,"Money")
			CallRemoteEvent(player,"open:skinshopUI",cash)
		end
	end
end)


AddRemoteEvent("preview:skin",function(player,skin)
	if(skin==0)then
		SetPlayerPropertyValue(player,"test:clothing",1)
	elseif(skin==1)then
		SetPlayerPropertyValue(player,"test:clothing",2)
	elseif(skin==2)then
		SetPlayerPropertyValue(player,"test:clothing",3)
	elseif(skin==3)then
		SetPlayerPropertyValue(player,"test:clothing",4)
	elseif(skin==4)then
		SetPlayerPropertyValue(player,"test:clothing",5)
	elseif(skin==6)then
		SetPlayerPropertyValue(player,"test:clothing",7)
	end
end)
AddRemoteEvent("buy:skin",function(player,skin)
	if(skin==0)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.skins.skin1)then
			SetPlayerPropertyValue(player,"Clothing",1)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.skins.skin1,true)
		end
	elseif(skin==1)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.skins.skin2)then
			SetPlayerPropertyValue(player,"Clothing",2)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.skins.skin2,true)
		end
	elseif(skin==2)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.skins.skin3)then
			SetPlayerPropertyValue(player,"Clothing",3)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.skins.skin3,true)
		end
	elseif(skin==3)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.skins.skin4)then
			SetPlayerPropertyValue(player,"Clothing",4)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.skins.skin4,true)
		end
	elseif(skin==4)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.skins.skin5)then
			SetPlayerPropertyValue(player,"Clothing",5)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.skins.skin5,true)
		end
	elseif(skin==6)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.skins.skin7)then
			SetPlayerPropertyValue(player,"Clothing",7)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.skins.skin7,true)
		end
	end
end)