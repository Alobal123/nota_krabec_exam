--This command unloads all units. 
-- 
local testBuildOrder = Spring.TestBuildOrder
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
running = {}

function Run(self, units, parameter)
	local transport = parameter.transport
	local x,y,z = SpringGetUnitPosition(transport)
	local rad = parameter.radius
	if transport == nil then return SUCCESS end
	
	
	if running[transport] == nil then
		running[transport] = true
		local cmdID = CMD.UNLOAD_UNITS
		SpringGiveOrderToUnit(transport, cmdID,{x,y,z,rad},{})
	end
	
	if( Spring.GetUnitIsTransporting(transport)== nil or Spring.GetUnitIsTransporting(transport)[1] == nil) then
		return SUCCESS
	end
	return RUNNING
end

function Reset(self)
	running = {}
end
