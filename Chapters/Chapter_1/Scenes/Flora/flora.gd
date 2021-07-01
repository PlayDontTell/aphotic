extends Node2D


onready var rdvPoints: = {
	"doorE": $Background/PassageRight.targetPosition,
	"doorW": $Background/PassageLeft.targetPosition,
	"doorSW": $Background/PassageBottom.targetPosition,
}


func get_floor_meshes():
	return [$FloorPolygonTop, $FloorPolygonLeft, $FloorPolygonRight, $FloorPolygonBottom]
