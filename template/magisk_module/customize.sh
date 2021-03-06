SKIPUNZIP=1

# check_architecture
if [ "$ARCH" != "arm" ] && [ "$ARCH" != "arm64" ] && [ "$ARCH" != "x86" ] && [ "$ARCH" != "x64" ]; then
  abort "! Unsupported platform: $ARCH"
else
  ui_print "- Device platform: $ARCH"
fi

# extract verify.sh
ui_print "- Extracting verify.sh"
unzip -o "$ZIPFILE" 'verify.sh' -d "$TMPDIR" >&2
if [ ! -f "$TMPDIR/verify.sh" ]; then
  ui_print    "*********************************************************"
  ui_print    "! Unable to extract verify.sh!"
  ui_print    "! This zip may be corrupted, please try downloading again"
  abort "*********************************************************"
fi
. $TMPDIR/verify.sh

# extract riru.sh
extract "$ZIPFILE" 'riru.sh' "$MODPATH"
. $MODPATH/riru.sh

check_riru_version

# extract libs
ui_print "- Extracting module files"

extract "$ZIPFILE" 'module.prop' "$MODPATH"
extract "$ZIPFILE" 'post-fs-data.sh' "$MODPATH"
extract "$ZIPFILE" 'uninstall.sh' "$MODPATH"
#extract "$ZIPFILE" 'sepolicy.rule' "$MODPATH"

if [ "$ARCH" = "x86" ] || [ "$ARCH" = "x64" ]; then
  ui_print "- Extracting x86 libraries"
  extract "$ZIPFILE" "system_x86/lib/libriru_$RIRU_MODULE_ID.so" "$MODPATH"
  mv "$MODPATH/system_x86" "$MODPATH/system"

  if [ "$IS64BIT" = true ]; then
    ui_print "- Extracting x64 libraries"
    extract "$ZIPFILE" "system_x86/lib64/libriru_$RIRU_MODULE_ID.so" "$MODPATH"
    mv "$MODPATH/system_x86/lib64" "$MODPATH/system/lib64"
  fi
else
  ui_print "- Extracting arm libraries"
  extract "$ZIPFILE" "system/lib/libriru_$RIRU_MODULE_ID.so" "$MODPATH"

  if [ "$IS64BIT" = true ]; then
    ui_print "- Extracting arm64 libraries"
    extract "$ZIPFILE" "system/lib64/libriru_$RIRU_MODULE_ID.so" "$MODPATH"
  fi
fi

set_perm_recursive "$MODPATH" 0 0 0755 0644

# extract Riru files
ui_print "- Extracting extra files"
[ -d "$RIRU_MODULE_PATH" ] || mkdir -p "$RIRU_MODULE_PATH" || abort "! Can't create $RIRU_MODULE_PATH"

rm -f "$RIRU_MODULE_PATH/module.prop.new"
extract "$ZIPFILE" 'riru/module.prop.new' "$RIRU_MODULE_PATH" true
set_perm "$RIRU_MODULE_PATH/module.prop.new" 0 0 0600 $RIRU_SECONTEXT

# Create default config if necessary
CONFIG_PATH="$RIRU_MODULE_PATH/config"

if [ ! -d "$CONFIG_PATH/properties" ]; then
    ui_print "- Creating default configuration (1)"
    mkdir -p "$CONFIG_PATH/properties"
    echo -n "V11" > "$CONFIG_PATH/properties/ro.miui.ui.version.name"
    echo -n "9" > "$CONFIG_PATH/properties/ro.miui.ui.version.code"
    echo -n "1570636800" > "$CONFIG_PATH/properties/ro.miui.version.code_time"
    echo -n "/sdcard/" > "$CONFIG_PATH/properties/ro.miui.internal.storage"
    echo -n "Xiaomi" > "$CONFIG_PATH/properties/ro.product.manufacturer"
    echo -n "Xiaomi" > "$CONFIG_PATH/properties/ro.product.brand"
    echo -n "Xiaomi" > "$CONFIG_PATH/properties/ro.product.name"
fi

if [ ! -d "$CONFIG_PATH/packages" ]; then
    ui_print "- Creating default configuration (2)"
    mkdir -p "$CONFIG_PATH/packages"
    touch "$CONFIG_PATH/packages/cmb.pb"
    touch "$CONFIG_PATH/packages/cn.adidas.app"
    touch "$CONFIG_PATH/packages/com.autonavi.minimap"
    touch "$CONFIG_PATH/packages/com.coolapk.market"
    touch "$CONFIG_PATH/packages/com.dianping.v1"
    touch "$CONFIG_PATH/packages/com.eastmoney.android.fund"
    touch "$CONFIG_PATH/packages/com.eg.android.AlipayGphone"
    touch "$CONFIG_PATH/packages/com.huami.watch.hmwatchmanager"
    touch "$CONFIG_PATH/packages/com.icbc"
    touch "$CONFIG_PATH/packages/com.sankuai.meituan"
    touch "$CONFIG_PATH/packages/com.smzdm.client.android"
    touch "$CONFIG_PATH/packages/com.starbucks.cn"
    touch "$CONFIG_PATH/packages/com.taobao.idlefish"
    touch "$CONFIG_PATH/packages/com.taobao.taobao"
    touch "$CONFIG_PATH/packages/com.tencent.weread"
    touch "$CONFIG_PATH/packages/com.tigerbrokers.stock"
    touch "$CONFIG_PATH/packages/com.wudaokou.hippo"
    touch "$CONFIG_PATH/packages/com.xes.jazhanghui.activity"
    touch "$CONFIG_PATH/packages/com.xiaomi.hm.health"
    touch "$CONFIG_PATH/packages/com.xiaomi.smarthome"
    touch "$CONFIG_PATH/packages/com.xiaomi.wearable"
    touch "$CONFIG_PATH/packages/com.ximalaya.ting.android"
    touch "$CONFIG_PATH/packages/cool.dingstock.mobile"
    touch "$CONFIG_PATH/packages/me.ele"
    touch "$CONFIG_PATH/packages/org.xinkb.blackboard.android"
fi

set_perm $CONFIG_PATH 0 0 0600 $RIRU_SECONTEXT
