extends SceneTree


func _init():
	var result = {
		"root_dir"	: ProjectSettings.globalize_path("res://"),
		"passed"	: 0,
		"failed"	: 0,
		"results"	: [],
		"summary"	: [],
	}
	var file_paths = get_test_files("res://tests/")
	for file_path in file_paths:
		var _result := call_tests(file_path)
		result["passed"] += _result["passed"]
		result["failed"] += _result["failed"]
		result["results"].append([_result["file_path"], _result["passed"], _result["failed"]])
		result.summary.append_array(_result.summary)
	var _log = GodotCLIUnitTestLogView.new()
	_log.show(result)
	_log.free()
	quit()


func call_tests(file_path:String) -> Dictionary:
	var _agg_result = {
		"file_path"	: file_path,
		"passed"	: 0,
		"failed"	: 0,
		"summary"	: [],
	}
	var _ins = load(file_path).new()
	var func_list :Array[Dictionary] = _ins.get_method_list()
	for function in func_list:
		var name = function.get("name") as String
		var _assert_info = call_test(_ins, name)
		if _assert_info.is_empty():
			continue
		if _assert_info.status:
			_agg_result["passed"] += 1
		else:
			_agg_result["failed"] += 1
			_agg_result["summary"].append([file_path.get_file(), _assert_info["func_name"], _assert_info["info"]])
	_ins.free()
	return _agg_result


## return: {}
func call_test(instance:GodotCLIUnittest, method_name:String)-> Dictionary:
	if not method_name.begins_with("test_"):
		return {}
	instance.active_function = method_name
	var _call = Callable(instance, method_name)
	return _call.call() as Dictionary


func get_test_files(path) -> Array[String]:
	var dir = DirAccess.open(path)
	var arr :Array[String] = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.begins_with("test_") and file_name.ends_with(".gd"):
					arr.append(path + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return arr
	
