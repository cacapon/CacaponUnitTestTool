# GodotCLIUnitTest
Godot4向けCLI用ユニットテストライブラリ
※ MacOSでの確認のみ実施　

## 使い方
1. 本ツールを`addon/`以下にインストールしてください。
	- EditorPluginではないので有効化できません。
1. プロジェクト直下に`test/`ディレクトリを作ってください
1. test_sample.gdを参考に `test_<任意の名前>.gd`スクリプトを作成してください
1. コマンドラインから`<Godot Engineのパス> -s addons/godot_cli_unittest/run.gd --headless`を実行してください
1. 次の条件に含まれるメソッドが実行されtest結果が表示されます
	- `test/`以下に存在するスクリプトであること
	- ファイル名が`test_`から始まるgdスクリプトであること
	- メソッド名が`test_`から始まること

### テスト結果表示例

成功時
``` sh
============================= test session starts ==============================
rootdir: /Users/cacapon-project/workspace/Godot4/GodotCLIUnitTest/
collected 1 items

res://tests/test_sample.gd 	PASSED:1
=================================== 1 passed ===================================
```

失敗時
```
============================= test session starts ==============================
rootdir: /Users/cacapon-project/workspace/Godot4/GodotCLIUnitTest/
collected 2 items

res://tests/test_sample.gd 	PASSED:1 FAILED:1
=========================== short test summary info ============================
FAILED res://tests/test_sample.gd:: - assert foo != foo
============================== 1 passed 1 failed ===============================
```

### テスト用メソッドの定義方法
``` gdscript
extends GodotCLIUnittest


func test_example() -> Dictionary:
	var a := 1
	var b := 2
	return assert_eq(a,b)
```

1. GodotCLIUnittestクラスを継承して作成します
2. `assert_eq()`メソッドか`assert_not_eq()`メソッドをreturnで返してください
