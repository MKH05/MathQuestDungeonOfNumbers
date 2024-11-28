extends Node

const SAVEFILE = "user://savefile.save"

var highest_record = 0
var score = 0

func _ready() -> void:
	load_score()

func update_recent(s):
	score = s

func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	if file:
		file.store_32(highest_record)
		file.close()
		print("Score saved:", highest_record)

func load_score():
	if FileAccess.file_exists(SAVEFILE):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		if file:
			highest_record = file.get_32()
			file.close()
			print("Score loaded:", highest_record)
