extends CSGCombiner3D

@export var foodToSpawn : PackedScene
@onready var spawner = %Spawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Something():
	var pos = spawner.global_position
	var instance = foodToSpawn.instantiate()
	instance.global_position = pos
	get_tree().get_first_node_in_group("World").add_child(instance)
