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

local radius = 2000 --TODO constanta
local myAllyID = Spring.GetMyAllyTeamID()

return function(strongholds, paths)
	local fronts = {}
	for i = 1,3 do 
		for key,value in pairs(paths[i]) do
			if bb.map[i][key] == "danger" then
				fronts[i] = value
				break
			end
		end
	end
	return fronts
end