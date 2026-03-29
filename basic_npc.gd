extends CharacterBody2D

@export var speed: float = 100
@onready var player: Node2D = get_parent().get_node("PlayerCharacter")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Tells nav_agent where we want to go (player)
	nav_agent.target_position = player.global_position
	
	#Nav_Agent gives a path towards player
	var next_path_position := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_position)
	
	#Move towards the player
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed
	look_at(player.position)
	move_and_slide()
	
	pass
	
func defeated() -> void:
	queue_free()
