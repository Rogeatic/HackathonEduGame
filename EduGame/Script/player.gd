extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var player = $CharacterBody2D
@onready var camera = $Camera2D
@onready var level = get_node("/root/Level")

var speed = 200

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
	move_and_collide(direction * speed * delta)

	# Determine animation
	if direction == Vector2(0, -1):
		_animated_sprite.play("Walk Up")
	elif direction == Vector2(0, 1):
		_animated_sprite.play("Walk Down")
	elif direction.x < 0:
		_animated_sprite.play("Walk Left")
	elif direction.x > 0:
		_animated_sprite.play("Walk Right")
	else:
		_animated_sprite.stop()
func set_camera_limits():
	if level.map_width != 0 and  level.map_height != 0:
		var tile_size = 16  # Assuming each tile is 16x16 pixels
		camera.limit_left = 0
		camera.limit_top = tile_size - level.map_offset
		camera.limit_right = level.map_width * tile_size - 1
		camera.limit_bottom = (level.map_height + level.map_offset) * tile_size
