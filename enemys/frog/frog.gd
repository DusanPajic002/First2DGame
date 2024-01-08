extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
const JUMP_VELOCITY = -250.0
var player 
var chase = false 

func _ready():
	get_node("AnimatedSprite2D").play("idle")

func _physics_process(delta):
	
	velocity.y += (gravity-gravity/3) * delta
	if chase == true: 
		
		player = get_node("../../players/Player")
		var direction = (player.position - self.position).normalized()
		side(direction.x)
		
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			get_node("AnimatedSprite2D").play("jump")
		elif velocity.y > 0:
			get_node("AnimatedSprite2D").play("fall")
				
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "death":
			if not is_on_floor():
				get_node("AnimatedSprite2D").play("fall")
			else:
				get_node("AnimatedSprite2D").play("idle")
			velocity.x = lerp(velocity.x, 0.0, 1);
		else:
			self.get_node("Frog").disabled = true;
			velocity.y = 0
			velocity.x = 0
	move_and_slide()

func _player_entered(body): 
	if body.name == "Player":
		chase = true;

func _player_exited(body):
	if body.name == "Player":
		chase = false

func _on_death_body_entered(body):
	if body.name == "Player":
		chase = false
		get_node("AnimatedSprite2D").play("death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()

func _on_deamge_body_entered(body):
	if body.name == "Player":
		body.health -= 3
		if body.health <= 0:
			body.queue_free()

func side(direction):
	if direction < 0:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction > 0:
		get_node("AnimatedSprite2D").flip_h = true
	velocity.x = direction * SPEED
