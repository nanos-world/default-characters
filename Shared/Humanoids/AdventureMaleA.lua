---@class AdventureMaleA: Character
---@overload fun(location: Vector, rotation: Rotator): AdventureMaleA
NanosWorldCharacters.AdventureMaleA = BaseDefaultCharacter.Inherit("AdventureMaleA", {
	name = "Adventure Male A",
	image = "assets://nanos-world/Thumbnails/SK_Adventure_02.jpg",
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
				"nanos-world::MI_Adventure_02_01",
				"nanos-world::MI_Adventure_02_02",
				"nanos-world::MI_Adventure_02_03",
			}
		}
	}
})

-- Constructor
function NanosWorldCharacters.AdventureMaleA:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Adventure_02_Full_03", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end