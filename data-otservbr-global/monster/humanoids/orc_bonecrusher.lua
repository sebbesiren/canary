local mType = Game.createMonsterType("Orc Bonecrusher")
local monster = {}

monster.health = 6000
monster.maxHealth = monster.health

monster.description = "An orc bonecrusher"
monster.experience = monster.health
monster.outfit = {
	lookType = 8,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.race = "blood"
monster.corpse = 5980
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "WH-I-I-I-R-L-WIND!", yell = false }
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, maxCount = 20 },
	{ id = 20086, chance = 50 }, -- umbral crossbow
	{ id = 20071, chance = 50 }, -- umbral axe
	{ id = 20074, chance = 50 }, -- umbral chopper
	{ id = 16129, chance = 100 }, -- major crystalline token
}

monster.attacks = {
	{ name = "melee", interval = 5000, chance = 100, minDamage = 0, maxDamage = -1600 },
	{ name = "Berserk", interval = 1000, chance = 100, minDamage = 0, maxDamage = -400, target = false },
	{ name = "condition", type = CONDITION_BLEEDING, interval = 12000, chance = 10, minDamage = -300, maxDamage = -400, radius = 4, target = true },
}

monster.defenses = {
	defense = 50,
	armor = 50,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 }
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }
}

mType:register(monster)
