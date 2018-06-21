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
	for key,value in pairs(bb.farcks) do
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
	local farcks = {}
	
	if bb.farcks == nil then
		bb.farcks = {}
	end
	for key,value in pairs(bb.farcks) do
		if not Spring.ValidUnitID(key) then bb.farcks[key] = nil end
	end
		
	local index = 1
	for _,value in pairs(allies) do
		local defID = Spring.GetUnitDefID(value)
		if UnitDefs[defID].humanName == "FARCK" then
			farcks[index] = value
			index = index + 1
			if bb.farcks[value] == nil then
				bb.farcks[value] = getFreeLane()
			end
		end
	end
	
	return farcks
end