extends CharacterBody2D

var push = false
var direction = 0
var can_spawn = false
var pop_num = 0
var canMerge : bool = false
var canMove : bool = true

@onready var mesh = %Mesh

@export_category("Cow")
@export var types : Array[String]
@export var PreFab : PackedScene = preload("res://Prefabs/Objects/cow.tscn")
@export var color : Color
@export var SPEED : int
@export var mod : int = 1
signal Clone()

enum CurrentState {
	idle,
	walking
}
var state = CurrentState.idle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh.modulate = color
	print(types)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if abs(global_position.x - $Target.global_position.x) <= 5:
		_change_state(CurrentState.idle)
	
	if is_on_floor():
		can_spawn = true
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if push:
		velocity.x = direction * delta * 5000
	else:
		velocity.x = 0
	
	if !push:
		var t = 0.0
		t += delta * .4
		global_position = global_position.lerp(Vector2(global_position.x + velocity.x, global_position.y), t)
	
	move_and_slide()

func Cow():
	print("Cow")

func _change_state(newState):
	state = newState

func idle():
	pass
	
func walking():
	pass

func _on_right_body_entered(body: Node2D) -> void:
	#print(body)
	if body.is_in_group("Player"):
		direction = -1
		push = true
	elif body.is_in_group("Cow") && body != self && canMerge == true:
		#print("Cow")
		if can_spawn:
			can_spawn = false	
			GlobalSignals.clone.emit(self, body, self.global_position)

func _on_left_body_entered(body: Node2D) -> void:
	#print(body)
	if body.is_in_group("Player"):
		direction = 1
		push = true
	elif body.is_in_group("Cow") && body != self && canMerge == true:
		#print("Cow")
		if can_spawn:
			can_spawn = false	
			GlobalSignals.clone.emit(self, body, self.global_position)
			
func _on_right_body_exited(body: Node2D) -> void:
	#print(body)
	if body.is_in_group("Player"):
		direction = 0
		push = false
	elif body.is_in_group("Cow") && body != self:
		#print("Cow")
		if can_spawn:
			self.queue_free()
			body.queue_free()

func _on_left_body_exited(body: Node2D) -> void:
	#print(body)
	if body.is_in_group("Player"):
		direction = 0
		push = false
	elif body.is_in_group("Cow") && body != self:
		#print("Cow")
		if can_spawn:
			self.queue_free()
			body.queue_free()


func _on_timer_timeout() -> void:
	canMerge = true


func _on_merge_check_timeout() -> void:
	var move = EventBus.rng.randi_range(-20, 20)
	$Target.global_position.x += move
	_change_state(CurrentState.walking)
