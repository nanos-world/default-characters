---@class Male: Character
---@overload fun(location: Vector, rotation: Rotator): Male
NanosWorldCharacters.Male = BaseDefaultCharacter.Inherit("Male", {
	name = "Male",
	image = "assets://nanos-world/Thumbnails/SK_Male.jpg",
	category = "humanoids",

	-- Customization
	is_male = true,
	skeletal_meshes = {
		["shirt"] = {
			"nanos-world::SK_Underwear",
			"nanos-world::SK_Shirt",
		},
		["pants"] = {
			"nanos-world::SK_Pants",
			"",
		},
		["shoes"] = {
			"nanos-world::SK_Shoes_01",
			"nanos-world::SK_Shoes_02",
		},
		["tie"] = {
			"nanos-world::SK_Tie",
			""
		}
	},
	static_meshes = {
		["hair"] = {
			socket = "hair_male",
			meshes = {
				"",
				"nanos-world::SM_Hair_Long",
				"nanos-world::SM_Hair_Short"
			}
		},
		["beard"] = {
			socket = "beard",
			meshes = {
				"",
				"nanos-world::SM_Beard_Extra",
				"nanos-world::SM_Beard_Middle",
				"nanos-world::SM_Beard_Mustache_01",
				"nanos-world::SM_Beard_Mustache_02",
				"nanos-world::SM_Beard_Side"
			}
		},
		["eye_left"] = {
			socket = "eye_left",
			meshes = {
				"nanos-world::SM_Eye"
			}
		},
		["eye_right"] = {
			socket = "eye_right",
			meshes = {
				"nanos-world::SM_Eye"
			}
		}
	},
	materials_parameters_color = {
		{
			parameter = "Tint",
			slot = "",
			values = {
				Color(1.000000, 1.000000, 1.000000),
				Color(1.000000, 0.926933, 0.820785),
				Color(0.984375, 0.854302, 0.661377),
				Color(1.000000, 0.866979, 0.785255),
				Color(0.890625, 0.768996, 0.658135),
				Color(0.880208, 0.706081, 0.588818),
				Color(0.526042, 0.340051, 0.221689),
				Color(0.244792, 0.185846, 0.151720),
				Color(0.791667, 0.573959, 0.428820),
				Color(0.947917, 0.655642, 0.399902),
				Color(0.583333, 0.406594, 0.261284),
				Color(0.645833, 0.465268, 0.360730),
				Color(1.000000, 0.917535, 0.739583),
				Color(0.932292, 0.825388, 0.670085),
				Color(0.817708, 0.710384, 0.549398),
				Color(0.765625, 0.620475, 0.454590),
				Color(0.050000, 0.050000, 0.080000),
			}
		},
		{
			parameter = "HairTint",
			slot = "hair",
			values = {
				Color(0.067708, 0.030797, 0.001471),
				Color(0.983483, 1.000000, 0.166667),
				Color(0.010000, 0.010000, 0.010000),
				Color(1.000000, 0.129006, 0.000000),
			}
		},
		{
			parameter = "HairTint",
			slot = "beard",
			values = {
				Color(0.067708, 0.030797, 0.001471),
				Color(0.983483, 1.000000, 0.166667),
				Color(0.010000, 0.010000, 0.010000),
				Color(1.000000, 0.129006, 0.000000),
			}
		}
	},
	morph_targets = {
		"nose1",
		"nose2",
		"brows",
		"mouth",
		"fat",
		"nose3",
		"chin",
		"face",
		"nose4",
		"skinny",
		"jaw",
		"brows2",
		"angry",
		-- "smirk",
		-- "smirk2",
		-- "smirk3",
		"smile",
		"nose6",
		"jaw_forward",
		"lips",
		"lips2",
		"mouth_wide",
		"eyes1",
		"eyes2",
		"eyes3",
		"eyes4",
		"eyes_retraction",
		"lips3",
		"eyes5",
		"nose7",
		"forehead",
		"bodyfat",
	}
})

-- Constructor
function NanosWorldCharacters.Male:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Male", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end