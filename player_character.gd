extends CharacterBody2D

var can_click_again = false
@onready var DOUBLE_CLICK_TIMER: Timer = $DoubleClickTimer

@onready var dash_timer: Timer = $DashTimer

@onready var health = 3
@onready var Damage_Sound = $DamageSFX

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var visible_attack: Sprite2D = $AttackHB/Screenshot20260331At12_00_29Pm


 
var dashing = false
var dash_direction = null
var dash_target = null

var is_moving = false


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

func _ready():
	add_child(DOUBLE_CLICK_TIMER)
	visible_attack.visible = false
		
func move(direction : Vector2):
	movement_direction = direction
	

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("attack"):
		visible_attack.visible = true
	else:
		visible_attack.visible = false
		
	
	if Input.is_action_just_pressed("move_left") and can_click_again == false:
		DOUBLE_CLICK_TIMER.start()
		can_click_again = true
		dash_direction = "left"
	elif Input.is_action_just_pressed("move_left") and can_click_again:
		
		dashing = true
		dash_timer.start()
		dash_target = "left"
		
		can_click_again = false
		
	if Input.is_action_just_pressed("move_right") and can_click_again == false:
		DOUBLE_CLICK_TIMER.start()
		can_click_again = true
		dash_direction = "right"
	elif Input.is_action_just_pressed("move_right") and can_click_again:
		dashing = true
		dash_timer.start()
		dash_target = "right"
		
		can_click_again = false
		
	if Input.is_action_just_pressed("move_up") and can_click_again == false:
		DOUBLE_CLICK_TIMER.start()
		can_click_again = true
		dash_direction = "up"
	elif Input.is_action_just_pressed("move_up") and can_click_again:
		dashing = true
		dash_timer.start()
		dash_target = "up"
		
		can_click_again = false
	
	if Input.is_action_just_pressed("move_down") and can_click_again == false:
		DOUBLE_CLICK_TIMER.start()
		can_click_again = true
		dash_direction = "down"
	elif Input.is_action_just_pressed("move_down") and can_click_again:
		dashing = true
		dash_timer.start()
		dash_target = "down"
		
		can_click_again = false
	
#ADD CODE THAT DECREASES MOVEMENT SPEED IF TWO KEYS ARE BEING PRESSED!!!
	
	#print(dash_direction)
	
	if dashing == true:
		if dash_target == dash_direction:
			movement_speed = 1000
			_rotation_speed = TAU * 6
	if dashing == false:
		movement_speed = 500
		_rotation_speed = TAU * 1.75
		
		
		
		
	

	
	movement_direction.x = Input.get_axis("move_left","move_right")
	movement_direction.y = Input.get_axis("move_up","move_down")
	
	#ROTATION CODE ONLY
	character_direction.y = Input.get_axis("move_left", "move_right")
	character_direction.x = Input.get_axis("move_down", "move_up")

	if character_direction:
		
		animation_player.play("walk")
		
		#DIRECTION CHARACTER IS FACING
		#DIRECTION CHARACTER IS FACING
		#DIRECTION CHARACTER IS FACING
		
		
		#This is very annoying, 
		#it controls the orientation of the player character

		_theta = wrapf(atan2(character_direction.y, character_direction.x) - rotation, -PI, PI)

		#abs theta is the absolute value of the direction the sprite needs to rotate to reach it's target position
		player_character.rotation += clamp(_rotation_speed * delta, 0 , abs(_theta)) * sign(_theta)
		
		#DIRECTION CHARACTER IS MOVING
		#DIRECTION CHARACTER IS MOVING
		#DIRECTION CHARACTER IS MOVING
		
		velocity = movement_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 60)
		animation_player.play("RESET")
	#print(movement_speed)
	
	move_and_slide()


#This timer basically is the time limit for whether or not a player can make their initial click a double click
#Once 0.25 seconds passes, they have to restart the double click
func _on_double_click_timer_timeout() -> void:
	can_click_again = false
#This sets the length of time the player is moving at an accelerate speed
func _on_dash_timer_timeout() -> void:
	dashing = false
	
func take_damage() -> void:
	Damage_Sound.play()
	health = health -1
	#get_parent().get_node("HealthBar").text = "Health: " + str(health)
	if health == 0:
		var main = get_parent()
		if main:
			main.game_over()
	pass
