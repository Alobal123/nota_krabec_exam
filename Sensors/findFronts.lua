local sensorInfo = {
	name = "findFronts",
	desc = "find the first places on map, where fighting is happenning",
	author = "Krabec",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1
local SpringGetUnitPosition = Spring.GetUnitPosition

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


return function(safety)
	local fronts = {}
	for i = 1,3 do 
		for key,value in pairs(bb.lanes[i]) do
			if bb.map[i][key] == "danger" then
				fronts[i] = bb.lanes[i][key-safety]["position"]
				break
			end
		end
		if fronts[i] == nil then fronts[i] = bb.lanes[i][7-safety]["position"] end
	end
	return fronts
end