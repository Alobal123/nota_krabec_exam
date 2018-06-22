local sensorInfo = {
	name = "findMetalSpot",
	desc = "find place on lane, where it is safe and there is metal to be collected",
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

local radius = 500 --TODO constanta
local myAllyID = Spring.GetMyAllyTeamID()


function hasMetal(point) 
	local x,z = point["x"],point["z"]
	--local amount = 0
	local features = Spring.GetFeaturesInSphere(x,Spring.GetGroundHeight(x,z),z,radius)
	return (#features > 0)
end

return function(laneID)
	if laneID == nil then return nil end
	local bestpoint = nil
	for key,value in pairs(bb.lanes[laneID]) do
		if bb.map[laneID][key]=="safe" then
			if key ==  #bb.lanes[laneID] then bestpoint = bb.lanes[laneID][6]
			else bestpoint = value end
			if hasMetal(value["position"]) then
				return value
			end
		end
	end
	return bestpoint
end