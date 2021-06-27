extends Node2D


onready var rdvPoints: = {
	"doorE": $Background/PassageRight.targetPosition
}


func get_floor_meshes():
	return [$FloorPolygonTop, $FloorPolygonLeft, $FloorPolygonRight, $FloorPolygonBottom]
