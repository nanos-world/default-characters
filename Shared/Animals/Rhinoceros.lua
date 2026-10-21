---@class Rhinoceros: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Rhinoceros
NanosWorldCharacters.Rhinoceros = BaseDefaultCharacterSimple.Inherit("Rhinoceros", {
	name = "Rhinoceros",
	image = "assets://nanos-world/Thumbnails/SK_Rhinoceros.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Rhinoceros",
	spawn_sound = "nanos-world::A_Rhinoceros",
})

-- Constructor
function NanosWorldCharacters.Rhinoceros:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Rhinoceros", "nanos-world::ABP_Rhinoceros", (enable_ai ~= false))

	self:SetHealth(1000)
	self:SetMaxHealth(1000)
	self:SetCapsuleSize(75, 101)
	self:SetSpeedSettings(520, 173)

	self:SetMaxAcceleration(312)
	self:SetBrakingSettings(4, 0.3, 374, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 85)
	self:SetRotationSettings(Rotator(0, 90, 0), false, true)

	-- Disables crouching since we don't have a resting animation
	self:SetCanCrouch(false)
end