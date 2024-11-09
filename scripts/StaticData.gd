extends Node

var charOpcs = {}
var data_file_path = "res://data/personaje.json"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	charOpcs = load_json_file(data_file_path)
	pass # Replace with function body.

func load_json_file (path :String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
