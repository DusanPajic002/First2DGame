extends CharacterBody2D

var health = 30
const SPEED = 180
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimationPlayer")
var double_jump = true  

func _physics_process(delta):
	
	velocity.y += gravity * delta
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	side(direction_x)
	
	if is_on_floor():
		if direction_x == 0:
			animation.play("idle")
		else:
			animation.play("run");
	elif velocity.y > 150:
		animation.play("fall")
		
	if (double_jump or is_on_floor()) and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		animation.play("jump")
		if not is_on_floor():
			double_jump = false
		else:
			double_jump = true
			
	move_and_slide()

func side(direction):
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	velocity.x = direction * SPEED
	
