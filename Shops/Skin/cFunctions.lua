--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local handmoney
AddRemoteEvent("Open->Hair->Shop->UI",function(cash)
	local handmoney=cash
	
	if(HairShop_UI)then
		HairShop_UI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	HairShop_UI=UIDialog()
	HairShop_UI.setTitle("Hair")
	HairShop_UI.appendTo(UIFramework)
	HairShop_UI.setCanClose(true)
	HairShop_UI.setMovable(false)
	local gender=GetPlayerPropertyValue(GetPlayerId(),"Gender")
	HairShop_UI.onClickClose(function(obj)
		obj.hide()
		disableHairShopUIFuncs()
		local sk=GetPlayerSkeletalMeshComponent(GetPlayerId(),"Clothing0");
		sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(PlayerHairModels[tostring(gender)][tonumber(GetPlayerPropertyValue(GetPlayerId(),"ClothingHair"))]));
	end)
	
	local text=UIText()
	text.setContent("Money: $"..handmoney)
	text.appendTo(HairShop_UI)
	
	local item
	local skinList=UIOptionList()
	skinList.allowMultiselection(false)
	if(gender=="Female")then
		skinList.appendOption(0,"Haare 1")
		skinList.appendOption(1,"Haare 2")
		skinList.appendOption(2,"Haare 3")
	elseif(gender=="Male")then
		skinList.appendOption(0,"Haare 1")
		skinList.appendOption(1,"Haare 2")
		skinList.appendOption(2,"Haare 3")
		skinList.appendOption(3,"Haare 4")
		skinList.appendOption(4,"Haare 5")
	end
	skinList.appendTo(HairShop_UI)
	skinList.onChange(function(obj)
		for _,v in ipairs(obj.getValue())do
			item=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Buy selected hair")
	Button1.onClick(function()
		if(item~="" and item~=nil)then
			CallRemoteEvent("Buy->Char->Item","Hair",item)
		end
	end)
	Button1.appendTo(HairShop_UI)
	
	local Button2=UIButton()
	Button2.setTitle("Preview selected hair")
	Button2.onClick(function()
		if(item~="" and item~=nil)then
			local sk=GetPlayerSkeletalMeshComponent(GetPlayerId(),"Clothing0");
			sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(PlayerHairModels[gender][item]));
		end
	end)
	Button2.appendTo(HairShop_UI)
end)
function disableHairShopUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end

local handmoney
AddRemoteEvent("Open->Outfit->Shop->UI",function(cash)
	local handmoney=cash
	
	if(ClothingShop_UI)then
		ClothingShop_UI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	ClothingShop_UI=UIDialog()
	ClothingShop_UI.setTitle("Outfits")
	ClothingShop_UI.appendTo(UIFramework)
	ClothingShop_UI.setCanClose(true)
	ClothingShop_UI.setMovable(false)
	local gender=GetPlayerPropertyValue(GetPlayerId(),"Gender")
	ClothingShop_UI.onClickClose(function(obj)
		obj.hide()
		disableClothingShopUIFuncs()
		local sk=GetPlayerSkeletalMeshComponent(GetPlayerId(),"Clothing1");
		sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(PlayerClothingModels[tostring(gender)][tonumber(GetPlayerPropertyValue(GetPlayerId(),"ClothingTyp"))]));
	end)
	
	local text=UIText()
	text.setContent("Money: $"..handmoney)
	text.appendTo(ClothingShop_UI)
	
	local item
	local skinList=UIOptionList()
	skinList.allowMultiselection(false)
	if(gender=="Female")then
		skinList.appendOption(0,"Outfit 1")
		skinList.appendOption(1,"Outfit 2")
		skinList.appendOption(2,"Outfit 3")
		skinList.appendOption(3,"Outfit 4")
		skinList.appendOption(4,"Outfit 5")
		skinList.appendOption(5,"Outfit 6")
	elseif(gender=="Male")then
		skinList.appendOption(0,"Outfit 1")
	end
	skinList.appendTo(ClothingShop_UI)
	skinList.onChange(function(obj)
		for _,v in ipairs(obj.getValue())do
			item=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Buy selected Outfit")
	Button1.onClick(function()
		if(item~="" and item~=nil)then
			CallRemoteEvent("Buy->Char->Item","Outfit",item)
		end
	end)
	Button1.appendTo(ClothingShop_UI)
	
	local Button2=UIButton()
	Button2.setTitle("Preview selected Outfit")
	Button2.onClick(function()
		if(item~="" and item~=nil)then
			local sk=GetPlayerSkeletalMeshComponent(GetPlayerId(),"Clothing1");
			sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(PlayerClothingModels[gender][item]));
		end
	end)
	Button2.appendTo(ClothingShop_UI)
end)
function disableClothingShopUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end





--//New clothing funcs
AddRemoteEvent("Sync->Client->Clothing",function(player,typ,typ2)
	if(typ=="Body")then
		local sk=GetPlayerSkeletalMeshComponent(player,"Body");
		sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(typ2));
		sk:SetColorParameterOnMaterials("Skin Color",FLinearColor(1.0,1.0,1.0,1));
	end
	if(typ=="Hair")then
		local sk=GetPlayerSkeletalMeshComponent(player,"Clothing0");
		sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(typ2))
	end
	if(typ=="Outfit")then
		local sk=GetPlayerSkeletalMeshComponent(player,"Clothing1");
		sk:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(typ2))
	end
end)


--[[AddEvent("OnPlayerStreamIn", function( player, otherplayer )
    CallRemoteEvent("ServerChangeOtherPlayerClothes", player, otherplayer)
end)]]