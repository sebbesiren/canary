local teleportPosition = Position(32201, 32296, 6)
local teleportTo = Position(5000, 5000, 11)

local adventurerToHubTeleport = MoveEvent()
function adventurerToHubTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(teleportTo)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

adventurerToHubTeleport:position(teleportPosition)
adventurerToHubTeleport:register()
