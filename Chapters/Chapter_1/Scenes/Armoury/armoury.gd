extends Node2D


onready var rdvPoints: = {
	"doorW": $Background/PassageLeft.targetPosition,
	"elevator": $Background/PassageElevator.targetPosition,
	"ladder": $Background/PassageLadder.targetPosition,
}


func _ready():
	if Data.data.chapter_1.elevator_floor != Data.data.player.scene:
		$Background/PassageElevator.visible = false
		$Background/PassageElevator/CollisionPolygon2D.disabled = true


func get_floor_meshes():
	return [$FloorPolygon]
