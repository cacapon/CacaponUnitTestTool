extends SceneTree

func show(result:Dictionary):
	var _output = create_session_starts(result)
	_output += create_short_summary(result)
	_output += create_fotter(result)
	print_rich(_output)

func create_session_starts(result:Dictionary) ->String:
	var _template := ""
	_template += center_fill("test session starts") +"\n"
	_template += "rootdir: %s" %result["root_dir"] +"\n"
	_template += "collected %d items" % (result["passed"] + result["failed"]) + "\n\n"

	result.results.sort()
	for test_result in result["results"]:
		_template += test_result + "\n"

	return _template
	
func create_short_summary(result:Dictionary) ->String:
	if result["summary"].is_empty():
		return ""
	var _template := "[color=blue]" + center_fill("short test summary info") + "[/color]" + "\n"

	result.summary.sort()
	for summary in result.summary:
		var formatted_summary = ""
		_template += "[color=red]FAILED[/color] %s::%s - %s"% summary + "\n"
	return _template
	
func create_fotter(result:Dictionary) -> String:
	var mes = "[color=green]%d passed[/color], [color=red]%d failed[/color]" %[result["passed"], result["failed"]]
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
