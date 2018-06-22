
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
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}
		
		}

	}
end

local runningL = {}
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

function Run(self, units, parameter)

	local transport = parameter.transport
	local unit = parameter.unit
	
	if unit == nil then return SUCCESS end
	if bb.boxes[unit]==nil then
		runningL[transport] = nil
		return SUCCESS end
	if runningL[transport] == nil then
		runningL[transport] = true
		local cmdID = CMD.LOAD_UNITS
		SpringGiveOrderToUnit(transport, cmdID,{unit},{})
	end
	
	if transport == nil then return SUCCESS end
	if Spring.GetUnitIsTransporting(transport)== nil or Spring.GetUnitIsTransporting(transport)[1] ~= nil or Spring.GetUnitTransporter(unit) ~= nil then
		runningL[transport] = nil
		return SUCCESS
	end
	return RUNNING
end

function Reset(self)
	local runningL = {}
end
