extends RigidBody2D

var speed = 200

func _physics_process(delta):
	var x_input = 0
	var y_input = 0
	
	if Input.is_key_pressed(KEY_W):
		y_input = -1
	if Input.is_key_pressed(KEY_S):
		y_input = 1
		
	if Input.is_key_pressed(KEY_A):
		x_input = -1
	if Input.is_key_pressed(KEY_D):
		x_input = 1

	var direction = Vector2(x_input, y_input).normalized()
	linear_velocity = direction * speed
