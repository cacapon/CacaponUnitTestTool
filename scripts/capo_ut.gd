class_name CacaponUnitTest
extends SceneTree

var _active_function := ""
var active_function :String:
	get:
		return _active_function
	set(value):
		active_function = value

## _input と　_expectedで比較します[br]
## return {"func_name":String, "status":bool, "info":String}
func assert_eq(_input:Variant, _expected:Variant) -> Dictionary:
	var _dict = {
		"func_name" : active_function,
		"status": _input == _expected,
		"info"	: "assert %s == %s" %[_input, _expected] if not _input == _expected else "",
	}

	return 	_dict

func assert_not_eq(_input:Variant, _expected:Variant) -> Dictionary:
	var _dict = {
		"func_name" : active_function,
		"status": _input != _expected,
		"info"	: "assert %s != %s" %[_input, _expected] if not _input != _expected else "",
	}

	return 	_dict
