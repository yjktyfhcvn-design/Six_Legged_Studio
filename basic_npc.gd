extends CharacterBody2D

@export var speed: float = 175
@onready var player: Node2D = get_parent().get_node("PlayerCharacter")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var npc: CharacterBody2D = $"."

@onready var leg_animation_player: AnimationPlayer = $"Leg Animation Player"
@onready var pincer_animation: AnimationPlayer = $PincerAnimation


@onready var infantry_ant: CharacterBody2D = $infantry_ant

var in_pursuit = true
var in_field = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y >= 320 and position.x <= 500:
		in_pursuit = false
	
		
	
	
	
	#Tells nav_agent where we want to go (player)
	nav_agent.target_position = player.global_position
	
	#Nav_Agent gives a path towards player
	if in_pursuit != false:
		var next_path_position := nav_agent.get_next_path_position()
		var direction := global_position.direction_to(next_path_position)
	
	#Move towards the player
		npc.look_at(player.position)
		look_at(player.position)
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		move_and_slide()
	
	pass
	
func defeated() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
	#while body.is_in_group("npc"):
		#in_pursuit = true
	
