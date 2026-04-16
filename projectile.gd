extends Node3D



func _physics_process(delta: float) -> void:
	translate(global_transform.basis.z * delta * 10)
