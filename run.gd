extends SceneTree


func _init():
	var result = CacaponUnitTestTotalInfo.new(ProjectSettings.globalize_path("res://"))
	var file_paths = get_test_files("res://tests/")
	for file_path in file_paths:
		var _result := call_tests(file_path)
		result.passed += _result.passed
		result.failed += _result.failed
		result.results.append(_result.output())
		result.summary.append_array((_result.summary))
		_result.free()
	var _log = load("res://log_view.gd").new()
	_log.show(result)
	result.free()
	_log.free()
	quit()

func call_tests(file_path:String) -> CacaponUnitTestAggregationInfo:
	# TODO:Thread実行に変えたい
	var _agg_result = CacaponUnitTestAggregationInfo.new(file_path)
	var _ins = load(file_path).new()
	var func_list :Array[Dictionary] = _ins.get_method_list()
	for function in func_list:
		var name = function.get("name") as String
		var _assert_info = call_test(_ins, name) as CacaponUnitTestAssertInfo
		if not _assert_info:
			continue
		if _assert_info.status:
			_agg_result.passed += 1
		else:
			_agg_result.failed += 1
			_agg_result.set_summary(_assert_info.func_name, _assert_info.info)
		_assert_info.free()
	_ins.free()
	return _agg_result

func call_test(instance:SceneTree, method_name:String)-> CacaponUnitTestAssertInfo:
	if not method_name.begins_with("test_"):
		return
	var _call = Callable(instance, method_name)
	return _call.call() as CacaponUnitTestAssertInfo


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
				if file_name.begins_with("test_"):
					arr.append(path + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return arr
	
