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


function getRatio(point)
	local allUnits = Spring.GetAllUnits()
	local enemyCount = 0
	local allyCount = 0
	for i=1,#allUnits do
		if (Vec3(SpringGetUnitPosition(enemies[i])):Distance(point) < radius) then
			local unitAllyID = Spring.GetUnitAllyTeam(allUnits[i])
			if unitAllyID == myAllyID then allyCount = allyCount + 1
			else enemyCount = enemyCount + 1 end
		end
	end
	
	if enemyCount <= 3 or allyCount <= 3 then 	
		return 1001
	end
	return enemycount/allyCount
end

function getBestCandidate(points) 
	local minimum = 0
	local best = nil
	for key,value in pairs(points) do
		if value <= minimum then
			minimum = value
			best = key
		end
	end
	return key
end

return function(strongholds, paths)
	
	local points = {}
	for key,value in pairs(paths) do
		points[value] = math.abs(getRatio(value) - 1) 
	end
	local fronts = {}
	for i=1,5 do
		fronts[i] = getBestCandidate(points)
		points[fronts[i]] = {}
	end
end