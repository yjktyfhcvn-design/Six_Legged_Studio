extends Sprite2D

var can_break = false

@onready var amber: Sprite2D = $"."
@onready var start_other_npcs: Timer = $"../../StartOtherNPCs"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	amber.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and can_break == true:
		amber.visible = false
		


func _on_break_body_entered(body: Node2D) -> void:
	if body.is_in_group("attack"):
		can_break = true
		
