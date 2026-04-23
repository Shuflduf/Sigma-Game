extends SpotLight3D

@export var rotation_speed: float = 2.0
@export var enabled: bool = true

func _physics_process(delta: float) -> void:
	if enabled:
		rotate_y(delta * rotation_speed)
