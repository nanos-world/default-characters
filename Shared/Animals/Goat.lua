---@class Goat: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Goat
NanosWorldCharacters.Goat = BaseDefaultCharacterSimple.Inherit("Goat", {
	name = "Goat",
	image = "assets://nanos-world/Thumbnails/SK_Goat.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Goat",
	spawn_sound = "nanos-world::A_Goat",
})

-- Constructor
function NanosWorldCharacters.Goat:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Goat", "nanos-world::ABP_Goat", (enable_ai ~= false))

	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetCapsuleSize(25, 55)
	self:SetSpeedSettings(350, 116)

	self:SetMaxAcceleration(297)
	self:SetBrakingSettings(4, 0.3, 357, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 35)
	self:SetRotationSettings(Rotator(0, 200, 0), false, true)
end