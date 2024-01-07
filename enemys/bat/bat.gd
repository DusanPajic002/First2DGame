extends CharacterBody2D

var health = 6
var SPEED = 40
var direction = 1

func _ready():
	get_node("AnimatedSprite2D").flip_h = true
	get_node("AnimatedSprite2D").play("fly")
	velocity.y =0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("AnimatedSprite2D").play("fly")
	if  position.x < 250:
		get_node("AnimatedSprite2D").flip_h = true
		direction = 1
	elif position.x > 550:
		get_node("AnimatedSprite2D").flip_h = false
		direction = -1
	print(velocity)
	velocity.x = direction * SPEED
	move_and_slide()
		

func _killbox_body_entered(body):
	if body.name == "Player":
		self.health -=3
		velocity.y -= body.velocity.y;
		#if health <=0:
			#get_node("AnimatedSprite2D").play("death")
			#await get_node("AnimatedSprite2D").animation_finished
			#self.queue_free()


func _on_demagebox_body_entered(body):
	if body.name == "Player":
		body.health -= 4
		if body.health <= 0:
			body.queue_free()


func _on_killbox_body_exited(body):
	velocity.y = 0 Replace with function body.
