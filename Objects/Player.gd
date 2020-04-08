extends Area2D

onready var sprite = $Sprite
var Ammo = preload("res://Objects/Ammo.tscn")
var PlayerExplode = preload("res://Effects/SpritePlayerExplode.tscn")
var canMove: bool = true
export var speed = 60
	
func _process(delta: float) -> void:
	if canMove:
		player_movement(delta)
	
func player_movement(delta: float) -> void:
	sprite.frame = 0
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		sprite.frame = 2
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		sprite.frame = 1
		
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
		
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	
	position += velocity.normalized() * speed * delta	
	
	if Input.is_action_just_released("ui_accept"):
		shoot()
	
func shoot():
	$AudioPlayerShoot.play()
	var ammo = Ammo.instance()
	get_tree().get_root().add_child(ammo) #so does not follow the player mvt
	ammo.global_position = position

func _exit_tree() -> void:
	var playerExplosion = PlayerExplode.instance()
	get_tree().get_root().call_deferred("add_child", playerExplosion)
	playerExplosion.global_position = global_position

func _on_Player_area_entered(area: Area2D) -> void:
	queue_free()
