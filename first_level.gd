extends Node

@export var Basic_Mob: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func game_over() -> void:
	$Mob_Timer.stop()
	print("game over")
	get_tree().change_scene_to_file("res://game_over.tscn")
	pass
	

	
func game_start() -> void:
	#Change depending on what we call the player node
	$PlayerCharacter.position = $Player_Spawn.position
	#Change Later to when game starts (but to test code)
	$Mob_Timer.start()
	
	pass


func _on_mob_timer_timeout() -> void:
	var mob = Basic_Mob.instantiate()
	print("spawned")
	#Chooses a Random Location on Path to Spawn
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position
	add_child(mob)
	pass
