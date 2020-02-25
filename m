From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] block: Replace zero-length array with flexible-array
 member
Date: Tue, 25 Feb 2020 17:48:37 -0600
Message-ID: <20200225234836.GA31741@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Richard Russon (FlatCap)" <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com, ceph-devel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: ceph-devel.vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 block/partitions/ldm.h             | 2 +-
 drivers/block/drbd/drbd_int.h      | 2 +-
 drivers/block/drbd/drbd_protocol.h | 8 ++++----
 drivers/block/rbd_types.h          | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index 1ca63e97bccc..172432ce5c0f 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -93,7 +93,7 @@ struct frag {				/* VBLK Fragment handling */
 	u8		num;		/* Total number of records */
 	u8		rec;		/* This is record number n */
 	u8		map;		/* Which portions are in use */
-	u8		data[0];
+	u8		data[];
 };
 
 /* In memory LDM database structures. */
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index aae99a2d7bd4..a3314dd781a7 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -620,7 +620,7 @@ struct fifo_buffer {
 	unsigned int head_index;
 	unsigned int size;
 	int total; /* sum of all values */
-	int values[0];
+	int values[];
 };
 extern struct fifo_buffer *fifo_alloc(unsigned int fifo_size);
 
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index e6fc5ad72501..dea59c92ecc1 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -271,7 +271,7 @@ struct p_rs_param {
 	u32 resync_rate;
 
 	      /* Since protocol version 88 and higher. */
-	char verify_alg[0];
+	char verify_alg[];
 } __packed;
 
 struct p_rs_param_89 {
@@ -305,7 +305,7 @@ struct p_protocol {
 	u32 two_primaries;
 
 	/* Since protocol version 87 and higher. */
-	char integrity_alg[0];
+	char integrity_alg[];
 
 } __packed;
 
@@ -360,7 +360,7 @@ struct p_sizes {
 	u16	    dds_flags; /* use enum dds_flags here. */
 
 	/* optional queue_limits if (agreed_features & DRBD_FF_WSAME) */
-	struct o_qlim qlim[0];
+	struct o_qlim qlim[];
 } __packed;
 
 struct p_state {
@@ -409,7 +409,7 @@ struct p_compressed_bm {
 	 */
 	u8 encoding;
 
-	u8 code[0];
+	u8 code[];
 } __packed;
 
 struct p_delay_probe93 {
diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
index ac98ab6ccd3b..a600e0eb6b6f 100644
--- a/drivers/block/rbd_types.h
+++ b/drivers/block/rbd_types.h
@@ -93,7 +93,7 @@ struct rbd_image_header_ondisk {
 	__le32 snap_count;
 	__le32 reserved;
 	__le64 snap_names_len;
-	struct rbd_image_snap_ondisk snaps[0];
+	struct rbd_image_snap_ondisk snaps[];
 } __attribute__((packed));
 
 
-- 
2.25.0
