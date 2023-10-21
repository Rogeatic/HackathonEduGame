extends CharacterBody2D

var speed = 100
var direction = Vector2(0, 0)  # This will make the enemy move left

func _physics_process(delta):
	# Move the enemy
	velocity = direction*speed
	move_and_slide()
