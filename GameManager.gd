extends Node


const CHAPTERS = {
	"chapter_1": "res://Chapters/Chapter_1/Chapter_1.tscn"
}


func _ready():
	SaveSystem.load_file(1)
	select_chapter(Data.data.player.chapter)


func select_chapter(chapter):
	Global.remove_all_children_scenes(self)
	Data.data.player.chapter = chapter
	Global.add_child_scene(self, CHAPTERS[chapter])
