---@class DeerDoe: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): DeerDoe
NanosWorldCharacters.DeerDoe = BaseDefaultCharacterSimple.Inherit("DeerDoe", {
	name = "Deer (Doe)",
	image = "assets://nanos-world/Thumbnails/SK_DeerDoe.jpg",
	category = "animals",
})

-- Constructor
function NanosWorldCharacters.DeerDoe:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_DeerDoe", "nanos-world::ABP_DeerDoe", (enable_ai ~= false))

	self:SetHealth(150)
	self:SetMaxHealth(150)
	self:SetCapsuleSize(32, 76)
	self:SetSpeedSettings(574, 191)

	self:SetMaxAcceleration(487)
	self:SetBrakingSettings(4, 0.3, 585, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 42)
	self:SetRotationSettings(Rotator(0, 180, 0), false, true)
end