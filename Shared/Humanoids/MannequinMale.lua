---@class MannequinMale: Character
---@overload fun(location: Vector, rotation: Rotator): MannequinMale
NanosWorldCharacters.MannequinMale = BaseDefaultCharacter.Inherit("MannequinMale", {
	name = "Mannequin Male",
	image = "assets://nanos-world/Thumbnails/SK_Mannequin.jpg",
	category = "humanoids",

	-- Customization
	is_male = true
})

-- Constructor
function NanosWorldCharacters.MannequinMale:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Mannequin", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end