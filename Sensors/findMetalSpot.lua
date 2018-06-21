local sensorInfo = {
	name = "findMetalSpot",
	desc = "find place on lane, where it is safe and there is metal to be collected",
	author = "Krabec",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 10
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
		if (Vec3(SpringGetUnitPosition(enemies[i])):Distance(point) < radius) then
			local unitAllyID = Spring.GetUnitAllyTeam(allUnits[i])
			if unitAllyID ~= myAllyID then return false end
		end
	end
	return true
end

function hasMetal(point) 
	
end

return function(lane)
	for key,value in pairs(lane) do
		if isSafe(value) and hasMetal(value) then 
			return value
		end
	end
end