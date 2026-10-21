---@class Crocodile: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Crocodile
NanosWorldCharacters.Crocodile = BaseDefaultCharacterSimple.Inherit("Crocodile", {
	name = "Crocodile",
	image = "assets://nanos-world/Thumbnails/SK_Crocodile.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Crocodile",
	spawn_sound = "nanos-world::A_Crocodile",

	-- Customization: one entry per look, a material per slot (body, fur)
	materials = {
		{ "nanos-world::M_Crocodile" },
		{ "nanos-world::M_CrocodileDirty" },
	},
})

-- Constructor
function NanosWorldCharacters.Crocodile:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Crocodile", "nanos-world::ABP_Crocodile", (enable_ai ~= false))

	local materials = NanosWorldCharacters.Crocodile.materials[math.random(#NanosWorldCharacters.Crocodile.materials)]
	for slot, material in ipairs(materials) do
		self:SetMaterial(material, slot - 1)
	end

	self:SetHealth(400)
	self:SetMaxHealth(400)
	self:SetCapsuleSize(55, 55)
	self:SetSpeedSettings(150, 50)

	-- Ramps speed up and down instead of starting and stopping in one frame
	self:SetMaxAcceleration(90)
	self:SetBrakingSettings(4, 0.3, 108, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 65)
	self:SetRotationSettings(Rotator(0, 60, 0), false, true)
end