extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _physics_process(delta):

	var vec = Vector2.ZERO
	vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	vec = vec.normalized()

	if vec != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", vec)
		animation_tree.set("parameters/Run/blend_position", vec)
		animation_state.travel("Run")
		velocity = velocity.move_toward(vec * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
