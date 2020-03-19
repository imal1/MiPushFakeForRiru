# Riru - MiPushFake

![License GPL-3.0](https://img.shields.io/badge/license-GPLv3.0-green.svg)

Fake as a Xiaomi device by hook system_property_get.

Requires Riru - Core v19 or above installed.

## What does this module do	

By default, `__system_property_get` (`android::base::GetProperty` on Pie+) will be hooked in packages selected in	
MiPushFramework with value map below	

* `ro.miui.ui.version.name` -> `V11`	
* `ro.miui.ui.version.code` -> `9`	
* `ro.miui.version.code_time` -> `1570636800`	
* `ro.miui.internal.storage` -> `/sdcard/`	
* `ro.product.manufacturer` -> `Xiaomi`	
* `ro.product.brand` -> `Xiaomi`	
* `ro.product.name` -> `Xiaomi`	