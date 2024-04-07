enum class ItemAugment_t : uint8_t {
	Knight_FierceBerserk_PowerfulImpact,
	Knight_FierceBerserk_StrongImpact,
	Knight_FierceBerserk_CriticalExtraDamage,
	Knight_AvatarOfSteel_Cooldown,

	Paladin_DivineCaldera_PowerfulImpact,
	Paladin_DivineCaldera_StrongImpact,
	Paladin_DivineCaldera_CriticalExtraDamage,
	Paladin_AvatarOfLight_Cooldown,

	Druid_EternalWinter_PowerfulImpact,
	Druid_EternalWinter_StrongImpact,
	Druid_EternalWinter_CriticalExtraDamage,
	Druid_TerraWave_PowerfulImpact,
	Druid_TerraWave_StrongImpact,
	Druid_TerraWave_CriticalExtraDamage,
	Druid_AvatarOfNature_Cooldown,

	Sorcerer_HellsCore_PowerfulImpact,
	Sorcerer_HellsCore_StrongImpact,
	Sorcerer_HellsCore_CriticalExtraDamage,
	Sorcerer_EnergyWave_PowerfulImpact
		Sorcerer_EnergyWave_StrongImpact,
	Sorcerer_EnergyWave_CriticalExtraDamage,
	Sorcerer_AvatarOfStorm_Cooldown,
}

class ItemAugmentContext {
public:
	explicit ItemAugmentContext(PlayerWheel &wheel, Vocation_t vocation) :
		m_wheel(wheel), m_vocation(vocation) { }

	void addStrategies(ItemAugment_t modifier);

	void resetStrategies() {
		m_strategies.clear();
	}

	void executeStrategies();

private:
	std::vector<std::unique_ptr<GemModifierStrategy>> m_strategies;
	PlayerWheel &m_wheel;
	Vocation_t m_vocation;
};
