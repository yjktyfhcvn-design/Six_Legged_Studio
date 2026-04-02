extends CharacterBody2D
@onready var leg_animation_player: AnimationPlayer = $"Leg Animation Player"
@onready var pincer_animation: AnimationPlayer = $PincerAnimation


func _physics_process(delta: float) -> void:
	leg_animation_player.play("walk")
	pincer_animation.play("pincers")
