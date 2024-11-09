extends Node

@onready var player: CharacterBody3D = $player
@onready var player_2: CharacterBody3D = $player2
# Called when the node enters the scene tree for the first time.
var arrayJugadores = [player, player_2]


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_3d_body_entered(body) -> void:
	if body is CharacterBody3D:
		print(body.numero_de_jugador)
		body.queue_free()
	pass # Replace with function body.
