local sensorInfo = {
	name = "findFronts",
	desc = "find places on map, where fighting is happenning",
	author = "Krabec,Petrroll",
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

local radius = 1000 --TODO constanta
local myAllyID = Spring.GetMyAllyTeamID()

-- is location far enough from enemies
function isLocSafe(point)
	local allUnits = Spring.GetAllUnits()
	for i=1,#allUnits do
		if (Vec3(SpringGetUnitPosition(allUnits[i])):Distance(point) < radius) then
			local unitAllyID = Spring.GetUnitAllyTeam(allUnits[i])
			if unitAllyID ~= myAllyID then return false end
		end
	end
	return true
end

-- update lane map safety information 
function updateLaneSafety(i)
	local path = bb.lanes[i]
	local dangerStart = false
	for key,value in pairs(path) do

		if not dangerStart and not isLocSafe(value["position"]) then
			dangerStart = true
		end

		if dangerStart then
			bb.map[i][key] = "danger"
		else
			bb.map[i][key] = "safe"
		end
	end
	
end

-- init map with default values
function initMap(paths)
	bb.map = {}
	bb.lanes = {paths["Top"]["points"],paths["Middle"]["points"],paths["Bottom"]["points"]}
	for i = 1,3 do
		-- init lane's map
		bb.map[i] = {}
		local index = 1
		for key,value in pairs(bb.lanes[i]) do
			bb.map[i][index] = "danger"
			index = index + 1
		end
	end
end


return function(paths)
	if bb.map == nil then initMap(paths) end
	for i=1,3 do
		updateLaneSafety(i)
	end
end