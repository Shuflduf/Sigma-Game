extends OmniLight3D

@export var flicker_speed: float = 0.1
@export var flicker_intensity: float = 0.3
@export var min_energy: float = 0.5
@export var max_energy: float = 1.5
@export var flicker_enabled: bool = true

var base_energy: float
var flicker_timer: float = 0.0

func _ready() -> void:
	base_energy = light_energy

func _process(delta: float) -> void:
	if not flicker_enabled:
		return

	flicker_timer += delta

	# Random flicker with smooth transitions
	var flicker = sin(flicker_timer * flicker_speed * TAU) * 0.5 + 0.5
	var random_flicker = randf_range(0.7, 1.0)

	light_energy = lerp(min_energy, max_energy, flicker * random_flicker)

	# Reset timer
	if flicker_timer > 10.0:
		flicker_timer = 0.0
