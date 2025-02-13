local config = {
	[VOCATION.ID.NONE] = {
		container = {
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- shovel
		},
	},

	[VOCATION.ID.SORCERER] = {
		items = {
			{ 3059, 1 }, -- spellbook
			{ 3074, 1 }, -- wand of vortex
			{ 17846, 1 }, -- leather harness
			{ 7992, 1 }, -- mage hat
			{ 22087, 1 }, -- wereboar loincloth
			{ 3552, 1 }, -- leather boots
			{ 3572, 1 }, -- scarf
		},

		container = {
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 268, 20 }, -- mana potion
		},
	},

	[VOCATION.ID.DRUID] = {
		items = {
			{ 3059, 1 }, -- spellbook
			{ 3066, 1 }, -- snakebite rod
			{ 17846, 1 }, -- leather harness
			{ 7992, 1 }, -- mage hat
			{ 22087, 1 }, -- wereboar loincloth
			{ 3552, 1 }, -- leather boots
			{ 3572, 1 }, -- scarf
		},

		container = {
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 268, 20 }, -- mana potion
		},
	},

	[VOCATION.ID.PALADIN] = {
		items = {
			{ 17810, 1 }, -- spike shield
			{ 3277, 1 }, -- spear
			{ 17846, 1 }, -- leather harness
			{ 22087, 1 }, -- wereboar loincloth
			{ 3552, 1 }, -- leather boots
			{ 3572, 1 }, -- scarf
			{ 3351, 1 }, -- steel helmet
		},

		container = {
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 266, 10 }, -- health potion
			{ 3350, 1 }, -- bow
			{ 35562, 1 }, -- quiver
			{ 15793, 50 }, -- crystalline arrow
			{ 3447, 1 }, -- 1 arrows
		},
	},

	[VOCATION.ID.KNIGHT] = {
		items = {
			{ 17810, 1 }, -- spike shield
			{ 3316, 1 }, -- orcish axe
			{ 17846, 1 }, -- leather harness
			{ 3351, 1 }, -- steel helmet
			{ 22087, 1 }, -- wereboar loincloth
			{ 3552, 1 }, -- leather boots
			{ 3572, 1 }, -- scarf
		},

		container = {
			{ 3297, 1 }, -- serpent sword
			{ 3282, 1 }, -- morning star
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 266, 20 }, -- health potion
		},
	},
}

local sendFirstItems = CreatureEvent("SendFirstItems")

function sendFirstItems.onLogin(player)
	local targetVocation = config[player:getVocation():getId()]
	if not targetVocation or player:getLastLoginSaved() ~= 0 then
		return true
	end

	if targetVocation.items then
		for i = 1, #targetVocation.items do
			player:addItem(targetVocation.items[i][1], targetVocation.items[i][2])
		end
	end

	local backpack = player:addItem(2854)
	if not backpack then
		return true
	end

	if targetVocation.container then
		for i = 1, #targetVocation.container do
			backpack:addItem(targetVocation.container[i][1], targetVocation.container[i][2])
		end
	end
	return true
end

sendFirstItems:register()
