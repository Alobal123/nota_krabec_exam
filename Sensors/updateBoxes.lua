local sensorInfo = {
	name = "updateBoxes",
	desc = "Returns all boxes which should be transported to new location",
	author = "Krabec",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

function shouldBeFree(fronts,box)
	for i = 1,3 do 
		if Vec3(Spring.GetUnitPosition(box)):Distance(fronts[i]) < 500 then--TODO constanta 
			return false
		end
	end
	return true
end

return function(fronts, base)
	for key,value in pairs(bb.boxes) do
		if Spring.GetUnitTransporter(key) == nil then 
			if Vec3(Spring.GetUnitPosition(key)):Distance(base) < 1000 then
				bb.boxes[key] = "atbase"
			elseif value == "busy" and shouldBeFree(fronts,key) then
				bb.boxes[key] = "free"
			end
			
		end
	end
	return nil
end