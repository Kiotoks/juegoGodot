extends Node3D
@onready var character: CharacterBody3D
@export var follow_speed: float = 15.0 
@export var damping: float = 0.1
@onready var bomba: RigidBody3D = $"../bomba"

var z_velocity: float = 0.0 
var offset = 7

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if  is_instance_valid(bomba.playerOwner):
		character = bomba.playerOwner
	if is_instance_valid(character):
		# Mantén la posición X e Y de la cámara pero sigue la Z del jugador
		# Calcula la distancia en Z entre la cámara y el jugador
		var z_difference = character.global_transform.origin.x + offset - global_transform.origin.x

		# Aplica una "fuerza" en Z basada en la diferencia y amortiguación
		z_velocity += z_difference * follow_speed * delta

		# Aplica amortiguación para suavizar el movimiento
		z_velocity *= (1.0 - damping)

		# Actualiza la posición Z de la cámara usando la velocidad calculada
		global_transform.origin.x += z_velocity * delta
	
