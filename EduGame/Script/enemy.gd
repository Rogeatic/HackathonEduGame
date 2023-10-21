extends RigidBody2D

enum State {
	PATROLLING,
	CHASING
}

var speed = 150
var direction = 1  # 1 for right, -1 for left
var left_boundary = -200
var right_boundary = 200
var player_in_range = false
var player
var current_state = State.PATROLLING
var velocity = Vector2()  # New addition for handling the RigidBody2D movement

func _physics_process(delta):
	match current_state:
		State.PATROLLING:
			patrol(delta)
		State.CHASING:
			chase(delta)
	linear_velocity = velocity  # Setting the velocity

func patrol(delta):
	velocity.x = speed * direction  # Using velocity instead of directly changing position
	if position.x > right_boundary:
		direction = -1
	elif position.x < left_boundary:
		direction = 1

func chase(delta):
	if player_in_range:
		var dir_to_player = (player.position - position).normalized()
		velocity = dir_to_player * speed
	else:
		velocity = Vector2()

func _on_DetectionArea_area_entered(area):
	if area.name == "Player":
		player_in_range = true
		player = area
		current_state = State.CHASING

func _on_DetectionArea_area_exited(area):
	if area.name == "Player":
		player_in_range = false
		current_state = State.PATROLLING
