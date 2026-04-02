extends CharacterBody2D

@export var speed: float = 175
@onready var player: Node2D = get_parent().get_node("PlayerCharacter")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var npc: CharacterBody2D = $"."

@onready var leg_animation_player: AnimationPlayer = $"Leg Animation Player"
@onready var pincer_animation: AnimationPlayer = $PincerAnimation

@onready var infantry_ant: CharacterBody2D = $infantry_ant
@onready var timer: Timer = $Timer

var enemy_health = 1
var pushback_force = Vector2.ZERO


var in_pursuit = true
var in_field = false

var amber_broken = false

var can_attack = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	
func physics_process(delta: float) -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(can_attack)
	if Input.is_action_just_pressed("attack"):
		can_attack = true
		timer.start()
	
	#Tells nav_agent where we want to go (player)
	nav_agent.target_position = player.global_position
	
	#Nav_Agent gives a path towards player
	var next_path_position := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_position)
	
	#Move towards the player
	npc.look_at(player.position)
	look_at(player.position)
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed
	move_and_slide()

	
	if enemy_health <= 0:
		defeated()
		
func defeated() -> void:
	queue_free()

func _on_npc_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		defeated()
	pass # Replace with function body.


func _on_npc_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack") and can_attack:
		print("attack")
		defeated()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	can_attack = false
	pass # Replace with function body.
