extends Area2D

@export var speed = 300
var screen_size 

func _ready(): #is called when node enters scene tree
	screen_size = get_viewport_rect().size 

func _process(delta):
	var velocity = Vector2.ZERO #Define o vetor para movimento
		#Check-input
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	if Input.is_action_pressed("move_up"):
		velocity.y-=1
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play(); #inicia ou para a animação
	else:
		$AnimatedSprite2D.stop();
	position+= velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
