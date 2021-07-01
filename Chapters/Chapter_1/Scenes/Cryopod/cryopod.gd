extends Node2D


onready var rdvPoints: = {
	"doorE": $Background/PassageRight.targetPosition,
	"doorW": $Background/PassageLeft.targetPosition,
	"doorS": $Background/PassageBottom.targetPosition,
}


func get_floor_meshes():
	return [$FloorPolygon]
