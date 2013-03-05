From: Loic Dachary <loic@dachary.org>
Subject: [PATCH] unit tests for FileStore::_detect_fs when running on ext4
Date: Tue,  5 Mar 2013 12:53:05 +0100
Message-ID: <1362484385-2346-1-git-send-email-loic@dachary.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:44304 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3CELxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 06:53:08 -0500
Received: from bet.multiburo.com (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 1834E26395
	for <ceph-devel@vger.kernel.org>; Tue,  5 Mar 2013 12:53:06 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

unit tests are added in test/filestore/store_test.cc for the
FileStore::_detect_fs method, when using ext4. It tests the following
situations:

 * without user_xattr, ext4 fails
 * mounted with user_xattr, ext4 fails if filestore_xattr_use_omap is false
 * mounted with user_xattr, ext4 succeeds if filestore_xattr_use_omap is true

The tests are grouped in an ext4 dedicated class

  TEST(EXT4StoreTest, _detect_fs)

The qa/workunits/filestore/filestore.sh script is added to prepare the
environment required for the unit tests ( create an image file,
formats it with ext4 etc.). It runs ceph_test_filestore with a sudo
to allow it to mount(2) and umount(2) the ext4 file system. It is
called with

  ceph_test_filestore --gtest_filter=EXT4StoreTest.*

to only run the ext4 dependent tests.

The filestore.sh script is meant to be used as part of teuthology
in order to increase the code coverage for src/os/FileStore.cc. It is
self tested and can be checked from the source directory with

  CEPH_TEST_FILESTORE=../../../src/ceph_test_filestore filestore.sh TEST

http://tracker.ceph.com/issues/4321 refs #4321

Signed-off-by: Loic Dachary <loic@dachary.org>
---
 qa/workunits/filestore/filestore.sh |   80 +++++++++++++++++++++++++++++++++++
 src/test/filestore/store_test.cc    |   57 +++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100755 qa/workunits/filestore/filestore.sh

diff --git a/qa/workunits/filestore/filestore.sh b/qa/workunits/filestore/filestore.sh
new file mode 100755
index 0000000..f951a37
--- /dev/null
+++ b/qa/workunits/filestore/filestore.sh
@@ -0,0 +1,80 @@
+#!/bin/bash 
+#
+# Copyright (C) 2013 Cloudwatt <libre.licensing@cloudwatt.com>
+#
+# Author: Loic Dachary <loic@dachary.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU Library Public License as published by
+# the Free Software Foundation; either version 2, or (at your option)
+# any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU Library Public License for more details.
+#
+set -e
+
+export PATH=/sbin:$PATH
+
+: ${VERBOSE:=false}
+: ${EXT4:=$(which mkfs.ext4)}
+: ${EXT3:=$(which mkfs.ext3)}
+: ${XFS:=$(which mkfs.xfs)}
+: ${BTRFS:=$(which mkfs.btrfs)}
+: ${CEPH_TEST_FILESTORE:=ceph_test_filestore}
+: ${FILE_SYSTEMS:=EXT4} #  EXT3 XFS BTRFS
+: ${DEBUG:=}
+
+function EXT4_test() {
+    local dir="$1"
+
+    if [ -z "$EXT4" ] ; then
+        echo "mkfs command for ext4 is missing. On Debian GNU/Linux try apt-get install e2fsprogs" >&2
+        return 1
+    fi
+
+    local disk="$dir/disk.img"
+
+    truncate --size=1G $disk || return 1
+    mkfs.ext4 -q -F $disk || return 2
+    mkdir -p $dir/mountpoint || return 3
+    MOUNTPOINT=$dir/mountpoint DISK=$disk sudo -E $CEPH_TEST_FILESTORE --gtest_filter=EXT4StoreTest.* $DEBUG || return 4
+}
+
+function main() {
+    local dir=$(mktemp --directory)
+
+    trap "sudo umount $dir/mountpoint || true ; rm -fr $dir" EXIT QUIT INT
+
+    for fs in $FILE_SYSTEMS ; do
+        ${fs}_test $dir || return 2
+    done
+}
+
+if [ "$1" = TEST ]
+then
+    set -x
+    set -o functrace
+    PS4=' ${FUNCNAME[0]}: $LINENO: '
+
+    DEBUG='--log-to-stderr=true --debug-filestore=20'
+
+    function run_test() {
+        dir=/tmp/filestore
+        rm -fr $dir
+        mkdir $dir
+        EXT4_test $dir || return 1
+
+        FILE_SYSTEMS=EXT4
+        main || return 2
+    }
+
+    run_test
+else
+    main
+fi
+# Local Variables:
+# compile-command: "CEPH_TEST_FILESTORE=../../../src/ceph_test_filestore filestore.sh TEST"
+# End:
diff --git a/src/test/filestore/store_test.cc b/src/test/filestore/store_test.cc
index c98ffb0..7631baa 100644
--- a/src/test/filestore/store_test.cc
+++ b/src/test/filestore/store_test.cc
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <iostream>
 #include <time.h>
+#include <sys/mount.h>
 #include "os/FileStore.h"
 #include "include/Context.h"
 #include "common/ceph_argparse.h"
@@ -823,6 +824,58 @@ TEST_F(StoreTest, ColSplitTest3) {
 }
 #endif
 
+//
+// support tests for qa/workunits/filestore/filestore.sh
+//
+TEST(EXT4StoreTest, _detect_fs) {
+  const string disk(::getenv("DISK"));
+  EXPECT_LT((unsigned)0, disk.size());
+  const string mnt(::getenv("MOUNTPOINT"));
+  EXPECT_LT((unsigned)0, mnt.size());
+  ::umount(mnt.c_str());
+
+  const string dir("store_test_temp_dir");
+  const string journal("store_test_temp_journal");
+
+  //
+  // without user_xattr, ext4 fails
+  //
+  {
+    g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "true");
+    EXPECT_EQ(::system((string("mount -o loop,nouser_xattr ") + disk + " " + mnt).c_str()), 0);
+    EXPECT_EQ(::chdir(mnt.c_str()), 0);
+    EXPECT_EQ(::mkdir(dir.c_str(), 0755), 0);
+    FileStore store(dir, journal);
+    EXPECT_EQ(store._detect_fs(), -ENOTSUP);
+    EXPECT_EQ(::chdir(".."), 0);
+    EXPECT_EQ(::umount(mnt.c_str()), 0);
+  }
+  //
+  // mounted with user_xattr, ext4 fails if filestore_xattr_use_omap is false
+  //
+  {
+    g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "false");
+    EXPECT_EQ(::system((string("mount -o loop,user_xattr ") + disk + " " + mnt).c_str()), 0);
+    EXPECT_EQ(::chdir(mnt.c_str()), 0);
+    FileStore store(dir, journal);
+    EXPECT_EQ(store._detect_fs(), -ENOTSUP);
+    EXPECT_EQ(::chdir(".."), 0);
+    EXPECT_EQ(::umount(mnt.c_str()), 0);
+  }
+  //
+  // mounted with user_xattr, ext4 succeeds if filestore_xattr_use_omap is true
+  //
+  {
+    g_ceph_context->_conf->set_val("filestore_xattr_use_omap", "true");
+    EXPECT_EQ(::system((string("mount -o loop,user_xattr ") + disk + " " + mnt).c_str()), 0);
+    EXPECT_EQ(::chdir(mnt.c_str()), 0);
+    FileStore store(dir, journal);
+    EXPECT_EQ(store._detect_fs(), 0);
+    EXPECT_EQ(::chdir(".."), 0);
+    EXPECT_EQ(::umount(mnt.c_str()), 0);
+  }
+}
+
 int main(int argc, char **argv) {
   vector<const char*> args;
   argv_to_vec(argc, (const char **)argv, args);
@@ -838,3 +891,7 @@ int main(int argc, char **argv) {
   ::testing::InitGoogleTest(&argc, argv);
   return RUN_ALL_TESTS();
 }
+
+// Local Variables:
+// compile-command: "cd ../.. ; make ceph_test_filestore ; ./ceph_test_filestore --gtest_filter=StoreTest.* --log-to-stderr=true --debug-filestore=20"
+// End:
-- 
1.7.10.4

