extends CanvasLayer
var lineas = []
var cabezas = []
@onready var scoreDisplays: Node = $scores
@onready var animation_player: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	cabezas = scoreDisplays.get_children()
	for c in cabezas:
		lineas.append(c.get_child(0))
	pass # Replace with function body.

func mostrarScores(scores, escena):
	visible = true
	animation_player.play("disolve")
	await animation_player.animation_finished
	get_tree().paused = true
	for s in range(len(scores)):
		cabezas[s].visible = true
		lineas[s].scale.y = -(scores[s] * 10)
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(escena)
	for s in range(len(scores)):
		cabezas[s].visible = false
	get_tree().paused = false
	animation_player.play_backwards("disolve")
	visible = false
