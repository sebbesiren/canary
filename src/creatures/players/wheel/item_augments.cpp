void ItemAugmentContext::addStrategies(ItemAugment_t modifier){
	WheelSpells::Bonus bonus;

	switch(modifier){
		case ItemAugment_t::Knight_FierceBerserk_PowerfulImpact:
			bonus.increase.damage = 25;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Fierce Berserk", bonus));
			break;
		case ItemAugment_t::Knight_FierceBerserk_StrongImpact:
			bonus.increase.damage = 12.5;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Fierce Berserk", bonus));
			break;
		case ItemAugment_t::Knight_FierceBerserk_CriticalExtraDamage:
			bonus.increase.criticalDamage = 8;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Fierce Berserk", bonus));
			break;
		case ItemAugment_t::Knight_AvatarOfSteel_Cooldown:
			bonus.decrease.cooldown = 900 * 1000;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Avatar of Steel", bonus));
			break;

		case ItemAugment_t::Paladin_DivineCaldera_PowerfulImpact:
			bonus.increase.damage = 25;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Divine Caldera", bonus));
			break;
		case ItemAugment_t::Paladin_DivineCaldera_StrongImpact:
			bonus.increase.damage = 12.5;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Divine Caldera", bonus));
			break;
		case ItemAugment_t::Paladin_DivineCaldera_CriticalExtraDamage:
			bonus.increase.criticalDamage = 8;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Divine Caldera", bonus));
			break;
		case ItemAugment_t::Paladin_AvatarOfLight_Cooldown:
			bonus.decrease.cooldown = 900 * 1000;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Avatar of Light", bonus));
			break;

		case ItemAugment_t::Druid_EternalWinter_PowerfulImpact:
			bonus.increase.damage = 25;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Eternal Winter", bonus));
			break;
		case ItemAugment_t::Druid_EternalWinter_StrongImpact:
			bonus.increase.damage = 12.5;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Eternal Winter", bonus));
			break;
		case ItemAugment_t::Druid_EternalWinter_CriticalExtraDamage:
			bonus.increase.criticalDamage = 8;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Eternal Winter", bonus));
			break;
		case ItemAugment_t::Druid_TerraWave_PowerfulImpact:
			bonus.increase.damage = 25;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Terra Wave", bonus));
			break;
		case ItemAugment_t::Druid_TerraWave_StrongImpact:
			bonus.increase.damage = 12.5;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Terra Wave", bonus));
			break;
		case ItemAugment_t::Druid_TerraWave_CriticalExtraDamage:
			bonus.increase.criticalDamage = 8;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Terra Wave", bonus));
			break;
		case ItemAugment_t::Druid_AvatarOfNature_Cooldown:
			bonus.decrease.cooldown = 900 * 1000;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Avatar of Nature", bonus));
			break;

		case ItemAugment_t::Sorcerer_HellsCore_PowerfulImpact:
			bonus.increase.damage = 25;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Hell's Core", bonus));
			break;
		case ItemAugment_t::Sorcerer_HellsCore_StrongImpact:
			bonus.increase.damage = 12.5;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Hell's Core", bonus));
			break;
		case ItemAugment_t::Sorcerer_HellsCore_CriticalExtraDamage:
			bonus.increase.criticalDamage = 8;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Hell's Core", bonus));
			break;
		case ItemAugment_t::Sorcerer_EnergyWave_PowerfulImpact:
			bonus.increase.damage = 25;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Energy Wave", bonus));
			break;
		case ItemAugment_t::Sorcerer_EnergyWave_StrongImpact:
			bonus.increase.damage = 12.5;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Energy Wave", bonus));
			break;
		case ItemAugment_t::Sorcerer_EnergyWave_CriticalExtraDamage:
			bonus.increase.criticalDamage = 8;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Energy Wave", bonus));
			break;
		case ItemAugment_t::Sorcerer_AvatarOfStorm_Cooldown:
			bonus.decrease.cooldown = 900 * 1000;
			m_strategies.push_back(std::make_unique<GemModifierSpellBonusStrategy>(m_wheel, "Avatar of Storm", bonus));
			break;

		default:
			g_logger().error("WheelModifierContext::setStrategy: Invalid item augment modifier: {}", static_cast<uint8_t>(modifier));
	}
}
