-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 30,
		multiplier = 20,
	},
	{
		minlevel = 31,
		maxlevel = 150,
		multiplier = 15,
	},
	{
		minlevel = 151,
		maxlevel = 200,
		multiplier = 10,
	},
	{
		minlevel = 201,
		multiplier = 7,
	},
}

skillsStages = {
	{
		minlevel = 1,
		multiplier = 7,
	},
}

magicLevelStages = {
	{
		minlevel = 1,
		multiplier = 7,
	},
}
