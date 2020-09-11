
function OnKeyPress(key)
if key == "U" then
          CallRemoteEvent("VehicleEngine") 
      else if key == "O" then
          GetVehicleSpeed()

      end
  end
  end
  AddEvent("OnKeyPress", OnKeyPress)


  function GetVehicleSpeed()
    local speed = math.tointeger(math.floor(GetVehicleForwardSpeed(GetPlayerVehicle())))
    AddPlayerChat("Speed:" .. speed .. " km/h")
end