--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--
--||        From: Frederic2ec        ||--


local RadioStatus=0
local Track=nil
local Vehicle=nil
local Volume=0.3

local Radios={
    {label="[INT] NCS #1",url="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://51.15.152.81:8947/listen.pls?sid=1&t=.pls"},
    {label="[INT] NCS #2",url="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://91.121.113.129:9115/listen.pls?sid=1&t=.pls"},
    {label="[GER] ILoveRadio",url="https://iloveradio.de/iloveradio.m3u"},
    {label="[GER] ILove2Dance",url="https://iloveradio.de/ilove2dance.m3u"},
    {label="[INT] Noise.FM",url="http://noisefm.ru:8000/play_256.m3u"},
    {label="[INT] Dubstep.FM",url="https://www.dubstep.fm/listen.m3u"},
}
local CurrentRadio=1
local channel=nil

AddEvent("OnKeyPress",function(key)  
    if(key=="R" and IsPlayerInVehicle())then
		channel=nil
        CallRemoteEvent("radio:getplayersinvehicle",RadioStatus)
    end
	
    if(RadioStatus==1 and key=="Num +" and IsPlayerInVehicle())then        
        CallRemoteEvent("radio:getplayersinvehicle",RadioStatus,1)
    elseif(RadioStatus==1 and key=="Num -" and IsPlayerInVehicle())then        
        CallRemoteEvent("radio:getplayersinvehicle",RadioStatus,0)
    end
	
    if(RadioStatus==1 and IsPlayerInVehicle()and key=="Mouse Wheel Up" or key=="Mouse Wheel Down")then
		if(channel==nil)then
			channel=1
		end
		if(key=="Mouse Wheel Up")then
			if(channel>=0)then
				channel=channel+1
				if(channel>#Radios)then--6
					channel=#Radios
				end
			end
		elseif(key=="Mouse Wheel Down")then
			channel=channel-1
			if(channel<=1)then
				channel=1
			end
		end
		
        if(channel~=nil)then
            CallRemoteEvent("radio:getplayersinvehicle",RadioStatus,nil,channel)
        end
    end
end)

AddEvent("OnPlayerLeaveVehicle",function(player,vehicle,seat)
    StopRadio()
end)
AddEvent("OnPlayerEnterVehicle",function(player,vehicle,seat)
    if(vehicle==Vehicle)then
        StartRadio()
    end
end)

AddRemoteEvent("radio:turnonradio",function(vehicle)
    StartRadio(vehicle)
end)
AddRemoteEvent("radio:turnoffradio",function(vehicle)
    StopRadio(vehicle)
end)
AddRemoteEvent("radio:setvolume",function(vehicle,volume)
    if(vehicle==Vehicle)then
        SetVolume(volume)
    end
end)
AddRemoteEvent("radio:setchannel",function(vehicle,channel)
    if(vehicle==Vehicle)then
        SetChannel(channel)
    end
end)

function StartRadio(vehicle)
    if(vehicle~=nil)then
        AddPlayerChat("Radio: Started")
        Vehicle=vehicle
        RadioStatus=1
    end
    
    Track=CreateSound(Radios[CurrentRadio].url)
    SetSoundVolume(Track,Volume)
end
function StopRadio(vehicle)
    if(Track~=nil)then
		DestroySound(Track)
	end
    if(vehicle~=nil)then
        AddPlayerChat("Radio: Stopped")
        RadioStatus=0
        Track=nil
        Vehicle=nil
        Volume=0.5
        CurrentRadio=1
    end
end
function SetVolume(volume)
    if(volume==1 and Volume<1.0)then
        Volume=Volume+0.1
        SetSoundVolume(Track,Volume)
    elseif(volume==0 and Volume>0.0)then
        Volume=Volume-0.1
        SetSoundVolume(Track,Volume)
    end
end
function SetChannel(channel)
    CurrentRadio=channel
	AddPlayerChat("Radio: "..Radios[CurrentRadio].label)
    DestroySound(Track)
    Track=CreateSound(Radios[CurrentRadio].url)
    SetSoundVolume(Track,Volume)
end