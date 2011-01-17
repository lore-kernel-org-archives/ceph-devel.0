From: MORITA Kazutaka <morita.kazutaka-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
Subject: [PATCH][qemu-iotests] add support for rbd and sheepdog
	protocols
Date: Tue, 18 Jan 2011 02:01:17 +0900
Message-ID: <1295283677-31712-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org>
List-Unsubscribe: <http://lists.wpkg.org/mailman/options/sheepdog>,
	<mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.wpkg.org/pipermail/sheepdog>
List-Post: <mailto:sheepdog-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org>
List-Help: <mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=help>
List-Subscribe: <http://lists.wpkg.org/mailman/listinfo/sheepdog>,
	<mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=subscribe>
Sender: sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
Errors-To: sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sheepdog-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This patch introduces tests for protocols other than file, and
initially supports rbd and sheepdog.

Signed-off-by: MORITA Kazutaka <morita.kazutaka-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
---
 001       |    1 +
 002       |    1 +
 003       |    1 +
 004       |    1 +
 005       |    6 ++++++
 006       |    1 +
 007       |    1 +
 008       |    1 +
 009       |    1 +
 010       |    1 +
 011       |    1 +
 012       |    1 +
 013       |    1 +
 014       |    1 +
 015       |    1 +
 016       |    1 +
 017       |    1 +
 018       |    1 +
 019       |    1 +
 020       |    1 +
 021       |    1 +
 022       |    1 +
 023       |    1 +
 024       |    1 +
 025       |    1 +
 026       |    1 +
 027       |    1 +
 028       |    1 +
 check     |    2 ++
 common    |   13 +++++++++++++
 common.rc |   45 +++++++++++++++++++++++++++++++++++++++++----
 31 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/001 b/001
index fe66a8e..bd88dde 100755
--- a/001
+++ b/001
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/002 b/002
index 57af974..bebed84 100755
--- a/002
+++ b/002
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/003 b/003
index 656da99..ee25fb8 100755
--- a/003
+++ b/003
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 size=128M
diff --git a/004 b/004
index 3de7ed8..c76451c 100755
--- a/004
+++ b/004
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/005 b/005
index 480276b..74537db 100755
--- a/005
+++ b/005
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 # vpc is limited to 127GB, so we can't test it here
@@ -49,6 +50,11 @@ if [ "$IMGFMT" = "vpc" ]; then
     _notrun "image format $IMGFMT does not support large image sizes"
 fi
 
+# sheepdog image is limited to 4TB, so we can't test it here
+if [ "$IMGPROTO" = "sheepdog" ]; then
+    _notrun "image protocol $IMGPROTO does not support large image sizes"
+fi
+
 echo
 echo "creating large image"
 _make_test_img 5000G
diff --git a/006 b/006
index 98ef4ea..0c0cf5d 100755
--- a/006
+++ b/006
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt vpc
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/007 b/007
index 2de1aa4..0139264 100755
--- a/007
+++ b/007
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # currently only qcow2 allows for consistency checks using qemu-img
 _supported_fmt qcow2
+_supported_proto generic
 _supported_os Linux
 
 echo
diff --git a/008 b/008
index b697deb..2c53bac 100755
--- a/008
+++ b/008
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/009 b/009
index 1499b77..f7262b5 100755
--- a/009
+++ b/009
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/010 b/010
index 440e9f6..e3205aa 100755
--- a/010
+++ b/010
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/011 b/011
index 87b4082..59df1ae 100755
--- a/011
+++ b/011
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/012 b/012
index 32a2647..4052956 100755
--- a/012
+++ b/012
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto file
 _supported_os Linux
 
 
diff --git a/013 b/013
index 0671bf6..ce40d5c 100755
--- a/013
+++ b/013
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # much of this could be generic for any format supporting compression.
 _supported_fmt qcow qcow2
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="0 4294967296"
diff --git a/014 b/014
index f38af43..a6d0aea 100755
--- a/014
+++ b/014
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # much of this could be generic for any format supporting snapshots
 _supported_fmt qcow2
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="0 4294967296"
diff --git a/015 b/015
index f3b0acc..bdafd26 100755
--- a/015
+++ b/015
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # actually any format that supports snapshots
 _supported_fmt qcow2
+_supported_proto generic
 _supported_os Linux
 
 echo
diff --git a/016 b/016
index e09ab86..16f151f 100755
--- a/016
+++ b/016
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # currently raw is the only protocol we support
 _supported_fmt raw
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/017 b/017
index 29dd53f..66951eb 100755
--- a/017
+++ b/017
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="0 4294967296"
diff --git a/018 b/018
index f155b49..bd2db78 100755
--- a/018
+++ b/018
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="0 4294967296"
diff --git a/019 b/019
index a2d67c3..8872b30 100755
--- a/019
+++ b/019
@@ -45,6 +45,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="0 4294967296"
diff --git a/020 b/020
index b065a53..2fb0ff8 100755
--- a/020
+++ b/020
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="0 4294967296"
diff --git a/021 b/021
index eb61230..6da79eb 100755
--- a/021
+++ b/021
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/022 b/022
index 635ad14..d35b816 100755
--- a/022
+++ b/022
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Any format that supports snapshots
 _supported_fmt qcow2
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="10485760 4294967296"
diff --git a/023 b/023
index 55c5be7..4f31b56 100755
--- a/023
+++ b/023
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # much of this could be generic for any format supporting compression.
 _supported_fmt qcow qcow2
+_supported_proto generic
 _supported_os Linux
 
 TEST_OFFSETS="0 4294967296"
diff --git a/024 b/024
index ff6e984..3d6f103 100755
--- a/024
+++ b/024
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Currently only qcow2 and qed support rebasing
 _supported_fmt qcow2 qed
+_supported_proto generic
 _supported_os Linux
 
 CLUSTER_SIZE=65536
diff --git a/025 b/025
index 6af1e46..fba44a4 100755
--- a/025
+++ b/025
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 _supported_fmt raw qcow2
+_supported_proto file sheepdog
 _supported_os Linux
 
 echo "=== Creating image"
diff --git a/026 b/026
index ad109f7..33e7da6 100755
--- a/026
+++ b/026
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Currently only qcow2 supports rebasing
 _supported_fmt qcow2
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/027 b/027
index 543c48f..7d90481 100755
--- a/027
+++ b/027
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt vmdk qcow qcow2 qed
+_supported_proto generic
 _supported_os Linux
 
 
diff --git a/028 b/028
index cb8b255..8321c93 100755
--- a/028
+++ b/028
@@ -45,6 +45,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files except vmdk and qcow which do not support
 # smaller backing files.
 _supported_fmt qcow2 qed
+_supported_proto generic
 _supported_os Linux
 
 # Choose a size that is not necessarily a cluster size multiple for image
diff --git a/check b/check
index e0eaa7a..84ef3e5 100755
--- a/check
+++ b/check
@@ -152,12 +152,14 @@ rm -f check.full
 [ -f check.time ] || touch check.time
 
 FULL_IMGFMT_DETAILS=`_full_imgfmt_details`
+FULL_IMGPROTO_DETAILS=`_full_imgproto_details`
 FULL_HOST_DETAILS=`_full_platform_details`
 #FULL_MKFS_OPTIONS=`_scratch_mkfs_options`
 #FULL_MOUNT_OPTIONS=`_scratch_mount_options`
 
 cat <<EOF
 IMGFMT        -- $FULL_IMGFMT_DETAILS
+IMGPROTO      -- $FULL_IMGPROTO_DETAILS
 PLATFORM      -- $FULL_HOST_DETAILS
 
 EOF
diff --git a/common b/common
index d95ba4c..c187f6c 100644
--- a/common
+++ b/common
@@ -43,6 +43,7 @@ randomize=false
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
 export IMGFMT=raw
+export IMGPROTO=file
 export QEMU_IO_OPTIONS=""
 
 for r
@@ -123,6 +124,8 @@ check options
     -vdi                test vdi
     -vpc                test vpc
     -vmdk               test vmdk
+    -rbd                test rbd
+    -sheepdog           test sheepdog
     -xdiff		graphical mode diff
     -nocache		use O_DIRECT on backing file
     -misalign		misalign memory allocations
@@ -179,6 +182,16 @@ testlist options
 	    xpand=false
 	    ;;
 
+	-rbd)
+	    IMGPROTO=rbd
+	    xpand=false
+	    ;;
+
+	-sheepdog)
+	    IMGPROTO=sheepdog
+	    xpand=false
+	    ;;
+
 	-nocache)
 	    QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --nocache"
 	    xpand=false
diff --git a/common.rc b/common.rc
index f2db92e..cdefafc 100644
--- a/common.rc
+++ b/common.rc
@@ -47,7 +47,11 @@ fi
 # make sure we have a standard umask
 umask 022
 
-TEST_IMG=$TEST_DIR/t.$IMGFMT
+if [ "$IMGPROTO" = "file" ]; then
+    TEST_IMG=$TEST_DIR/t.$IMGFMT
+else
+    TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
+fi
 
 _make_test_img()
 {
@@ -61,6 +65,7 @@ _make_test_img()
 
     # XXX(hch): have global image options?
     $QEMU_IMG create -f $IMGFMT $TEST_IMG $extra_img_options | \
+    	sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" | \
     	sed -e "s#$TEST_DIR#TEST_DIR#g" | \
     	sed -e "s#$IMGFMT#IMGFMT#g" | \
 	sed -e "s# encryption=off##g" | \
@@ -72,9 +77,23 @@ _make_test_img()
 
 _cleanup_test_img()
 {
-    rm -f $TEST_DIR/t.$IMGFMT
-    rm -f $TEST_DIR/t.$IMGFMT.orig
-    rm -f $TEST_DIR/t.$IMGFMT.base
+    case "$IMGPROTO" in
+
+        file)
+            rm -f $TEST_DIR/t.$IMGFMT
+            rm -f $TEST_DIR/t.$IMGFMT.orig
+            rm -f $TEST_DIR/t.$IMGFMT.base
+            ;;
+
+        rbd)
+            rbd rm $TEST_DIR/t.$IMGFMT > /dev/null
+            ;;
+
+        sheepdog)
+            collie vdi delete $TEST_DIR/t.$IMGFMT
+            ;;
+
+    esac
 }
 
 _check_test_img()
@@ -207,6 +226,19 @@ _supported_fmt()
     _notrun "not suitable for this image format: $IMGFMT"
 }
 
+# tests whether $IMGPROTO is one of the supported image protocols for a test
+#
+_supported_proto()
+{
+    for f; do
+	if [ "$f" = "$IMGPROTO" -o "$f" = "generic" ]; then
+	    return
+	fi
+    done
+
+    _notrun "not suitable for this image protocol: $IMGPROTO"
+}
+
 # tests whether the host OS is one of the supported OSes for a test
 #
 _supported_os()
@@ -234,6 +266,11 @@ _full_imgfmt_details()
     echo "$IMGFMT"
 }
 
+_full_imgproto_details()
+{
+    echo "$IMGPROTO"
+}
+
 _full_platform_details()
 {
     os=`uname -s`
-- 
1.5.6.5
