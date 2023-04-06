local mType = Game.createMonsterType("Ancient Dragon")
local monster = {}

monster.health = 8000
monster.maxHealth = monster.health

monster.description = "An ancient dragon"
monster.experience = monster.health * 1.2
monster.outfit = {
	lookType = 927,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.race = "blood"
monster.corpse = 5984
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 4,
	runHealth = 300,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "ZCHHHHHHH", yell = true },
	{ text = "I WILL ERASE YOU!", yell = true }
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 10, maxCount = 80 },
	{ name = "strange helmet", chance = 360 },
	{ name = "dragon scale mail", chance = 170 },
	{ name = "royal helmet", chance = 280 },
	{ name = "dragon slayer", chance = 100 },
	{ id = 20080, chance = 200 }, -- umbral hammer
	{ id = 20077, chance = 200 }, -- umbral mace
	{ id = 16114, chance = 200 }, -- prismatic ring
	{ id = 16129, chance = 200 }, -- major crystalline token
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -600, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 8000, chance = 100, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -600, length = 10, spread = 5, effect = CONST_ME_FIREAREA, target = false },
	{ name = "firefield", interval = 15000, chance = 100, range = 7, radius = 8, shootEffect = CONST_ANI_FIRE, target = true },
}

monster.defenses = {
	defense = 34,
	armor = 34,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 57, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false }
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = 80 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -10 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 }
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType:register(monster)
