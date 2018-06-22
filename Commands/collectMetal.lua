
local giveOrderToUnit = Spring.GiveOrderToUnit

function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
					{ 
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",

			},
			{ 
				name = "place",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}
		
		}

	}
end

runningF = {}
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local radius = 500


function Run(self, units, parameter)

	local place = parameter.place
	local unit = parameter.unit
	
	if unit == nil then return SUCCESS end
	if place == nil then return SUCCESS end
	place = place["position"]
	if runningF[unit] == nil then
		runningF[unit] = true
		local cmdID = CMD.RECLAIM
		x,y,z = place["x"],place["y"],place["z"]
		SpringGiveOrderToUnit(unit, CMD.MOVE,{x,y,z},{})
		SpringGiveOrderToUnit(unit, cmdID,{x,y,z,radius},{"shift"})
	end
	
	return RUNNING
end

function Reset(self)
	runningF = {}
end
