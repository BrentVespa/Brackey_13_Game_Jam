extends Node3D

@onready var lightSource = %SpotLight3D
@onready var meshInt = %MeshInstance3D
@export var state : bool = false

func Something():
	#print("Lights state: ", state)
	if !state:
		meshInt.mesh.material.emission = Color(1, 1, 1, 1)
		lightSource.light_energy = 25
		state = !state
	elif state:
		meshInt.mesh.material.emission = Color(0, 0, 0, 1)
		lightSource.light_energy = 0
		state = !state
