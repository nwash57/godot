extends Node2D

var points = []
var moving = false
var player
var navigation
var target_pos = Vector2(0,0)
var test_player_pos
var isTestFrame = true

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	navigation = get_tree().get_nodes_in_group("navigation")[0]
	set_fixed_process(true)

func _fixed_process(delta):
	if (moving):
		move(delta, target_pos)
	if (abs(player.get_global_pos().x - target_pos.x) < 5 && abs(player.get_global_pos().y - target_pos.y) < 5):
		end_move()
	if (OS.get_frames_drawn() % 5 == 0):
		if (isTestFrame):
			test_player_pos = player.get_global_pos()
		elif (player.get_global_pos() == test_player_pos):
			end_move()
		if (isTestFrame):
			isTestFrame = false
		else:
			isTestFrame = true
	

func end_move():
	moving = false
	player.complete_current_action()

func _draw():
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0))
#
#func _input(event):
#	if (event.type == InputEvent.MOUSE_BUTTON):
#		moving = true
#		target_pos = event.pos
#
func get_moving():
	return moving

func start_move(tp):
	target_pos = tp
	moving = true

func move(delta, target_pos):
	points = navigation.get_simple_path(player.get_global_pos(), target_pos, false)
	if points.size() > 1:
		var impulse = (points[1] - player.get_global_pos()).normalized()
		player.apply_impulse(Vector2(), impulse * 5000 * delta)
		player.update()