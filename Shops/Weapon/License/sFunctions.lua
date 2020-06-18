--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


GunlicensePedObjectsCached={}
local NPCpositions={
	{205507,193920,1360,0}
}
AddEvent("OnPackageStart",function()
	local NPC={}
	for i,v in pairs(NPCpositions)do
		v.NPC=CreateNPC(v[1],v[2],v[3],v[4])
		SetNPCHealth(v.NPC,999999999)
		
		SetNPCPropertyValue(v.NPC,"npc:clothing",14)
		
		CreateText3D("Gunlicensetest\nPress '"..interactKey.."'",18,v[1],v[2],v[3]+120,0,0,0)
		table.insert(GunlicensePedObjectsCached,v.NPC)
	end
end)

AddEvent("OnPlayerJoin",function(player)
    CallRemoteEvent(player,"call:gunlicense",GunlicensePedObjectsCached)
end)

AddRemoteEvent("interact:gunlicense",function(player,object)
	if(GetPlayerPropertyValue(player,"Playtime")>=180)then
		local dealer=GetGunlicensePedByObject(object)
		if(dealer)then
			local x,y,z=GetNPCLocation(dealer.NPC)
			local x2,y2,z2=GetPlayerLocation(player)
			local dist=GetDistance3D(x,y,z,x2,y2,z2)
			if(dist<130)then
				if(GetPlayerPropertyValue(player,"Gunlicense")==0)then
					CallRemoteEvent(player,"open:gunlicenseUI")
				else
					CallRemoteEvent(player,"MakeNotification","You have already a Gunlicense!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			end
		end
	else
		CallRemoteEvent(player,"MakeNotification","You haven't enough play time! (3hours)","linear-gradient(to right, #ff5f6d, #ffc371)")
	end
end)
function GetGunlicensePedByObject(object)
	for _,v in pairs(NPCpositions)do
		if(v.NPC==object)then
			return v
		end
	end
	return nil
end

local WrongAnswerCount={}
AddRemoteEvent("start:gunlicense:test",function(player)
	if(GetPlayerPropertyValue(player,"Money")>=500)then
		CallRemoteEvent(player,"trigger:gunlicenseQuestionUI")
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-500,true)
		CallRemoteEvent(player,"MakeNotification","Test started!","linear-gradient(to right, #00b09b, #96c93d)")
	else
		CallRemoteEvent(player,"MakeNotification","You haven't enough Money! ($500)","linear-gradient(to right, #ff5f6d, #ffc371)")
	end
end)

AddRemoteEvent("next:gunlicense:test",function(player,item,typ)
	if(typ==1)then
		WrongAnswerCount[player]=0
		if(item==0)then
			CallRemoteEvent(player,"trigger:gunlicenseQuestionUI")
		else
			CallRemoteEvent(player,"trigger:gunlicenseQuestionUI")
			WrongAnswerCount[player]=WrongAnswerCount[player]+1
		end
	elseif(typ==2)then
		if(item==1)then
			CallRemoteEvent(player,"trigger:gunlicenseQuestionUI")
		else
			CallRemoteEvent(player,"trigger:gunlicenseQuestionUI")
			WrongAnswerCount[player]=WrongAnswerCount[player]+1
		end
	elseif(typ==3)then
		if(item==1)then
			CallRemoteEvent(player,"trigger:gunlicenseQuestionUI")
		else
			CallRemoteEvent(player,"trigger:gunlicenseQuestionUI")
			WrongAnswerCount[player]=WrongAnswerCount[player]+1
		end
		if(WrongAnswerCount[player]>=2)then
			CallRemoteEvent(player,"destroy:gunlicenseQuestionUI")
			WrongAnswerCount[player]=0
			CallRemoteEvent(player,"MakeNotification","Failed!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	elseif(typ==4)then
		if(WrongAnswerCount[player]>=2)then
			CallRemoteEvent(player,"destroy:gunlicenseQuestionUI")
			WrongAnswerCount[player]=0
			CallRemoteEvent(player,"MakeNotification","Failed!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)

AddRemoteEvent("buy:gunlicense",function(player)
	if(GetPlayerPropertyValue(player,"Money")>=prices.shop.weapon.gunlicense)then
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.weapon.gunlicense,true)
		SetPlayerPropertyValue(player,"Gunlicense",1,true)
		AddPlayerChat(player,"Weaponlicense successfully bought!")
	end
end)