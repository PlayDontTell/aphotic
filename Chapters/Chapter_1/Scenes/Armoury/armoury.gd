extends Node2D


func _ready():
	if Data.data.chapter_1.elevator_floor != Data.data.player.scene:
		$Background/PassageElevator.visible = false
		$Background/PassageElevator/CollisionPolygon2D.disabled = true


func get_floor_meshes():
	return [$FloorPolygon]
