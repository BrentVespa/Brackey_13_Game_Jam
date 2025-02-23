extends Node

var rng = RandomNumberGenerator.new()
@export_category("World_Settings")
@export var Money = 0
@export var override = true
@export var food : int = 50
@export var water : int = 50
@export var stress : int = 50
@export var textTime : int = 10
#World States are as folows:
#0 Failure
#1 Cutscene
#2-15 Game is running and events are happening
@export var WorldState : int = 2
@export var oldWorldState : int
var canFail = true
@export var Types : Dictionary = {"Blue": 5, "Purple": 10, "Yellow" : 1000}
@export var TypesColor : Dictionary = {"Blue": Color.BLUE, "Purple": Color.PURPLE, "Yellow" : Color.YELLOW}
@onready var World = get_tree().get_first_node_in_group("World")
@onready var UI = get_tree().get_first_node_in_group("UI")
@onready var UI3D = get_tree().get_first_node_in_group("UI3D")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	GlobalSignals.clone.connect(clone)
	GlobalSignals.cloneFresh.connect(cloneFresh)
	GlobalSignals.payout.connect(payout)
	GlobalSignals.updateUI.connect(_update_UI)
	GlobalSignals.closeTextBoxes.connect(_closeTextBoxes)
	GlobalSignals.updateUI3D.connect(_update_UI_3D)
	GlobalSignals.updatePlayerStats.connect(_updatePlayerStats)
	GlobalSignals.updateWorldState.connect(_updateWorldState)
	GlobalSignals.failState.connect(_failState)
	GlobalSignals.advanceSubWorldTick.connect(_advanceSubWorldTick)
	GlobalSignals.advanceMainWorldTick.connect(_advanceMainWorldTick)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canFail:
		if food <= 0 || water <= 0 || stress <= 0:
			canFail = false
			var anim = get_tree().get_first_node_in_group("Tran")
			_updateWorldState(0)
			anim.play("Fail")

func clone(caller: CharacterBody2D, hit: CharacterBody2D, pos):
	var popx = rng.randf_range(-2, 2)
	var popy = rng.randf_range(-2, 2)
	pos = Vector2(caller.global_position.x + popx, caller.global_position.y + popy)
	var instance = caller.PreFab.instantiate()
	instance.position = pos
	if instance.types.size() == 0:
		if instance.types.has(caller.types) == false:
			#print(instance.types)
			instance.types.append_array(caller.types)
		if instance.types.has(hit.types) == false:
			#print(instance.types)
			instance.types.append_array(hit.types)
	for e in instance.types:
		if instance.types.count(e) != 1:
			instance.types.erase(e)
	instance.pop_num = (rng.randi_range(1, 20) / 2)
	instance.color = caller.color + hit.color
	if instance.pop_num % 2 == 0 || override == true:
		World.add_child(instance)
	hit.queue_free()
	caller.queue_free()

func cloneFresh(caller: CharacterBody2D, PreFab: PackedScene, pos):
	var popx = rng.randi_range(-100, 100)
	var popy = rng.randi_range(-100, 100)
	pos = Vector2(pos.x + popx, pos.y + popy)
	var instance = PreFab.instantiate()
	instance.position = pos
	instance.types.clear()
	var random_key = Types.keys().pick_random()
	instance.types.append(random_key)
	print(instance.types)
	print(TypesColor)
	for e in TypesColor:
		print(e)
		if instance.types.has(e):
			if instance.color != TypesColor.get(e):
				instance.color += TypesColor.get(e)
				print(instance.color)
	World.add_child(instance)
	Money -= 5
	_update_UI()

func payout(caller: CharacterBody2D):
	#print("Paying out in 1")
	var moneyCalc = 0
	for e in caller.types:
		if Types.has(e):
			moneyCalc += Types.get(e) * caller.mod
		#print("Paying out: ", moneyCalc)
	Money += moneyCalc
	_update_UI()

func _update_UI():
	UI.text = ("$ %d" % Money)

func _update_UI_3D():
	UI3D.update_text()
	
func _updatePlayerStats(UFood, UWater, UStress):
	food += UFood
	water += UWater
	stress += UStress

func _closeTextBoxes(caller):
	print("Close Text Boxes has been called by: ", caller)
	var existingText = get_tree().get_nodes_in_group("Text")
	for e in existingText:
		print(e)
		if e == caller:
			caller.flip()
		else:
			e.hideText()

func _updateWorldState(new: int):
		oldWorldState = WorldState
		if WorldState >= 6:
			WorldState = 2
		else:
			WorldState = new

func _failState():
	if canFail:
		canFail = false
		var anim = get_tree().get_first_node_in_group("Tran")
		_updateWorldState(0)
		anim.play("Win")

func _advanceSubWorldTick():
	food -= 1
	water -= 1
	stress -= 1
	_update_UI_3D()
	
func _advanceMainWorldTick():
	_updateWorldState(WorldState + 1)
	PaController._worldEventReference()
	stress -= 10
	_update_UI_3D()
	
