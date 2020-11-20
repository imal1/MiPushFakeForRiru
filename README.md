# Riru - MiPushFake

![License GPL-3.0](https://img.shields.io/badge/license-GPLv3.0-green.svg)

Fake as a Xiaomi device by hooking system_property_get.

Requires Riru Core installed.

## What does this module do	

By default, `__system_property_get` (`__system_property_read_callback` on API 26+) will be hooked in packages selected in	
MiPushFramework with value map below	

* `ro.miui.ui.version.name` -> `V11`	
* `ro.miui.ui.version.code` -> `9`	
* `ro.miui.version.code_time` -> `1570636800`	
* `ro.miui.internal.storage` -> `/sdcard/`	
* `ro.product.manufacturer` -> `Xiaomi`	
* `ro.product.brand` -> `Xiaomi`	
* `ro.product.name` -> `Xiaomi`	

## Configuration

### Packages

`/data/adb/riru/modules/mipush_fake/packages/<package name>`

### Properties

`/data/misc/riru/modules/mipush_fake/properties/<key>` (file content is value)

* `ro.miui.ui.version.name` -> `V11`	
* `ro.miui.ui.version.code` -> `9`	
* `ro.miui.version.code_time` -> `1570636800`	
* `ro.miui.internal.storage` -> `/sdcard/`	
* `ro.product.manufacturer` -> `Xiaomi`	
* `ro.product.brand` -> `Xiaomi`	
* `ro.product.name` -> `Xiaomi`	

Thanks
* Timothy Zhang
* MlgmXyysd
* Rikka