extends CharacterBody2D

@export var speed: float = 175
@onready var player: Node2D = get_parent().get_node("PlayerCharacter")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var npc: CharacterBody2D = $"."
@onready var timer: Timer = $Timer

@onready var leg_animation_player: AnimationPlayer = $"Leg Animation Player"
@onready var pincer_animation: AnimationPlayer = $PincerAnimation

@onready var infantry_ant: CharacterBody2D = $infantry_ant

@onready var enemy_health: ProgressBar = $EnemyHelth



var pushback_force = Vector2.ZERO


var in_pursuit = true
var in_field = false
var can_attack = false

var amber_broken = false

var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	can_attack = false
	
	
func en_take_damage(damage):
	if enemy_health.value < damage:
		damage = enemy_health.value
	enemy_health.value -= damage


func knock_back(source_position: Vector2) -> void:
	pushback_force = -global_position.direction_to(source_position) * 300
	
func physics_process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y >= 320 and position.x <= 500 and !amber_broken:
		in_pursuit = false


	#Tells nav_agent where we want to go (player)
	nav_agent.target_position = player.global_position
	
	#Nav_Agent gives a path towards player
	if in_pursuit == true :
		var next_path_position := nav_agent.get_next_path_position()
		var direction := global_position.direction_to(next_path_position)
	
	#Move towards the player
		npc.look_at(player.position)
		look_at(player.position)
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		move_and_slide()
	print(can_attack)
	
		
	if Input.is_action_just_pressed("attack") and can_attack == true:
		en_take_damage(10)
	
	if enemy_health.value == 0:
		defeated()
		
	#print(in_pursuit)
	
func defeated() -> void:
	queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("i'm working")
		in_pursuit = false
	
		can_attack = true
	
		
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		in_pursuit = true
		
		can_attack = false


	
func _on_timer_timeout() -> void:
	can_attack = false
