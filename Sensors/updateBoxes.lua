local sensorInfo = {
	name = "getAllBoxes",
	desc = "Returns all owned deathboxes on the map",
	author = "Krabec",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description return table of all transportable allied units
return function()
	local allies = Spring.GetTeamUnits(0)
	boxes = {}
	if bb.boxes == nil then
		bb.boxes = {}
	end
	
	index = 1
	for _,value in pairs(allies) do
		defID = Spring.GetUnitDefID(value)
		if UnitDefs[defID].humanName == "Box-of-Death" then
			boxes[index] = value
			if bb.boxes[value] == nil then
				bb.boxes[value] = "free"
			end
			index = index + 1
		end
	end
	return boxes
end