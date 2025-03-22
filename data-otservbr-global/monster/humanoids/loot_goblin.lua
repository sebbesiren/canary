local mType = Game.createMonsterType("Loot Goblin")
local monster = {}

local LootGoblinConfig = {
	Storage = {
		SpawnTime = 1,
	},
	SecondsToDefeat = 180,
}

monster.description = "a loot goblin"
monster.experience = 25
monster.outfit = {
	lookType = 61,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

--monster.bosstiary = {
--	bossRaceId = 5003,
--	bossRace = RARITY_ARCHFOE,
--}

monster.health = 30000
monster.maxHealth = 30000
monster.race = "blood"
monster.corpse = 6002
monster.speed = 250
monster.manaCost = 290

monster.changeTarget = {
	interval = 5000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = true,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 29000,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 5,
	color = 197,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Zig Zag! Gobo attack!", yell = false },
	{ text = "Bugga! Bugga!", yell = false },
	{ text = "My precious!", yell = true },
	{ text = "Help! Goblinkiller!", yell = true },
}

monster.loot = {
	{ name = "crystal coin", chance = 50000, maxCount = 60 },
	{ name = "silver token", chance = 20000, maxCount = 20 },
	{ name = "bullseye potion", chance = 24490, maxCount = 5 },
	{ name = "berserk potion", chance = 22449, maxCount = 5 },
	{ name = "mastermind potion", chance = 18367, maxCount = 5 },
	{ name = "raw watermelon tourmaline", chance = 7322, maxCount = 3 },
	{ id = 22772, chance = 100, maxCount = 1 }, -- exp boost scroll

	{ name = "winged boots", chance = 40 },
	{ name = "tagralt blade", chance = 40 },
	{ id = 30403, chance = 40 }, -- enchanted theurgic amulet

	{ name = "falcon battleaxe", chance = 40 },
	{ name = "falcon longsword", chance = 40 },
	{ name = "falcon mace", chance = 40 },
	{ name = "grant of arms", chance = 40 },
	{ name = "falcon bow", chance = 40 },
	{ name = "falcon circlet", chance = 40 },
	{ name = "falcon coif", chance = 40 },
	{ name = "falcon rod", chance = 40 },
	{ name = "falcon wand", chance = 40 },
	{ name = "falcon shield", chance = 40 },
	{ name = "falcon greaves", chance = 40 },
	{ name = "falcon plate", chance = 40 },

	{ name = "dawnfire sherwani", chance = 40 },
	{ name = "frostflower boots", chance = 40 },
	{ name = "feverbloom boots", chance = 40 },
	{ id = 39233, chance = 40 }, -- enchanted turtle amulet
	{ name = "midnight tunic", chance = 40 },
	{ name = "midnight sarong", chance = 40 },
	{ name = "naga quiver", chance = 40 },
	{ name = "naga sword", chance = 40 },
	{ name = "naga axe", chance = 40 },
	{ name = "naga club", chance = 40 },
	{ name = "naga wand", chance = 40 },
	{ name = "naga rod", chance = 40 },
	{ name = "naga crossbow", chance = 40 },

	{ id = 32616, chance = 40 }, -- phantasmal axe
	{ name = "ghost chestplate", chance = 40 },
	{ name = "fabulous legs", chance = 40 },
	{ name = "soulful legs", chance = 40 },
	{ name = "galea mortis", chance = 40 },
	{ name = "toga mortis", chance = 40 },
	{ name = "gnome shield", chance = 40 },
	{ name = "gnome armor", chance = 40 },
	{ name = "gnome helmet", chance = 40 },
	{ name = "gnome sword", chance = 40 },

	{ name = "unerring dragon scale armor", chance = 40 },
	{ name = "dauntless dragon scale armor", chance = 40 },
	{ name = "arcane dragon robe", chance = 40 },
	{ name = "mystical dragon robe", chance = 40 },

	{ name = "amber crusher", chance = 250 },
	{ id = 47375, chance = 40 }, -- amber axe
	{ id = 47369, chance = 40 }, -- amber greataxe
	{ id = 47368, chance = 40 }, -- amber slayer
	{ id = 47374, chance = 40 }, -- amber sabre
	{ id = 47376, chance = 40 }, -- amber cudgel
	{ id = 47370, chance = 40 }, -- amber bludgeon
	{ id = 47371, chance = 40 }, -- amber bow
	{ id = 47377, chance = 40 }, -- amber crossbow
	{ id = 47372, chance = 40 }, -- amber wand
	{ id = 47373, chance = 40 }, -- amber rod
	{ id = 48514, chance = 40 }, -- strange inedible fruit

	{ name = "eldritch breeches", chance = 40 },
	{ name = "eldritch cowl", chance = 40 },
	{ name = "eldritch hood", chance = 40 },
	{ name = "eldritch bow", chance = 40 },
	{ name = "eldritch quiver", chance = 40 },
	{ name = "eldritch claymore", chance = 40 },
	{ name = "eldritch greataxe", chance = 40 },
	{ name = "eldritch warmace", chance = 40 },
	{ name = "eldritch shield", chance = 40 },
	{ name = "eldritch cuirass", chance = 40 },
	{ name = "eldritch folio", chance = 40 },
	{ name = "eldritch tome", chance = 40 },
	{ name = "eldritch rod", chance = 40 },
	{ name = "eldritch wand", chance = 40 },
	{ name = "gilded eldritch claymore", chance = 40 },
	{ name = "gilded eldritch greataxe", chance = 40 },
	{ name = "gilded eldritch warmace", chance = 40 },
	{ name = "gilded eldritch wand", chance = 40 },
	{ name = "gilded eldritch rod", chance = 40 },
	{ name = "gilded eldritch bow", chance = 40 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -600, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
}

monster.defenses = {
	defense = 10,
	armor = 6,
	mitigation = 0.20,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = -20 },
	{ type = COMBAT_MANADRAIN, percent = -20 },
	{ type = COMBAT_DROWNDAMAGE, percent = -20 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType.onSpawn = function(monster, spawnPosition)
	monster:setStorageValue(LootGoblinConfig.Storage.SpawnTime, os.time())
	monster:say("You have " .. LootGoblinConfig.SecondsToDefeat .. " seconds to kill the loot goblin.", TALKTYPE_MONSTER_SAY)
end
mType.onThink = function(monster, interval)
	if os.time() > monster:getStorageValue(LootGoblinConfig.Storage.SpawnTime) + LootGoblinConfig.SecondsToDefeat then
		if monster:getId() then
			monster:remove()
		end
	end
end

mType:register(monster)
