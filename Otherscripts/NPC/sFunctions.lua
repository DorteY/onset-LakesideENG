--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


--//Weed NPC funcs
DealerObjectsCached={}
local weedNPCpositions={
	{199488,169513,1308,-90},
	{215985,181465,1314,76},
	{198450,212817,1194,-105},
	{193683,213805,1307,160},
	{139909,179396,1448,-40}
}


function createWeedDealer()
	if(DealerNPC)then
		DestroyNPC(DealerNPC)
		DealerNPC=nil
	end
	if(DealerText)then
		DestroyText3D(DealerText)
	end
	
	rdmWeedAmount=math.random(5,17)
	rdmWeedMoneyAmount=math.random(5,12)
	local rdm=math.random(1,#weedNPCpositions)
	local rdmPos=weedNPCpositions[rdm]
	
	DealerNPC=CreateNPC(rdmPos[1],rdmPos[2],rdmPos[3],rdmPos[4])
	SetNPCHealth(DealerNPC,999999999)
	
	SetNPCPropertyValue(DealerNPC,"npc:clothing",11)
	
	DealerText=CreateText3D("Dealer\nPress '"..interactKey.."'",18,rdmPos[1],rdmPos[2],rdmPos[3]+120,0,0,0)
	table.insert(DealerObjectsCached,DealerNPC)
end
AddEvent("OnPackageStart",createWeedDealer)


AddEvent("OnPlayerJoin",function(player)
    CallRemoteEvent(player,"call:dealer",DealerObjectsCached)
end)

AddRemoteEvent("interact:dealer",function(player,object)
    local dealer=GetDealearByObject(object)
	if(dealer)then
		local x,y,z=GetNPCLocation(DealerNPC)
		local x2,y2,z2=GetPlayerLocation(player)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<150)then
			CallRemoteEvent(player,"open:dealerUI",rdmWeedAmount,rdmWeedMoneyAmount)
		end
	end
end)
function GetDealearByObject(object)
	for _,v in pairs(weedNPCpositions)do
		if(DealerNPC==object)then
			return v
		end
	end
	return nil
end


AddRemoteEvent("buy:dealer:weed",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(DealerNPC)then
			if(GetPlayerPropertyValue(player,"Money")>=rdmWeedAmount*rdmWeedMoneyAmount)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-rdmWeedAmount*rdmWeedMoneyAmount,true)
				SetPlayerPropertyValue(player,"Weed",GetPlayerPropertyValue(player,"Weed")+rdmWeedAmount,true)
				
				CallRemoteEvent(player,"MakeNotification","You successfully bought Weed (x"..rdmWeedAmount..")","linear-gradient(to right, #00b09b, #96c93d)")
				
				if(DealerNPC)then
					DestroyNPC(DealerNPC)
					DealerNPC=nil
				end
				if(DealerText)then
					DestroyText3D(DealerText)
				end
				Delay(10*60*1000,function(DealerNPC)
					createWeedDealer()
				end,DealerNPC)
			else
				CallRemoteEvent(player,"MakeNotification","You haven't enough money!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		else
			CallRemoteEvent(player,"MakeNotification","The Dealer is not here!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)