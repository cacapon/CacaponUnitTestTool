class_name CacaponUnitTestAggregationInfo
extends SceneTree

var file_path	:String
var passed		:=0
var failed		:=0
var summary		:Array[String]

func _init(_file_path:String):
	file_path 	= _file_path

func set_summary(func_name:String, _assert:String):
	# <red>FAILED</red> <test-dir>/<testfile>.gd::<test_func>() - assert 11 <= 10
	var _template = ""
	_template += "[color=red]FAILED[/color] "
	_template += "%s::" % file_path
	_template += "%s " % func_name
	_template += "- %s" % _assert
	summary.append(_template)

func output() ->String:
	var passed_text = "PASSED:%d"% passed
	var failed_text = "FAILED:%d"% failed

	if passed > 0:
		passed_text = "[color=green]" + passed_text + "[/color]"
	if failed > 0:
		failed_text = "[color=red]" + failed_text + "[/color]"

	return "%s {%s, %s}" % [file_path, passed_text, failed_text]
