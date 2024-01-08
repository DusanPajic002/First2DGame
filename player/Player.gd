extends CharacterBody2D

var health = 30
const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimationPlayer")
var double_jump = true  

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	if direction_x == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction_x == 1:
		get_node("AnimatedSprite2D").flip_h = false
	velocity.x = direction_x * SPEED
	print(direction_x)
	if is_on_floor():
		if direction_x == 0:
			animation.play("idle")
		else:
			
			animation.play("run");
				
	
	
	if (is_on_floor() or double_jump) and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		animation.play("jump")
		if not is_on_floor():
			double_jump = false  # Iskoristite dvostruki skok
		else:
			double_jump = true 
	elif velocity.y > 0 and not is_on_floor():
		animation.play("fall")
		
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#if direction == -1:
		#get_node("AnimatedSprite2D").flip_h = true
	#elif direction == 1:
		#get_node("AnimatedSprite2D").flip_h = false
	#if direction:
		#velocity.x = direction * SPEED
		#if velocity.y == 0:
			#animation.play("run");
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#if velocity.y == 0:
			#if direction_y == 0:
				#animation.play("idle")
			#elif direction_y == 1:
				#animation.play("crouch")
	#if velocity.y > 0:

	move_and_slide()
