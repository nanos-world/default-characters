---@class AdventureMaleC: Character
---@overload fun(location: Vector, rotation: Rotator): AdventureMaleC
NanosWorldCharacters.AdventureMaleC = BaseDefaultCharacter.Inherit("AdventureMaleC", {
	name = "Adventure Male C",
	image = "assets://nanos-world/Thumbnails/SK_Adventure_05.jpg",
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
				"nanos-world::MI_Adventure_05_01",
				"nanos-world::MI_Adventure_05_02",
				"nanos-world::MI_Adventure_05_03",
				"nanos-world::MI_Adventure_05_NoTattoo_01",
				"nanos-world::MI_Adventure_05_NoTattoo_02",
				"nanos-world::MI_Adventure_05_NoTattoo_03",
			}
		}
	}
})

-- Constructor
function NanosWorldCharacters.AdventureMaleC:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Adventure_05_Full_02", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end