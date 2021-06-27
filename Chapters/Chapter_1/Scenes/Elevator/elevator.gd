extends Node2D


onready var chapter = get_node("..")


func _ready():
	$BackZone.goToRoom = Data.data.chapter_1.elevator_floor


func get_floor_meshes():
	return [$FloorPolygon]


func command(floor_name, requestedPosition, requestedFlipH):
	Data.data.chapter_1.elevator_floor = floor_name
	chapter.change_room(floor_name, requestedPosition, requestedFlipH)


func animate_elevator_travel(floor_name, requestedPosition, requestedFlipH):
	# Actions before elevator travel
	command(floor_name, requestedPosition, requestedFlipH)
