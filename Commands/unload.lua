local giveOrderToUnit = Spring.GiveOrderToUnit

function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
			{ 
				name = "transport",
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
				name = "radius",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "100",
			}
		}
	}
end


local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitPosition = Spring.GetUnitPosition
local runningU = {}

function Run(self, units, parameter)
	local transport = parameter.transport
	local x,y,z = parameter.position["x"],parameter.position["y"],parameter.position["z"]
	local rad = parameter.radius
	
	if transport == nil then return SUCCESS end
	if( Spring.GetUnitIsTransporting(transport)== nil or Spring.GetUnitIsTransporting(transport)[1] == nil) then
		runningU[transport] = nil
		return SUCCESS
	end
	
	
	if runningU[transport] == nil then
		runningU[transport] = true
		local cmdID = CMD.UNLOAD_UNITS
		SpringGiveOrderToUnit(transport, cmdID,{x,y,z,rad},{})
	end
	
	
	return RUNNING
end

function Reset(self)
	local runningU = {}
end
