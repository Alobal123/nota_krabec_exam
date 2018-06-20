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
local enemies = Spring.GetTeamUnits(1)
local allies = Spring.GetTeamUnits(0)

function getRatio(point)
	local enemyCount = 0
	for i=1,#enemies do
		if (Vec3(SpringGetUnitPosition(enemies[i])):Distance(point) < radius) then
			enemyCount = enemyCount + 1
		end
	end
	
	allyCount = 0
	for i=1,#allies do
		if (Vec3(SpringGetUnitPosition(allies[i])):Distance(point) < radius) then
			allyCount = allyCount + 1
		end
	end
	if enemyCount <= 3 or allyCount <= 3 then 	
		return 1001
	end
	return enemycount/allyCount
end

function getBestCandidate(points) 
	minimum = 0
	best = nil
	for key,value in pairs(points) do
		if value <= minimum then
			minimum = value
			best = key
		end
	end
	return key
end

return function(strongholds, paths)
	
	points = {}
	for key,value in pairs(paths) do
		points[value] = math.abs(getRatio(value) - 1) 
	end
	fronts = {}
	for i=1,5 do
		fronts[i] = getBestCandidate(points)
		points[fronts[i]] = {}
	end
end