extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
const JUMP_VELOCITY = -300.0
var jumped = false
var player 
var chase = false 

func _physics_process(delta):
	# Add the gravity
	velocity.y += gravity * delta
	if chase == true:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if velocity.y > 0:
			get_node("AnimatedSprite2D").play("fall")
			jumped = true
		else:
			get_node("AnimatedSprite2D").play("jump")
		player = get_node("../../players/Player") 
		var direction = (player.position - self.position).normalized()
		if direction.x > 0 :	
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("idle")	
		velocity.x =0
	move_and_slide()

func _player_entered(body): 
	if body.name == "Player":
		chase = true;

func _player_exited(body):
	if body.name == "Player":
		chase = false # Replace	 with function body.

func _on_death_body_entered(body):
	if body.name == "Player":
		var player = get_node("../../players/Player") 
		var direction = (player.position - self.position).normalized()
		print(direction.y)
		if direction.y < -0.9:
			self.queue_free()
