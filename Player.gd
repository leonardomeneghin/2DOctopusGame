extends Area2D
signal hit

@export var speed = 300
var screen_size 

func _ready(): #is called when node enters scene tree
	screen_size = get_viewport_rect().size 
	#hide()

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
		
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = velocity.x < 0
			
		elif velocity.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_v = velocity.y > 0
		
		position+= velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
	else:
		$AnimatedSprite2D.stop();
		



func _on_body_entered(body) -> void:
	hide() #Player desaparece
	hit.emit()
	# try broke
	#$CollisionShape2D.disabled = true
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
