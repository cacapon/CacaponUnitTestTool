class_name CacaponUnitTest
extends SceneTree

## _input と　_expectedで比較します[br]
## return {"func_name":String, "status":bool, "info":String}
func assert_eq(_func_name:String, _input:Variant, _expected:Variant) -> Dictionary:
	var _dict = {
		"func_name" : _func_name,
		"status": _input == _expected,
		"info"	: "assert %s == %s" %[_input, _expected],
	}

	return 	_dict
