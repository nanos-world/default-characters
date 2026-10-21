---@class Lioness: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Lioness
NanosWorldCharacters.Lioness = BaseDefaultCharacterSimple.Inherit("Lioness", {
	name = "Lioness",
	image = "assets://nanos-world/Thumbnails/SK_Lioness.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Lion",
	spawn_sound = "nanos-world::A_Lion",
})

-- Constructor
function NanosWorldCharacters.Lioness:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Lioness", "nanos-world::ABP_Lion", (enable_ai ~= false))

	self:SetHealth(250)
	self:SetMaxHealth(250)
	self:SetCapsuleSize(38, 67)
	self:SetSpeedSettings(800, 266)

	self:SetMaxAcceleration(680)
	self:SetBrakingSettings(4, 0.3, 816, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 48)
	self:SetRotationSettings(Rotator(0, 180, 0), false, true)
end