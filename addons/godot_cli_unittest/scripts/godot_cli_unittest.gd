class_name GodotCLIUnittest
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
	# type check
	if typeof(_input) != typeof(_expected):
		var _input_type 	:= type_string(typeof(_input))
		var _expected_type 	:= type_string(typeof(_expected))
		return _create_unittest_data(
			false,
			"_input:%s != _expected:%s" %[_input_type , _expected_type]
		)

	return 	_create_unittest_data(
		_input == _expected, 
		"assert %s == %s" %[_input, _expected] if not _input == _expected else ""
	)

func assert_not_eq(_input:Variant, _expected:Variant) -> Dictionary:
	if typeof(_input) != typeof(_expected):
		var _input_type 	:= type_string(typeof(_input))
		var _expected_type 	:= type_string(typeof(_expected))
		return _create_unittest_data(
			false,
			"_input:%s != _expected:%s" %[_input_type , _expected_type]
		)

	return 	_create_unittest_data(
		_input != _expected,
		"assert %s != %s" %[_input, _expected] if not _input != _expected else "",
	)

func _create_unittest_data(status:bool,info:String)-> Dictionary:
	var _dict = {
		"func_name" : active_function,
		"status": status,
		"info"	: info,
	}
	return _dict
