extends ColorRect

@onready var AnimP : AnimationPlayer = %Anim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _fail():
	get_tree().change_scene_to_file("res://Scenes/fail_state.tscn")

func _on_timer_timeout() -> void:
	print("Ding Dong")
	GlobalSignals.emit_signal("advanceSubWorldTick")


func _on_timer_2_timeout() -> void:
	print("Bing Bong Death Approches")
	GlobalSignals.emit_signal("advanceMainWorldTick")
