extends Node3D
@onready var robot: Node3D = $"3DGodotRobot"
@onready var animacion = robot.get_node("AnimationPlayer")
@export var confeti : Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ganados = StaticData.cantGanados
	var mayor = 0
	var ganador = 0
	for g in ganados:
		if g > mayor:
			mayor = g
			ganador = ganados.find(g)
	
	robot.cambiarColor(ganador)
	animacion.play("Emote1")
	for c in confeti:
		c.activar()
		await get_tree().create_timer(0.7).timeout
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animacion.play("Emote1")
	pass


func _on_boton_salir_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")
	pass # Replace with function body.
