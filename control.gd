extends Control

@onready var sec: RichTextLabel = $sec
@onready var tsec: RichTextLabel = $dsec


@export var seconds = 25
var tenth_seconds = 0

func _ready():
	pass

func _physics_process(delta):
	if seconds > 0 and tenth_seconds <= 0:
		seconds -= 1
		tenth_seconds = 10
		
	if seconds >= 10:
		sec.set_text(str(seconds))
	else:
		sec.set_text("0"+str(seconds))
		
	if tenth_seconds >= 10:
		tsec.set_text(str(tenth_seconds))
	else:
		tsec.set_text("0"+str(tenth_seconds))
		
	if seconds <= 0:
		print("game won")
		get_tree().change_scene_to_file("res://game_won.tscn")
	

func _on_timer_timeout() -> void:
	tenth_seconds -= 1
