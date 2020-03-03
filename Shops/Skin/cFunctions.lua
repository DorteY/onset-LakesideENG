--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local handmoney

AddRemoteEvent("open:skinshopUI",function(cash)
	local handmoney=cash
	
	if(SkinShop_GUI)then
		SkinShop_GUI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	SkinShop_GUI=UIDialog()
	SkinShop_GUI.setTitle("Skin Shop")
	SkinShop_GUI.appendTo(UIFramework)
	SkinShop_GUI.setCanClose(true)
	SkinShop_GUI.setMovable(false)
	SkinShop_GUI.onClickClose(function(obj)
		obj.hide()
		disableSkinShopUIFuncs()
		SetPlayerClothingPreset(GetPlayerId(),GetPlayerPropertyValue(GetPlayerId(),"Clothing"))
	end)
	
	local text=UIText()
	text.setContent("Here you can buy a skin.")
	text.appendTo(SkinShop_GUI)
	
	local text2=UIText()
	text2.setContent("Money: $"..handmoney)
	text2.appendTo(SkinShop_GUI)
	
	local item
	local skinList=UIOptionList()
	skinList.allowMultiselection(false)
	skinList.appendOption(0,"Skin 1 ($"..prices.shop.skins.skin1..")")
	skinList.appendOption(1,"Skin 2 ($"..prices.shop.skins.skin2..")")
	skinList.appendOption(2,"Skin 3 ($"..prices.shop.skins.skin3..")")
	skinList.appendOption(3,"Skin 4 ($"..prices.shop.skins.skin4..")")
	skinList.appendOption(4,"Skin 5 ($"..prices.shop.skins.skin5..")")
	skinList.appendOption(6,"Skin 7 ($"..prices.shop.skins.skin7..")")
	skinList.appendTo(SkinShop_GUI)
	skinList.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			item=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Buy selected skin")
	Button1.onClick(function()
		if(item~="" and item~=nil)then
			CallRemoteEvent("buy:skin",item)
			SetPlayerClothingPreset(GetPlayerId(),GetPlayerPropertyValue(GetPlayerId(),"Clothing"))
		end
	end)
	Button1.appendTo(SkinShop_GUI)
	
	local Button2=UIButton()
	Button2.setTitle("Preview selected skin")
	Button2.onClick(function()
		if(item~="" and item~=nil)then
			CallRemoteEvent("preview:skin",item)
		end
	end)
	Button2.appendTo(SkinShop_GUI)
end)

function disableSkinShopUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end

function OnPlayerNetworkUpdatePropertyValue(player,index,value)
	if(index=="test:clothing")then
		SetPlayerClothingPreset(player,value)
	end
end
AddEvent("OnPlayerNetworkUpdatePropertyValue",OnPlayerNetworkUpdatePropertyValue)