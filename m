From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] fstests: attr: add support for cephfs
Date: Wed,  3 May 2017 11:54:13 +0100
Message-ID: <20170503105413.8314-1-lhenriques@suse.com>
Return-path: <fstests-owner@vger.kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Block size for cephfs is 4M, which makes generic/020 test fail as the
value for MAX_ATTRS and MAX_ATTRVAL_SIZE will be too high.  Restrict these
two variables to sane values for this FSTYP.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 common/attr | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/common/attr b/common/attr
index ac139e618b2a..c840ce42a1fa 100644
--- a/common/attr
+++ b/common/attr
@@ -254,26 +254,36 @@ _sort_getfattr_output()
 }
 
 # set maximum total attr space based on fs type
-if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" -o "$FSTYP" == "pvfs2" ]; then
+case "$FSTYP" in
+xfs|udf|pvfs2|ceph)
 	MAX_ATTRS=1000
-else # Assume max ~1 block of attrs
+	;;
+*)
+	# Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
 	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
 	let MAX_ATTRS=$BLOCK_SIZE/40
-fi
+esac
 
 export MAX_ATTRS
 
 # Set max attr value size based on fs type
-if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" -o "$FSTYP" == "btrfs" ]; then
+case "$FSTYP" in
+xfs|udf|btrfs)
 	MAX_ATTRVAL_SIZE=64
-elif [ "$FSTYP" == "pvfs2" ]; then
+	;;
+pvfs2)
 	MAX_ATTRVAL_SIZE=8192
-else # Assume max ~1 block of attrs
+	;;
+ceph)
+	MAX_ATTRVAL_SIZE=65536
+	;;
+*)
+	# Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
 	# leave a little overhead
 	let MAX_ATTRVAL_SIZE=$BLOCK_SIZE-256
-fi
+esac
 
 export MAX_ATTRVAL_SIZE
 # make sure this script returns success
