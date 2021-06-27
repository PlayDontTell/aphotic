extends Node

const SCENES = {
	"cryopod": "res://Chapters/Chapter_1/Scenes/Cryopod/cryopod.tscn",
	"flora": "res://Chapters/Chapter_1/Scenes/Flora/flora.tscn",
	"control": "res://Chapters/Chapter_1/Scenes/Control/control.tscn",
	"quarters": "res://Chapters/Chapter_1/Scenes/Quarters/quarters.tscn",
	"maintenance": "res://Chapters/Chapter_1/Scenes/Maintenance/maintenance.tscn",
	"reactor": "res://Chapters/Chapter_1/Scenes/Reactor/reactor.tscn",
	"elevator": "res://Chapters/Chapter_1/Scenes/Elevator/elevator.tscn",
	"science": "res://Chapters/Chapter_1/Scenes/Science/science.tscn",
	"defense": "res://Chapters/Chapter_1/Scenes/Defense/defense.tscn",
	"armoury": "res://Chapters/Chapter_1/Scenes/Armoury/armoury.tscn",
}

var data: = {
	"elevator_floor": "control",
}

var ui = "res://UI/UI.tscn"


func _init():
	if not Data.data.has(Data.data.player.chapter):
		Data.data[Data.data.player.chapter] = data


func _ready():
	change_room(Data.data.player.scene)


func change_room(room, requestedPosition = Data.data.player.position,
		requestedFlipH = Data.data.player.flip_h):
	$UI/Cursor.areasEntered.clear()
	Global.remove_all_children_scenes(self, ["UI"])
	Global.add_child_scene(self, SCENES[room])
	Data.data.player.scene = room
	yield(get_tree(), "idle_frame")
	if has_node(room + "/Player"):
		# Setting the zone where the player can move.
		var floorPolygon = get_node(room).get_floor_meshes()
		var playerNav = get_node(room + "/Player/Navigation2D")
		playerNav.set_navigation_polygon(floorPolygon)
		# Setting the player appearance.
		var player = get_node(room + "/Player")
		player.select_character(Data.data.player.character)
		if requestedPosition == Vector2.ZERO:
			player.get_node("PlayerSprite").position = Data.data.player.position
		else:
			player.get_node("PlayerSprite").position = get_node(room).rdvPoints[requestedPosition]
		player.get_node("PlayerSprite").flip_h = requestedFlipH


func _on_Cursor_request_action(parameters):
	var p = parameters
	if has_node(Data.data.player.scene + "/Player"):
		var player = get_node(Data.data.player.scene +"/Player")
		match parameters.size():
			2:
				player.go_to(p[0], p[1])
			3:
				player.go_to(p[0], p[1], p[2])
			4:
				player.go_to(p[0], p[1], p[2], p[3])
			5:
				player.go_to(p[0], p[1], p[2], p[3], p[4])
			6:
				player.go_to(p[0], p[1], p[2], p[3], p[4], p[5])
			7:
				player.go_to(p[0], p[1], p[2], p[3], p[4], p[5], p[6])


func _on_Cursor_request_room_change(room):
	change_room(room)
