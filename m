From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [RFC 1/2] block: let bdrv_set_key be used for authentication
Date: Wed,  9 Nov 2011 16:20:55 -0800
Message-ID: <ffc4f33d11e28204e6f35538b616c8968fdf8396.1320884065.git.josh.durgin@dreamhost.com>
References: <cover.1320884065.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47233 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756628Ab1KJAVk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 19:21:40 -0500
In-Reply-To: <cover.1320884065.git.josh.durgin@dreamhost.com>
In-Reply-To: <cover.1320884065.git.josh.durgin@dreamhost.com>
References: <cover.1320884065.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, kwolf@redhat.com

Add a BlockDriverState member 'needs_auth' to distinguish between
drives that require authentication and those that are encrypted.
Update the block_passwd monitor command and error strings to be about
generic passwords instead of encryption.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block.c          |   27 +++++++++++++++++++--------
 block.h          |    2 +-
 block_int.h      |    3 ++-
 blockdev.c       |    3 ++-
 hmp-commands.hx  |    6 +++---
 monitor.c        |   13 +++++++------
 qapi-schema.json |    7 +++++--
 qemu-img.c       |    4 ++--
 qerror.c         |   16 ++++++++--------
 qerror.h         |   12 ++++++------
 qmp-commands.hx  |    6 ++++--
 11 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/block.c b/block.c
index 49ca0b3..a33ed47 100644
--- a/block.c
+++ b/block.c
@@ -499,7 +499,7 @@ static int refresh_total_sectors(BlockDriverState *bs, int64_t hint)
         return 0;
 
     /* query actual device if possible, otherwise just trust the hint */
-    if (drv->bdrv_getlength) {
+    if (drv->bdrv_getlength && !(bdrv_key_required(bs) && bs->needs_auth)) {
         int64_t length = drv->bdrv_getlength(bs);
         if (length < 0) {
             return length;
@@ -1781,9 +1781,12 @@ int bdrv_key_required(BlockDriverState *bs)
 {
     BlockDriverState *backing_hd = bs->backing_hd;
 
-    if (backing_hd && backing_hd->encrypted && !backing_hd->valid_key)
+    if (backing_hd &&
+        (backing_hd->encrypted || backing_hd->needs_auth) &&
+        !backing_hd->valid_key) {
         return 1;
-    return (bs->encrypted && !bs->valid_key);
+    }
+    return (bs->encrypted || bs->needs_auth) && !bs->valid_key;
 }
 
 int bdrv_set_key(BlockDriverState *bs, const char *key)
@@ -1796,7 +1799,7 @@ int bdrv_set_key(BlockDriverState *bs, const char *key)
         if (!bs->encrypted)
             return 0;
     }
-    if (!bs->encrypted) {
+    if (!bs->encrypted && !bs->needs_auth) {
         return -EINVAL;
     } else if (!bs->drv || !bs->drv->bdrv_set_key) {
         return -ENOMEDIUM;
@@ -1808,6 +1811,11 @@ int bdrv_set_key(BlockDriverState *bs, const char *key)
         bs->valid_key = 1;
         /* call the change callback now, we skipped it on open */
         bdrv_dev_change_media_cb(bs, true);
+        /* if we couldn't read the size before, set it now */
+        if (bs->needs_auth) {
+            refresh_total_sectors(bs, bs->total_sectors);
+            bdrv_dev_resize_cb(bs);
+        }
     }
     return ret;
 }
@@ -1974,6 +1982,7 @@ BlockInfoList *qmp_query_block(Error **errp)
             info->value->inserted->ro = bs->read_only;
             info->value->inserted->drv = g_strdup(bs->drv->format_name);
             info->value->inserted->encrypted = bs->encrypted;
+            info->value->inserted->needs_auth = bs->needs_auth;
             if (bs->backing_file[0]) {
                 info->value->inserted->has_backing_file = true;
                 info->value->inserted->backing_file = g_strdup(bs->backing_file);
@@ -2059,14 +2068,16 @@ BlockStatsList *qmp_query_blockstats(Error **errp)
     return head;
 }
 
-const char *bdrv_get_encrypted_filename(BlockDriverState *bs)
+const char *bdrv_get_protected_filename(BlockDriverState *bs)
 {
-    if (bs->backing_hd && bs->backing_hd->encrypted)
+    if (bs->backing_hd &&
+        (bs->backing_hd->encrypted || bs->backing_hd->needs_auth)) {
         return bs->backing_file;
-    else if (bs->encrypted)
+    } else if (bs->encrypted || bs->needs_auth) {
         return bs->filename;
-    else
+    } else {
         return NULL;
+    }
 }
 
 void bdrv_get_backing_filename(BlockDriverState *bs,
diff --git a/block.h b/block.h
index 9d8909b..126ba11 100644
--- a/block.h
+++ b/block.h
@@ -262,7 +262,7 @@ int bdrv_write_compressed(BlockDriverState *bs, int64_t sector_num,
                           const uint8_t *buf, int nb_sectors);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 
-const char *bdrv_get_encrypted_filename(BlockDriverState *bs);
+const char *bdrv_get_protected_filename(BlockDriverState *bs);
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
 int bdrv_can_snapshot(BlockDriverState *bs);
diff --git a/block_int.h b/block_int.h
index 69418fe..68b91a1 100644
--- a/block_int.h
+++ b/block_int.h
@@ -177,7 +177,8 @@ struct BlockDriverState {
     int keep_read_only; /* if true, the media was requested to stay read only */
     int open_flags; /* flags used to open the file, re-used for re-open */
     int encrypted; /* if true, the media is encrypted */
-    int valid_key; /* if true, a valid encryption key has been set */
+    int needs_auth; /* if true, the media requires authentication */
+    int valid_key; /* if true, a valid key has been set */
     int sg;        /* if true, the device is a /dev/sg* */
 
     BlockDriver *drv; /* NULL means no media */
diff --git a/blockdev.c b/blockdev.c
index 9068c5b..a5fbf42 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -718,7 +718,8 @@ int do_block_set_passwd(Monitor *mon, const QDict *qdict,
 
     err = bdrv_set_key(bs, qdict_get_str(qdict, "password"));
     if (err == -EINVAL) {
-        qerror_report(QERR_DEVICE_NOT_ENCRYPTED, bdrv_get_device_name(bs));
+        qerror_report(QERR_DEVICE_PASSWORD_UNNECESSARY,
+                      bdrv_get_device_name(bs));
         return -1;
     } else if (err < 0) {
         qerror_report(QERR_INVALID_PASSWORD);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index f8d855e..fd15dba 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1200,8 +1200,8 @@ ETEXI
     {
         .name       = "block_passwd",
         .args_type  = "device:B,password:s",
-        .params     = "block_passwd device password",
-        .help       = "set the password of encrypted block devices",
+        .params     = "device password",
+        .help       = "set the password for a block device",
         .user_print = monitor_user_noop,
         .mhandler.cmd_new = do_block_set_passwd,
     },
@@ -1224,7 +1224,7 @@ ETEXI
 STEXI
 @item block_passwd @var{device} @var{password}
 @findex block_passwd
-Set the encrypted device @var{device} password to @var{password}
+Set the password of @var{device} password to @var{password}
 ETEXI
 
     {
diff --git a/monitor.c b/monitor.c
index 5ea35de..6eea007 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1073,7 +1073,7 @@ static void do_singlestep(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void encrypted_bdrv_it(void *opaque, BlockDriverState *bs);
+static void protected_bdrv_it(void *opaque, BlockDriverState *bs);
 
 struct bdrv_iterate_context {
     Monitor *mon;
@@ -1102,7 +1102,7 @@ static int do_cont(Monitor *mon, const QDict *qdict, QObject **ret_data)
     }
 
     bdrv_iterate(iostatus_bdrv_it, NULL);
-    bdrv_iterate(encrypted_bdrv_it, &context);
+    bdrv_iterate(protected_bdrv_it, &context);
     /* only resume the vm if all keys are set and valid */
     if (!context.err) {
         vm_start();
@@ -1121,7 +1121,7 @@ static void bdrv_key_cb(void *opaque, int err)
         do_cont(mon, NULL, NULL);
 }
 
-static void encrypted_bdrv_it(void *opaque, BlockDriverState *bs)
+static void protected_bdrv_it(void *opaque, BlockDriverState *bs)
 {
     struct bdrv_iterate_context *context = opaque;
 
@@ -4926,12 +4926,13 @@ int monitor_read_bdrv_key_start(Monitor *mon, BlockDriverState *bs,
     }
 
     if (monitor_ctrl_mode(mon)) {
-        qerror_report(QERR_DEVICE_ENCRYPTED, bdrv_get_device_name(bs));
+        qerror_report(QERR_DEVICE_PASSWORD_REQUIRED, bdrv_get_device_name(bs));
         return -1;
     }
 
-    monitor_printf(mon, "%s (%s) is encrypted.\n", bdrv_get_device_name(bs),
-                   bdrv_get_encrypted_filename(bs));
+    monitor_printf(mon, "%s (%s) requires a password.\n",
+                   bdrv_get_device_name(bs),
+                   bdrv_get_protected_filename(bs));
 
     mon->password_completion_cb = completion_cb;
     mon->password_opaque = opaque;
diff --git a/qapi-schema.json b/qapi-schema.json
index fbbdbe0..ab45057 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -370,6 +370,8 @@
 #
 # @encrypted: true if the backing device is encrypted
 #
+# @needs_auth: true if the backing device requires authentication
+#
 # @bps: total throughput limit in bytes per second is specified
 #
 # @bps_rd: read throughput limit in bytes per second is specified
@@ -389,8 +391,9 @@
 { 'type': 'BlockDeviceInfo',
   'data': { 'file': 'str', 'ro': 'bool', 'drv': 'str',
             '*backing_file': 'str', 'encrypted': 'bool',
-            'bps': 'int', 'bps_rd': 'int', 'bps_wr': 'int',
-            'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int'} }
+            'needs_auth': 'bool', 'bps': 'int', 'bps_rd': 'int',
+            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int',
+            'iops_wr': 'int'} }
 
 ##
 # @BlockDeviceIoStatus:
diff --git a/qemu-img.c b/qemu-img.c
index 86127f0..77c8165 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -240,8 +240,8 @@ static BlockDriverState *bdrv_new_open(const char *filename,
         goto fail;
     }
 
-    if (bdrv_is_encrypted(bs)) {
-        printf("Disk image '%s' is encrypted.\n", filename);
+    if (bdrv_key_required(bs)) {
+        printf("Disk image '%s' requires a password.\n", filename);
         if (read_password(password, sizeof(password)) < 0) {
             error_report("No password given");
             goto fail;
diff --git a/qerror.c b/qerror.c
index 807fb55..e4d9a9b 100644
--- a/qerror.c
+++ b/qerror.c
@@ -61,10 +61,6 @@ static const QErrorStringTable qerror_table[] = {
         .desc      = "The command %(name) has not been found",
     },
     {
-        .error_fmt = QERR_DEVICE_ENCRYPTED,
-        .desc      = "Device '%(device)' is encrypted",
-    },
-    {
         .error_fmt = QERR_DEVICE_INIT_FAILED,
         .desc      = "Device '%(device)' could not be initialized",
     },
@@ -85,10 +81,6 @@ static const QErrorStringTable qerror_table[] = {
         .desc      = "Device '%(device)' has not been activated",
     },
     {
-        .error_fmt = QERR_DEVICE_NOT_ENCRYPTED,
-        .desc      = "Device '%(device)' is not encrypted",
-    },
-    {
         .error_fmt = QERR_DEVICE_NOT_FOUND,
         .desc      = "Device '%(device)' not found",
     },
@@ -105,6 +97,14 @@ static const QErrorStringTable qerror_table[] = {
         .desc      = "Device '%(device)' does not support hotplugging",
     },
     {
+        .error_fmt = QERR_DEVICE_PASSWORD_REQUIRED,
+        .desc      = "Device '%(device)' requires a password",
+    },
+    {
+        .error_fmt = QERR_DEVICE_PASSWORD_UNNECESSARY,
+        .desc      = "Device '%(device)' does not require a password",
+    },
+    {
         .error_fmt = QERR_DUPLICATE_ID,
         .desc      = "Duplicate ID '%(id)' for %(object)",
     },
diff --git a/qerror.h b/qerror.h
index 777a36a..2e6ecc5 100644
--- a/qerror.h
+++ b/qerror.h
@@ -63,9 +63,6 @@ QError *qobject_to_qerror(const QObject *obj);
 #define QERR_COMMAND_NOT_FOUND \
     "{ 'class': 'CommandNotFound', 'data': { 'name': %s } }"
 
-#define QERR_DEVICE_ENCRYPTED \
-    "{ 'class': 'DeviceEncrypted', 'data': { 'device': %s } }"
-
 #define QERR_DEVICE_INIT_FAILED \
     "{ 'class': 'DeviceInitFailed', 'data': { 'device': %s } }"
 
@@ -81,9 +78,6 @@ QError *qobject_to_qerror(const QObject *obj);
 #define QERR_DEVICE_NOT_ACTIVE \
     "{ 'class': 'DeviceNotActive', 'data': { 'device': %s } }"
 
-#define QERR_DEVICE_NOT_ENCRYPTED \
-    "{ 'class': 'DeviceNotEncrypted', 'data': { 'device': %s } }"
-
 #define QERR_DEVICE_NOT_FOUND \
     "{ 'class': 'DeviceNotFound', 'data': { 'device': %s } }"
 
@@ -96,6 +90,12 @@ QError *qobject_to_qerror(const QObject *obj);
 #define QERR_DEVICE_NO_HOTPLUG \
     "{ 'class': 'DeviceNoHotplug', 'data': { 'device': %s } }"
 
+#define QERR_DEVICE_PASSWORD_REQUIRED \
+    "{ 'class': 'DevicePasswordRequired', 'data': { 'device': %s } }"
+
+#define QERR_DEVICE_PASSWORD_UNNECESSARY \
+    "{ 'class': 'DevicePasswordUnnecessary', 'data': { 'device': %s } }"
+
 #define QERR_DUPLICATE_ID \
     "{ 'class': 'DuplicateId', 'data': { 'id': %s, 'object': %s } }"
 
diff --git a/qmp-commands.hx b/qmp-commands.hx
index 94da2a8..629af4b 100644
--- a/qmp-commands.hx
+++ b/qmp-commands.hx
@@ -826,7 +826,7 @@ EQMP
         .name       = "block_passwd",
         .args_type  = "device:B,password:s",
         .params     = "block_passwd device password",
-        .help       = "set the password of encrypted block devices",
+        .help       = "set the password for a block device",
         .user_print = monitor_user_noop,
         .mhandler.cmd_new = do_block_set_passwd,
     },
@@ -835,7 +835,7 @@ SQMP
 block_passwd
 ------------
 
-Set the password of encrypted block devices.
+Set the password for a block device.
 
 Arguments:
 
@@ -1190,6 +1190,7 @@ Each json-object contain the following:
                                 "tftp", "vdi", "vmdk", "vpc", "vvfat"
          - "backing_file": backing file name (json-string, optional)
          - "encrypted": true if encrypted, false otherwise (json-bool)
+         - "needs_auth": true if the device requires authentication, false otherwise (json-bool)
          - "bps": limit total bytes per second (json-int)
          - "bps_rd": limit read bytes per second (json-int)
          - "bps_wr": limit write bytes per second (json-int)
@@ -1216,6 +1217,7 @@ Example:
                "ro":false,
                "drv":"qcow2",
                "encrypted":false,
+               "needs_auth":false,
                "file":"disks/test.img",
                "bps":1000000,
                "bps_rd":0,
-- 
1.7.1

