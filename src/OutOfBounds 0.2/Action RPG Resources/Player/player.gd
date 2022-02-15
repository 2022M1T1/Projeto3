extends KinematicBody2D

const ACCELERATION = 2000
const FRICTION = 2000
const MAX_SPEED = 100
var velocity = Vector2.ZERO

var animationPlayer = null

func _ready():
	animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var input_Vector = Vector2.ZERO
	input_Vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_Vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_Vector = input_Vector.normalized()
	
	if input_Vector != Vector2.ZERO:
		if input_Vector.x > 0:
			animationPlayer.play("RunRight")
			
		elif input_Vector.x < 0:
			animationPlayer.play("RunLeft")
		elif input_Vector.y > 0:
			animationPlayer.play("RunDown")
		else:
			animationPlayer.play("RunUp")
		velocity = velocity.move_toward(input_Vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if Input.is_action_just_released("ui_right"):
			animationPlayer.play("IdleRight")
		elif Input.is_action_just_released("ui_left"):
			animationPlayer.play("IdleLeft")
		elif Input.is_action_just_released("ui_up"):
			animationPlayer.play("IdleUp")
		elif Input.is_action_just_released("ui_down"):
			animationPlayer.play("IdleDown")
	velocity = move_and_slide(velocity)