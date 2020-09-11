AddCommand("carinfo", function(player)
    local vehicle = GetPlayerVehicle(player)
    local health  = GetVehicleHealth(vehicle)
    local plate   = GetVehicleLicensePlate(vehicle)
    local model   = GetVehicleModel(vehicle)
    local modelname = GetVehicleModelName(vehicle)
    local engine = GetVehicleEngineState(vehicle)
    local number =	GetVehicleNumberOfSeats(vehicle)
    local color =   GetVehicleColor(vehicle)
    local phare = GetVehicleLightState(vehicle)
    
AddPlayerChat(player, ('ID : %s | VIE : %s | PLAQUE : %s | MODEL : %s | MODENAME %s | MOTEUR : %s | SIEGE : %s | COULEUR : %s | PHARE : %s'):format(vehicle, health, plate, model, modelname, engine, number, color, phare))


        
end)


function cmd_v(player, model)
    local invehicle = GetPlayerVehicle(player)
    
	if (model == nil) then
      return  AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/car | " .. '</>' .. "entre 1 et 25.")
	end

	model = tonumber(model)

	if (model < 1 or model > 25) then
    return  AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/car | " .. '</>' .. "Le modéle "..model.." existe pas [1 - 25].")
    end
    
    if ( invehicle ~= 0) then
      return  AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/car | " .. '</>' .. "Vous etes deja dans un véhicule.")
    end
	local x, y, z = GetPlayerLocation(player)
	local h = GetPlayerHeading(player)

	local vehicle = CreateVehicle(model, x, y, z, h)
	if (vehicle == false) then
    return  AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/car | " .. '</>' .. "Erreur.")
	end

	SetVehicleLicensePlate(vehicle, "ONSET")
	AttachVehicleNitro(vehicle, true)

	if (model == 8) then
		SetVehicleColor(vehicle, RGB(0.0, 60.0, 240.0))
		SetVehicleLicensePlate(vehicle, "EMS")
	end


	SetPlayerInVehicle(player, vehicle)
    local name = GetVehicleModelName(vehicle)
    AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/car | " .. '</>' .. "Model : " .. name .. " | ID: " .. vehicle)
end
AddCommand("car", cmd_v)


AddCommand("dv", function(player)
    local vehicle = GetPlayerVehicle(player)
    local name = GetVehicleModelName(vehicle)
    if vehicle ~= 0 then
        DestroyVehicle( vehicle )
            AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/DV | " .. '</>' .. "Véhicule supprimer : " .. name .. " | ID : " ..vehicle)     
else
    AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/DV | " .. '</>' .. "Vous devez etre dans un vehicule")     
end
end)




AddCommand("dv2", function(player)
	local vehicles = GetStreamedVehiclesForPlayer(player)
	local found = 0
	local nearest_dist = 400
	local x, y, z = GetPlayerLocation(player)
    
	for _,v in pairs(vehicles) do
		local x2, y2, z2 = GetVehicleLocation(v)
        local dist = GetDistance3D(x, y, z, x2, y2, z2)       
        if dist < nearest_dist then
            local name = GetVehicleModelName(v)

            DestroyVehicle(v)
         --   AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15">' .. "/DV2 | " .. '</>' .. "Véhicule supprimer : " .. name .. " | ID : " ..v)
            AddPlayerChat(player, ('<span color="#FF0000" style="bold" size="15">/DV2 | </>Véhicule supprimer : %s | ID : %s'):format(name, v))
            
			nearest_dist = dist
            found = v
        else
            AddPlayerChat(player,'<span color="#FF0000" style="bold" size="15"> /DV2 |</> Aucun véhicule')
		end
    end

	return found, nearest_dist

end)



function StartEngine(player)
    local veh = GetPlayerVehicle(player)
    local driver = GetVehicleDriver(veh)
    if veh ~= 0 and driver == 1 then
       StartVehicleEngine(veh)
       AddPlayerChat(player, "Moteur ouvert")
    else if driver == 0 then
        AddPlayerChat(player, "Vous devez etre conducteur")
    else
        AddPlayerChat(player, "Vous devez etre dans un véhicule")
    end
 end
end
 AddCommand('moteuron', StartEngine)


 function StopEngine(player)
    local veh = GetPlayerVehicle(player)
    local driver = GetVehicleDriver(veh)
    if veh ~= 0 and driver == 1 then
       StopVehicleEngine(veh)
       AddPlayerChat(player, "Moteur fermer")
    else if driver == 0 then
        AddPlayerChat(player, "Vous devez etre conducteur")
    else
        AddPlayerChat(player, "Vous devez etre dans un véhicule")
    end
    end
 end
 AddCommand('moteuroff', StopEngine)


 AddRemoteEvent("VehicleEngine", function(player)
    local veh = GetPlayerVehicle(player)
    local driver = GetVehicleDriver(veh)
    if GetVehicleEngineState(veh) ~= true then
        if veh ~= 0 and driver == 1 then
            StartVehicleEngine(veh)
            AddPlayerChat(player, "Moteur ouvert")
        end
    else if GetVehicleEngineState(veh) == true then
        if veh ~= 0 and driver == 1 then
            StopVehicleEngine(veh)
            AddPlayerChat(player, "Moteur fermer")
        end
    else if driver == 0 then
        AddPlayerChat(player, "Vous devez etre conducteur")
    else
        AddPlayerChat(player, "Vous devez etre dans un véhicule")
    end
end
    end
 
end)




