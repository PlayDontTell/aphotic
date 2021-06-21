extends Node


var lastFlipH: bool


func add_child_scene(parent_node, scene_to_load):
	var scene = ResourceLoader.load(scene_to_load)
	scene = scene.instance()
	yield(get_tree(), "idle_frame")
	parent_node.add_child(scene)


func remove_child_scene(parent_node, scene_to_unload):
	if parent_node.get_child_count() > 0:
		for i in parent_node.get_children():
			if not i.get_name() == scene_to_unload:
				parent_node.remove_child(i)
				i.queue_free()

func remove_all_children_scenes(parent_node, exceptions := []):
	for i in parent_node.get_children():
		if not i.name in exceptions:
			parent_node.remove_child(i)
			i.queue_free()

func set_children_highlighted(parent_node):
	for i in parent_node.get_children():
		if i.is_in_group("highlight"):
			i.modulate = Color(1.8, 1.8, 1.8, 1)
		if i.is_in_group("highlight_soft"):
			i.modulate = Color(1.3, 1.3, 1.3, 1)

func reset_children_modulate(parent_node):
	for i in parent_node.get_children():
		i.modulate = Color(1, 1, 1, 1)
