--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: Talos         ||--
--||         Lake-Gaming.com         ||--


local scoreboard
local sb_timer=0

local function OnPackageStart()
	scoreboard=CreateWebUI(0.0,0.0,0.0,0.0,5,10)
	LoadWebFile(scoreboard,"http://asset/"..GetPackageName().."/Files/Tablist/scoreboard.html")
	SetWebSize(scoreboard,1065,600)
	SetWebAlignment(scoreboard,0.5, 0.5)
	SetWebAnchors(scoreboard,0.5, 0.5, 0.5, 0.5)
	SetWebVisibility(scoreboard,WEB_HIDDEN)
end
AddEvent("OnPackageStart",OnPackageStart)

local function OnPackageStop()
	DestroyTimer(sb_timer)
	DestroyWebUI(scoreboard)
end
AddEvent("OnPackageStop",OnPackageStop)

local function OnKeyPress(key)
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		if(key=="Tab")then
			if(IsValidTimer(sb_timer))then
				DestroyTimer(sb_timer)
			end
			sb_timer=CreateTimer(UpdateScoreboardData,1500)
			UpdateScoreboardData()
			SetWebVisibility(scoreboard,WEB_VISIBLE)
		end
	end
end
AddEvent("OnKeyPress",OnKeyPress)

local function OnKeyRelease(key)
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		if(key=="Tab")then
			DestroyTimer(sb_timer)
			SetWebVisibility(scoreboard,WEB_HIDDEN)
		end
	end
end
AddEvent("OnKeyRelease",OnKeyRelease)

function UpdateScoreboardData()
	CallRemoteEvent("update:scoreboard")
end

function OnGetScoreboardData(servername,count,maxplayers,players)
	ExecuteWebJS(scoreboard,"SetServerName('"..servername.."');")
	ExecuteWebJS(scoreboard,"SetPlayerCount("..count..", "..maxplayers..");")
	ExecuteWebJS(scoreboard,"RemovePlayers();")
	
	for i,v in ipairs(players)do
		ExecuteWebJS(scoreboard,"AddPlayer("..i..", '"..v[1].."', '"..v[2].."', '"..v[3].."', '"..v[4].."');")
	end
end
AddRemoteEvent("update:scoreboard",OnGetScoreboardData)