extends SceneTree

func show(result:CacaponUnitTestTotalInfo):
	var _output = create_session_starts(result)
	_output += create_short_summary(result)
	_output += create_fotter(result)
	print_rich(_output)

func create_session_starts(result:CacaponUnitTestTotalInfo) ->String:
	var _template := ""
	_template += "============================= test session starts ==============================" +"\n"
	_template += "rootdir: %s" %result.root_dir +"\n"
	_template += "collected %d items" % (result.passed + result.failed) + "\n\n"

	result.results.sort()
	for test_result in result.results:
		_template += test_result + "\n"

	return _template
	
func create_short_summary(result:CacaponUnitTestTotalInfo) ->String:
	if result.summary.is_empty():
		return ""
	var _template := "[color=blue]=========================== short test summary info ============================[/color]" + "\n"

	result.summary.sort()
	for summary in result.summary:
		_template += summary + "\n"
	return _template
	
func create_fotter(result:CacaponUnitTestTotalInfo) -> String:
	var _template = "===========================   [color=green]%d passed[/color], [color=red]%d failed[/color]    ===========================" %[result.passed, result.failed]
	return _template
