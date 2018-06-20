--Simple move command which does not keep formation.

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
			{ 
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",

			},
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "tolerance",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}
		}
	}
end


-- speed-ups
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitPosition = Spring.GetUnitPosition
running = false

function Run(self, units, parameter)
	local position = parameter.position -- Vec3
	local unit = parameter.unit
	local tolerance = parameter.tolerance
	
	-- pick the spring command implementing the move
	local cmdID = CMD.MOVE
	if not running then	
		running = true
		local x,z = position["x"],position["z"]
		thisUnitWantedPosition = Vec3(x,Spring.GetGroundHeight(x,z),z)
		SpringGiveOrderToUnit(unit, cmdID, thisUnitWantedPosition:AsSpringVector(), {})
	end
	
	-- We return success once each unit is close enough to the target location
	
	if (Vec3(SpringGetUnitPosition(unit)):Distance(thisUnitWantedPosition) > tolerance) then
			return RUNNING
	end
	
	return SUCCESS
end


function Reset(self)
	running = false
end
