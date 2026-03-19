---@class AdventureFemaleA: Character
---@overload fun(location: Vector, rotation: Rotator): AdventureFemaleA
NanosWorldCharacters.AdventureFemaleA = BaseDefaultCharacter.Inherit("AdventureFemaleA", {
	name = "Adventure Female A",
	image = "assets://nanos-world/Thumbnails/SK_Adventure_01.jpg",
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
				"nanos-world::MI_Adventure_01_01",
				"nanos-world::MI_Adventure_01_02",
				"nanos-world::MI_Adventure_01_03",
			}
		}
	}
})

-- Constructor
function NanosWorldCharacters.AdventureFemaleA:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Adventure_01_Full_02", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end