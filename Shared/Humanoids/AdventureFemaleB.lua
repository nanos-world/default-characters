---@class AdventureFemaleB: Character
---@overload fun(location: Vector, rotation: Rotator): AdventureFemaleB
NanosWorldCharacters.AdventureFemaleB = BaseDefaultCharacter.Inherit("AdventureFemaleB", {
	name = "Adventure Female B",
	image = "assets://nanos-world/Thumbnails/SK_Adventure_03.jpg",
	category = "humanoids",

	-- Customization
	is_male = false,
	speak_animation = "nanos-world::A_Adventure_Mouth_Talk",
	morph_targets_force = {
		["Close_Mouth"] = 1
	},
	materials = {
		{
			slot = "",
			index = 0,
			values = {
				"nanos-world::MI_Adventure_03_01",
				"nanos-world::MI_Adventure_03_02",
				"nanos-world::MI_Adventure_03_03",
			}
		}
	}
})

-- Constructor
function NanosWorldCharacters.AdventureFemaleB:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Adventure_03_Full_02", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end