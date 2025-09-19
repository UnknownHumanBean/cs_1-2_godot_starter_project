# Lesson 5: Player Combat - Shooting Projectiles

## What We're Learning Today
- How to create new objects while the game is running
- How to make objects move in different directions
- How to connect keyboard input to game actions
- How to use scene instantiation in Godot

## What We're Building
By the end of this lesson, your player will be able to shoot projectiles by pressing the spacebar! The projectiles will fly in whatever direction your player is facing and travel across the screen until they hit something or go off-screen.

## Today's New Programming Concept
**Dynamic Object Creation** - Instead of having all objects already in the level, we can create new objects while the game is running. This is how games create bullets, spawn enemies, drop items, and more!

## Part 1: Understanding the Code

### Step 1: Look at What We Need
To make projectiles work, we need:
- A projectile scene (the bullet/arrow object)
- A way to create new projectiles when we press a key
- Logic to make projectiles move in the right direction
- A way to remove projectiles when they're no longer needed

### Step 2: Understand Scene Instantiation
In Godot, we can load and create copies of scenes:
```gdscript
# Load the scene file
var projectile_scene = preload("res://scenes/projectile.tscn")

# Create a new instance (copy) of that scene  
var new_projectile = projectile_scene.instantiate()

# Add it to the game world
get_parent().add_child(new_projectile)
```

### Step 3: Think About Direction
From Lesson 2, we learned that the player has a `facing` variable that stores "up", "down", "left", or "right". We can use this to make projectiles go the right way!

## Part 2: Learning Object Creation

### The preload() Function
`preload()` loads a scene file and keeps it in memory:
- It happens when the game starts, not when you call it
- It's faster than loading scenes during gameplay
- You can create multiple copies from one preloaded scene

### The instantiate() Function
`instantiate()` creates a new copy of a scene:
- Each copy is independent (has its own position, properties, etc.)
- You can create as many copies as you want
- Each copy behaves according to its script

### Adding Objects to the World
`add_child()` puts a new object into the game:
- The object becomes part of the scene tree
- It will appear on screen and start running its code
- `get_parent()` adds it to the same level as the player

## Part 3: Building the Shooting System

### Step 1: Create Projectile Movement
First, let's make a script that makes projectiles move. You'll need to create or examine the projectile script.

The projectile needs:
- A speed variable (how fast it moves)
- A direction variable (which way it goes)
- Movement code in `_physics_process`

**Hint:** Projectiles move similar to the player, but they don't get input from keys - they just keep moving in one direction.

### Step 2: Add Shooting Input to Player
In your player script, you need to detect when the spacebar is pressed.

**Input detection hint:**
```gdscript
if Input.is_action_just_pressed("ui_accept"):
	# Spacebar was just pressed!
```

`is_action_just_pressed()` only triggers once per press (unlike `get_axis()` which is continuous).

### Step 3: Create and Launch Projectiles
When the player presses spacebar, you need to:
1. Load the projectile scene
2. Create a new instance
3. Set the projectile's position to the player's position  
4. Set the projectile's direction based on player facing
5. Add the projectile to the game world

## Documentation Examples

### Creating New Objects from Scenes
To create a new object from a scene file:
```gdscript
# First, load the scene (usually done at the top with other variables)
var bullet_scene = preload("res://scenes/bullet.tscn")

# Then create a new instance when needed
var new_bullet = bullet_scene.instantiate()
```

### Setting Object Position
To place an object at a specific location:
```gdscript
# Set position to same as current object
new_object.global_position = global_position

# Or set to specific coordinates
new_object.global_position = Vector2(100, 200)
```

### Calling Functions on Other Objects
To call a function on an object you just created:
```gdscript
# Call a function with no parameters
new_object.some_function()

# Call a function with one parameter
new_object.set_something("parameter_value")
```

### Adding Objects to the Game World
To make a new object appear in the game:
```gdscript
# Add as child to the same parent as current object
get_parent().add_child(new_object)

# Add as child to the current object
add_child(new_object)
```

### Step 4: Set Projectile Direction
The projectile needs to know which way to move. You can:
- Pass the direction when creating the projectile
- Use a function like `set_direction()` on the new projectile
- Set the projectile's direction variable directly

## Part 4: Understanding the Flow

### The Complete Shooting Process
Here's what happens when you press spacebar:
1. Player detects spacebar input
2. Player creates new projectile instance
3. Player sets projectile position and direction
4. Player adds projectile to the game world
5. Projectile starts moving in its assigned direction
6. Projectile continues until it hits something or goes off-screen

### Why This Pattern Works
This follows good game design:
- **Player handles shooting logic** (when and where to shoot)
- **Projectile handles movement** (how to fly and what to do when hitting things)
- **Each object has clear responsibilities**

## Part 5: Practice and Testing

### Test 1: Basic Shooting
Press spacebar while facing different directions:

**Expected behavior:**
- Projectile appears at player position
- Projectile moves in the direction player is facing
- New projectile created each time you press spacebar

### Test 2: Direction Accuracy
Face each direction and shoot:
- Facing "right" → projectile goes right
- Facing "up" → projectile goes up
- Facing "left" → projectile goes left  
- Facing "down" → projectile goes down

### Test 3: Multiple Projectiles
Press spacebar multiple times quickly:
- Multiple projectiles should exist at the same time
- Each projectile should move independently
- All projectiles should move at the same speed

## Common Problems and Solutions

### Problem: Projectile appears but doesn't move
**Solution:** Check that the projectile script has movement code in `_physics_process` and that the direction is being set correctly.

### Problem: Projectile moves in wrong direction
**Solution:** Make sure you're converting the facing string ("up", "down", etc.) to the correct movement values (-1, 1, etc.).

### Problem: Multiple projectiles when holding spacebar
**Solution:** This is normal with `is_action_just_pressed()`. If you want different behavior, we can change it later.

### Problem: "res://scenes/projectile.tscn" file not found
**Solution:** Make sure the projectile scene exists and the file path is correct.

## Advanced Concepts

### Using the Facing Direction
Since we already have the `facing` variable from Lesson 2, we can pass it directly to the projectile:
```gdscript
# Just pass the facing string to the projectile
projectile.set_direction(facing)
```

The projectile can then convert the string to movement in its own script.

### Memory Management
Projectiles should remove themselves when they go off-screen or hit targets to prevent memory buildup.

## What We Accomplished
🎉 Fantastic work! You just learned:
- **Dynamic object creation** - making new objects during gameplay
- **Scene instantiation** - using preload() and instantiate()
- **Input detection** - responding to specific key presses
- **Object positioning** - placing new objects at specific locations
- **Direction systems** - converting facing direction to movement
- **Parent-child relationships** - adding objects to the scene tree

## Debugging Your Shooting System

Add these print statements to track the process:

```gdscript
# When shooting:
print("Player shooting! Facing: ", facing)

# In projectile movement:
print("Projectile moving in direction: ", direction)
```

This helps you see:
- When shooting input is detected
- What direction the projectile should move
- Whether the projectile is actually moving

## Next Time Preview
In our next lesson, we'll create stationary turrets that shoot back at the player! We'll learn how to make enemies that can detect the player's position and fire projectiles toward them.
