extends Area2D


export(String, "control", "defense", "armoury") var button_level
var frame_offset: int = 0
var focus_offset: int = 0


func _ready():
	initialize()


func _on_Button_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if Data.data.chapter_1.elevator_floor != button_level:
				if event.pressed:
					focus_offset = 1
					initialize()
				else:
					focus_offset = 0
					initialize()


func initialize():
	if Data.data.chapter_1.elevator_floor == button_level:
		frame_offset = 0
		focus_offset = 1
		$CollisionPolygon2D.disabled = true
	else:
		frame_offset = 2
	$ButtonSprite.frame = frame_offset + focus_offset
	$ShadowSprite.frame = frame_offset + focus_offset
