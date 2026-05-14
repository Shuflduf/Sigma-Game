extends OmniLight3D

@export var flicker_speed: float = 0.15
@export var flicker_intensity: float = 0.4
@export var min_energy: float = 0.3
@export var max_energy: float = 1.2
@export var flicker_enabled: bool = true
@export var color_shift_enabled: bool = false
@export var base_color: Color = Color(0.0, 1.0, 0.8, 1.0)

var base_energy: float
var flicker_timer: float = 0.0
var flicker_pattern: int = 0

func _ready() -> void:
	base_energy = light_energy
	base_color = light_color
	randomize()

func _process(delta: float) -> void:
	if not flicker_enabled:
		return

	flicker_timer += delta

	# Multiple flicker patterns for variety
	match flicker_pattern:
		0:  # Smooth sine wave
			var flicker = sin(flicker_timer * flicker_speed * TAU) * 0.5 + 0.5
			var random_flicker = randf_range(0.8, 1.0)
			light_energy = lerp(min_energy, max_energy, flicker * random_flicker)
		1:  # Broken neon flicker
			var random_val = randf()
			if random_val > 0.85:
				light_energy = randf_range(min_energy, max_energy * 0.5)
			else:
				light_energy = max_energy * 0.9
		2:  # Pulsing flicker
			var pulse = abs(sin(flicker_timer * flicker_speed * TAU * 2.0))
			light_energy = lerp(min_energy, max_energy, pulse)

	# Optional color shift for more dynamic effect
	if color_shift_enabled:
		var color_variance = sin(flicker_timer * 0.5) * 0.1
		light_color = base_color.lerp(Color.WHITE, color_variance)

	# Switch patterns every 20 seconds
	if flicker_timer > 20.0:
		flicker_timer = 0.0
		flicker_pattern = randi() % 3
