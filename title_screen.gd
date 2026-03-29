extends Node
@onready var start_button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://first_level.tscn")
	pass # Replace with function body.
