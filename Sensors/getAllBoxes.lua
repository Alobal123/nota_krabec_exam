local sensorInfo = {
	name = "getAllBoxes",
	desc = "Returns all owned deathboxes on the map",
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

-- @description return table of all transportable allied units
return function()
	local teamID = Spring.GetMyTeamID()
	local allies = Spring.GetTeamUnits(teamID)
	local boxes = {}
	if bb.boxes == nil then
		bb.boxes = {}
	end
	for key,value in pairs(bb.boxes) do
		if not Spring.ValidUnitID(key) then bb.boxes[key] = nil end
	end
	
	local index = 1
	for _,value in pairs(allies) do
		local defID = Spring.GetUnitDefID(value)
		if UnitDefs[defID].humanName == "Box-of-Death" then
			boxes[index] = value
			if bb.boxes[value] == nil then
				bb.boxes[value] = "free"
			end
			index = index + 1
		end
	end
	return b
end