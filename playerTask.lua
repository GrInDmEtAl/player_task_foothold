-------------------------------------------------------------------------
-- Test with detection in Foothold mission by @Leka 14/04/2025
-- Example used https://github.com/FlightControl-Master/MOOSE_MISSIONS/blob/develop/Ops/PlayerTask/PlayerTask%20-%20020%20-%20Detection/PlayerTask%20-%20020%20-%20Detection.lua
-------------------------------------------------------------------------
-- Documentation
-- 
-- PLAYERTASK: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.PlayerTask.html
-- 
-------------------------------------------------------------------------

-- Settings
-- _SETTINGS:SetPlayerMenuOn()
-- _SETTINGS:SetImperial()
-- _SETTINGS:SetA2G_BR()

-- Set up A2G task controller for the blue side named "82nd Airborne"
local taskmanager = PLAYERTASKCONTROLLER:New("1st Foothold Airborne",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)

-- Set up detection with grup names containing
local AWAC_jtacs = {
    "awacs1",
    "awacs2",
    "awacs3",
	"jtacDrone",
	"JTAC9linefm",
	"JTAC9lineam"
}
taskmanager:SetupIntel(AWAC_jtacs)

-- Set the menu to be calles Eagle Eye
taskmanager:SetMenuName("Eagle Eye")

-- accept-zones for detection

--  tested worked
local Zones_MA_circle = {
    "Akrotiri",
    "Paphos",
    "Polis",
    "Karavostasi",
    "Larnaca",
    "Ercan",
    "Pinarbashi",
    "Gecitkale",
    "Incirlik",
    "Hatay",
    "Minakh",
    "Aleppo",
    "Taftanaz",
    "Jirah",
    "Tabqa",
    "Bassel Al-Assad",
    "Hama",
    "Palmyra",
    "Power Plant",
    "FOB Alpha",
    "Bravo",
    "Charlie",
    "Delta",
    "Foxtrot",
    "Golf",
    "Hotel",
    "India",
    "Juliett",
    "Kilo",
    "Oscar",
    "Papa",
    "Sierra",
    "Tango",
    "Uniform",
    "Victor",
    "Substation North",
    "Durayhim",
    "Raqqa",
    "Dam",
    "TV Tower",
    "SA-5",
    "Military Base",
    "Factory",
    "Substation West",
    "Rene Mouawad",
    "Wujah",
    "Rayak",
    "Al Qusayr",
    "Tiyas",
    "An Nasiriyah",
    "Thalah",
    "King Hussein Air College",
    "Muwaffaq Salti",
    "Prince Hassan",
    "Ben Gurion",
    "Ramat David",
    "Rosh Pina",
    "Marka",
    "Gaziantep",
    "Manbij",
    "Shayrat",
    "Ben Gurion Defence",
    "Ramat David Defence",
    "Jordan Defence",
    "Incirlik Defence",
    "Silkworm Site",
    "FOB Lima",
    "Abu al-Duhur",
    "Damascus",
    "Beirut",
    "Radio Tower",
    "November",
    "Romeo",
    "Red Carrier",
    "Refinery",
    "FOB Mike"
}


    -- "Carrier Group",

for _, zoneName in ipairs(Zones_MA_circle) do
  taskmanager:AddAcceptZone( ZONE:New(zoneName) )
end

-- auto-add map markers when tasks are added
function taskmanager:OnAfterTaskAdded(From,Event,To,Task)
  local task = Task -- Ops.PlayerTask#PLAYERTASK
  local coord = task.Target:GetCoordinate()
  local taskID = string.format("Task ID #%03d | Type: %s | Threat: %d",task.PlayerTaskNr,task.Type,task.Target:GetThreatLevelMax())
  local mark = MARKER:New(coord,taskID)
  mark:ReadWrite()
  mark:ToCoalition(taskmanager.Coalition)
end
