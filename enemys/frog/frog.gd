extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 40
const JUMP_VELOCITY = -300.0
var player 
var chase = false 

func _ready():
	get_node("AnimatedSprite2D").play("idle")

func _physics_process(delta):
	# Add the gravity
	velocity.y += gravity * delta
	if chase == true: 
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if velocity.y > 0:
			get_node("AnimatedSprite2D").play("fall")
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
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("idle")	
			velocity.x = 0
	move_and_slide()

func _player_entered(body): 
	if body.name == "Player":
		chase = true;

func _player_exited(body):
	if body.name == "Player":
		chase = false # Replace	 with function body.

func _on_death_body_entered(body):
	if body.name == "Player":
		chase = false
		velocity.y = 0
		velocity.x = 0 
		get_node("AnimatedSprite2D").play("death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()



func _on_deamge_body_entered(body):
	if body.name == "Player":
		body.health -= 3
		if body.health <= 0:
			body.queue_free()
