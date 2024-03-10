class_name GodotCLIUnitTestLogView
extends SceneTree

func show(result:Dictionary):
	var _output = create_session_starts(result)
	_output += create_short_summary(result)
	_output += create_fotter(result)
	print_rich(_output)

func create_session_starts(result:Dictionary) ->String:
	#ex:
	# ============================= test session starts ==============================
	# rootdir: /Users/cacapon-project/workspace/Godot4/CacaponUnitTestTool/
	# collected 3 items
	#
	# res://tests/test_sample.gd 	PASSED:2 FAILED:1
	var _template := ""
	_template += center_fill("test session starts") +"\n"
	_template += "rootdir: %s" %result["root_dir"] +"\n"
	_template += "collected %d items" % (result["passed"] + result["failed"]) + "\n\n"

	var _passed_tmp := "[color=green]PASSED:%d[/color] "
	var _failed_tmp := "[color=red]FAILED:%d[/color] "

	result.results.sort()
	for test_result in result["results"]:
		_template += "%s \t" % test_result[0]
		if test_result[1] != 0:
			_template += _passed_tmp % test_result[1]
		if test_result[2] != 0:
			_template += _failed_tmp % test_result[2]
		_template += "\n"
	return _template
	
func create_short_summary(result:Dictionary) ->String:
	# ex: =========================== short test summary info ============================
	# ex: FAILED res://tests/test_sample.gd:: - assert foo != foo
	if result["summary"].is_empty():
		return ""
	var _template := "[color=blue]" + center_fill("short test summary info") + "[/color]" + "\n"

	result.summary.sort()
	for summary in result.summary:
		var formatted_summary = ""
		_template += "[color=red]FAILED[/color] %s::%s - %s"% summary + "\n"
	return _template
	
func create_fotter(result:Dictionary) -> String:
	# ex: ============================== 2 passed, 1 failed ==============================
	var mes = ""
	var _passed_tmp := "[color=green]%d passed[/color] "
	var _failed_tmp := "[color=red]%d failed[/color] "

	if result["passed"] != 0:
		mes += _passed_tmp % result["passed"]
	if result["failed"] != 0:
		mes += _failed_tmp % result["failed"]

	# 末尾空白トリミング
	mes = mes.trim_suffix(" ")

	return center_fill(mes)


## strを中央揃えしてwidthの数だけfill_charで埋めます
func center_fill(str:String, width:int=80, fill_char="=") -> String:
	# BBCodeを無視する
	var regex = RegEx.new()
	regex.compile("\\[[^\\]]*\\]")
	var trim_bbcode_str = regex.sub(str,"", true)

	var padding := width - trim_bbcode_str.length()
	if padding <= 0:
		return str
	var left_padding := padding / 2 - 1
	var right_padding := padding - left_padding - 2
	return fill_char.repeat(left_padding) + " %s " % str + fill_char.repeat(right_padding)
