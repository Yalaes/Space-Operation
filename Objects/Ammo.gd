extends Area2D

export var speed = 350
export var direction: Vector2
var Explosion = preload("res://Effects/Explode.tscn")
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()	
	
func _exit_tree() -> void:
	var explosion = Explosion.instance()
	get_tree().get_root().add_child(explosion)
	explosion.global_position = global_position
