
extends Panel

var counter=0
var checkBox

func _ready():
	set_process(true)
	get_node("Button").connect("pressed",self,"_on_button_pressed")

func _on_button_pressed():
	checkBox = get_node("CheckBox")
	
	get_node("Label").set_text("Hello")
	if (checkBox.is_pressed()):
		checkBox.set_pressed(false)
	else:
		checkBox.set_pressed(true)
	var scene = load("res://sayHello.scn")
	var node = scene.instance()
	add_child(node)

func _process(delta):
	counter+=delta
	get_node("Label").set_text(str(counter))