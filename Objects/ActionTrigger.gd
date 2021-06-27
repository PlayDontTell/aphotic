extends Node2D


export(String, "idle", "go to", "pick", "look", "push", "duck") var actionType
export var flipH = false
export var actionName: String
export var goToRoom: String
export var isInsertShot: bool
export var goToPosition: String

onready var targetPosition: Vector2 = $TargetPosition.position + position


func _on_ActionTrigger_area_entered(area):
	if area.is_in_group("cursor"):
		Global.set_children_highlighted(self)


func _on_ActionTrigger_area_exited(area):
	if area.is_in_group("cursor"):
		Global.reset_children_modulate(self)
