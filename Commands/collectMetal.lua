-- This command loads all units in area nearby position, in radius 
local testBuildOrder = Spring.TestBuildOrder
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

running = {}
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local radius = 2000


function Run(self, units, parameter)

	local place = parameter.place
	local unit = parameter.unit
	
	if unit == nil then return SUCCESS end
	
	if running[unit] == nil then
		running[unit] = true
		local cmdID = CMD.RECLAIM
		x,y,z = place["x"],place["y"],place["z"]
		SpringGiveOrderToUnit(unit, cmdID,{x,y,z,radius},{})
	end
	
	return RUNNING
end

function Reset(self)
	running = {}
end
