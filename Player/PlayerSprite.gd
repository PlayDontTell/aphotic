extends Sprite


signal arrived_at_destination

var speed: int
var path: PoolVector2Array


func _process(delta):
	# Calculate the movement distance for this frame.
	var distance_to_walk = speed * delta
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
			# Orientation of Char
			Data.data.player.flip_h = position.direction_to(path[0])[0] < 0
			set_flip_h(Data.data.player.flip_h)
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
	# If no more steps, Char is arrived.
	if path.size() == 0:
		emit_signal("arrived_at_destination")
	
	if get_node("..").char_data.properties.has_following_eyes:
		if Data.data.player.flip_h:
			$CharHead.offset = Vector2(1.5, -4)
			$CharHead/CharEyes.offset = Vector2(1.5, 32)
		else:
			$CharHead.offset = Vector2(0.5, -4)
			$CharHead/CharEyes.offset = Vector2(0.5, 32)
		
		if get_viewport():
			# Direction of the eyes.
			var eyesOrientation = position.direction_to(get_global_mouse_position())
			var eyesInverted = get_global_mouse_position() <= position
			# Position of the eyes.
			$CharHead/CharEyes.flip_h = eyesInverted
			$CharHead.flip_h = eyesInverted
			$CharHead/CharEyes.position.y = -36 + eyesOrientation.y
	Data.data.player.position = position
