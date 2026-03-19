extends Node
@export var speed = 5.0
@onready var player: CharacterBody3D = get_parent()

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
	var move_dir = input_dir.rotated(-player.rotation.y) * speed
	player.velocity.x = lerp(player.velocity.x, move_dir.x, delta * 10.0)
	player.velocity.z = lerp(player.velocity.z, move_dir.y, delta * 10.0)
