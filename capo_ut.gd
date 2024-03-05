class_name CacaponUnitTest
extends SceneTree

func assert_eq(_func_name:String, _input:Variant, _expected:Variant) -> CacaponUnitTestAssertInfo:
	var _info = CacaponUnitTestAssertInfo.new(_func_name) #TODO:テストファイルのパスを知りたい

	_info._input 	= _input
	_info._expected = _expected
	_info.status 	= _input == _expected
	_info.info		= "assert %s == %s" %[_input, _expected] 
	return 	_info
