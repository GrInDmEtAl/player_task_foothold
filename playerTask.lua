-- Test with detection in Foothold mission by @Leka 14/04/2025
-- Example used https://github.com/FlightControl-Master/MOOSE_MISSIONS/blob/develop/Ops/PlayerTask/PlayerTask%20-%20020%20-%20Detection/PlayerTask%20-%20020%20-%20Detection.lua
-------------------------------------------------------------------------
-- Documentation
--  
-- PLAYERTASK: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.PlayerTask.html
--  Need Limit range detections 
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

-- Not tested 
-- local Zones_MA = {
    -- "zone1",
    -- "zone1",
    -- "zone1"
-- }
taskmanager:AddAcceptZone(ZONE:New("AcceptZone"))  --using global zone around map named AcceptZone in ME
-- taskmanager:AddAcceptZone(ZONE:FindByName("AcceptZone"))

-- auto-add map markers when tasks are added
function taskmanager:OnAfterTaskAdded(From,Event,To,Task)
  local task = Task -- Ops.PlayerTask#PLAYERTASK
  local coord = task.Target:GetCoordinate()
  local taskID = string.format("Task ID #%03d | Type: %s | Threat: %d",task.PlayerTaskNr,task.Type,task.Target:GetThreatLevelMax())
  local mark = MARKER:New(coord,taskID)
  mark:ReadWrite()
  mark:ToCoalition(taskmanager.Coalition)
end
