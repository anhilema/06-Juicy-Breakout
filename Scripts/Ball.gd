extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
onready var splodey = load("res://Scenes/splodey.tscn")
var alive = true


func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			var s = splodey.instance()
			s.position = position
			get_node("/root/Game/esplode").add_child(s)
			s.emitting = true
			print(s.position)
			body.queue_free()
	
	if position.y > get_viewport().size.y and alive:
		alive = false
		Game.change_lives(-1)
		$Particles2D2.emitting = true
		print($Particles2D2.position)
		$Timer.start()

func _on_Timer_timeout():
	Starting.startCountdown(3)
	queue_free()
