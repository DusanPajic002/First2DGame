extends CharacterBody2D

var health = 6
var direction_x

const LEFT_BORDER = 250
const RIGHT_BORDER = 550
const SPEED = 40


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	direction_x = randi_range(0, 1)
	if direction_x == 0:
		direction_x = -1;
	get_node("AnimatedSprite2D").play("fly")

func _process(delta):
	
	get_node("AnimatedSprite2D").play("fly")
	side(direction_x)
	velocity.x = direction_x * SPEED
	velocity.y = 0
	
	if  position.x < LEFT_BORDER:
		direction_x = 1
	elif position.x > RIGHT_BORDER:
		direction_x = -1
		
	move_and_slide()
		

func _killbox_body_entered(body):
	if body.name == "Player":
		self.health -=3
		print(body.velocity)
		#if health <=0:
			#get_node("AnimatedSprite2D").play("death")
			#await get_node("AnimatedSprite2D").animation_finished
			#self.queue_free()


func _on_demagebox_body_entered(body):
	if body.name == "Player":
		body.health -= 4
		
func side(direction):
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = true
	
