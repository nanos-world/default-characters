---@class Wolf: CharacterSimple
---@overload fun(location: Vector, rotation: Rotator): Wolf
NanosWorldCharacters.Wolf = BaseDefaultCharacterSimple.Inherit("Wolf", {
	name = "Wolf",
	image = "assets://nanos-world/Thumbnails/SK_Wolf.jpg",
	category = "animals",

	-- Random cue: calls now and then and on spawn, also used when hurt and dying
	random_sound = "nanos-world::A_Wolf",
	spawn_sound = "nanos-world::A_Wolf",

	-- Customization: one entry per look, a material per slot (body, fur)
	materials = {
		{ "nanos-world::M_Wolf", "nanos-world::M_WolfFur" },
		{ "nanos-world::M_WolfArctic", "nanos-world::M_WolfFurArctic" },
		{ "nanos-world::M_WolfDark", "nanos-world::M_WolfFurDark" },
	},
})

-- Constructor
function NanosWorldCharacters.Wolf:Constructor(location, rotation, enable_ai)
	BaseDefaultCharacterSimple.Constructor(self, location or Vector(), rotation or Rotator(), "nanos-world::SK_Wolf", "nanos-world::ABP_Wolf", (enable_ai ~= false))

	local materials = NanosWorldCharacters.Wolf.materials[math.random(#NanosWorldCharacters.Wolf.materials)]
	for slot, material in ipairs(materials) do
		self:SetMaterial(material, slot - 1)
	end

	self:SetHealth(120)
	self:SetMaxHealth(120)
	self:SetCapsuleSize(28, 49)
	self:SetSpeedSettings(445, 148)

	self:SetMaxAcceleration(378)
	self:SetBrakingSettings(4, 0.3, 453, 0, 0, 0)

	self:SetAIAvoidanceSettings(true, 38)
	self:SetRotationSettings(Rotator(0, 250, 0), false, true)
end