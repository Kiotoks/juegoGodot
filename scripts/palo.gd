# Script en el RigidBody3D del palo
extends RigidBody3D

@export var rotation_speed = 1.0  # Ajusta la velocidad de rotación
@export var push_force = 20.0
@export var up_force = 5.0


@export var delay_time = 5.0  # Tiempo de espera antes de comenzar a girar (5 segundos)

var can_rotate = false  # Controla si el palo puede rotar o no

func _ready():
	can_sleep = false
	# Configura y empieza el temporizador
	var timer = $Timer  # Asegúrate de tener un Timer como hijo de este nodo
	timer.wait_time = delay_time
	timer.start()
	timer.connect("timeout", _on_Timer_timeout)  # Conecta la señal al método de inicio de rotación

# Función que se ejecuta cuando el temporizador llega a 0
func _on_Timer_timeout():
	print("hola")
	can_rotate = true  # Permite que el palo comience a rotar después del retraso

func _integrate_forces(state):
	if can_rotate:
		var rotation_transform = Transform3D(Basis(Vector3.UP, rotation_speed * state.step), Vector3.ZERO)
		self.transform *= rotation_transform


func _on_area_3d_body_entered(body) -> void:
	if body.is_class("CharacterBody3D"):  
		
		var push_direction = (body.global_transform.origin - global_transform.origin).normalized()
		# Aplica un impulso directo al jugador
		push_direction = push_direction * Vector3(push_force, 1 , push_force) 
		push_direction += Vector3(0, up_force, 0)
		body.velocity += push_direction
