--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local HairShopMarker={
	[1]=CreatePickup(340,208221,180323,1260),
}

local OutfitShopMarker={
	[1]=CreatePickup(340,207575,180323,1260),
}

for i=1,#HairShopMarker do
	SetPickupPropertyValue(HairShopMarker[i],"Pickup->Typ->Hair",true)
end
for i=1,#OutfitShopMarker do
	SetPickupPropertyValue(OutfitShopMarker[i],"Pickup->Typ->Outfit",true)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(not(IsPlayerInVehicle(player)))then
		if(GetPickupPropertyValue(Marker,"Pickup->Typ->Hair")==true)then
			local cash=GetPlayerPropertyValue(player,"Money")
			CallRemoteEvent(player,"Open->Hair->Shop->UI",cash)
		elseif(GetPickupPropertyValue(Marker,"Pickup->Typ->Outfit")==true)then
			local cash=GetPlayerPropertyValue(player,"Money")
			CallRemoteEvent(player,"Open->Outfit->Shop->UI",cash)
		end
	end
end)


--//New clothing funcs
AddRemoteEvent("Buy->Char->Item",function(player,typ,typ2)
	local gender=tostring(GetPlayerPropertyValue(player,"Gender"))
	if(typ=="Hair")then
		SetPlayerPropertyValue(player,"ClothingHair",tonumber(typ2))
		CallRemoteEvent(player,"Sync->Client->Clothing",player,"Hair",PlayerHairModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingHair"))]);
		CallRemoteEvent(player,"MakeNotification","Hair successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
		
		UpdateClothes(player)
	end
	if(typ=="Outfit")then
		SetPlayerPropertyValue(player,"ClothingOutfit",tonumber(typ2))
		CallRemoteEvent(player,"Sync->Client->Clothing",player,"Outfit",PlayerClothingModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingOutfit"))]);
		CallRemoteEvent(player,"MakeNotification","Outfit successfully bought!","linear-gradient(to right, #00b09b, #96c93d)")
		
		UpdateClothes(player)
	end
end)


function UpdateClothes(player)
	if(PlayerBodyModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingBody"))])then
		CallRemoteEvent(player,"Sync->Client->Clothing",player,"Body",PlayerBodyModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingBody"))]);
	else
		AddPlayerChat(player,"ERROR: #09312")
	end
	
	if(PlayerHairModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingHair"))])then
		CallRemoteEvent(player,"Sync->Client->Clothing",player,"Hair",PlayerHairModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingHair"))]);
	else
		AddPlayerChat(player,"ERROR: #97522")
	end
	
	if(PlayerClothingModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingOutfit"))])then
		CallRemoteEvent(player,"Sync->Client->Clothing",player,"Outfit",PlayerClothingModels[tostring(GetPlayerPropertyValue(player,"Gender"))][tonumber(GetPlayerPropertyValue(player,"ClothingOutfit"))]);
	else
		AddPlayerChat(player,"ERROR: #58992")
	end
end
AddRemoteEvent("Sync->Server->Clothing",UpdateClothes)

function UpdateClothesAllPlayers(player,target)

end