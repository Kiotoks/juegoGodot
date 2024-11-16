extends Node3D
@onready var confeti: Node3D = $confeti


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	confeti.activar()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
