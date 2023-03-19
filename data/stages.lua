-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 30,
		multiplier = 13
	}, {
		minlevel = 31,
		maxlevel = 50,
		multiplier = 10
	}, {
		minlevel = 51,
		maxlevel = 150,
		multiplier = 7
	}, {
		minlevel = 151,
		maxlevel = 250,
		multiplier = 5
	}, {
		minlevel = 251,
		multiplier = 3
	}
}

skillsStages = {
	{
		minlevel = 1,
		maxlevel = 250,
		multiplier = 5
	}, {
		minlevel = 251,
		multiplier = 3
	}
}

magicLevelStages = {
	{
		minlevel = 1,
		maxlevel = 250,
		multiplier = 5
	}, {
		minlevel = 251,
		multiplier = 3
	}
}
