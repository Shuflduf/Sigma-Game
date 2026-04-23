extends RigidBody3D


func _physics_process(delta: float) -> void:
	if not linear_velocity.is_zero_approx():
		linear_velocity = linear_velocity.normalized() * 10.0


func _on_timer_timeout() -> void:
	queue_free()
