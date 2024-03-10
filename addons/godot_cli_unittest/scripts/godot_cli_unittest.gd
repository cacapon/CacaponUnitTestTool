class_name GodotCLIUnittest
extends SceneTree

var _active_function := ""
var active_function :String:
	get:
		return _active_function
	set(value):
		_active_function = value + "()"


## _input と　_expectedで一致するか比較します[br]
## return {"func_name":String, "status":bool, "info":String}
func assert_eq(_input:Variant, _expected:Variant) -> Dictionary:
	return _assert_base(_input, _expected, true)


## _input と　_expectedで一致しないか比較します[br]
## return {"func_name":String, "status":bool, "info":String}
func assert_not_eq(_input:Variant, _expected:Variant) -> Dictionary:
	return _assert_base(_input, _expected, false)


func _assert_base(_input:Variant, _expected:Variant, operator:bool) -> Dictionary:
	# type check
	if typeof(_input) != typeof(_expected):
		var _input_type 	:= type_string(typeof(_input))
		var _expected_type 	:= type_string(typeof(_expected))
		return _create_unittest_data(
			false,
			"type_unmatch: %s and %s" %[_input_type , _expected_type]
		)

	# assert
	var status 	:bool = operator == (_input == _expected) # ==か!=かをoperatorで判定している
	var info 	:= ""

	if not status:
		# 比較が不一致だった場合にエラーメッセージを生成する
		info = "assert: %s %s= %s" %[_input, ("=" if operator else "!") ,_expected]

	return	_create_unittest_data(status, info)


func _create_unittest_data(status:bool,info:String)-> Dictionary:
	var _dict = {
		"func_name" : active_function,
		"status": status,
		"info"	: info,
	}
	return _dict
