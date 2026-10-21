---@class Lion: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Lion
NanosWorldCharacters.Lion = BaseDefaultCharacterSimple.Inherit("Lion", {
	name = "Lion",
	image = "assets://nanos-world/Thumbnails/SK_Lion.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Lion",
	spawn_sound = "nanos-world::A_Lion",
})

-- Constructor
function NanosWorldCharacters.Lion:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Lion", "nanos-world::ABP_Lion", (enable_ai ~= false))

	self:SetHealth(300)
	self:SetMaxHealth(300)
	self:SetCapsuleSize(40, 72)
	self:SetSpeedSettings(800, 266)

	self:SetMaxAcceleration(680)
	self:SetBrakingSettings(4, 0.3, 816, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 50)
	self:SetRotationSettings(Rotator(0, 180, 0), false, true)
end