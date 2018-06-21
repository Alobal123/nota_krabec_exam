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


function hasMetal(point) 
	local x,z = point["x"],point["z"]
	local X,Z = math.floor(x/16), math.floor(Z/16)
	local mRadius = math.floor(radius/16)
	local amount = 0
	for dx =-mRadius,mRadius do
		for dz =-mRadius,mRadius do
			amount = amount + Spring.GetMetalAmount(X+dx,Z+dz)
		end
	end
	return (amount > 0)
end

return function(lane)
	for key,value in pairs(lane) do
		if bb.paths[i][key]=="safe" and hasMetal(value) then 
			return value
		end
	end
	return nil
end