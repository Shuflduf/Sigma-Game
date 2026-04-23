extends Node3D

@export var move_speed: float = 2.0
@export var move_distance: float = 3.0
@export var move_axis: Vector3 = Vector3.UP  # Direction of movement

var start_position: Vector3
var time_elapsed: float = 0.0

func _ready() -> void:
	start_position = global_position

func _process(delta: float) -> void:
	time_elapsed += delta

	# Smooth back-and-forth movement using sine wave
	var offset = sin(time_elapsed * move_speed) * move_distance
	global_position = start_position + (move_axis * offset)
