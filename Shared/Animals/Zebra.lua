---@class Zebra: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Zebra
NanosWorldCharacters.Zebra = BaseDefaultCharacterSimple.Inherit("Zebra", {
	name = "Zebra",
	image = "assets://nanos-world/Thumbnails/SK_Zebra.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Zebra",
	spawn_sound = "nanos-world::A_Zebra",
})

-- Constructor
function NanosWorldCharacters.Zebra:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Zebra", "nanos-world::ABP_Zebra", (enable_ai ~= false))

	self:SetHealth(250)
	self:SetMaxHealth(250)
	self:SetCapsuleSize(40, 95)
	self:SetSpeedSettings(900, 300)

	self:SetMaxAcceleration(765)
	self:SetBrakingSettings(4, 0.3, 918, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 50)
	self:SetRotationSettings(Rotator(0, 150, 0), false, true)

	-- Disables crouching since we don't have a resting animation
	self:SetCanCrouch(false)
end