extends Node

const SAVE_DIR = "user://saves/"

var save_path = SAVE_DIR + "save_%03d.dat"

func save_file(id):
	var data = Data.data
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open(save_path % id, File.WRITE)
#	var error = file.open_encrypted_with_pass(save_path % id, File.WRITE, "&Fr4GMt8T!0n.")
	if error == OK:
		file.store_var(data)
		file.close()


func load_file(id):
	var file = File.new()
	if file.file_exists(save_path % id):
		var error = file.open(save_path % id, File.READ)
#		var error = file.open_encrypted_with_pass(save_path % id, File.READ, "&Fr4GMt8T!0n.")
		if error == OK:
			Data.data = file.get_var()
			file.close()
