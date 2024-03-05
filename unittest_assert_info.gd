class_name CacaponUnitTestAssertInfo
extends SceneTree

var func_name	:String
var _input		:Variant
var _expected	:Variant
var status		:bool
var info		:String

func _init(_func_name:String):
	func_name	= _func_name
	info		= ""
