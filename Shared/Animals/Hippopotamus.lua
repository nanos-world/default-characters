---@class Hippopotamus: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Hippopotamus
NanosWorldCharacters.Hippopotamus = BaseDefaultCharacterSimple.Inherit("Hippopotamus", {
	name = "Hippopotamus",
	image = "assets://nanos-world/Thumbnails/SK_Hippopotamus.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Hippopotamus",
	spawn_sound = "nanos-world::A_Hippopotamus",
})

-- Constructor
function NanosWorldCharacters.Hippopotamus:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Hippopotamus", "nanos-world::ABP_Hippopotamus", (enable_ai ~= false))

	self:SetHealth(800)
	self:SetMaxHealth(800)
	self:SetCapsuleSize(70, 90)
	self:SetSpeedSettings(600, 200)

	self:SetMaxAcceleration(360)
	self:SetBrakingSettings(4, 0.3, 432, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 80)
	self:SetRotationSettings(Rotator(0, 90, 0), false, true)
end