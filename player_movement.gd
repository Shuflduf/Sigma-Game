extends Node

@warning_ignore("unused_signal")
signal jumped

const MAX_VELOCITY_AIR = 0.6
const MAX_VELOCITY_GROUND = 6.0
const MAX_ACCELERATION = 10 * MAX_VELOCITY_GROUND
const GRAVITY = 15.34
const STOP_SPEED = 1.5
const JUMP_IMPULSE = 4
const FRICTION = 4.0

var wish_jump = false
var wish_dir = Vector3.ZERO
var jump_enabled = true

@onready var player: CharacterBody3D = $".."

func _physics_process(delta: float) -> void:
	_process_movement(delta)

	player.move_and_slide()


func _process_movement(delta: float):
	if player.is_on_floor():
		if wish_jump:
			player.velocity.y = JUMP_IMPULSE
			player.velocity = update_velocity_air(delta)
			wish_jump = false
		else:
			player.velocity = update_velocity_ground(delta)
	else:
		player.velocity += player.get_gravity() * delta
		player.velocity = update_velocity_air(delta)


func update_velocity_ground(delta: float) -> Vector3:
	var speed = player.velocity.length()
	if !is_zero_approx(speed):
		var control = max(STOP_SPEED, speed)
		var drop = control * FRICTION * delta
		player.velocity *= max(speed - drop, 0) / speed

	return accelerate(MAX_VELOCITY_GROUND, delta)


func update_velocity_air(delta: float) -> Vector3:
	return accelerate(MAX_VELOCITY_AIR, delta)


func accelerate(max_velocity: float, delta: float) -> Vector3:
	var current_speed = player.velocity.dot(wish_dir)
	var add_speed = clamp(max_velocity - current_speed, 0, MAX_ACCELERATION * delta)

	return player.velocity + add_speed * wish_dir
