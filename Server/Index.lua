NanosWorldCharactersHelper = {}

function NanosWorldCharactersHelper.SelectRandomMesh(mesh)
	if (type(mesh) == "table") then
		return NanosWorldCharactersHelper.SelectRandomMesh(mesh[math.random(#mesh)])
	else
		return mesh
	end
end

-- Helper to add randomization to Characters, called in their constructors
function NanosWorldCharactersHelper.CustomizeCharacter(character)
	local class = character:GetClass()

	-- Death/Pain Sounds
	local selected_death_sound = ""
	local selected_pain_sound = ""

	if (class.is_male) then
		selected_death_sound = MALE_DEATH_SOUNDS[math.random(#MALE_DEATH_SOUNDS)]
		selected_pain_sound = MALE_PAIN_SOUNDS[math.random(#MALE_PAIN_SOUNDS)]
	else
		selected_death_sound = FEMALE_DEATH_SOUNDS[math.random(#FEMALE_DEATH_SOUNDS)]
		selected_pain_sound = FEMALE_PAIN_SOUNDS[math.random(#FEMALE_PAIN_SOUNDS)]
	end

	character:SetDeathSound(selected_death_sound)
	character:SetPainSound(selected_pain_sound)

	if (class.skeletal_meshes ~= nil) then
		for id, skeletal_meshes in pairs(class.skeletal_meshes) do
			local skeletal_mesh = NanosWorldCharactersHelper.SelectRandomMesh(skeletal_meshes)
			if (skeletal_mesh ~= "") then
				character:AddSkeletalMeshAttached(id, skeletal_mesh)
			end
		end
	end

	if (class.static_meshes ~= nil) then
		for id, static_mesh_config in pairs(class.static_meshes) do
			local static_mesh = NanosWorldCharactersHelper.SelectRandomMesh(static_mesh_config.meshes)
			if (static_mesh ~= "") then
				character:AddStaticMeshAttached(id, static_mesh, static_mesh_config.socket)
			end
		end
	end

	if (class.morph_targets ~= nil) then
		for _, morph_target in pairs(class.morph_targets) do
			local value = math.random(100) / 100 - 0.5 -- Only from -0.5 ~ 0.5
			character:SetMorphTarget(morph_target, value)
		end
	end

	if (class.morph_targets_force ~= nil) then
		for morph_target, value in pairs(class.morph_targets_force) do
			character:SetMorphTarget(morph_target, value)
		end
	end

	if (class.materials ~= nil) then
		for _, material_config in pairs(class.materials) do
			local selected_material = math.random(#material_config.values)
			character:SetMaterial(material_config.values[selected_material], material_config.index, material_config.slot)
		end
	end

	if (class.materials_parameters_color ~= nil) then
		for _, materials_parameter_color in pairs(class.materials_parameters_color) do
			local selected_material = math.random(#materials_parameter_color.values)
			character:SetMaterialColorParameter(materials_parameter_color.parameter, materials_parameter_color.values[selected_material], -1, materials_parameter_color.slot)
		end
	end
end