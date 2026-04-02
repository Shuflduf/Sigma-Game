extends CharacterBody3D

@export var max_hp: int = 3
var current_hp: int

func _ready() -> void:
	current_hp = max_hp
	print("Enemy spawned with ", current_hp, " HP")

func take_damage(amount: int) -> void:
	current_hp -= amount
	print("Enemy hit! HP left: ", current_hp)

	if current_hp <= 0:
		die()

func die() -> void:
	print("Enemy died!")
