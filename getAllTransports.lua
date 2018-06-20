local sensorInfo = {
	name = "getAllTransports",
	desc = "Returns all transports",
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
return function(safePlace, units)
	transports = {}
	index = 1
	for i=1,#units do
		value = units[i]
		defID = Spring.GetUnitDefID(value)
		if UnitDefs[defID].isTransport then
			transports[index] = value
			index = index + 1
		end
	end

	return transports
end