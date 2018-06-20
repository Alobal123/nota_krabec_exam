local sensorInfo = {
	name = "getFreeBoxes",
	desc = "Returns box ready to be transported",
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


return function()

	for key,value in pairs(bb.boxes) do

		if value == "free" then
			bb.boxes[key] = "busy"
			return key
		end
		
	end

	return nil
end