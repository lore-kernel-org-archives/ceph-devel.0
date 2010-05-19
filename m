From: Christian Brunner <chb@muc.de>
Subject: [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Wed, 19 May 2010 21:22:22 +0200
Message-ID: <20100519192222.GD61706@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:49469 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab0ESTWY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 May 2010 15:22:24 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org

The attached patch is a block driver for the distributed file system
Ceph (http://ceph.newdream.net/). This driver uses librados (which
is part of the Ceph server) for direct access to the Ceph object
store and is running entirely in userspace. Therefore it is
called "rbd" - rados block device.

To compile the driver a recent version of ceph (>= 0.20.1) is needed
and you have to "--enable-rbd" when running configure.

Additional information is available on the Ceph-Wiki:

http://ceph.newdream.net/wiki/Kvm-rbd

---
 Makefile          |    3 +
 Makefile.objs     |    1 +
 block/rados.h     |  376 ++++++++++++++++++++++++++++++++++
 block/rbd.c       |  585 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/rbd_types.h |   48 +++++
 configure         |   27 +++
 6 files changed, 1040 insertions(+), 0 deletions(-)
 create mode 100644 block/rados.h
 create mode 100644 block/rbd.c
 create mode 100644 block/rbd_types.h

diff --git a/Makefile b/Makefile
index eb9e02b..b1ab3e9 100644
--- a/Makefile
+++ b/Makefile
@@ -27,6 +27,9 @@ configure: ;
 $(call set-vpath, $(SRC_PATH):$(SRC_PATH)/hw)
 
 LIBS+=-lz $(LIBS_TOOLS)
+ifdef CONFIG_RBD
+LIBS+=-lrados
+endif
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-tech.html qemu.1 qemu-img.1 qemu-nbd.8
diff --git a/Makefile.objs b/Makefile.objs
index acbaf22..85791ac 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -18,6 +18,7 @@ block-nested-y += parallels.o nbd.o blkdebug.o
 block-nested-$(CONFIG_WIN32) += raw-win32.o
 block-nested-$(CONFIG_POSIX) += raw-posix.o
 block-nested-$(CONFIG_CURL) += curl.o
+block-nested-$(CONFIG_RBD) += rbd.o
 
 block-obj-y +=  $(addprefix block/, $(block-nested-y))
 
diff --git a/block/rados.h b/block/rados.h
new file mode 100644
index 0000000..6cde9a1
--- /dev/null
+++ b/block/rados.h
@@ -0,0 +1,376 @@
+#ifndef __RADOS_H
+#define __RADOS_H
+
+/*
+ * Data types for the Ceph distributed object storage layer RADOS
+ * (Reliable Autonomic Distributed Object Store).
+ */
+
+
+
+/*
+ * osdmap encoding versions
+ */
+#define CEPH_OSDMAP_INC_VERSION     5
+#define CEPH_OSDMAP_INC_VERSION_EXT 5
+#define CEPH_OSDMAP_VERSION         5
+#define CEPH_OSDMAP_VERSION_EXT     5
+
+/*
+ * fs id
+ */
+struct ceph_fsid {
+	unsigned char fsid[16];
+};
+
+static inline int ceph_fsid_compare(const struct ceph_fsid *a,
+				    const struct ceph_fsid *b)
+{
+	return memcmp(a, b, sizeof(*a));
+}
+
+/*
+ * ino, object, etc.
+ */
+typedef __le64 ceph_snapid_t;
+#define CEPH_SNAPDIR ((__u64)(-1))  /* reserved for hidden .snap dir */
+#define CEPH_NOSNAP  ((__u64)(-2))  /* "head", "live" revision */
+#define CEPH_MAXSNAP ((__u64)(-3))  /* largest valid snapid */
+
+struct ceph_timespec {
+	__le32 tv_sec;
+	__le32 tv_nsec;
+} __attribute__ ((packed));
+
+
+/*
+ * object layout - how objects are mapped into PGs
+ */
+#define CEPH_OBJECT_LAYOUT_HASH     1
+#define CEPH_OBJECT_LAYOUT_LINEAR   2
+#define CEPH_OBJECT_LAYOUT_HASHINO  3
+
+/*
+ * pg layout -- how PGs are mapped onto (sets of) OSDs
+ */
+#define CEPH_PG_LAYOUT_CRUSH  0
+#define CEPH_PG_LAYOUT_HASH   1
+#define CEPH_PG_LAYOUT_LINEAR 2
+#define CEPH_PG_LAYOUT_HYBRID 3
+
+
+/*
+ * placement group.
+ * we encode this into one __le64.
+ */
+struct ceph_pg {
+	__le16 preferred; /* preferred primary osd */
+	__le16 ps;        /* placement seed */
+	__le32 pool;      /* object pool */
+} __attribute__ ((packed));
+
+/*
+ * pg_pool is a set of pgs storing a pool of objects
+ *
+ *  pg_num -- base number of pseudorandomly placed pgs
+ *
+ *  pgp_num -- effective number when calculating pg placement.  this
+ * is used for pg_num increases.  new pgs result in data being "split"
+ * into new pgs.  for this to proceed smoothly, new pgs are intiially
+ * colocated with their parents; that is, pgp_num doesn't increase
+ * until the new pgs have successfully split.  only _then_ are the new
+ * pgs placed independently.
+ *
+ *  lpg_num -- localized pg count (per device).  replicas are randomly
+ * selected.
+ *
+ *  lpgp_num -- as above.
+ */
+#define CEPH_PG_TYPE_REP     1
+#define CEPH_PG_TYPE_RAID4   2
+#define CEPH_PG_POOL_VERSION 2
+struct ceph_pg_pool {
+	__u8 type;                /* CEPH_PG_TYPE_* */
+	__u8 size;                /* number of osds in each pg */
+	__u8 crush_ruleset;       /* crush placement rule */
+	__u8 object_hash;         /* hash mapping object name to ps */
+	__le32 pg_num, pgp_num;   /* number of pg's */
+	__le32 lpg_num, lpgp_num; /* number of localized pg's */
+	__le32 last_change;       /* most recent epoch changed */
+	__le64 snap_seq;          /* seq for per-pool snapshot */
+	__le32 snap_epoch;        /* epoch of last snap */
+	__le32 num_snaps;
+	__le32 num_removed_snap_intervals; /* if non-empty, NO per-pool snaps */
+	__le64 auid;               /* who owns the pg */
+} __attribute__ ((packed));
+
+/*
+ * stable_mod func is used to control number of placement groups.
+ * similar to straight-up modulo, but produces a stable mapping as b
+ * increases over time.  b is the number of bins, and bmask is the
+ * containing power of 2 minus 1.
+ *
+ * b <= bmask and bmask=(2**n)-1
+ * e.g., b=12 -> bmask=15, b=123 -> bmask=127
+ */
+static inline int ceph_stable_mod(int x, int b, int bmask)
+{
+	if ((x & bmask) < b)
+		return x & bmask;
+	else
+		return x & (bmask >> 1);
+}
+
+/*
+ * object layout - how a given object should be stored.
+ */
+struct ceph_object_layout {
+	struct ceph_pg ol_pgid;   /* raw pg, with _full_ ps precision. */
+	__le32 ol_stripe_unit;    /* for per-object parity, if any */
+} __attribute__ ((packed));
+
+/*
+ * compound epoch+version, used by storage layer to serialize mutations
+ */
+struct ceph_eversion {
+	__le32 epoch;
+	__le64 version;
+} __attribute__ ((packed));
+
+/*
+ * osd map bits
+ */
+
+/* status bits */
+#define CEPH_OSD_EXISTS 1
+#define CEPH_OSD_UP     2
+
+/* osd weights.  fixed point value: 0x10000 == 1.0 ("in"), 0 == "out" */
+#define CEPH_OSD_IN  0x10000
+#define CEPH_OSD_OUT 0
+
+
+/*
+ * osd map flag bits
+ */
+#define CEPH_OSDMAP_NEARFULL (1<<0)  /* sync writes (near ENOSPC) */
+#define CEPH_OSDMAP_FULL     (1<<1)  /* no data writes (ENOSPC) */
+#define CEPH_OSDMAP_PAUSERD  (1<<2)  /* pause all reads */
+#define CEPH_OSDMAP_PAUSEWR  (1<<3)  /* pause all writes */
+#define CEPH_OSDMAP_PAUSEREC (1<<4)  /* pause recovery */
+
+/*
+ * osd ops
+ */
+#define CEPH_OSD_OP_MODE       0xf000
+#define CEPH_OSD_OP_MODE_RD    0x1000
+#define CEPH_OSD_OP_MODE_WR    0x2000
+#define CEPH_OSD_OP_MODE_RMW   0x3000
+#define CEPH_OSD_OP_MODE_SUB   0x4000
+
+#define CEPH_OSD_OP_TYPE       0x0f00
+#define CEPH_OSD_OP_TYPE_LOCK  0x0100
+#define CEPH_OSD_OP_TYPE_DATA  0x0200
+#define CEPH_OSD_OP_TYPE_ATTR  0x0300
+#define CEPH_OSD_OP_TYPE_EXEC  0x0400
+#define CEPH_OSD_OP_TYPE_PG    0x0500
+
+enum {
+	/** data **/
+	/* read */
+	CEPH_OSD_OP_READ      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 1,
+	CEPH_OSD_OP_STAT      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 2,
+
+	/* fancy read */
+	CEPH_OSD_OP_MASKTRUNC = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 4,
+
+	/* write */
+	CEPH_OSD_OP_WRITE     = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 1,
+	CEPH_OSD_OP_WRITEFULL = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 2,
+	CEPH_OSD_OP_TRUNCATE  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 3,
+	CEPH_OSD_OP_ZERO      = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 4,
+	CEPH_OSD_OP_DELETE    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 5,
+
+	/* fancy write */
+	CEPH_OSD_OP_APPEND    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 6,
+	CEPH_OSD_OP_STARTSYNC = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 7,
+	CEPH_OSD_OP_SETTRUNC  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 8,
+	CEPH_OSD_OP_TRIMTRUNC = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 9,
+
+	CEPH_OSD_OP_TMAPUP  = CEPH_OSD_OP_MODE_RMW | CEPH_OSD_OP_TYPE_DATA | 10,
+	CEPH_OSD_OP_TMAPPUT = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 11,
+	CEPH_OSD_OP_TMAPGET = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 12,
+
+	CEPH_OSD_OP_CREATE  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 13,
+
+	/** attrs **/
+	/* read */
+	CEPH_OSD_OP_GETXATTR  = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_ATTR | 1,
+	CEPH_OSD_OP_GETXATTRS = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_ATTR | 2,
+
+	/* write */
+	CEPH_OSD_OP_SETXATTR  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_ATTR | 1,
+	CEPH_OSD_OP_SETXATTRS = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_ATTR | 2,
+	CEPH_OSD_OP_RESETXATTRS = CEPH_OSD_OP_MODE_WR|CEPH_OSD_OP_TYPE_ATTR | 3,
+	CEPH_OSD_OP_RMXATTR   = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_ATTR | 4,
+
+	/** subop **/
+	CEPH_OSD_OP_PULL           = CEPH_OSD_OP_MODE_SUB | 1,
+	CEPH_OSD_OP_PUSH           = CEPH_OSD_OP_MODE_SUB | 2,
+	CEPH_OSD_OP_BALANCEREADS   = CEPH_OSD_OP_MODE_SUB | 3,
+	CEPH_OSD_OP_UNBALANCEREADS = CEPH_OSD_OP_MODE_SUB | 4,
+	CEPH_OSD_OP_SCRUB          = CEPH_OSD_OP_MODE_SUB | 5,
+
+	/** lock **/
+	CEPH_OSD_OP_WRLOCK    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 1,
+	CEPH_OSD_OP_WRUNLOCK  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 2,
+	CEPH_OSD_OP_RDLOCK    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 3,
+	CEPH_OSD_OP_RDUNLOCK  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 4,
+	CEPH_OSD_OP_UPLOCK    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 5,
+	CEPH_OSD_OP_DNLOCK    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 6,
+
+	/** exec **/
+	CEPH_OSD_OP_CALL    = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_EXEC | 1,
+
+	/** pg **/
+	CEPH_OSD_OP_PGLS      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_PG | 1,
+};
+
+static inline int ceph_osd_op_type_lock(int op)
+{
+	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_LOCK;
+}
+static inline int ceph_osd_op_type_data(int op)
+{
+	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_DATA;
+}
+static inline int ceph_osd_op_type_attr(int op)
+{
+	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_ATTR;
+}
+static inline int ceph_osd_op_type_exec(int op)
+{
+	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_EXEC;
+}
+static inline int ceph_osd_op_type_pg(int op)
+{
+	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_PG;
+}
+
+static inline int ceph_osd_op_mode_subop(int op)
+{
+	return (op & CEPH_OSD_OP_MODE) == CEPH_OSD_OP_MODE_SUB;
+}
+static inline int ceph_osd_op_mode_read(int op)
+{
+	return (op & CEPH_OSD_OP_MODE) == CEPH_OSD_OP_MODE_RD;
+}
+static inline int ceph_osd_op_mode_modify(int op)
+{
+	return (op & CEPH_OSD_OP_MODE) == CEPH_OSD_OP_MODE_WR;
+}
+
+#define CEPH_OSD_TMAP_HDR 'h'
+#define CEPH_OSD_TMAP_SET 's'
+#define CEPH_OSD_TMAP_RM  'r'
+
+extern const char *ceph_osd_op_name(int op);
+
+
+/*
+ * osd op flags
+ *
+ * An op may be READ, WRITE, or READ|WRITE.
+ */
+enum {
+	CEPH_OSD_FLAG_ACK = 1,          /* want (or is) "ack" ack */
+	CEPH_OSD_FLAG_ONNVRAM = 2,      /* want (or is) "onnvram" ack */
+	CEPH_OSD_FLAG_ONDISK = 4,       /* want (or is) "ondisk" ack */
+	CEPH_OSD_FLAG_RETRY = 8,        /* resend attempt */
+	CEPH_OSD_FLAG_READ = 16,        /* op may read */
+	CEPH_OSD_FLAG_WRITE = 32,       /* op may write */
+	CEPH_OSD_FLAG_ORDERSNAP = 64,   /* EOLDSNAP if snapc is out of order */
+	CEPH_OSD_FLAG_PEERSTAT = 128,   /* msg includes osd_peer_stat */
+	CEPH_OSD_FLAG_BALANCE_READS = 256,
+	CEPH_OSD_FLAG_PARALLELEXEC = 512, /* execute op in parallel */
+	CEPH_OSD_FLAG_PGOP = 1024,      /* pg op, no object */
+	CEPH_OSD_FLAG_EXEC = 2048,      /* op may exec */
+};
+
+enum {
+	CEPH_OSD_OP_FLAG_EXCL = 1,      /* EXCL object create */
+};
+
+#define EOLDSNAPC    ERESTART  /* ORDERSNAP flag set; writer has old snapc*/
+#define EBLACKLISTED ESHUTDOWN /* blacklisted */
+
+/*
+ * an individual object operation.  each may be accompanied by some data
+ * payload
+ */
+struct ceph_osd_op {
+	__le16 op;           /* CEPH_OSD_OP_* */
+	__le32 flags;        /* CEPH_OSD_FLAG_* */
+	union {
+		struct {
+			__le64 offset, length;
+			__le64 truncate_size;
+			__le32 truncate_seq;
+		} __attribute__ ((packed)) extent;
+		struct {
+			__le32 name_len;
+			__le32 value_len;
+		} __attribute__ ((packed)) xattr;
+		struct {
+			__u8 class_len;
+			__u8 method_len;
+			__u8 argc;
+			__le32 indata_len;
+		} __attribute__ ((packed)) cls;
+		struct {
+			__le64 cookie, count;
+		} __attribute__ ((packed)) pgls;
+	};
+	__le32 payload_len;
+} __attribute__ ((packed));
+
+/*
+ * osd request message header.  each request may include multiple
+ * ceph_osd_op object operations.
+ */
+struct ceph_osd_request_head {
+	__le32 client_inc;                 /* client incarnation */
+	struct ceph_object_layout layout;  /* pgid */
+	__le32 osdmap_epoch;               /* client's osdmap epoch */
+
+	__le32 flags;
+
+	struct ceph_timespec mtime;        /* for mutations only */
+	struct ceph_eversion reassert_version; /* if we are replaying op */
+
+	__le32 object_len;     /* length of object name */
+
+	__le64 snapid;         /* snapid to read */
+	__le64 snap_seq;       /* writer's snap context */
+	__le32 num_snaps;
+
+	__le16 num_ops;
+	struct ceph_osd_op ops[];  /* followed by ops[], obj, ticket, snaps */
+} __attribute__ ((packed));
+
+struct ceph_osd_reply_head {
+	__le32 client_inc;                /* client incarnation */
+	__le32 flags;
+	struct ceph_object_layout layout;
+	__le32 osdmap_epoch;
+	struct ceph_eversion reassert_version; /* for replaying uncommitted */
+
+	__le32 result;                    /* result code */
+
+	__le32 object_len;                /* length of object name */
+	__le32 num_ops;
+	struct ceph_osd_op ops[0];  /* ops[], object */
+} __attribute__ ((packed));
+
+
+#endif
diff --git a/block/rbd.c b/block/rbd.c
new file mode 100644
index 0000000..eedae50
--- /dev/null
+++ b/block/rbd.c
@@ -0,0 +1,585 @@
+/*
+ * QEMU Block driver for RADOS (Ceph)
+ *
+ * Copyright (C) 2010 Christian Brunner <chb@muc.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu-common.h"
+#include <sys/types.h>
+#include <stdbool.h>
+
+#include <qemu-common.h>
+
+#include "rbd_types.h"
+#include "rados.h"
+#include "module.h"
+#include "block_int.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <rados/librados.h>
+
+#include <signal.h>
+
+/*
+ * When specifying the image filename use:
+ *
+ * rbd:poolname/devicename
+ *
+ * poolname must be the name of an existing rados pool
+ *
+ * devicename is the basename for all objects used to
+ * emulate the raw device.
+ *
+ * Metadata information (image size, ...) is stored in an
+ * object with the name "devicename.rbd".
+ *
+ * The raw device is split into 4MB sized objects by default.
+ * The sequencenumber is encoded in a 12 byte long hex-string,
+ * and is attached to the devicename, separated by a dot.
+ * e.g. "devicename.1234567890ab"
+ *
+ */
+
+#define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
+
+typedef struct RBDAIOCB {
+    BlockDriverAIOCB common;
+    QEMUBH *bh;
+    int ret;
+    QEMUIOVector *qiov;
+    char *bounce;
+    int write;
+    int64_t sector_num;
+    int aiocnt;
+    int error;
+} RBDAIOCB;
+
+typedef struct RADOSCB {
+    int rcbid;
+    RBDAIOCB *acb;
+    int done;
+    int64_t segsize;
+    char *buf;
+} RADOSCB;
+
+typedef struct RBDRVRBDState {
+    rados_pool_t pool;
+    char name[RBD_MAX_OBJ_NAME_SIZE];
+    int name_len;
+    uint64_t size;
+    uint64_t objsize;
+} RBDRVRBDState;
+
+typedef struct rbd_obj_header_ondisk RbdHeader1;
+
+static int rbd_parsename(const char *filename, char *pool, char *name)
+{
+    const char *rbdname;
+    char *p, *n;
+    int l;
+
+    if (!strstart(filename, "rbd:", &rbdname)) {
+        return -EINVAL;
+    }
+
+    pstrcpy(pool, 2 * RBD_MAX_SEG_NAME_SIZE, rbdname);
+    p = strchr(pool, '/');
+    if (p == NULL) {
+        return -EINVAL;
+    }
+
+    *p = '\0';
+    n = ++p;
+
+    l = strlen(n);
+
+    if (l > RBD_MAX_OBJ_NAME_SIZE) {
+        fprintf(stderr, "object name to long\n");
+        return -EINVAL;
+    } else if (l <= 0) {
+        fprintf(stderr, "object name to short\n");
+        return -EINVAL;
+    }
+
+    strcpy(name, n);
+
+    return l;
+}
+
+static int create_tmap_op(uint8_t op, const char *name, char **tmap_desc)
+{
+    uint32_t len = strlen(name);
+    uint32_t total_len = 1 + (sizeof(uint32_t) + len) + sizeof(uint32_t);       /* encoding op + name + empty buffer */
+    char *desc;
+
+    desc = qemu_malloc(total_len);
+    if (!desc) {
+        return -ENOMEM;
+    }
+
+    *tmap_desc = desc;
+
+    *desc = op;
+    desc++;
+    memcpy(desc, &len, sizeof(len));
+    desc += sizeof(len);
+    memcpy(desc, name, len);
+    desc += len;
+    len = 0;
+    memcpy(desc, &len, sizeof(len));
+    desc += sizeof(len);
+
+    return desc - *tmap_desc;
+}
+
+static void free_tmap_op(char *tmap_desc)
+{
+    qemu_free(tmap_desc);
+}
+
+static int rbd_register_image(rados_pool_t pool, const char *name)
+{
+    char *tmap_desc;
+    const char *dir = RBD_DIRECTORY;
+    int ret;
+
+    ret = create_tmap_op(CEPH_OSD_TMAP_SET, name, &tmap_desc);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = rados_tmap_update(pool, dir, tmap_desc, ret);
+    free_tmap_op(tmap_desc);
+
+    return ret;
+}
+
+static int rbd_create(const char *filename, QEMUOptionParameter *options)
+{
+    int64_t bytes = 0;
+    int64_t objsize;
+    uint64_t size;
+    time_t mtime;
+    uint8_t obj_order = RBD_DEFAULT_OBJ_ORDER;
+    char pool[RBD_MAX_SEG_NAME_SIZE];
+    char n[RBD_MAX_SEG_NAME_SIZE];
+    char name[RBD_MAX_SEG_NAME_SIZE];
+    RbdHeader1 header;
+    rados_pool_t p;
+    int name_len;
+    int ret;
+
+    if ((name_len = rbd_parsename(filename, pool, name)) < 0) {
+        return -EINVAL;
+    }
+
+    snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX);
+
+    /* Read out options */
+    while (options && options->name) {
+        if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
+            bytes = options->value.n;
+        } else if (!strcmp(options->name, BLOCK_OPT_CLUSTER_SIZE)) {
+            if (options->value.n) {
+                objsize = options->value.n;
+                if (!objsize || ((objsize - 1) & objsize)) {    /* not a power of 2? */
+                    fprintf(stderr, "obj size needs to be power of 2\n");
+                    return -EINVAL;
+                }
+                if (objsize < 4096) {
+                    fprintf(stderr, "obj size too small\n");
+                    return -EINVAL;
+                }
+
+                for (obj_order = 0; obj_order < 64; obj_order++) {
+                    if (objsize == 1)
+                        break;
+                    objsize >>= 1;
+                }
+            }
+        }
+        options++;
+    }
+
+    memset(&header, 0, sizeof(header));
+    pstrcpy(header.text, sizeof(header.text), rbd_text);
+    pstrcpy(header.signature, sizeof(header.signature), rbd_signature);
+    pstrcpy(header.version, sizeof(header.version), rbd_version);
+    header.image_size = bytes;
+    cpu_to_le64s((uint64_t *) & header.image_size);
+    header.obj_order = obj_order;
+    header.crypt_type = RBD_CRYPT_NONE;
+    header.comp_type = RBD_COMP_NONE;
+    header.snap_seq = 0;
+    header.snap_count = 0;
+    cpu_to_le32s(&header.snap_count);
+
+    if (rados_initialize(0, NULL) < 0) {
+        fprintf(stderr, "error initializing\n");
+        return -EIO;
+    }
+
+    if (rados_open_pool(pool, &p)) {
+        fprintf(stderr, "error opening pool %s\n", pool);
+        return -EIO;
+    }
+
+    /* check for existing rbd header file */
+    ret = rados_stat(p, n, &size, &mtime);
+    if (ret == 0) {
+        ret=-EEXIST;
+        goto done;
+    }
+
+    /* create header file */
+    ret = rados_write(p, n, 0, (const char *)&header, sizeof(header));
+    if (ret < 0) {
+        goto done;
+    }
+
+    ret = rbd_register_image(p, name);
+done:
+    rados_close_pool(p);
+    rados_deinitialize();
+
+    return ret;
+}
+
+static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
+{
+    RBDRVRBDState *s = bs->opaque;
+    char pool[RBD_MAX_SEG_NAME_SIZE];
+    char n[RBD_MAX_SEG_NAME_SIZE];
+    char hbuf[4096];
+
+    if ((s->name_len = rbd_parsename(filename, pool, s->name)) < 0) {
+        return -EINVAL;
+    }
+    snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFFIX);
+
+    if (rados_initialize(0, NULL) < 0) {
+        fprintf(stderr, "error initializing\n");
+        return -EIO;
+    }
+
+    if (rados_open_pool(pool, &s->pool)) {
+        fprintf(stderr, "error opening pool %s\n", pool);
+        return -EIO;
+    }
+
+    if (rados_read(s->pool, n, 0, hbuf, 4096) < 0) {
+        fprintf(stderr, "error reading header from %s\n", s->name);
+        return -EIO;
+    }
+    if (!strncmp(hbuf + 64, rbd_signature, 4)) {
+        if (!strncmp(hbuf + 68, rbd_version, 8)) {
+            RbdHeader1 *header;
+
+            header = (RbdHeader1 *) hbuf;
+            le64_to_cpus((uint64_t *) & header->image_size);
+            s->size = header->image_size;
+            s->objsize = 1 << header->obj_order;
+        } else {
+            fprintf(stderr, "Unknown image version %s\n", hbuf + 68);
+            return -EIO;
+        }
+    } else {
+        fprintf(stderr, "Invalid header signature %s\n", hbuf + 64);
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static void rbd_close(BlockDriverState *bs)
+{
+    RBDRVRBDState *s = bs->opaque;
+
+    rados_close_pool(s->pool);
+    rados_deinitialize();
+}
+
+static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
+                  uint8_t *buf, int nb_sectors, int write)
+{
+    RBDRVRBDState *s = bs->opaque;
+    char n[RBD_MAX_SEG_NAME_SIZE];
+
+    int64_t segnr, segoffs, segsize, r;
+    int64_t off, size;
+
+    off = sector_num * 512;
+    size = nb_sectors * 512;
+    segnr = (int64_t) (off / s->objsize);
+    segoffs = (int64_t) (off % s->objsize);
+    segsize = (int64_t) (s->objsize - segoffs);
+
+    while (size > 0) {
+        if (size < segsize) {
+            segsize = size;
+        }
+
+        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name,
+                 (long long unsigned int)segnr);
+
+        if (write) {
+            if ((r = rados_write(s->pool, n, segoffs, (const char *)buf,
+                segsize)) < 0) {
+                return r;
+            }
+        } else {
+            r = rados_read(s->pool, n, segoffs, (char *)buf, segsize);
+            if (r == -ENOENT) {
+                memset(buf, 0, segsize);
+            } else if (r < 0) {
+                return(r);
+            } else if (r < segsize) {
+                memset(buf + r, 0, segsize - r);
+            }
+            r = segsize;
+        }
+
+        buf += segsize;
+        size -= segsize;
+        segoffs = 0;
+        segsize = s->objsize;
+        segnr++;
+    }
+
+    return (0);
+}
+
+static int rbd_read(BlockDriverState *bs, int64_t sector_num,
+                    uint8_t *buf, int nb_sectors)
+{
+    return rbd_rw(bs, sector_num, buf, nb_sectors, 0);
+}
+
+static int rbd_write(BlockDriverState *bs, int64_t sector_num,
+                     const uint8_t *buf, int nb_sectors)
+{
+    return rbd_rw(bs, sector_num, (uint8_t *) buf, nb_sectors, 1);
+}
+
+static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
+{
+    RBDAIOCB *acb = (RBDAIOCB *) blockacb;
+    qemu_bh_delete(acb->bh);
+    acb->bh = NULL;
+    qemu_aio_release(acb);
+}
+
+static AIOPool rbd_aio_pool = {
+    .aiocb_size = sizeof(RBDAIOCB),
+    .cancel = rbd_aio_cancel,
+};
+
+/* This is the callback function for rados_aio_read and _write */
+static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
+{
+    RBDAIOCB *acb = rcb->acb;
+    int64_t r;
+    int i;
+
+    acb->aiocnt--;
+    r = rados_aio_get_return_value(c);
+    rados_aio_release(c);
+    if (acb->write) {
+        if (r < 0) {
+            acb->ret = r;
+            acb->error = 1;
+        } else if (!acb->error) {
+            acb->ret += rcb->segsize;
+        }
+    } else {
+        if (r == -ENOENT) {
+            memset(rcb->buf, 0, rcb->segsize);
+            if (!acb->error) {
+                acb->ret += rcb->segsize;
+            }
+        } else if (r < 0) {
+            acb->ret = r;
+            acb->error = 1;
+        } else if (r < rcb->segsize) {
+            memset(rcb->buf + r, 0, rcb->segsize - r);
+            if (!acb->error) {
+                acb->ret += rcb->segsize;
+            }
+        } else if (!acb->error) {
+            acb->ret += r;
+        }
+    }
+    qemu_free(rcb);
+    i = 0;
+    if (!acb->aiocnt && acb->bh) {
+        qemu_bh_schedule(acb->bh);
+    }
+}
+
+/* Callback when all queued rados_aio requests are complete */
+static void rbd_aio_bh_cb(void *opaque)
+{
+    RBDAIOCB *acb = opaque;
+
+    if (!acb->write) {
+        qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb->qiov->size);
+    }
+    qemu_vfree(acb->bounce);
+    acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
+    qemu_bh_delete(acb->bh);
+    acb->bh = NULL;
+    qemu_aio_release(acb);
+}
+
+static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
+                                           int64_t sector_num,
+                                           QEMUIOVector *qiov,
+                                           int nb_sectors,
+                                           BlockDriverCompletionFunc *cb,
+                                           void *opaque, int write)
+{
+    RBDAIOCB *acb;
+    RADOSCB *rcb;
+    rados_completion_t c;
+    char n[RBD_MAX_SEG_NAME_SIZE];
+    int64_t segnr, segoffs, segsize, last_segnr;
+    int64_t off, size;
+    char *buf;
+
+    RBDRVRBDState *s = bs->opaque;
+
+    acb = qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
+    acb->write = write;
+    acb->qiov = qiov;
+    acb->bounce = qemu_blockalign(bs, qiov->size);
+    acb->aiocnt = 0;
+    acb->ret = 0;
+    acb->error = 0;
+
+    if (!acb->bh) {
+        acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
+    }
+
+    if (write) {
+        qemu_iovec_to_buffer(acb->qiov, acb->bounce);
+    }
+
+    buf = acb->bounce;
+
+    off = sector_num * 512;
+    size = nb_sectors * 512;
+    segnr = (int64_t) (off / s->objsize);
+    segoffs = (int64_t) (off % s->objsize);
+    segsize = (int64_t) (s->objsize - segoffs);
+
+    last_segnr = ((off + size - 1) / s->objsize);
+    acb->aiocnt = (last_segnr - segnr) + 1;
+
+    while (size > 0) {
+        if (size < segsize) {
+            segsize = size;
+        }
+
+        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name,
+                 (long long unsigned int)segnr);
+
+        rcb = qemu_malloc(sizeof(RADOSCB));
+        rcb->done = 0;
+        rcb->acb = acb;
+        rcb->segsize = segsize;
+        rcb->buf = buf;
+
+        if (write) {
+            rados_aio_create_completion(rcb, NULL,
+                                        (rados_callback_t) rbd_finish_aiocb, &c);
+            rados_aio_write(s->pool, n, segoffs, buf, segsize, c);
+        } else {
+            rados_aio_create_completion(rcb, (rados_callback_t) rbd_finish_aiocb,
+                                        NULL, &c);
+            rados_aio_read(s->pool, n, segoffs, buf, segsize, c);
+        }
+
+        buf += segsize;
+        size -= segsize;
+        segoffs = 0;
+        segsize = s->objsize;
+        segnr++;
+    }
+
+    return &acb->common;
+}
+
+static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState *bs,
+                                       int64_t sector_num, QEMUIOVector *qiov,
+                                       int nb_sectors,
+                                       BlockDriverCompletionFunc *cb,
+                                       void *opaque)
+{
+    return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 0);
+}
+
+static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState *bs,
+                                        int64_t sector_num, QEMUIOVector *qiov,
+                                        int nb_sectors,
+                                        BlockDriverCompletionFunc *cb,
+                                        void *opaque)
+{
+    return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 1);
+}
+
+static int rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    RBDRVRBDState *s = bs->opaque;
+    bdi->cluster_size = s->objsize;
+    return 0;
+}
+
+static int64_t rbd_getlength(BlockDriverState *bs)
+{
+    RBDRVRBDState *s = bs->opaque;
+
+    return s->size;
+}
+
+static QEMUOptionParameter rbd_create_options[] = {
+    {
+     .name = BLOCK_OPT_SIZE,
+     .type = OPT_SIZE,
+     .help = "Virtual disk size"
+    },
+    {
+     .name = BLOCK_OPT_CLUSTER_SIZE,
+     .type = OPT_SIZE,
+     .help = "RBD object size"
+    },
+    {NULL}
+};
+
+static BlockDriver bdrv_rbd = {
+    .format_name = "rbd",
+    .instance_size = sizeof(RBDRVRBDState),
+    .bdrv_open = rbd_open,
+    .bdrv_read = rbd_read,
+    .bdrv_write = rbd_write,
+    .bdrv_close = rbd_close,
+    .bdrv_create = rbd_create,
+    .bdrv_get_info = rbd_getinfo,
+    .create_options = rbd_create_options,
+    .bdrv_getlength = rbd_getlength,
+    .protocol_name = "rbd",
+
+    .bdrv_aio_readv = rbd_aio_readv,
+    .bdrv_aio_writev = rbd_aio_writev,
+};
+
+static void bdrv_rbd_init(void)
+{
+    bdrv_register(&bdrv_rbd);
+}
+
+block_init(bdrv_rbd_init);
diff --git a/block/rbd_types.h b/block/rbd_types.h
new file mode 100644
index 0000000..dfd5aa0
--- /dev/null
+++ b/block/rbd_types.h
@@ -0,0 +1,48 @@
+#ifndef _FS_CEPH_RBD
+#define _FS_CEPH_RBD
+
+#include <linux/types.h>
+
+/*
+ * rbd image 'foo' consists of objects
+ *   foo.rbd      - image metadata
+ *   foo.00000000
+ *   foo.00000001
+ *   ...          - data
+ */
+
+#define RBD_SUFFIX	 	".rbd"
+#define RBD_DIRECTORY           "rbd_directory"
+
+#define RBD_DEFAULT_OBJ_ORDER	22   /* 4MB */
+
+#define RBD_MAX_OBJ_NAME_SIZE	96
+#define RBD_MAX_SEG_NAME_SIZE	128
+
+#define RBD_COMP_NONE		0
+#define RBD_CRYPT_NONE		0
+
+static const char rbd_text[] = "<<< Rados Block Device Image >>>\n";
+static const char rbd_signature[] = "RBD";
+static const char rbd_version[] = "001.001";
+
+struct rbd_obj_snap_ondisk {
+	__le64 id;
+	__le64 image_size;
+} __attribute__((packed));
+
+struct rbd_obj_header_ondisk {
+	char text[64];
+	char signature[4];
+	char version[8];
+	__le64 image_size;
+	__u8 obj_order;
+	__u8 crypt_type;
+	__u8 comp_type;
+	__le32 snap_seq;
+	__le32 snap_count;
+	__le64 snap_names_len;
+	struct rbd_obj_snap_ondisk snaps[0];
+} __attribute__((packed));
+
+#endif
diff --git a/configure b/configure
index 36d028f..d07a7e5 100755
--- a/configure
+++ b/configure
@@ -299,6 +299,7 @@ pkgversion=""
 check_utests="no"
 user_pie="no"
 zero_malloc=""
+rbd="no"
 
 # OS specific
 if check_define __linux__ ; then
@@ -660,6 +661,8 @@ for opt do
   ;;
   --enable-vhost-net) vhost_net="yes"
   ;;
+  --enable-rbd) rbd="yes"
+  ;;
   *) echo "ERROR: unknown option $opt"; show_help="yes"
   ;;
   esac
@@ -826,6 +829,7 @@ echo "  --enable-docs            enable documentation build"
 echo "  --disable-docs           disable documentation build"
 echo "  --disable-vhost-net      disable vhost-net acceleration support"
 echo "  --enable-vhost-net       enable vhost-net acceleration support"
+echo "  --enable-rbd		 enable building the rados block device (rbd)"
 echo ""
 echo "NOTE: The object files are built at the place where configure is launched"
 exit 1
@@ -1569,6 +1573,25 @@ if test "$mingw32" != yes -a "$pthread" = no; then
 fi
 
 ##########################################
+# rbd probe
+if test "$rbd" != "no" ; then
+  cat > $TMPC <<EOF
+#include <stdio.h>
+#include <rados/librados.h>
+int main(void) { rados_initialize(0, NULL); return 0; }
+EOF
+  if compile_prog "" "-lrados -lcrypto" ; then
+    rbd=yes
+    LIBS="$LIBS -lrados -lcrypto"
+  else
+    if test "$rbd" = "yes" ; then
+      feature_not_found "rados block device"
+    fi
+    rbd=no
+  fi
+fi
+
+##########################################
 # linux-aio probe
 
 if test "$linux_aio" != "no" ; then
@@ -2031,6 +2054,7 @@ echo "preadv support    $preadv"
 echo "fdatasync         $fdatasync"
 echo "uuid support      $uuid"
 echo "vhost-net support $vhost_net"
+echo "rbd support       $rbd"
 
 if test $sdl_too_old = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -2260,6 +2284,9 @@ echo "CONFIG_UNAME_RELEASE=\"$uname_release\"" >> $config_host_mak
 if test "$zero_malloc" = "yes" ; then
   echo "CONFIG_ZERO_MALLOC=y" >> $config_host_mak
 fi
+if test "$rbd" = "yes" ; then
+  echo "CONFIG_RBD=y" >> $config_host_mak
+fi
 
 # USB host support
 case "$usb" in
-- 
1.7.0.4

