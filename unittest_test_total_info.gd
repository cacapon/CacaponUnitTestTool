class_name CacaponUnitTestTotalInfo
extends SceneTree

var root_dir	:String
var passed		:= 0
var failed		:= 0
var results		:Array[String]
var summary		:Array[String]

func _init(_root_dir:String):
	root_dir 	= _root_dir
