extends RigidBody2D

@onready var _animated_sprite = $AnimatedSprite2D
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
	linear_velocity = direction * speed

	# Determine animation
	if direction == Vector2(0, -1):
		_animated_sprite.play("Walk Up")
	elif direction == Vector2(0, 1):
		_animated_sprite.play("Walk Down")
	elif direction == Vector2(-1, 0) or direction.x < 0:  # Includes diagonal left
		_animated_sprite.play("Walk Left")
	elif direction == Vector2(1, 0) or direction.x > 0:  # Includes diagonal right
		_animated_sprite.play("Walk Right")
	else:
		_animated_sprite.stop()
