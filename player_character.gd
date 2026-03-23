extends CharacterBody2D

@onready var player_character: CharacterBody2D = $"."


@export var _rotation_speed : float = TAU * 1.5
var _theta : float
var character_direction : Vector2

@export var movement_speed : float = 500

#MUST READ
#MUST READ
#MUST READ:
#I KNOW HOW CONFUSING it is, but movement_direction is the only the x,y movement
#and character_direction is the rotation of the sprite
var movement_direction : Vector2

func move(direction : Vector2):
	movement_direction = direction


func _physics_process(delta: float) -> void:
	
	movement_direction.x = Input.get_axis("move_left","move_right")
	movement_direction.y = Input.get_axis("move_up","move_down")
	
	
	#ROTATION CODE ONLY
	character_direction.y = Input.get_axis("move_left", "move_right")
	character_direction.x = Input.get_axis("move_down", "move_up")

	if character_direction:
		
		#DIRECTION CHARACTER IS FACING
		#DIRECTION CHARACTER IS FACING
		#DIRECTION CHARACTER IS FACING
		
		#This is very annoying, 
		#it controls the orientation of the player character

		_theta = wrapf(atan2(character_direction.y, character_direction.x) - rotation, -PI, PI)

		#abs theta is the absolute value of the direction the sprite needs to rotate to reach it's target position
		player_character.rotation += clamp(_rotation_speed * delta, 0 , abs(_theta)) * sign(_theta)
		
		print(abs(_theta))
	
		#DIRECTION CHARACTER IS MOVING
		#DIRECTION CHARACTER IS MOVING
		#DIRECTION CHARACTER IS MOVING
		
		velocity = movement_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 60)
	move_and_slide()
	
