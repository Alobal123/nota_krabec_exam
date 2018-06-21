local sensorInfo = {
	name = "getUnitPosition",
	desc = "Returns position of a unit",
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

return function(unit)
	return Vec3(Spring.GetUnitPosition(unit))
end