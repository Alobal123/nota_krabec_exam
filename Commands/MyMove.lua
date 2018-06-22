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
local runningA = {}

function Run(self, units, parameter)
	local position = parameter.position -- Vec3
	local unit = parameter.unit
	local tolerance = parameter.tolerance
	
	if Spring.GetUnitHealth(unit)==nil then return SUCCESS end
	if position == nil then return SUCCESS end
	
	-- pick the spring command implementing the move
	local cmdID = CMD.MOVE
	if runningA[unit] == nil then	
		local x,z = position["x"],position["z"]
		thisUnitWantedPosition = Vec3(x,Spring.GetGroundHeight(x,z),z)
		SpringGiveOrderToUnit(unit, cmdID, thisUnitWantedPosition:AsSpringVector(), {})
		runningA[unit] = true
	end
	
	
	
	if (Vec3(SpringGetUnitPosition(unit)):Distance(thisUnitWantedPosition) > tolerance) then
			return RUNNING
	end
	
	runningA[unit] = nil
	return SUCCESS
end


function Reset(self)
	--runningA = {}
end
