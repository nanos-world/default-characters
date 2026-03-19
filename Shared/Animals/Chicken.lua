---@class Chicken: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Chicken
NanosWorldCharacters.Chicken = BaseDefaultCharacterSimple.Inherit("Chicken", {
	name = "Chicken",
	image = "assets://nanos-world/Thumbnails/SK_Chicken.jpg",
	category = "animals",

	-- Customization
	materials = {
		"nanos-world::MI_Chicken_A",
		"nanos-world::MI_Chicken_B",
		"nanos-world::MI_Chicken_C",
	},
	random_sound = "nanos-world::A_Chicken",
	spawn_sound = "nanos-world::A_Chicken"
})

-- Constructor
function NanosWorldCharacters.Chicken:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Chicken", "nanos-world::ABP_Chicken", (enable_ai ~= false))

	self:SetMaterial(NanosWorldCharacters.Chicken.materials[math.random(#NanosWorldCharacters.Chicken.materials)])

	self:SetAirControl(0.5)
	self:SetJumpZVelocity(300)
	self:SetGravityScale(0.5)
	self:SetCapsuleSize(20, 20)
	self:SetSpeedSettings(300, 150)
	self:SetAIAvoidanceSettings(true, 30)
	self:SetRotationSettings(Rotator(0, 500, 0), false, true)

	-- TODO method on CharacterSimple
	-- self:SetPhysicalAnimationSettings("CHICKEN_-Spine", false, true)
end