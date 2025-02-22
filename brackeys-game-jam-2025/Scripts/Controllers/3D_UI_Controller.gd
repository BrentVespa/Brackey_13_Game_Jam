extends Control

@onready var FoodBar = $"%Food"
@onready var WaterBar = $"%Water"
@onready var StressBar = $"%Stress"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FoodBar.value = EventBus.food
	WaterBar.value = EventBus.water
	StressBar.value = EventBus.stress

func update_text():
	FoodBar.value = EventBus.food
	WaterBar.value = EventBus.water
	StressBar.value = EventBus.stress
