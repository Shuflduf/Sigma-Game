extends Node3D
@export var projectile: PackedScene


func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
	if event.is_action_pressed("shoot"):
		shoot()


func shoot():
	var mouse_pos = get_mouse_pos()
	var angle = atan2(mouse_pos.x, mouse_pos.y)
	var new_proj = projectile.instantiate()
	get_tree().root.add_child(new_proj)
	new_proj.global_position = global_position
	new_proj.rotation.y = angle / 2
	print(angle)
	DebugDraw2D.set_text("angle", angle)


func get_mouse_pos() -> Vector2:
	return (
		(
			(get_viewport().get_mouse_position() / get_viewport().get_visible_rect().size)
			- Vector2(0.5, 0.5)
		)
		* Vector2(2.0, 2.0)
	)
