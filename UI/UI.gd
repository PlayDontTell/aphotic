extends Node


func _input(event):
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE) and not event.echo:
			
			var result = Data.save_file(1)

			if result is GDScriptFunctionState: # Still working.
				result = yield(result, "completed")

			get_tree().quit()
