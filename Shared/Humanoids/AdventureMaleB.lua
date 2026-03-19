---@class AdventureMaleB: Character
---@overload fun(location: Vector, rotation: Rotator): AdventureMaleB
NanosWorldCharacters.AdventureMaleB = BaseDefaultCharacter.Inherit("AdventureMaleB", {
	name = "Adventure Male B",
	image = "assets://nanos-world/Thumbnails/SK_Adventure_04.jpg",
	category = "humanoids",

	-- Customization
	is_male = true,
	speak_animation = "nanos-world::A_Adventure_Mouth_Talk",
	morph_targets_force = {
		["Close_Mouth"] = 1
	},
	materials = {
		{
			slot = "",
			index = 0,
			values = {
				"nanos-world::MI_Adventure_04_01",
				"nanos-world::MI_Adventure_04_02",
				"nanos-world::MI_Adventure_04_03",
			}
		}
	}
})

-- Constructor
function NanosWorldCharacters.AdventureMaleB:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Adventure_04_Full_02", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end