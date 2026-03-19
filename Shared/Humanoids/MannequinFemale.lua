---@class MannequinFemale: Character
---@overload fun(location: Vector, rotation: Rotator): Female
NanosWorldCharacters.MannequinFemale = BaseDefaultCharacter.Inherit("MannequinFemale", {
	name = "Mannequin Female",
	image = "assets://nanos-world/Thumbnails/SK_Mannequin_Female.jpg",
	category = "humanoids",

	-- Customization
	is_male = false
})

-- Constructor
function NanosWorldCharacters.MannequinFemale:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Mannequin_Female", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end