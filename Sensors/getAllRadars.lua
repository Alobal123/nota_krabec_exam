local sensorInfo = {
	name = "getAllBoxes",
	desc = "Returns all owned FARKS",
	author = "Krabec",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

function checkIfLineIsOccupied(laneId)
	for key,value in pairs(bb.radars) do
		if value == laneId then return true end
	end
	return false
end

function getFreeLane()
	for i=1,3 do 
		if not checkIfLineIsOccupied(i) then return i end
	end
	return nil
end


return function()
	local teamID = Spring.GetMyTeamID()
	local allies = Spring.GetTeamUnits(teamID)
	local radars = {}
	
	if bb.radars == nil then
		bb.radars = {}
	end
	for key,value in pairs(bb.radars) do
		if not Spring.ValidUnitID(key) then bb.radars[key] = nil end
	end
		
	local index = 1
	for _,value in pairs(allies) do
		local defID = Spring.GetUnitDefID(value)
		if UnitDefs[defID].humanName == "Seer" then
			radars[index] = value
			index = index + 1
			if bb.radars[value] == nil then
				bb.radars[value] = getFreeLane()
			end
		end
	end
	
	return radars
end