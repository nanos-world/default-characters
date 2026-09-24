# Default Characters

A collection of humanoids, animals and robots built with the meshes already included in the nanos world Default Asset Pack. Every character comes with randomized customization (clothes, hair, beards, skin, face morphs and voices) and an optional simple AI.

They all show up automatically in the [Sandbox](https://github.com/nanos-world/nanos-world-sandbox) Spawn Menu under the NPCs tab.


## Available Characters

| Class | Name | Base |
|---|---|---|
| `Male` | Male | Character |
| `Female` | Female | Character |
| `MannequinMale` | Mannequin Male | Character |
| `MannequinFemale` | Mannequin Female | Character |
| `ClassicMale` | Classic Male | Character |
| `PostApocalyptic` | Post Apocalyptic | Character |
| `AdventureMaleA` | Adventure Male A | Character |
| `AdventureMaleB` | Adventure Male B | Character |
| `AdventureMaleC` | Adventure Male C | Character |
| `AdventureFemaleA` | Adventure Female A | Character |
| `AdventureFemaleB` | Adventure Female B | Character |
| `Chicken` | Chicken | CharacterSimple |
| `StackOBot` | Stack-O-Bot | CharacterSimple |


## Features

- Random outfits, hair, beards, materials and face morph targets on every spawn
- Random male/female pain and death voices
- Optional AI: NPCs wander around, run away when damaged and get up after being ragdolled
- Dead NPCs are cleaned up automatically after 10 seconds
- AI is disabled automatically when a player possesses the character
- Sandbox Context Menu options to toggle "auto walk" and "run when damaged"


## Installation

Add it to the `packages_requirements` of your game-mode or package `Package.toml`:

```toml
packages_requirements = [
    "default-characters",
]
```


## Usage

Every character is a global class (they are also available in the exported `NanosWorldCharacters` table):

```lua
-- Constructor(location, rotation, enable_ai)
-- enable_ai defaults to true
local npc = Male(Vector(0, 0, 100), Rotator())
```


## Examples

Spawn a random character for each player that joins:

```lua
Player.Subscribe("Spawn", function(player)
	local character = AdventureFemaleA(Vector(0, 0, 100), Rotator(), false)
	player:Possess(character)
end)
```

Fill the map with wandering chickens:

```lua
for i = 1, 20 do
	Chicken(Vector(math.random(-2000, 2000), math.random(-2000, 2000), 100))
end
```

Control the AI manually:

```lua
local npc = Female(Vector(0, 0, 100), Rotator())

-- Stop wandering around
npc:SetAutoWalk(nil, false)

-- Don't flee when shot
npc:SetRunWhenDamaged(nil, false)

-- Or turn the whole AI off
npc:SetAIEnabled(false)
```
