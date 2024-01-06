extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 1

var player 
var chase = false 

func _physics_process(delta):
	# Add the gravity
	velocity.y += gravity * delta
	print(chase)
	if chase == true:
		get_node("AnimatedSprite2D").play("jump")
		player = get_node("../../players/Player") 
		var direction = (player.position - self.position).normalized()
		if direction.x > 0 :	
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x += direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("idle")	
		velocity.x =0
	move_and_slide()

func _player_entered(body): 
	if body.name == "Player":
		chase = true;
		


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		chase = false # Replace	 with function body.
