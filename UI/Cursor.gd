extends Node2D


signal request_action(parameters)
signal request_room_change(room)

var areasEntered = []


func _process(_delta):
	position = get_global_mouse_position()


func _on_Area2D_area_entered(area):
	if not area in areasEntered:
		areasEntered.append(area)
		if area.is_in_group("highlight"):
			Global.set_children_highlighted(area)


func _on_Area2D_area_exited(area):
	if area in areasEntered:
		areasEntered.remove(areasEntered.find(area))
		if area.is_in_group("highlight"):
			Global.reset_children_modulate(area)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			for i in areasEntered:
				if i.is_in_group("action_trigger"):
					emit_signal("request_action",
					[i.targetPosition,
					i.actionType,
					i.actionName,
					i.flipH,
					i.goToRoom,
					i.goToPosition,
					i.goToRdvPoint])
					return
				if i.is_in_group("backzone"):
					emit_signal("request_room_change", i.goToRoom)
					return
			emit_signal("request_action",
					[event.position,
					"idle"])
