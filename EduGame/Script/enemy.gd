extends RigidBody2D

enum State {
	PATROLLING,
	CHASING,
	ATTACKING  # New attack state
}

var speed = 150
var direction = 1  # 1 for right, -1 for left
var left_boundary = -200
var right_boundary = 200
var player_in_range = false
var player
var current_state = State.PATROLLING
var velocity = Vector2()

var max_health = 100
var current_health = max_health

var attack_damage = 10  # Damage amount when attacking
var attack_cooldown = 2.5  # Cooldown between attacks in seconds
var attack_timer = 0.0  # Timer to track attack cooldown

func _ready():
	# Initialize the enemy's health when it spawns
	current_health = max_health

func _physics_process(delta):
	# Check attack cooldown
	if attack_timer > 0:
		attack_timer -= delta
	
	# Check if the enemy can attack
	if player_in_range and attack_timer <= 0:
		current_state = State.ATTACKING
	elif player_in_range:
		current_state = State.CHASING

	match current_state:
		State.PATROLLING:
			patrol(delta)
		State.CHASING:
			chase(delta)
		State.ATTACKING:
			attack()
	linear_velocity = velocity  # Setting the velocity

@warning_ignore("unused_parameter")
func patrol(delta):
	velocity.x = speed * direction
	if position.x > right_boundary:
		direction = -1
	elif position.x < left_boundary:
		direction = 1

@warning_ignore("unused_parameter")
func chase(delta):
	if player_in_range:
		var dir_to_player = (player.position - position).normalized()
		velocity = dir_to_player * speed
	else:
		velocity = Vector2()

func attack():
	if attack_timer <= 0:
		var bodies = $AttackRange.get_overlapping_bodies()  # Adjust the node name to match your AttackRange node
		for body in bodies:
			if body.has_method("take_damage"):
				body.take_damage(attack_damage)
		attack_timer = attack_cooldown

func _on_DetectionArea_area_entered(area):
	if area.name == "Player":
		player_in_range = true
		player = area
		current_state = State.CHASING

func _on_DetectionArea_area_exited(area):
	if area.name == "Player":
		player_in_range = false
		player = null
		current_state = State.PATROLLING
