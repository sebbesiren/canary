local mType = Game.createMonsterType("Balrog")
local monster = {}

monster.description = "A mighty demon"
monster.health = 600000
monster.maxHealth = monster.health

monster.experience = monster.health * 5
monster.outfit = {
	lookType = 1468,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.race = "fire"
monster.corpse = 5995
monster.speed = 128
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20
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
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
	maxSummons = 6,
	summons = {
		{ name = "demon", chance = 100, interval = 10000, count = 1 }
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "MUST KILL TRANAN!", yell = false },
	{ text = "I SMELL TRANAN!", yell = false },
	{ text = "OFFER TRANAN TO ME NOW!", yell = false },
	{ text = "IT IS TRANJAKT!", yell = false },
}

monster.loot = {
	{ id = 3039, chance = 2220, maxCount = 20 }, -- red gem
	{ name = "crystal coin", chance = 90540, maxCount = 10 },
	{ name = "golden legs", chance = 2000 },
	{ name = "magic plate armor", chance = 130 },
	{ name = "mastermind shield", chance = 480 },
	{ name = "demon shield", chance = 2000 },
	{ name = "fire mushroom", chance = 19660, maxCount = 100 },
	{ name = "demon horn", chance = 40920, maxCount = 10 },
	{ name = "demonrage sword", chance = 1500 },
	{ id = 32616, chance = 300 }, -- phantasmal axe
	{ name = "ghost chestplate", chance = 150 },
	{ name = "fabulous legs", chance = 150 },
	{ name = "soulful legs", chance = 150 },
	{ name = "galea mortis", chance = 150 },
	{ name = "toga mortis", chance = 500 },
	{ id = 16114, chance = 10000 }, -- prismatic ring
	{id = 27649, chance = 510}, -- gnome legs
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -5000, range = 1, radius = 5, effect = CONST_ME_MAGIC_GREEN, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -800, range = 7, radius = 6, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 4000, chance = 35, type = COMBAT_ICEDAMAGE, minDamage = -900, maxDamage = -1100, range = 7, radius = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 1200, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -4000, maxDamage = -6000, length = 8, spread = 3, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "gaz'haragoth iceball", interval = 10000, chance = 100, minDamage = -1000, maxDamage = -1500, target = false },
	{ name = "gaz'haragoth death", interval = 30000, chance = 100, target = false },
	{ name = "gaz'haragoth paralyze", interval = 8000, chance = 100, target = false },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 180, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 }
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -12 },
	{ type = COMBAT_HOLYDAMAGE, percent = -12 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 }
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
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
