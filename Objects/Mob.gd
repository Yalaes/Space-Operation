extends Area2D

#Mob movement
export var velocity: = Vector2.ZERO
export var speed: = 100

export var canShoot: bool
export var shootSpeed: = 1.5

export(String, FILE) var ammoPath
var Ammo
export(String, FILE) var explodeAnim
var ExplodeAnim

func _ready() -> void:
	$Timer.wait_time = shootSpeed
	Ammo = load(ammoPath)
	ExplodeAnim = load(explodeAnim)
	
func _physics_process(delta: float) -> void:
	position.y += velocity.y * speed * delta
	
func shoot() -> void:
	var ammo = Ammo.instance()
	get_tree().get_root().add_child(ammo)
	ammo.global_position = position

func _on_Timer_timeout() -> void:
	if canShoot:
		shoot()

func _on_screen_exited() -> void:
	queue_free()
