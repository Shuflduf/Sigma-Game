extends CharacterBody3D

@export var max_hp: int = 3
@export var speed: float = 3.5
@export var attack_range: float = 2.0
@export var detect_radius: float = 10.0
@export var attack_damage: int = 1
@export var drop_item: String = "scrap_metal"

var current_hp: int
var player: Node3D = null
var nav_agent: NavigationAgent3D
var is_ally: bool = false

enum State { PATROL, CHASE, ATTACK, DEAD, ALLY }
var state: State = State.PATROL

# Patrol points — set these in the Inspector or leave empty to just idle
@export var patrol_points: Array[Vector3] = []
var patrol_index: int = 0

func _ready() -> void:
	current_hp = max_hp
	nav_agent = $NavigationAgent3D
	$DetectionArea.body_entered.connect(_on_body_entered)
	$DetectionArea.body_exited.connect(_on_body_exited)
	print("Enemy spawned with ", current_hp, " HP")

func _physics_process(delta: float) -> void:
	if is_ally:
		_follow_player()
		return
	match state:
		State.PATROL: _patrol()
		State.CHASE:  _chase()
		State.ATTACK: _attack(delta)
		State.DEAD:   pass
		State.ALLY:   _follow_player()

# --- PATROL ---
func _patrol() -> void:
	if patrol_points.is_empty():
		velocity = Vector3.ZERO
		move_and_slide()
		return
	var target = patrol_points[patrol_index]
	nav_agent.target_position = target
	var next = nav_agent.get_next_path_position()
	velocity = (next - global_position).normalized() * (speed * 0.5)
	move_and_slide()
	if global_position.distance_to(target) < 1.0:
		patrol_index = (patrol_index + 1) % patrol_points.size()

# --- CHASE ---
func _chase() -> void:
	if player == null:
		state = State.PATROL
		return
	nav_agent.target_position = player.global_position
	var dist = global_position.distance_to(player.global_position)
	if dist <= attack_range:
		state = State.ATTACK
		return
	var next = nav_agent.get_next_path_position()
	velocity = (next - global_position).normalized() * speed
	move_and_slide()

# --- ATTACK ---
var attack_timer: float = 0.0
func _attack(delta: float) -> void:
	velocity = Vector3.ZERO
	move_and_slide()
	attack_timer -= delta
	if player == null:
		state = State.PATROL
		return
	if global_position.distance_to(player.global_position) > attack_range * 1.5:
		state = State.CHASE
		return
	if attack_timer <= 0.0:
		attack_timer = 1.8
		print("Enemy attacks player!")
		if player.has_method("take_damage"):
			player.take_damage(attack_damage)

# --- ALLY FOLLOW ---
func _follow_player() -> void:
	if player == null:
		return
	var dist = global_position.distance_to(player.global_position)
	if dist > 3.0:
		nav_agent.target_position = player.global_position
		var next = nav_agent.get_next_path_position()
		velocity = (next - global_position).normalized() * speed
	else:
		velocity = Vector3.ZERO
	move_and_slide()

# --- TAKE DAMAGE ---
func take_damage(amount: int) -> void:
	if state == State.DEAD or is_ally:
		return
	current_hp -= amount
	print("Enemy hit! HP left: ", current_hp)
	if current_hp <= 0:
		die()
	else:
		state = State.CHASE  # always chase after being hit

# --- DIE / BECOME ALLY ---
func die() -> void:
	state = State.DEAD
	print("Enemy defeated!")
	_drop_item()
	# Become ally instead of dying immediately
	_become_ally()

func _become_ally() -> void:
	is_ally = true
	state = State.ALLY
	print("Enemy is now your ally!")
	# Optional: change mesh color or material here to show alliance

func _drop_item() -> void:
	print("Enemy dropped: ", drop_item)
	# Spawn a pickup node here later

# --- DETECTION ---
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
		if not is_ally:
			state = State.CHASE

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		if not is_ally:
			player = null
			state = State.PATROL
