extends GodotCLIUnittest

func test_eq_ok() -> Dictionary:
	var a := 1
	var b := 1
	return assert_eq(a,b)

func test_eq_ng() -> Dictionary:
	var a := 1
	var b := 2
	return assert_eq(a,b)

func test_not_eq_ok() -> Dictionary:
	var a := "foo"
	var b := "bar"
	return assert_not_eq(a,b)

func test_not_eq_ng() -> Dictionary:
	var a := "foo"
	var b := "foo"
	return assert_not_eq(a,b)

func test_type_check() -> Dictionary:
	var a := 1
	var b := "bar"
	return assert_eq(a,b)

func test_type_check_not_eq() -> Dictionary:
	var a := 1.0
	var b := ["hoge"]
	return assert_not_eq(a,b)
