extends GodotCLIUnittest

func test_eq_ok() -> Dictionary:
	var a := 1
	var b := 1
	return assert_eq(a,b)

#func test_eq_ng() -> Dictionary:
	#var a := 1
	#var b := 2
	#return assert_eq(a,b)

func test_not_eq_ok() -> Dictionary:
	var a := "foo"
	var b := "bar"
	return assert_not_eq(a,b)

#func test__not_eq_ng() -> Dictionary:
	#var a := "foo"
	#var b := "foo"
	#return assert_not_eq(a,b)

