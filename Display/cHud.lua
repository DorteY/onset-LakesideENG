--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local VehicleHud
local HealthHud
local ArmorHud
local HungerHud
local ThirstHud
local MoneyHud

personalMenuIsOpen=1

local function OnPackageStart()
	ShowHealthHUD(false)
	
	VehicleHud=CreateWebUI(0.0,0.0,0.0,0.0,9,31)
	LoadWebFile(VehicleHud,"http://asset/"..GetPackageName().."/Files/Hud/Speedo/index.html")
	SetWebAlignment(VehicleHud,1.0,0.0)
	SetWebAnchors(VehicleHud,0.0,0.0,1.0,1.0)
    SetWebVisibility(VehicleHud,WEB_HIDDEN)
	
	ArmorHud=CreateWebUI(0.0,0.0,0.0,0.0,9,32)
	SetWebAlignment(ArmorHud,1.0,0.0)
	SetWebAnchors(ArmorHud,0.0,0.0,1.0,1.0) 
	LoadWebFile(ArmorHud,"http://asset/"..GetPackageName().."/Files/Hud/armor.html")
    SetWebVisibility(ArmorHud,WEB_HITINVISIBLE)
	
	HealthHud=CreateWebUI(0.0,0.0,0.0,0.0,9,32)
	SetWebAlignment(HealthHud,1.0,0.0)
	SetWebAnchors(HealthHud,0.0,0.0,1.0,1.0) 
	LoadWebFile(HealthHud,"http://asset/"..GetPackageName().."/Files/Hud/health.html")
    SetWebVisibility(HealthHud,WEB_HITINVISIBLE)
	
	HungerHud=CreateWebUI(0.0,0.0,0.0,0.0,9,32)
	SetWebAlignment(HungerHud,1.0,0.0)
	SetWebAnchors(HungerHud,0.0,0.0,1.0,1.0) 
	LoadWebFile(HungerHud,"http://asset/"..GetPackageName().."/Files/Hud/hunger.html")
    SetWebVisibility(HungerHud,WEB_HITINVISIBLE)
	
	ThirstHud=CreateWebUI(0.0,0.0,0.0,0.0,9,32)
	SetWebAlignment(ThirstHud,1.0,0.0)
	SetWebAnchors(ThirstHud,0.0,0.0,1.0,1.0) 
	LoadWebFile(ThirstHud,"http://asset/"..GetPackageName().."/Files/Hud/thirst.html")
    SetWebVisibility(ThirstHud,WEB_HITINVISIBLE)
	
	MoneyHud=CreateWebUI(0.0,0.0,0.0,0.0,9,32)
	SetWebAlignment(MoneyHud,1.0,0.0)
	SetWebAnchors(MoneyHud,0.0,0.0,1.0,1.0) 
	LoadWebFile(MoneyHud,"http://asset/"..GetPackageName().."/Files/Hud/money.html")
    SetWebVisibility(MoneyHud,WEB_HITINVISIBLE)
end
AddEvent("OnPackageStart",OnPackageStart)

function updateHud()
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		ShowWeaponHUD(true)
		
		local pArmor=GetPlayerArmor()
		local pHealth=GetPlayerHealth()
		local pHunger=GetPlayerPropertyValue(GetPlayerId(),"hunger")
		local pThirst=GetPlayerPropertyValue(GetPlayerId(),"thirst")
		local pMoney=GetPlayerPropertyValue(GetPlayerId(),"Money")
		local veh=GetPlayerVehicle()
		
		if(veh~=0)then
			local vehiclespeed=math.floor(GetVehicleForwardSpeed(veh))
			local vehiclehealth=math.floor(GetVehicleHealth(veh))
			local vehiclefuel=GetVehiclePropertyValue(veh,"veh:fuel")or 100
			SetWebVisibility(VehicleHud,WEB_VISIBLE)
			ExecuteWebJS(VehicleHud,"SetVehicleFuel("..vehiclefuel..");")
			ExecuteWebJS(VehicleHud,"SetVehicleSpeed("..vehiclespeed..");")
			ExecuteWebJS(VehicleHud,"SetVehicleHealth("..vehiclehealth..");")
		else
			SetWebVisibility(VehicleHud,WEB_HIDDEN)
		end
		
		if(ArmorHud~=nil and pArmor~=nil)then
			ExecuteWebJS(ArmorHud,"SetArmor("..pArmor..", "..personalMenuIsOpen..");")
		end
		if(HealthHud~=nil and pHealth~=nil)then
			ExecuteWebJS(HealthHud,"SetHealth("..pHealth..", "..personalMenuIsOpen..");")
		end
		if(HungerHud~=nil and pHunger~=nil)then
			ExecuteWebJS(HungerHud,"SetHunger("..pHunger..", "..personalMenuIsOpen..");")
		end
		if(ThirstHud~=nil and pThirst~=nil)then
			ExecuteWebJS(ThirstHud,"SetThirst("..pThirst..", "..personalMenuIsOpen..");")
		end
		if(MoneyHud~=nil and pMoney~=nil)then
			ExecuteWebJS(MoneyHud,"SetMoney("..pMoney..", "..personalMenuIsOpen..");")
		end
	end
end

CreateTimer(function()
    updateHud()
end,100)