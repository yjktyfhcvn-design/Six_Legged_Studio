#extends Node2D
#class_name Stopwatch
#
#var time = 0.0
#var stopped = false
#
#func time_to_string():
	#var msec = fmod(time, 1) * 1000
	#var sec = fmod(time, 60)
	#var min = time / 60
	#var format_string = "%02d : %02d : %02d"
	#var actual_string = format_string % [min,sec,msec]
#
#func _process(delta):
	#if stopped:
		#return
	#time += delta
	#print(actual_string)
	#
#func reset():
	#time = 0.0


	#return actual_string
