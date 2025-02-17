extends Area2D

var pressed : bool = false
@export_category("Button Settings")
@export var PreFab : PackedScene = preload("res://Prefabs/Objects/cow.tscn")
@onready var Spawn = %SpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Player") && pressed == false:
		print("Buttoning")
		var button = get_child(0)
		button.global_position = lerp(button.global_position, Vector2(button.global_position.x, button.global_position.y + 5), .8)
		pressed = true
		GlobalSignals.cloneFresh.emit(body, PreFab, Spawn.global_position)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("Player") && pressed == true:
		print("UnButtoning")
		var button = get_child(0)
		button.global_position = lerp(button.global_position, Vector2(button.global_position.x, button.global_position.y - 5), .8)
		pressed = false
