extends Node2D


onready var chapter = get_node("../..")

export(String, "char_underpants", "char_fancypants") var character
var CHARACTER = {
	
	"char_underpants": {
			"name": "Char in underpants",
			"properties": {
				"walk_speed": 35,
				"run_speed": 80,
				"has_following_eyes": true,
				},
			"animations": true,
			"sprite": load("res://Player/Char/char_underpants.png")
			},
	
	"char_fancypants": {
			"name": "Char in fancy pants",
			"properties": {
				"walk_speed": 35,
				"run_speed": 80,
				"has_following_eyes": true,
				},
			"animations": true,
			"sprite": load("res://Player/Char/char_fancypants.png")
			}
	}

var running_cap_length: float = 90
var lastAction: String
var char_data = CHARACTER[Data.data.player.character]


func _ready():
	select_character(Data.data.player.character)


func select_character(selectedCharacter):
	Data.data.player.character = selectedCharacter
	init_character()


func init_character():
	$PlayerSprite.set_flip_h(Data.data.player.flip_h)
	$PlayerSprite.texture = char_data.sprite
	if char_data.properties.has_following_eyes:
		$PlayerSprite/CharHead.modulate = Color.white
	else:
		$PlayerSprite/CharHead.modulate = Color.transparent


func go_to(	targetPos,
			actionType,
			actionName = lastAction,
			flipH = true,
			goToRoom = "",
			isInsertShot = false,
			goToPosition = Vector2.ZERO):
	if char_data.properties.walk_speed != 0:
		# Def  of the current and target positions.
		var currentPos = $PlayerSprite.position
		targetPos.x = round(targetPos.x)
		targetPos.y = round(targetPos.y)
		# If Char isn't at the target position, find a path.
		if  not currentPos == targetPos:
			var path = $Navigation2D.get_simple_path(currentPos, targetPos)
			# If the target is reachable (no gap between the areas).
			if path.size() > 0:
				# If the target is reachable (not the closest point).
				if targetPos == path[-1]:
					var charName = char_data.name
					var printSentence = charName + " is going to " + str(targetPos)
					if actionType == "":
						print(printSentence + ".")
					elif actionType == "go to":
						print(printSentence + " to go to " + goToRoom + ".")
					else:
						print(printSentence + " to " + actionType + ".")
					# Draw the line.
					$Line2D.points = path
					# Calculation of the total length to go, to assign speed.
					var travel_length: float = 0
					for i in path.size() - 1:
						travel_length += path[i].distance_to(path[i+1])	
					# Assigning speed, according to the running distance minimum.
					if travel_length >= running_cap_length:
						$PlayerSprite.speed = char_data.properties.run_speed
						$AnimationTree["parameters/playback"].travel("run")
					else:
						$PlayerSprite.speed = char_data.properties.walk_speed
						$AnimationTree["parameters/playback"].travel("walk")
					$PlayerSprite.path = path
		lastAction = actionName
		yield($PlayerSprite,"arrived_at_destination")
		if $PlayerSprite.position == targetPos and actionName == lastAction:
#			if actionType in ["go to", "idle"]:
#				Data.data.player.position = $PlayerSprite.position
			if not actionType in ["go to", "look", "duck"]:
				$AnimationTree["parameters/playback"].travel(actionType)
			else:
				chapter.change_room(goToRoom, goToPosition, flipH)
