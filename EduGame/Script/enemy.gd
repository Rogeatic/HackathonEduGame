extends RigidBody2D

var speed = 0  # Negative value to make it move left, adjust as needed

func _physics_process(delta):
	var x_input = 0
	var y_input = 0
	linear_velocity = speed
	
