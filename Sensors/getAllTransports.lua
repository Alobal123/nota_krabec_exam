local sensorInfo = {
	name = "getAllTransports",
	desc = "Returns all transports",
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
	local transports = {}
	if bb.transports == nil then
		bb.transports = {}
	end
	for key,value in pairs(bb.transports) do
		if not Spring.ValidUnitID(key) then bb.transports[key] = nil end
	end
	
	local index = 1
	for _,value in pairs(allies) do
		local defID = Spring.GetUnitDefID(value)
		if UnitDefs[defID].isTransport then
			transports[index] = value
			if bb.transports[value] == nil then
				bb.transports[value] = "free"
			end
			index = index + 1
		end
	end
	return transports
end