extends ParallaxBackground



var scrolling_speed = 80
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= scrolling_speed * delta
