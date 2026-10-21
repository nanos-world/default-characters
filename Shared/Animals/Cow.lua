---@class Cow: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Cow
NanosWorldCharacters.Cow = BaseDefaultCharacterSimple.Inherit("Cow", {
	name = "Cow",
	image = "assets://nanos-world/Thumbnails/SK_Cow.jpg",
	category = "animals",

	-- Customization: one entry per look, a material per slot (body, fur)
	materials = {
		{ "nanos-world::M_Cow1", "nanos-world::M_CowFur1" },
		{ "nanos-world::M_Cow2", "nanos-world::M_CowFur2" },
		{ "nanos-world::M_Cow3", "nanos-world::M_CowFur3" },
	},
})

-- Constructor
function NanosWorldCharacters.Cow:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Cow", "nanos-world::ABP_Cow", (enable_ai ~= false))

	local materials = NanosWorldCharacters.Cow.materials[math.random(#NanosWorldCharacters.Cow.materials)]
	for slot, material in ipairs(materials) do
		self:SetMaterial(material, slot - 1)
	end

	self:SetHealth(300)
	self:SetMaxHealth(300)
	self:SetCapsuleSize(45, 69)
	self:SetSpeedSettings(600, 200)

	self:SetMaxAcceleration(360)
	self:SetBrakingSettings(4, 0.3, 432, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 55)
	self:SetRotationSettings(Rotator(0, 125, 0), false, true)
end