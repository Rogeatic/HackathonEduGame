extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var player = $CharacterBody2D
@onready var camera = $Camera2D
@onready var level = get_node("/root/Level")
@onready var tilemap = get_node("/root/Level/TileMap")


var speed = 100
#var width/2 = ProjectSettings.get_setting("display/window/size/viewport_width")
#var height/2 = ProjectSettings.get_setting("display/window/size/viewport_height")


func _input(event):
   # Mouse in viewport coordinates.
	var playerPos = get_viewport_rect().size / 2
	if event is InputEventMouseButton:
		var distanceOfClick = playerPos.distance_to(event.position)
		#print(str(distanceOfClick))
		if (distanceOfClick < 40):
			print(distanceOfClick)
		
# In Player.gd



func handle_special_tile_collision():
	print("Collided with special tile!")
	# Handle the collision - for example, move to next level, 
	# play an animation, etc.



	#elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)

func _physics_process(delta):
	var x_input = 0
	var y_input = 0

	if Input.is_key_pressed(KEY_W):
		y_input = -1
	elif Input.is_key_pressed(KEY_S):
		y_input = 1

	if Input.is_key_pressed(KEY_A):
		x_input = -1
	elif Input.is_key_pressed(KEY_D):
		x_input = 1

	var direction = Vector2(x_input, y_input).normalized()
	
	# Assuming CharacterBody2D has a move_and_collide method similar to KinematicBody2D
	var movement = direction * speed * delta
	var collision := move_and_collide(movement)
	if collision:
		var body = collision.get_collider()
<<<<<<< Updated upstream
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
		if body == tilemap:  # Check if the player collided with the TileMap
			var colliding_cell = tilemap.world_to_map(collision.collision_point)
			if tilemap.get_cell(colliding_cell.x, colliding_cell.y + level.map_offset) == level.BREAKABLE_TILE_ID:
				tilemap.set_cell(colliding_cell.x, colliding_cell.y + level.map_offset, -1)  # Remove the breakable block
=======
		if body.has_method("get_name"): 
			print("Collided with:", body.get_name())
			if body.get_name() == "Exit":
				GlobalData.level_scene
=======
		if body.has_method("get_name"): 
			print("Collided with:", body.get_name())
			if body.get_name() == "Exit":
>>>>>>> d98a54f1393566a13b34cab2c0e32e431a58fd4a
				get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
			if body.get_name() == "Exit2":
				get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		else:
			print("Collided with an unnamed object.")
<<<<<<< HEAD

=======
>>>>>>> d98a54f1393566a13b34cab2c0e32e431a58fd4a
	
>>>>>>> Stashed changes
	

	# Determine animation
	if direction == Vector2(0, -1):
		_animated_sprite.play("Up")
	elif direction == Vector2(0, 1):
		_animated_sprite.play("Down")
	elif direction.x < 0:
		_animated_sprite.play("Left")
	elif direction.x > 0:
		_animated_sprite.play("Right")
	else:
		_animated_sprite.stop()
func set_camera_limits():
	if level.map_width != 0 and  level.map_height != 0:
		var tile_size = 16  # Assuming each tile is 16x16 pixels
		camera.limit_left = 0
		camera.limit_top = tile_size - level.map_offset
		camera.limit_right = level.map_width * tile_size - 1
		camera.limit_bottom = (level.map_height + level.map_offset) * tile_size
