extends Area2D
class_name Ammo

export var speed = 350
export var direction: Vector2
# any Non animated sprite
export(String, FILE) var texturePath
# the corresponding explosion effect
export(String, FILE) var explosionPath
var Explosion

func _ready() -> void:
	$Sprite.texture = load(texturePath)
	Explosion = load(explosionPath)

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()	
	
func _exit_tree() -> void:
	var explosion = Explosion.instance()
	get_tree().get_root().call_deferred("add_child", explosion)
	explosion.global_position = global_position

