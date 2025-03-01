extends RigidBody2D
class_name RingPhysical
onready var ring : Area2D = $Ring
var exit_timer:float = 2.0

func _ready() -> void:
	set_intangible_temp()

func set_intangible_temp():
	ring.set_deferred("monitoring", false)
	ring.pick_box.set_deferred("disabled", true)
	yield(get_tree().create_timer(1.5),"timeout")
	if is_instance_valid(ring):
		ring.set_deferred("monitoring", true)
		ring.pick_box.set_deferred("disabled", false)
		counddown_exit()

func counddown_exit():
	yield(get_tree().create_timer(exit_timer), "timeout")
	var co_timer = get_tree().create_timer(3.0).connect("timeout", self, "queue_free")
	var count_disappear = 0.1
	
	while true:
		visible = !visible
		yield(get_tree().create_timer(count_disappear), "timeout")
		visible = !visible
		yield(get_tree().create_timer(count_disappear), "timeout")
		visible = !visible
		yield(get_tree().create_timer(count_disappear), "timeout")
		visible = !visible
		yield(get_tree().create_timer(count_disappear), "timeout")
		if count_disappear > 0.01:
			count_disappear -= 0.01


func _on_Ring_tree_exited() -> void:
	queue_free()
