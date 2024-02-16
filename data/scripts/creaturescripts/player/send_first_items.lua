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
			{ 3567, 1 }, -- blue robe
			{ 7992, 1 }, -- mage hat
			{ 10387, 1 }, -- zaoan legs
			{ 10386, 1 }, -- zaoan shoes
			{ 3572, 1 }, -- scarf
		},

		container = {
			{ 3043, 5 }, -- crystal coin
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 268, 10 }, -- mana potion
		},
	},

	[VOCATION.ID.DRUID] = {
		items = {
			{ 3059, 1 }, -- spellbook
			{ 3066, 1 }, -- snakebite rod
			{ 3567, 1 }, -- blue robe
			{ 7992, 1 }, -- mage hat
			{ 10387, 1 }, -- zaoan legs
			{ 10386, 1 }, -- zaoan shoes
			{ 3572, 1 }, -- scarf
		},

		container = {
			{ 3043, 5 }, -- crystal coin
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 268, 10 }, -- mana potion
		},
	},

	[VOCATION.ID.PALADIN] = {
		items = {
			{ 3416, 1 }, -- dragon shield
			{ 3277, 1 }, -- spear
			{ 3567, 1 }, -- blue robe
			{ 10387, 1 }, -- zaoan legs
			{ 10386, 1 }, -- zaoan shoes
			{ 3572, 1 }, -- scarf
			{ 3351, 1 }, -- steel helmet
		},

		container = {
			{ 3043, 5 }, -- crystal coin
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 266, 10 }, -- health potion
			{ 3350, 1 }, -- bow
			{ 3447, 1 }, -- 1 arrows
		},
	},

	[VOCATION.ID.KNIGHT] = {
		items = {
			{ 3416, 1 }, -- dragon shield
			{ 3316, 1 }, -- orcish axe
			{ 3567, 1 }, -- blue robe
			{ 3351, 1 }, -- steel helmet
			{ 10387, 1 }, -- zaoan legs
			{ 10386, 1 }, -- zaoan shoes
			{ 3572, 1 }, -- scarf
		},

		container = {
			{ 3043, 5 }, -- crystal coin
			{ 3297, 1 }, -- serpent sword
			{ 3282, 1 }, -- morning star
			{ 3003, 1 }, -- rope
			{ 5710, 1 }, -- light shovel
			{ 266, 10 }, -- health potion
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
