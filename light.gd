extends SpotLight3D

@export var rotation_speed: float = 2.0
@export var rotation_enabled: bool = true
@export var pulse_enabled: bool = true
@export var pulse_speed: float = 2.0
@export var min_energy: float = 0.6
@export var max_energy: float = 1.2
@export var base_color: Color = Color(0.0, 1.0, 0.9, 1.0)

var base_energy: float
var timer: float = 0.0

func _ready() -> void:
	base_energy = light_energy
	base_color = light_color

func _physics_process(delta: float) -> void:
	if rotation_enabled:
		rotate_y(delta * rotation_speed)
	
	if pulse_enabled:
		timer += delta
		# Create a pulsing effect combined with rotation
		var pulse = sin(timer * pulse_speed * TAU) * 0.5 + 0.5
		light_energy = lerp(min_energy, max_energy, pulse)
		
		# Optional: slight color variation for spotlight beam
		var color_intensity = pulse * 0.3 + 0.7
		light_color = base_color * color_intensity
