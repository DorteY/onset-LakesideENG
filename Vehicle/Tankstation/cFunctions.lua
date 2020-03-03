--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local handmoney
local litermoney
local vehliters

local function openTankstationUIFunc(cash,literprice,liters)
    handmoney=tonumber(cash)
    litermoney=literprice
    vehliters=tonumber(liters)
	
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	Tankstation_GUI=UIDialog()
	Tankstation_GUI.setTitle("Tankstation")
	Tankstation_GUI.appendTo(UIFramework)
	Tankstation_GUI.setCanClose(true)
	Tankstation_GUI.setMovable(false)
	Tankstation_GUI.onClickClose(function(obj)
		obj.destroy()
		SetInputMode(INPUT_GAME)
		SetIgnoreLookInput(false)
		SetIgnoreMoveInput(false)
		ShowMouseCursor(false)
	end)
	
	local text=UIText()
	text.setContent("Money: $"..handmoney)
	text.appendTo(Tankstation_GUI)
	
	local text2=UIText()
	text2.setContent("Liter price: $"..litermoney)
	text2.appendTo(Tankstation_GUI)
	
	local text3=UIText()
	text3.setContent("Vehicle liters: "..vehliters)
	text3.appendTo(Tankstation_GUI)
	
	local amount=UITextField()
	amount.setPlaceholder("Amount (liters)")
	amount.setValue(1)
	amount.appendTo(Tankstation_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Full")
	Button1.onClick(function()
		if(amount.getValue()~="")then
			CallRemoteEvent("tank:vehicle","full",_)
		end
	end)
	Button1.appendTo(Tankstation_GUI)
	
	local Button2=UIButton()
	Button2.setTitle("Liters")
	Button2.onClick(function()
		if(amount.getValue()~="")then
			CallRemoteEvent("tank:vehicle","liters",amount.getValue())
		end
	end)
	Button2.appendTo(Tankstation_GUI)
end
AddRemoteEvent("open:tankstationUI",openTankstationUIFunc)