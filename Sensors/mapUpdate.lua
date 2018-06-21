local sensorInfo = {
	name = "findFronts",
	desc = "find places on map, where fighting is happenning",
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

function isSafe(point)
	local allUnits = Spring.GetAllUnits()
	for i=1,#allUnits do
		if (Vec3(SpringGetUnitPosition(allUnits[i])):Distance(point) < radius) then
			local unitAllyID = Spring.GetUnitAllyTeam(allUnits[i])
			if unitAllyID ~= myAllyID then return false end
		end
	end
	return true
end

function updatePath(i)
	local path = bb.map[i]
	local dangerStart = false
	for key,value in pairs(path) do
		if not dangerStart then
			if not isSafe(key) then 
				dangerStart = true
			end
		end
		if dangerStart then
			path[key] = "danger"
		else
			path[key] = "safe"
		end
	end
	
end

return function(strongholds, paths)
	if bb.map == nil then
		bb.map = {}
		bb.map[1] = {}
		for i = 1,3 do
			local index = 0
			for key,value in pairs(paths[i]) do
				index = index + 1
				bb.map[i][index] = "danger"
			end
		end
	end
	for i=1,3 do
		updatePath(i)
	end
end