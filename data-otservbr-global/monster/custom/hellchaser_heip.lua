local mType = Game.createMonsterType("Hellchaser Heip")
local monster = {}

monster.description = "Hellchaser Heip"
monster.outfit = {
	lookType = 1057,
	lookHead = 114,
	lookBody = 95,
	lookLegs = 94,
	lookFeet = 78,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 800000
monster.maxHealth = monster.health
monster.experience = 16000000
monster.race = "blood"
monster.corpse = 28625
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.bosstiary = {
	bossRaceId = 5002,
	bossRace = RARITY_ARCHFOE,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "bag you covet", chance = 400, maxCount = 1 },
	{ name = "bag you desire", chance = 1000, maxCount = 1 },
	{ name = "primal bag", chance = 3000, maxCount = 1 },
}

monster.attacks = {
	-- CONST_ME_BIG_SCRATCH
	-- CONST_ANI_ENERGY
	-- CONST_ANI_FIRE

	-- Melee atks
	{ name = "heip melee", interval = 2000, chance = 100, range = 1 },
	{ name = "two way blast", interval = 2100, chance = 10 },
	{ name = "cross blast", interval = 2000, chance = 10 },

	-- range atks
	{ name = "heip energy ball", interval = 4000, chance = 50 },
	{ name = "heip inferno strike", interval = 5000, chance = 50 },

	-- stage atks (boss has to stand still)
	{ name = "small mortar", interval = 2000, chance = 20 },
	{ name = "small mortar", interval = 2000, chance = 20 },
	{ name = "large ripple blast", interval = 15000, chance = 50 },
}

monster.defenses = {
	defense = 60,
	armor = 82,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
