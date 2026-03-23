extends CharacterBody2D

@onready var player_character: CharacterBody2D = $"../PlayerCharacter"

@onready var web_animation: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $"AttackDuration"
@onready var fade_away_timer: Timer = $FadeAway
@onready var web_weapon: Node2D = $"."

var player_position
var target_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	web_weapon.visible = false
	web_animation.play("deploy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("deploy_web"):
		timer.start()
		web_animation.play("deploy")
		web_weapon.visible = true

	#I just need to make the net go to the player where they deploy it


func _on_timer_timeout() -> void:
	web_animation.play("fade away")
	fade_away_timer.start()

func _on_fade_away_timeout() -> void:
	web_weapon.visible = false
