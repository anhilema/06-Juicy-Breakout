extends Node2D

export var lives = 3
export var score = 0
var max_score = 0

var new_ball = preload("res://Scenes/Ball.tscn")
var Woo = load("res://Scenes/Woot.tscn")
var frick = load("res://Scenes/futz.tscn")
onready var ASP = get_node("Bwaaoing")
onready var BLU = get_node("Ouch")


func _ready():
	randomize()
	$Score.update_score(score)
	$Lives.update_lives(lives)
	for tile in get_tree().get_nodes_in_group("Tiles"):
		max_score += tile.points

func change_score(s):
	score += s
	$Score.update_score(score)
	ASP.play(0)
	var e = Woo.instance()
	get_node("/root/Game/Woo").add_child(e)
	e.emitting = true
	#if there are no more tiles, show the winning screen  len(get_tree().get_nodes_in_group("Tiles"))
	if score == 500:
		get_tree().change_scene("res://Scenes/Win.tscn")

func change_lives(l):
	lives += l
	$Lives.update_lives(lives)
	BLU.play(0)
	var falmingo = frick.instance()
	get_node("/root/Game/Oof").add_child(falmingo)
	falmingo.emitting = true
	#if there are no more lives show the game over screen
	if lives <= 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")

func make_new_ball(pos):
	var ball = new_ball.instance()
	ball.position = pos
	ball.name = "Ball"
	var vector = Vector2(0, -300)
	#choose a random direction, constraining it so we don't get too steep an angle
	if randi()%2:
		vector = vector.rotated(rand_range(PI/6,PI/3))
	else: 
		vector = vector.rotated(rand_range(-PI/3,-PI/6))
	ball.linear_velocity = vector
	add_child(ball)

