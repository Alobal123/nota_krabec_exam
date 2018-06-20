local sensorInfo = {
	name = "updateBoxes",
	desc = "Returns all boxes which should be transported to new location",
	author = "Krabec",
	date = "2018-06-20",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

function shouldBeFree(fronts,box)
	local boxpos = SpringGetUnitPosition(box)
	for i = 1,5 do 
		if (Vec3(box):Distance(fronts[i]) < 4000) then--TODO constanta 
			return false
		end
	end
	return true
end

return function(fronts)
	for key,value in pairs(bb.boxes) do
		if value = "busy" and Spring.GetUnitTransporter(key) == nil then
			if shouldBeFree(fronts,key) then
				bb.boxes[key] = "free"
			end
		end
	end
	return nil
end