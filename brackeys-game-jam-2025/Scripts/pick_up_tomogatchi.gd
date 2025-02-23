extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func Interact():
	get_tree().get_first_node_in_group("Tomogatchi").show()
	get_parent().queue_free()
