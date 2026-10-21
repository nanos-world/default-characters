---@class DeerStag: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): DeerStag
NanosWorldCharacters.DeerStag = BaseDefaultCharacterSimple.Inherit("DeerStag", {
	name = "Deer (Stag)",
	image = "assets://nanos-world/Thumbnails/SK_DeerStag.jpg",
	category = "animals",
})

-- Constructor
function NanosWorldCharacters.DeerStag:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_DeerStag", "nanos-world::ABP_DeerStag", (enable_ai ~= false))

	self:SetHealth(200)
	self:SetMaxHealth(200)
	self:SetCapsuleSize(35, 105)
	self:SetSpeedSettings(633, 211)

	self:SetMaxAcceleration(538)
	self:SetBrakingSettings(4, 0.3, 645, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 45)
	self:SetRotationSettings(Rotator(0, 180, 0), false, true)
end