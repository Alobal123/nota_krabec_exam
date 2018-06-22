local sensorInfo = {
	name = "findFronts",
	desc = "find the first places on map, where fighting is happenning",
	author = "Krabec",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0
local SpringGetUnitPosition = Spring.GetUnitPosition

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


return function()
	local fronts = {}
	for i = 1,3 do 
		for key,value in pairs(bb.lanes[i]) do
			if bb.map[i][key] == "danger" then
				fronts[i] = bb.lanes[i][key]["position"]
				break
			end
		end
		if fronts[i] == nil then fronts[i] = bb.lanes[i][3]["position"] end
	end
	return fronts
end