extends StaticBody3D

@onready var WorldText = %WorldText
@onready var TextBox = %TextBox
@onready var UIText = %UIText
@export var Text : String
@export var TextBoxText : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Text != "":
		WorldText.text = Text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Interact():
	if TextBoxText != "":
		UIText.text = TextBoxText
		GlobalSignals.emit_signal("closeTextBoxes", self)

func flip():
	if TextBox.visible:
		TextBox.hide()
	else:
		TextBox.show()

func hideText():
	TextBox.hide()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if TextBox.visible:
		TextBox.hide()
