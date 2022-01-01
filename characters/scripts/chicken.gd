extends KinematicBody2D
# up, down left right; U, D, L, R

var body_data = {"head" : 1, "body" : 1, "eyes" : 1, "arms" : 1, "mouth" : 1, 
"legs" : 1}
onready var age = 0
var health = 1

var dir = "D"
var anim = "idle"
var speed = 500
var velocity = Vector2.ZERO

var inventory = {}

func _ready():
	pass

func _process(delta):
	animate_body()
	get_input()
	velocity = move_and_slide(velocity)

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		dir = "R"
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		dir = "L"
		velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		dir = "D"
		anim = "walk_y"
		velocity.y += 1
	if Input.is_action_pressed('move_up'):
		dir = "U"
		anim = "walk_y"
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed
"""
animate_body
This function will set the animations for each body component, and set the anim 
for the AnimationPlayer to play.
"""
func animate_body():
	$Body/Head/Eyes.play(str(body_data["eyes"]) + "_" + dir)
	$Body/Head/Mouth.play(str(body_data["mouth"]) + "_" + dir)
	$Body/Arm_L.play(str(body_data["arms"]) + "_" + dir)
	$Body/Arm_R.play(str(body_data["legs"]) + "_" + dir)
	$AnimationPlayer.play(anim)
	if dir == "U":
		$Body/Head/Eyes.visible = false
		$Body/Head/Mouth.visible = false
		$Body/Head/Feathers.flip_h = true
	else:
		$Body/Head/Eyes.visible = true
		$Body/Head/Mouth.visible = true
		$Body/Head/Feathers.flip_h = false
	
func render(data):
	body_data = data
