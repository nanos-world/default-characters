---@class PostApocalyptic: Character
---@overload fun(location: Vector, rotation: Rotator): PostApocalyptic
NanosWorldCharacters.PostApocalyptic = BaseDefaultCharacter.Inherit("PostApocalyptic", {
	name = "Post Apocalyptic",
	image = "assets://nanos-world/Thumbnails/SK_PostApocalyptic.jpg",
	category = "humanoids",

	-- Customization
	is_male = true
})

-- Constructor
function NanosWorldCharacters.PostApocalyptic:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacter.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_PostApocalyptic", (enable_ai ~= false))

	NanosWorldCharactersHelper.CustomizeCharacter(self)
end