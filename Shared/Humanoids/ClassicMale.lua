---@class ClassicMale: Character
---@overload fun(location: Vector, rotation: Rotator): ClassicMale
NanosWorldCharacters.ClassicMale = BaseDefaultCharacter.Inherit("ClassicMale", {
	name = "Classic Male",
	image = "assets://nanos-world/Thumbnails/SK_ClassicMale.jpg",
	category = "humanoids",

	-- Customization
	is_male = true
})

-- Constructor
function NanosWorldCharacters.ClassicMale:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_ClassicMale", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end