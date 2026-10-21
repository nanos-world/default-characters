---@class Fox: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Fox
NanosWorldCharacters.Fox = BaseDefaultCharacterSimple.Inherit("Fox", {
	name = "Fox",
	image = "assets://nanos-world/Thumbnails/SK_Fox.jpg",
	category = "animals",
})

-- Constructor
function NanosWorldCharacters.Fox:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Fox", "nanos-world::ABP_Fox", (enable_ai ~= false))

	self:SetHealth(60)
	self:SetMaxHealth(60)
	self:SetCapsuleSize(18, 28)
	self:SetSpeedSettings(263, 87)

	self:SetMaxAcceleration(223)
	self:SetBrakingSettings(4, 0.3, 268, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 28)
	self:SetRotationSettings(Rotator(0, 250, 0), false, true)
end