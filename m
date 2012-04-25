From: Pierre Rognant <prognant@oodrive.fr>
Subject: [PATCH] Wireshark dissector updated, work with the current development tree of wireshark. The way I patched it is not really clean, but it can be useful if some people quickly need to inspect ceph network flows.
Date: Wed, 25 Apr 2012 16:23:50 +0200
Message-ID: <1335363830-1748-1-git-send-email-prognant@oodrive.fr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.oodrive.com ([195.68.89.211]:42829 "EHLO mail.oodrive.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730Ab2DYOdB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Apr 2012 10:33:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.oodrive.com (Postfix) with ESMTP id 8611F46D0419
	for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 16:23:52 +0200 (CEST)
Received: from mail.oodrive.com ([127.0.0.1])
	by localhost (mail.oodrive.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCFCULVKVvN4 for <ceph-devel@vger.kernel.org>;
	Wed, 25 Apr 2012 16:23:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [46.218.198.50])
	by mail.oodrive.com (Postfix) with ESMTPSA id DB00B46D02BA
	for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 16:23:50 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Pierre Rognant <prognant@oodrive.com>

---
 wireshark/ceph/ceph_fs.h     |  213 +++++++++++++++-----
 wireshark/ceph/crc32c.h      |    2 +-
 wireshark/ceph/msgr.h        |   67 +++++--
 wireshark/ceph/packet-ceph.c |  461 ++++++++++++++++++++++++++++++++++--------
 wireshark/ceph/rados.h       |  100 +++++++--
 wireshark/ceph/sctp_crc32.c  |   27 ++-
 wireshark/wireshark.patch    |   26 +--
 7 files changed, 695 insertions(+), 201 deletions(-)

diff --git a/wireshark/ceph/ceph_fs.h b/wireshark/ceph/ceph_fs.h
index 41a941c..b8c6069 100644
--- a/wireshark/ceph/ceph_fs.h
+++ b/wireshark/ceph/ceph_fs.h
@@ -16,40 +16,37 @@
 #include "rados.h"
 
 /*
- * Ceph release version
- */
-#define CEPH_VERSION_MAJOR 0
-#define CEPH_VERSION_MINOR 16
-#define CEPH_VERSION_PATCH 1
-
-#define CEPH_STRINGIFY_(x) #x
-#define CEPH_STRINGIFY(x) CEPH_STRINGIFY_(x)
-#define CEPH_MAKE_VERSION(x, y, z) CEPH_STRINGIFY(x) "." CEPH_STRINGIFY(y) \
-	"." CEPH_STRINGIFY(z)
-#define CEPH_VERSION CEPH_MAKE_VERSION(CEPH_VERSION_MAJOR, \
-				       CEPH_VERSION_MINOR, CEPH_VERSION_PATCH)
-
-/*
  * subprotocol versions.  when specific messages types or high-level
  * protocols change, bump the affected components.  we keep rev
  * internal cluster protocols separately from the public,
  * client-facing protocol.
  */
-#define CEPH_OSD_PROTOCOL     7 /* cluster internal */
-#define CEPH_MDS_PROTOCOL     9 /* cluster internal */
+#define CEPH_OSD_PROTOCOL     8 /* cluster internal */
+#define CEPH_MDS_PROTOCOL    12 /* cluster internal */
 #define CEPH_MON_PROTOCOL     5 /* cluster internal */
-#define CEPH_OSDC_PROTOCOL   20 /* server/client */
-#define CEPH_MDSC_PROTOCOL   29 /* server/client */
+#define CEPH_OSDC_PROTOCOL   24 /* server/client */
+#define CEPH_MDSC_PROTOCOL   32 /* server/client */
 #define CEPH_MONC_PROTOCOL   15 /* server/client */
 
 
 #define CEPH_INO_ROOT  1
+#define CEPH_INO_CEPH  2        /* hidden .ceph dir */
 
 /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
 #define CEPH_MAX_MON   31
 
 
-unsigned int ceph_full_name_hash(const char *name, unsigned int len);
+/*
+ * feature bits
+ */
+#define CEPH_FEATURE_UID            (1<<0)
+#define CEPH_FEATURE_NOSRCADDR      (1<<1)
+#define CEPH_FEATURE_MONCLOCKCHECK  (1<<2)
+#define CEPH_FEATURE_FLOCK          (1<<3)
+#define CEPH_FEATURE_SUBSCRIBE2     (1<<4)
+#define CEPH_FEATURE_MONNAMES       (1<<5)
+#define CEPH_FEATURE_RECONNECT_SEQ  (1<<6)
+#define CEPH_FEATURE_DIRLAYOUTHASH  (1<<7)
 
 
 /*
@@ -62,10 +59,10 @@ struct ceph_file_layout {
 	__le32 fl_stripe_count;    /* over this many objects */
 	__le32 fl_object_size;     /* until objects are this big, then move to
 				      new objects */
-	__le32 fl_cas_hash;        /* 0 = none; 1 = sha256 */
+	__le32 fl_cas_hash;        /* UNUSED.  0 = none; 1 = sha256 */
 
 	/* pg -> disk layout */
-	__le32 fl_object_stripe_unit;  /* for per-object parity, if any */
+	__le32 fl_object_stripe_unit;  /* UNUSED.  for per-object parity, if any */
 
 	/* object -> pg layout */
 	__le32 fl_pg_preferred; /* preferred primary for pg (-1 for none) */
@@ -76,6 +73,26 @@ struct ceph_file_layout {
 
 int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
 
+struct ceph_dir_layout {
+	__u8   dl_dir_hash;   /* see ceph_hash.h for ids */
+	__u8   dl_unused1;
+	__u16  dl_unused2;
+	__u32  dl_unused3;
+} __attribute__ ((packed));
+
+/* crypto algorithms */
+#define CEPH_CRYPTO_NONE 0x0
+#define CEPH_CRYPTO_AES  0x1
+
+#define CEPH_AES_IV "cephsageyudagreg"
+
+/* security/authentication protocols */
+#define CEPH_AUTH_UNKNOWN	0x0
+#define CEPH_AUTH_NONE	 	0x1
+#define CEPH_AUTH_CEPHX	 	0x2
+
+#define CEPH_AUTH_UID_DEFAULT ((__u64) -1)
+
 
 /*********************************************
  * message layer
@@ -92,12 +109,12 @@ int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
 /* client <-> monitor */
 #define CEPH_MSG_MON_MAP                4
 #define CEPH_MSG_MON_GET_MAP            5
-#define CEPH_MSG_CLIENT_MOUNT           10
-#define CEPH_MSG_CLIENT_MOUNT_ACK       11
 #define CEPH_MSG_STATFS                 13
 #define CEPH_MSG_STATFS_REPLY           14
 #define CEPH_MSG_MON_SUBSCRIBE          15
 #define CEPH_MSG_MON_SUBSCRIBE_ACK      16
+#define CEPH_MSG_AUTH			17
+#define CEPH_MSG_AUTH_REPLY		18
 
 /* client <-> mds */
 #define CEPH_MSG_MDS_MAP                21
@@ -113,10 +130,35 @@ int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
 #define CEPH_MSG_CLIENT_SNAP            0x312
 #define CEPH_MSG_CLIENT_CAPRELEASE      0x313
 
+/* pool ops */
+#define CEPH_MSG_POOLOP_REPLY           48
+#define CEPH_MSG_POOLOP                 49
+
+
 /* osd */
-#define CEPH_MSG_OSD_MAP          41
-#define CEPH_MSG_OSD_OP           42
-#define CEPH_MSG_OSD_OPREPLY      43
+#define CEPH_MSG_OSD_MAP                41
+#define CEPH_MSG_OSD_OP                 42
+#define CEPH_MSG_OSD_OPREPLY            43
+#define CEPH_MSG_WATCH_NOTIFY           44
+
+
+/* watch-notify operations */
+enum {
+  WATCH_NOTIFY				= 1, /* notifying watcher */
+  WATCH_NOTIFY_COMPLETE			= 2, /* notifier notified when done */
+};
+
+
+/* pool operations */
+enum {
+  POOL_OP_CREATE			= 0x01,
+  POOL_OP_DELETE			= 0x02,
+  POOL_OP_AUID_CHANGE			= 0x03,
+  POOL_OP_CREATE_SNAP			= 0x11,
+  POOL_OP_DELETE_SNAP			= 0x12,
+  POOL_OP_CREATE_UNMANAGED_SNAP		= 0x21,
+  POOL_OP_DELETE_UNMANAGED_SNAP		= 0x22,
+};
 
 struct ceph_mon_request_header {
 	__le64 have_version;
@@ -127,7 +169,6 @@ struct ceph_mon_request_header {
 struct ceph_mon_statfs {
 	struct ceph_mon_request_header monhdr;
 	struct ceph_fsid fsid;
-	__le64 tid;
 } __attribute__ ((packed));
 
 struct ceph_statfs {
@@ -137,11 +178,35 @@ struct ceph_statfs {
 
 struct ceph_mon_statfs_reply {
 	struct ceph_fsid fsid;
-	__le64 tid;
 	__le64 version;
 	struct ceph_statfs st;
 } __attribute__ ((packed));
 
+const char *ceph_pool_op_name(int op);
+
+struct ceph_mon_poolop {
+	struct ceph_mon_request_header monhdr;
+	struct ceph_fsid fsid;
+	__le32 pool;
+	__le32 op;
+	__le64 auid;
+	__le64 snapid;
+	__le32 name_len;
+} __attribute__ ((packed));
+
+struct ceph_mon_poolop_reply {
+	struct ceph_mon_request_header monhdr;
+	struct ceph_fsid fsid;
+	__le32 reply_code;
+	__le32 epoch;
+	char has_data;
+	char data[0];
+} __attribute__ ((packed));
+
+struct ceph_mon_unmanaged_snap {
+	__le64 snapid;
+} __attribute__ ((packed));
+
 struct ceph_osd_getmap {
 	struct ceph_mon_request_header monhdr;
 	struct ceph_fsid fsid;
@@ -157,11 +222,18 @@ struct ceph_client_mount {
 	struct ceph_mon_request_header monhdr;
 } __attribute__ ((packed));
 
+#define CEPH_SUBSCRIBE_ONETIME    1  /* i want only 1 update after have */
+
 struct ceph_mon_subscribe_item {
-	__le64 have_version;	__le64 have;
+	__le64 have_version;    __le64 have;
 	__u8 onetime;
 } __attribute__ ((packed));
 
+struct ceph_mon_subscribe_ack {
+	__le32 duration;         /* seconds */
+	struct ceph_fsid fsid;
+} __attribute__ ((packed));
+
 /*
  * mds states
  *   > 0 -> in
@@ -194,16 +266,18 @@ extern const char *ceph_mds_state_name(int s);
  *  - they also define the lock ordering by the MDS
  *  - a few of these are internal to the mds
  */
-#define CEPH_LOCK_DN          1
-#define CEPH_LOCK_ISNAP       2
-#define CEPH_LOCK_IVERSION    4     /* mds internal */
-#define CEPH_LOCK_IFILE       8     /* mds internal */
-#define CEPH_LOCK_IAUTH       32
-#define CEPH_LOCK_ILINK       64
-#define CEPH_LOCK_IDFT        128   /* dir frag tree */
-#define CEPH_LOCK_INEST       256   /* mds internal */
-#define CEPH_LOCK_IXATTR      512
-#define CEPH_LOCK_INO         2048  /* immutable inode bits; not a lock */
+#define CEPH_LOCK_DVERSION    1
+#define CEPH_LOCK_DN          2
+#define CEPH_LOCK_ISNAP       16
+#define CEPH_LOCK_IVERSION    32    /* mds internal */
+#define CEPH_LOCK_IFILE       64
+#define CEPH_LOCK_IAUTH       128
+#define CEPH_LOCK_ILINK       256
+#define CEPH_LOCK_IDFT        512   /* dir frag tree */
+#define CEPH_LOCK_INEST       1024  /* mds internal */
+#define CEPH_LOCK_IXATTR      2048
+#define CEPH_LOCK_IFLOCK      4096  /* advisory file locks */
+#define CEPH_LOCK_INO         8192  /* immutable inode bits; not a lock */
 
 /* client_session ops */
 enum {
@@ -239,11 +313,15 @@ enum {
 	CEPH_MDS_OP_GETATTR    = 0x00101,
 	CEPH_MDS_OP_LOOKUPHASH = 0x00102,
 	CEPH_MDS_OP_LOOKUPPARENT = 0x00103,
+	CEPH_MDS_OP_LOOKUPINO  = 0x00104,
 
 	CEPH_MDS_OP_SETXATTR   = 0x01105,
 	CEPH_MDS_OP_RMXATTR    = 0x01106,
 	CEPH_MDS_OP_SETLAYOUT  = 0x01107,
 	CEPH_MDS_OP_SETATTR    = 0x01108,
+	CEPH_MDS_OP_SETFILELOCK= 0x01109,
+	CEPH_MDS_OP_GETFILELOCK= 0x00110,
+	CEPH_MDS_OP_SETDIRLAYOUT=0x0110a,
 
 	CEPH_MDS_OP_MKNOD      = 0x01201,
 	CEPH_MDS_OP_LINK       = 0x01202,
@@ -253,7 +331,7 @@ enum {
 	CEPH_MDS_OP_RMDIR      = 0x01221,
 	CEPH_MDS_OP_SYMLINK    = 0x01222,
 
-	CEPH_MDS_OP_CREATE     = 0x00301,
+	CEPH_MDS_OP_CREATE     = 0x01301,
 	CEPH_MDS_OP_OPEN       = 0x00302,
 	CEPH_MDS_OP_READDIR    = 0x00305,
 
@@ -290,6 +368,7 @@ union ceph_mds_request_args {
 	struct {
 		__le32 frag;                 /* which dir fragment */
 		__le32 max_entries;          /* how many dentries to grab */
+		__le32 max_bytes;
 	} __attribute__ ((packed)) readdir;
 	struct {
 		__le32 mode;
@@ -313,13 +392,22 @@ union ceph_mds_request_args {
 	struct {
 		struct ceph_file_layout layout;
 	} __attribute__ ((packed)) setlayout;
+	struct {
+		__u8 rule; /* currently fcntl or flock */
+		__u8 type; /* shared, exclusive, remove*/
+		__le64 pid; /* process id requesting the lock */
+		__le64 pid_namespace;
+		__le64 start; /* initial location to lock */
+		__le64 length; /* num bytes to lock from start */
+		__u8 wait; /* will caller wait for lock to become available? */
+	} __attribute__ ((packed)) filelock_change;
 } __attribute__ ((packed));
 
 #define CEPH_MDS_FLAG_REPLAY        1  /* this is a replayed op */
 #define CEPH_MDS_FLAG_WANT_DENTRY   2  /* want dentry in reply */
 
 struct ceph_mds_request_head {
-	__le64 tid, oldest_client_tid;
+	__le64 oldest_client_tid;
 	__le32 mdsmap_epoch;           /* on client */
 	__le32 flags;                  /* CEPH_MDS_FLAG_* */
 	__u8 num_retry, num_fwd;       /* count retry, fwd attempts */
@@ -342,7 +430,6 @@ struct ceph_mds_request_release {
 
 /* client reply */
 struct ceph_mds_reply_head {
-	__le64 tid;
 	__le32 op;
 	__le32 result;
 	__le32 mdsmap_epoch;
@@ -392,7 +479,7 @@ struct ceph_mds_reply_inode {
 	struct ceph_timespec rctime;
 	struct ceph_frag_tree_head fragtree;  /* (must be at end of struct) */
 } __attribute__ ((packed));
-/* followed by frag array, then symlink string, then xattr blob */
+/* followed by frag array, symlink string, dir layout, xattr blob */
 
 /* reply_lease follows dname, and reply_inode */
 struct ceph_mds_reply_lease {
@@ -408,6 +495,23 @@ struct ceph_mds_reply_dirfrag {
 	__le32 dist[];
 } __attribute__ ((packed));
 
+#define CEPH_LOCK_FCNTL    1
+#define CEPH_LOCK_FLOCK    2
+
+#define CEPH_LOCK_SHARED   1
+#define CEPH_LOCK_EXCL     2
+#define CEPH_LOCK_UNLOCK   4
+
+struct ceph_filelock {
+	__le64 start;/* file offset to start lock at */
+	__le64 length; /* num bytes to lock; 0 for all following start */
+	__le64 client; /* which client holds the lock */
+	__le64 pid; /* process id holding the lock on the client */
+	__le64 pid_namespace;
+	__u8 type; /* shared lock, exclusive lock, or unlock */
+} __attribute__ ((packed));
+
+
 /* file access modes */
 #define CEPH_FILE_MODE_PIN        0
 #define CEPH_FILE_MODE_RD         1
@@ -436,9 +540,10 @@ int ceph_flags_to_mode(int flags);
 #define CEPH_CAP_SAUTH      2
 #define CEPH_CAP_SLINK      4
 #define CEPH_CAP_SXATTR     6
-#define CEPH_CAP_SFILE      8   /* goes at the end (uses >2 cap bits) */
+#define CEPH_CAP_SFILE      8
+#define CEPH_CAP_SFLOCK    20 
 
-#define CEPH_CAP_BITS       16
+#define CEPH_CAP_BITS       22
 
 /* composed values */
 #define CEPH_CAP_AUTH_SHARED  (CEPH_CAP_GSHARED  << CEPH_CAP_SAUTH)
@@ -456,6 +561,9 @@ int ceph_flags_to_mode(int flags);
 #define CEPH_CAP_FILE_BUFFER   (CEPH_CAP_GBUFFER   << CEPH_CAP_SFILE)
 #define CEPH_CAP_FILE_WREXTEND (CEPH_CAP_GWREXTEND << CEPH_CAP_SFILE)
 #define CEPH_CAP_FILE_LAZYIO   (CEPH_CAP_GLAZYIO   << CEPH_CAP_SFILE)
+#define CEPH_CAP_FLOCK_SHARED  (CEPH_CAP_GSHARED   << CEPH_CAP_SFLOCK)
+#define CEPH_CAP_FLOCK_EXCL    (CEPH_CAP_GEXCL     << CEPH_CAP_SFLOCK)
+
 
 /* cap masks (for getattr) */
 #define CEPH_STAT_CAP_INODE    CEPH_CAP_PIN
@@ -491,7 +599,8 @@ int ceph_flags_to_mode(int flags);
 			      CEPH_CAP_FILE_EXCL)
 #define CEPH_CAP_ANY_WR   (CEPH_CAP_ANY_EXCL | CEPH_CAP_ANY_FILE_WR)
 #define CEPH_CAP_ANY      (CEPH_CAP_ANY_RD | CEPH_CAP_ANY_EXCL | \
-			   CEPH_CAP_ANY_FILE_WR | CEPH_CAP_PIN)
+			   CEPH_CAP_ANY_FILE_WR | CEPH_CAP_FILE_LAZYIO | \
+			   CEPH_CAP_PIN)
 
 #define CEPH_CAP_LOCKS (CEPH_LOCK_IFILE | CEPH_LOCK_IAUTH | CEPH_LOCK_ILINK | \
 			CEPH_LOCK_IXATTR)
@@ -528,7 +637,6 @@ struct ceph_mds_caps {
 	__le32 migrate_seq;
 	__le64 snap_follows;
 	__le32 snap_trace_len;
-	__le64 client_tid;          /* for FLUSH(SNAP) -> FLUSH(SNAP)_ACK */
 
 	/* authlock */
 	__le32 uid, gid, mode;
@@ -582,12 +690,21 @@ struct ceph_mds_cap_reconnect {
 	__le64 cap_id;
 	__le32 wanted;
 	__le32 issued;
+	__le64 snaprealm;
+	__le64 pathbase;        /* base ino for our path to this ino */
+	__le32 flock_len;       /* size of flock state blob, if any */
+} __attribute__ ((packed));
+/* followed by flock blob */
+
+struct ceph_mds_cap_reconnect_v1 {
+	__le64 cap_id;
+	__le32 wanted;
+	__le32 issued;
 	__le64 size;
 	struct ceph_timespec mtime, atime;
 	__le64 snaprealm;
 	__le64 pathbase;        /* base ino for our path to this ino */
 } __attribute__ ((packed));
-/* followed by encoded string */
 
 struct ceph_mds_snaprealm_reconnect {
 	__le64 ino;     /* snap realm base */
diff --git a/wireshark/ceph/crc32c.h b/wireshark/ceph/crc32c.h
index 13df359..e3cf8ff 100644
--- a/wireshark/ceph/crc32c.h
+++ b/wireshark/ceph/crc32c.h
@@ -5,7 +5,7 @@
 extern "C" {
 #endif
 
-uint32_t crc32c_le(uint32_t crc, unsigned char const *data, unsigned length);
+uint32_t ceph_crc32c_le(uint32_t crc, unsigned char const *data, unsigned length);
 
 #ifdef __cplusplus
 }
diff --git a/wireshark/ceph/msgr.h b/wireshark/ceph/msgr.h
index 2f61704..2604e1a 100644
--- a/wireshark/ceph/msgr.h
+++ b/wireshark/ceph/msgr.h
@@ -1,6 +1,10 @@
 #ifndef CEPH_MSGR_H
 #define CEPH_MSGR_H
 
+#ifdef __cplusplus
+#include <sys/socket.h> // for struct sockaddr_storage
+#endif
+
 /*
  * Data types for message passing layer used by Ceph.
  */
@@ -21,7 +25,7 @@
  * whenever the wire protocol changes.  try to keep this string length
  * constant.
  */
-#define CEPH_BANNER "ceph v022"
+#define CEPH_BANNER "ceph v027"
 #define CEPH_BANNER_MAX_LEN 30
 
 
@@ -46,33 +50,25 @@ struct ceph_entity_name {
 	__le64 num;
 } __attribute__ ((packed));
 
-#define CEPH_ENTITY_TYPE_MON    1
-#define CEPH_ENTITY_TYPE_MDS    2
-#define CEPH_ENTITY_TYPE_OSD    3
-#define CEPH_ENTITY_TYPE_CLIENT 4
+#define CEPH_ENTITY_TYPE_MON    0x01
+#define CEPH_ENTITY_TYPE_MDS    0x02
+#define CEPH_ENTITY_TYPE_OSD    0x04
+#define CEPH_ENTITY_TYPE_CLIENT 0x08
+#define CEPH_ENTITY_TYPE_AUTH   0x20
+
+#define CEPH_ENTITY_TYPE_ANY    0xFF
+
+extern const char *ceph_entity_type_name(int type);
 
 /*
  * entity_addr -- network address
  */
 struct ceph_entity_addr {
-	__le32 erank;  /* entity's rank in process */
+	__le32 type;
 	__le32 nonce;  /* unique id for process (e.g. pid) */
 	struct sockaddr_storage in_addr;
 } __attribute__ ((packed));
 
-static inline bool ceph_entity_addr_is_local(const struct ceph_entity_addr *a,
-					     const struct ceph_entity_addr *b)
-{
-	return a->nonce == b->nonce &&
-		memcmp(&a->in_addr, &b->in_addr, sizeof(a->in_addr)) == 0;
-}
-
-static inline bool ceph_entity_addr_equal(const struct ceph_entity_addr *a,
-					  const struct ceph_entity_addr *b)
-{
-	return memcmp(a, b, sizeof(*a)) == 0;
-}
-
 struct ceph_entity_inst {
 	struct ceph_entity_name name;
 	struct ceph_entity_addr addr;
@@ -93,24 +89,32 @@ struct ceph_entity_inst {
 #define CEPH_MSGR_TAG_ACK           8  /* message ack */
 #define CEPH_MSGR_TAG_KEEPALIVE     9  /* just a keepalive byte! */
 #define CEPH_MSGR_TAG_BADPROTOVER  10  /* bad protocol version */
+#define CEPH_MSGR_TAG_BADAUTHORIZER 11 /* bad authorizer */
+#define CEPH_MSGR_TAG_FEATURES      12 /* insufficient features */
+#define CEPH_MSGR_TAG_SEQ           13 /* 64-bit int follows with seen seq number */
 
 
 /*
  * connection negotiation
  */
 struct ceph_msg_connect {
+	__le64 features;     /* supported feature bits */
 	__le32 host_type;    /* CEPH_ENTITY_TYPE_* */
 	__le32 global_seq;   /* count connections initiated by this host */
 	__le32 connect_seq;  /* count connections initiated in this session */
 	__le32 protocol_version;
+	__le32 authorizer_protocol;
+	__le32 authorizer_len;
 	__u8  flags;         /* CEPH_MSG_CONNECT_* */
 } __attribute__ ((packed));
 
 struct ceph_msg_connect_reply {
 	__u8 tag;
+	__le64 features;     /* feature bits for this session */
 	__le32 global_seq;
 	__le32 connect_seq;
 	__le32 protocol_version;
+	__le32 authorizer_len;
 	__u8 flags;
 } __attribute__ ((packed));
 
@@ -120,8 +124,9 @@ struct ceph_msg_connect_reply {
 /*
  * message header
  */
-struct ceph_msg_header {
+struct ceph_msg_header_old {
 	__le64 seq;       /* message seq# for this session */
+	__le64 tid;       /* transaction id */
 	__le16 type;      /* message type */
 	__le16 priority;  /* priority.  higher value == higher priority */
 	__le16 version;   /* version of message encoding */
@@ -133,10 +138,30 @@ struct ceph_msg_header {
 			     receiver: mask against ~PAGE_MASK */
 
 	struct ceph_entity_inst src, orig_src;
-	__le32 dst_erank;
+	__le32 reserved;
+	__le32 crc;       /* header crc32c */
+} __attribute__ ((packed));
+
+
+struct ceph_msg_header {
+	__le64 seq;       /* message seq# for this session */
+	__le64 tid;       /* transaction id */
+	__le16 type;      /* message type */
+	__le16 priority;  /* priority.  higher value == higher priority */
+	__le16 version;   /* version of message encoding */
+
+	__le32 front_len; /* bytes in main payload */
+	__le32 middle_len;/* bytes in middle payload */
+	__le32 data_len;  /* bytes of data payload */
+	__le16 data_off;  /* sender: include full offset;
+			     receiver: mask against ~PAGE_MASK */
+
+	struct ceph_entity_name src;
+	__le32 reserved;
 	__le32 crc;       /* header crc32c */
 } __attribute__ ((packed));
 
+
 #define CEPH_MSG_PRIO_LOW     64
 #define CEPH_MSG_PRIO_DEFAULT 127
 #define CEPH_MSG_PRIO_HIGH    196
diff --git a/wireshark/ceph/packet-ceph.c b/wireshark/ceph/packet-ceph.c
index 754478d..5acdd43 100644
--- a/wireshark/ceph/packet-ceph.c
+++ b/wireshark/ceph/packet-ceph.c
@@ -18,18 +18,21 @@
 # include "config.h"
 #endif
 
+
 #include <stdio.h>
 #include <glib.h>
 #include <epan/packet.h>
+#include <epan/tvbuff.h>
+#include <epan/tvbuff-int.h>
+
 #include <epan/dissectors/packet-tcp.h>
 
 #include "types.h"
-
 #include "crc32c.h"
-
 #include <string.h>
 
 #define PROTO_TAG_CEPH	"CEPH"
+#define AUTH_LEN		174
 
 /* Wireshark ID of the CEPH protocol */
 static int proto_ceph = -1;
@@ -69,6 +72,14 @@ static guint32 global_ceph_max_mon_port = 6799;
 #define PROTO_ADD_TEXT(type, s, field, modifier)\
 	proto_tree_add_text(tree, tvb, offset + offsetof(type, field), sizeof(s->field), "" #field ": " modifier, s->field);
 
+#define PROTO_ADD_SIMPLE_TEXT(tree,getter,format,var)\
+	do { \
+	    var = getter(tvb,offset); \
+	    proto_tree_add_text(tree, tvb, offset, sizeof(var), format, var);\
+	    offset += sizeof(var); \
+	} while(0)
+
+
 #define PROTO_ADD_ITEM(tree, type, hf, s, field) \
 	proto_tree_add_item(tree, hf, tvb, offset + offsetof(type, field), sizeof(s->field), TRUE);
 
@@ -91,6 +102,11 @@ static const value_string packettypenames[] = {
 	{ 11, "Client Mount Ack" },
 	{ 12, "Client Unmount" },
 	{ 13, "Statfs" },
+	{ 14, "Statfs Reply" },
+	{ 15, "Mon Subscribe" },
+	{ 16, "Mon Subscribe Ack" },
+	{ 17, "Authentication" },
+	{ 18, "Authentication reply" },
 	{ 20, "MDS Get Map" },
 	{ 21, "MDS Map" },
 	{ 22, "Client Session" },
@@ -101,10 +117,14 @@ static const value_string packettypenames[] = {
 	{ 0x310, "Client Caps" },
 	{ 0x311, "Client Lease" },
 	{ 0x312, "Client Snap" },
+	{ 0x313, "Client Cap Release" },
 	{ 40, "OSD Get Map" },
 	{ 41, "OSD Map" },
 	{ 42, "OSD Op" },
 	{ 43, "OSD Op Reply" },
+	{ 44, "Watch Notify" },
+	{ 48, "Poolop Reply" },
+	{ 49, "Poolop" },
 	{ 0, NULL }
 };	
 
@@ -168,7 +188,11 @@ static gint hf_ceph_footer_flags = -1;
 static gint hf_ceph_footer_front_crc = -1;
 static gint hf_ceph_footer_middle_crc = -1;
 static gint hf_ceph_footer_data_crc = -1;
-
+static gint hf_ceph_monmap = -1;
+static gint hf_ceph_mdsmap = -1;
+static gint hf_ceph_mdsnode = -1;
+static gint hf_ceph_auth_reply = -1;
+static gint hf_ceph_pgpools = -1;
 
 /* These are the ids of the subtrees that we may be creating */
 static gint ett_ceph = -1;
@@ -183,6 +207,65 @@ static gint ett_ceph_data = -1;
 static gint ett_ceph_footer = -1;
 
 
+const char *ceph_cap_op_name(int op)
+{
+        char* plop = malloc(16*sizeof(char));
+        sprintf(plop,"%i",op);
+        switch (op) {
+        case CEPH_CAP_OP_GRANT: return "grant";
+        case CEPH_CAP_OP_REVOKE: return "revoke";
+        case CEPH_CAP_OP_TRUNC: return "trunc";
+        case CEPH_CAP_OP_EXPORT: return "export";
+        case CEPH_CAP_OP_IMPORT: return "import";
+        case CEPH_CAP_OP_UPDATE: return "update";
+        case CEPH_CAP_OP_DROP: return "drop";
+        case CEPH_CAP_OP_FLUSH: return "flush";
+        case CEPH_CAP_OP_FLUSH_ACK: return "flush_ack";
+        case CEPH_CAP_OP_FLUSHSNAP: return "flushsnap";
+        case CEPH_CAP_OP_FLUSHSNAP_ACK: return "flushsnap_ack";
+        case CEPH_CAP_OP_RELEASE: return "release";
+        case CEPH_CAP_OP_RENEW: return "renew";
+        }
+        return plop;
+}
+
+const char *ceph_mds_op_name(int op)
+{
+  char* plop = malloc(16*sizeof(char));
+         sprintf(plop,"%i",op);
+        switch (op) {
+        case CEPH_MDS_OP_LOOKUP:  return "lookup";
+        case CEPH_MDS_OP_LOOKUPHASH:  return "lookuphash";
+        case CEPH_MDS_OP_LOOKUPPARENT:  return "lookupparent";
+        case CEPH_MDS_OP_LOOKUPINO:  return "lookupino";
+        case CEPH_MDS_OP_GETATTR:  return "getattr";
+        case CEPH_MDS_OP_SETXATTR: return "setxattr";
+        case CEPH_MDS_OP_SETATTR: return "setattr";
+        case CEPH_MDS_OP_RMXATTR: return "rmxattr";
+        case CEPH_MDS_OP_SETLAYOUT: return "setlayou";
+        case CEPH_MDS_OP_SETDIRLAYOUT: return "setdirlayout";
+        case CEPH_MDS_OP_READDIR: return "readdir";
+        case CEPH_MDS_OP_MKNOD: return "mknod";
+        case CEPH_MDS_OP_LINK: return "link";
+        case CEPH_MDS_OP_UNLINK: return "unlink";
+        case CEPH_MDS_OP_RENAME: return "rename";
+        case CEPH_MDS_OP_MKDIR: return "mkdir";
+        case CEPH_MDS_OP_RMDIR: return "rmdir";
+        case CEPH_MDS_OP_SYMLINK: return "symlink";
+        case CEPH_MDS_OP_CREATE: return "create";
+        case CEPH_MDS_OP_OPEN: return "open";
+        case CEPH_MDS_OP_LOOKUPSNAP: return "lookupsnap";
+        case CEPH_MDS_OP_LSSNAP: return "lssnap";
+        case CEPH_MDS_OP_MKSNAP: return "mksnap";
+        case CEPH_MDS_OP_RMSNAP: return "rmsnap";
+        case CEPH_MDS_OP_SETFILELOCK: return "setfilelock";
+        case CEPH_MDS_OP_GETFILELOCK: return "getfilelock";
+        }
+        return plop;
+}
+
+
+
 void proto_reg_handoff_ceph(void)
 {
 	static gboolean initialized=FALSE;
@@ -207,8 +290,23 @@ void proto_register_ceph (void)
 	*/
 	static hf_register_info hf[] = {
 		{ &hf_ceph,
-			{ "Data", "ceph.data", FT_NONE, BASE_NONE, NULL, 0x0,
+			{ "Data", "ceph.data", FT_NONE , BASE_NONE, NULL, 0,
 			"CEPH PDU", HFILL }},
+		{ &hf_ceph_pgpools,
+			{ "pgpools", "ceph.pgpools", FT_NONE , BASE_NONE, NULL, 0,
+			"CEPH PG Pools", HFILL }},
+		{ &hf_ceph_monmap,
+			{ "MON map", "ceph.monmap", FT_NONE , BASE_NONE, NULL, 0,
+			"CEPH MON map", HFILL }},
+		{ &hf_ceph_mdsmap,
+			{ "MDS map", "ceph.mdsmap", FT_NONE , BASE_NONE, NULL, 0,
+			"CEPH MDS map", HFILL }},
+		{ &hf_ceph_mdsnode,
+			{ "MDS node", "ceph.mdsnode", FT_NONE , BASE_NONE, NULL, 0,
+			"CEPH MDS node", HFILL }},
+		{ &hf_ceph_auth_reply,
+			{ "Authentication reply", "ceph.auth.reply", FT_NONE , BASE_NONE, NULL, 0,
+			"CEPH Authentication reply", HFILL }},
 		{ &hf_ceph_header,
 			{ "Header", "ceph.header", FT_NONE, BASE_NONE, NULL, 0x0,
 		 	"CEPH Header", HFILL }},
@@ -219,7 +317,7 @@ void proto_register_ceph (void)
 			{ "Ceph Entity Type", "ceph.entity.type", FT_UINT32, BASE_DEC, NULL, 0x0,
 			"Ceph Entity Type", HFILL }},
 		{ &hf_ceph_entity_num,
-			{ "Ceph Entity Num", "ceph.entity.num", FT_UINT32, BASE_DEC, NULL, 0x0,
+			{ "Ceph Entity Num", "ceph.entity.num", FT_UINT64, BASE_DEC, NULL, 0x0,
 			"Ceph Entity Num", HFILL }},
 		{ &hf_ceph_entity_addr,
 			{ "Ceph Entity Addr", "ceph.entity.addr", FT_NONE, BASE_NONE, NULL, 0x0,
@@ -339,10 +437,10 @@ void proto_register_ceph (void)
 			{ "Front", "ceph.front", FT_NONE, BASE_NONE, NULL, 0x0,
 		 	"Ceph Front", HFILL }},
 		{ &hf_ceph_data,
-			{ "Data", "ceph.data", FT_NONE, BASE_HEX, NULL, 0x0,
+			{ "Data", "ceph.data", FT_NONE, BASE_NONE, NULL, 0x0,
 		 	"Ceph Data", HFILL }},
 		{ &hf_ceph_footer,
-			{ "Footer", "ceph.footer", FT_NONE, BASE_HEX, NULL, 0x0,
+			{ "Footer", "ceph.footer", FT_NONE, BASE_NONE, NULL, 0x0,
 		 	"Ceph Footer", HFILL }},
 		{ &hf_ceph_footer_flags,
 			{ "flags", "ceph.footer.flags", FT_UINT32, BASE_HEX, NULL, 0x0,
@@ -367,7 +465,7 @@ void proto_register_ceph (void)
 		&ett_ceph_text,
 		&ett_ceph_data,
 		&ett_ceph_front,
-		&ett_ceph_footer
+		&ett_ceph_footer,
 	};
 	//if (proto_ceph == -1) { /* execute protocol initialization only once */
 	proto_ceph = proto_register_protocol ("CEPH Protocol", "CEPH", "ceph");
@@ -430,40 +528,30 @@ static guint32 dissect_ceph_entity_addr(tvbuff_t *tvb, proto_tree *tree, guint32
 
 static guint32 dissect_ceph_fsid(tvbuff_t *tvb, proto_tree *tree, guint32 offset)
 {
-	proto_tree *ceph_entity_tree = NULL;
-	proto_item *ceph_sub_item = NULL;
-	struct ceph_fsid *fsid;
-
-	fsid = (struct ceph_fsid *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_fsid));
-
-	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_fsid, tvb, offset, sizeof(struct ceph_entity_addr), TRUE );
-	ceph_entity_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
-
-	proto_tree_add_item(ceph_entity_tree, hf_ceph_connect_erank, tvb, offset, 4, TRUE);
-	proto_tree_add_item(ceph_entity_tree, hf_ceph_connect_nonce, tvb, offset+4, 4, TRUE);
-
-	proto_tree_add_text(tree, tvb, 0, 
-				sizeof(struct ceph_fsid), "fsid: " FMT_INO "." FMT_INO, ((unsigned long long *)fsid->fsid)[0], ((unsigned long long *)fsid->fsid)[1]);
-	
+	struct ceph_fsid fsid;
+	guint32 * fsid_dec = NULL;
+	fsid_dec = malloc(4*sizeof(guint32));
+	fsid = *(struct ceph_fsid *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_fsid));
+	memcpy(fsid_dec,fsid.fsid,4*sizeof(guint32));
+	proto_tree_add_text(tree, tvb, offset,sizeof(struct ceph_fsid), "fsid: %x-%x-%x-%x",
+			ntohl(fsid_dec[0]),
+			ntohl(fsid_dec[1]),
+			ntohl(fsid_dec[2]),
+			ntohl(fsid_dec[3])
+			);
 	offset += sizeof(struct ceph_fsid);
-
 	return offset;
 }
 
-static guint32 dissect_ceph_entity_inst(tvbuff_t *tvb, proto_tree *tree, guint32 offset)
+guint32 dissect_ceph_entity_name(tvbuff_t *tvb, proto_tree *tree, guint32 offset)
 {
-	proto_tree *ceph_entity_tree = NULL;
-	proto_item *ceph_sub_item = NULL;
-
-	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_entity_addr, tvb, offset, sizeof(struct ceph_entity_addr), TRUE );
-	ceph_entity_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
-	proto_tree_add_item(ceph_entity_tree, hf_ceph_entity_type, tvb, offset, 4, TRUE);
-	proto_tree_add_item(ceph_entity_tree, hf_ceph_entity_num, tvb, offset+4, 4, TRUE);
-	offset += 8;
-	offset = dissect_ceph_entity_addr(tvb, ceph_entity_tree, offset);
+	proto_tree_add_item(tree, hf_ceph_entity_type, tvb, offset, 1, TRUE);
+	proto_tree_add_item(tree, hf_ceph_entity_num, tvb, offset+1, 8, TRUE);
+	offset += sizeof(struct ceph_entity_name);
 	return offset;
 }
 
+
 static guint32 dissect_ceph_footer(tvbuff_t *tvb, proto_tree *tree, guint32 offset, guint32 data_crc)
 {
 	proto_tree *ceph_footer_tree = NULL;
@@ -472,13 +560,13 @@ static guint32 dissect_ceph_footer(tvbuff_t *tvb, proto_tree *tree, guint32 offs
 
 	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_footer, tvb, offset, sizeof(struct ceph_msg_footer), TRUE );
 	ceph_footer_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
-	proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_flags, tvb, offset, 4, TRUE);
-	proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_front_crc, tvb, offset+4, 4, TRUE);
-	proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_middle_crc, tvb, offset+8, 4, TRUE);
-	data_crc_item = proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_data_crc, tvb, offset+12, 4, TRUE);
+	proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_front_crc, tvb, offset, 4, TRUE);
+	proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_middle_crc, tvb, offset+4, 4, TRUE);
+	data_crc_item = proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_data_crc, tvb, offset+8, 4, TRUE);
 	proto_item_append_text(data_crc_item, " (calculated %x)", data_crc);
+	proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_flags, tvb, offset+12, 1, TRUE);
 
-	offset += 12;
+	offset += 13;
 	return offset;
 }
 
@@ -488,6 +576,7 @@ static guint32 dissect_ceph_client_connect(tvbuff_t *tvb, proto_tree *tree, guin
 	proto_item *ceph_sub_item = NULL;
 	proto_item *ceph_item = proto_tree_get_parent(tree);
 	struct ceph_msg_connect *msg;
+	guint32 auth_len = 0;
 
 	offset = dissect_ceph_banner(tvb, tree, offset);
 
@@ -507,12 +596,19 @@ static guint32 dissect_ceph_client_connect(tvbuff_t *tvb, proto_tree *tree, guin
 #endif
 
 	msg = (struct ceph_msg_connect *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_msg_connect));
+	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, features, "%lld");
 	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, host_type, "%d");
-	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, global_seq, "%d");
 	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, connect_seq, "%d");
+	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, global_seq, "%d");
 	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, protocol_version, "%d");
 	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, flags, "%x");
-
+	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, authorizer_protocol, "%d");
+	PROTO_ADD_TEXT(struct ceph_msg_connect, msg, authorizer_len, "%d");
+	offset += sizeof(struct ceph_msg_connect);
+	auth_len = msg->authorizer_len;
+	auth_len = 174;
+	proto_tree_add_text(tree,tvb, offset, auth_len, "Authentication key");
+	offset += auth_len;
 	return offset;
 }
 
@@ -534,9 +630,11 @@ static guint32 dissect_ceph_server_connect(tvbuff_t *tvb, proto_tree *tree, guin
 	offset = dissect_ceph_entity_addr(tvb, ceph_header_tree, offset);
 	msg = (struct ceph_msg_connect_reply *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_msg_connect_reply));
 	PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, tag, "%d");
+	PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, features, "%lld");
 	PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, global_seq, "%d");
 	PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, connect_seq, "%d");
 	PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, protocol_version, "%d");
+	PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, authorizer_len, "%d");
 	PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, flags, "%x");
 
 	return offset;
@@ -594,7 +692,7 @@ static guint32 dissect_ceph_mon_statfs(tvbuff_t *tvb, proto_tree *tree, guint32
 	req = (struct ceph_mon_statfs *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_mon_statfs));
 	
 	dissect_ceph_fsid(tvb, tree, offset + offsetof(struct ceph_mon_statfs, fsid));
-	PROTO_ADD_TEXT(struct ceph_mon_statfs, req, tid, "%lld");
+	PROTO_ADD_TEXT(struct ceph_mon_statfs, req, monhdr.session_mon_tid, "%lld");
 
 	return offset + sizeof(struct ceph_mon_statfs);
 }
@@ -606,7 +704,8 @@ static guint32 dissect_ceph_mon_statfs_reply(tvbuff_t *tvb, proto_tree *tree, gu
 	req = (struct ceph_mon_statfs_reply *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_mon_statfs_reply));
 	
 	dissect_ceph_fsid(tvb, tree, offset + offsetof(struct ceph_mon_statfs_reply, fsid));
-	PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, tid, "%lld");
+	PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, version, "%lld");
+
 	PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, st.kb, "%lld");
 	PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, st.kb_used, "%lld");
 	PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, st.kb_avail, "%lld");
@@ -646,7 +745,7 @@ static guint32 dissect_ceph_client_mds_request(tvbuff_t *tvb, packet_info *pinfo
 
 	head = (struct ceph_mds_request_head *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_mds_request_head));
 	
-	PROTO_ADD_TEXT(struct ceph_mds_request_head, head, tid, "%lld");
+	//PROTO_ADD_TEXT(struct ceph_mds_request_head, head, tid, "%lld");
 	PROTO_ADD_TEXT(struct ceph_mds_request_head, head, oldest_client_tid, "%lld");
 	PROTO_ADD_TEXT(struct ceph_mds_request_head, head, mdsmap_epoch, "%d");
 	PROTO_ADD_TEXT(struct ceph_mds_request_head, head, num_retry, "%d");
@@ -695,6 +794,7 @@ static guint32 dissect_ceph_client_mds_request(tvbuff_t *tvb, packet_info *pinfo
 	case CEPH_MDS_OP_LSSNAP:
 	case CEPH_MDS_OP_MKSNAP:
 	case CEPH_MDS_OP_RMSNAP:
+	case CEPH_MDS_OP_CREATE:
 		break;
 	}
 
@@ -730,7 +830,7 @@ static guint32 dissect_ceph_client_mds_reply(tvbuff_t *tvb, packet_info *pinfo,
 
 	head = (struct ceph_mds_reply_head *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_mds_reply_head));
 	
-	PROTO_ADD_TEXT(struct ceph_mds_reply_head, head, tid, "%lld");
+	//PROTO_ADD_TEXT(struct ceph_mds_reply_head, head, tid, "%lld");
 
 	proto_tree_add_text(tree, tvb, offsetof(struct ceph_mds_reply_head, op), 
 				sizeof(head->op), "op: %d (%s)", head->op, ceph_mds_op_name(head->op));
@@ -789,7 +889,7 @@ static guint32 dissect_ceph_client_mds_caps_request(tvbuff_t *tvb, packet_info *
 	PROTO_ADD_TEXT(struct ceph_mds_caps, head, snap_follows, "%llu");
 	PROTO_ADD_TEXT(struct ceph_mds_caps, head, snap_trace_len, "%d");
 
-#define CAPS_REQ_ADD_TIME(field) PROTO_ADD_TIME(tvb, tree, struct ceph_mds_caps, offset, head, field, field) 
+#define CAPS_REQ_ADD_TIME(field) PROTO_ADD_TIME(tvb, tree, struct ceph_mds_caps, offset, head, field, field)
 	CAPS_REQ_ADD_TIME(mtime);
 	CAPS_REQ_ADD_TIME(atime);
 	CAPS_REQ_ADD_TIME(ctime);
@@ -801,9 +901,163 @@ static guint32 dissect_ceph_client_mds_caps_request(tvbuff_t *tvb, packet_info *
 	return orig_ofs + sizeof(struct ceph_mds_caps);
 }
 
-static guint32 dissect_ceph_client_front(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, guint32 offset, guint16 type)
+static guint32 dissect_ceph_auth_reply(tvbuff_t *tvb, proto_tree *tree, guint32 offset){
+	guint32 protocol, result, payload_len,str_len;
+	guint64 global_id;
+	proto_item *ceph_sub_item = NULL;
+	proto_item *ceph_item = proto_tree_get_parent(tree);
+    proto_tree *ceph_auth_reply_tree;
+
+    ceph_auth_reply_tree = proto_item_add_subtree(ceph_item, ett_ceph);
+	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_auth_reply, tvb, offset, 16, TRUE );
+    ceph_auth_reply_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
+
+    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"protocol: %d",protocol);
+    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"result: %d",result);
+    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letoh64,"global_id: %lu", global_id);
+    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"payload_len: %d",payload_len);
+
+    str_len = tvb_get_letohl(tvb,offset+payload_len);
+    proto_tree_add_text(ceph_auth_reply_tree, tvb, offset+payload_len, str_len,"%s",tvb_get_const_stringz(tvb,offset,&str_len));
+	return offset;
+}
+
+static guint32 dissect_ceph_pgpools(tvbuff_t *tvb, proto_tree *tree, guint32 offset){
+	guint32 n, i, pool;
+	proto_item *ceph_item = proto_tree_get_parent(tree);
+	proto_tree *ceph_pgpools_tree;
+	proto_item *ceph_sub_item = NULL;
+	ceph_pgpools_tree = proto_item_add_subtree(ceph_item, ett_ceph);
+	ceph_sub_item = proto_tree_add_item(tree, hf_ceph_pgpools, tvb, offset, -1, TRUE );
+	ceph_pgpools_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
+    PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl," %d pool(s)",n);
+    for ( i = 0; i<n; i++){
+        PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"data_pg_pool: %d",pool);
+        PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"cas_pg_pool: %d",pool);
+    }
+	return offset;
+}
+static guint32 dissect_ceph_mdsmap_node(tvbuff_t *tvb, proto_tree *tree, guint32 offset){
+	guint8 infoversion;
+	guint32 field, num_export_targets, i;
+	guint64 global_id, field64;
+	proto_item *ceph_item = proto_tree_get_parent(tree);
+	proto_tree *ceph_mdsnode_tree;
+	proto_item *ceph_sub_item = NULL;
+	struct ceph_timespec *cephtime = NULL;
+	time_t time;
+	ceph_mdsnode_tree = proto_item_add_subtree(ceph_item, ett_ceph);
+	ceph_sub_item = proto_tree_add_item(tree, hf_ceph_mdsnode, tvb, offset, -1, TRUE );
+	ceph_mdsnode_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
+
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"Global ID: %ld",global_id);
+	infoversion = *tvb_get_ptr(tvb,offset,sizeof(infoversion));
+	offset++;
+	offset+=sizeof(guint64);
+    proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, sizeof(infoversion), "version: %d", infoversion);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"Name length: %d",field);
+    proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, field,"MDS name: %s",tvb_get_const_stringz(tvb,offset,&field));
+    offset+=field-1;
+    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"mds: %d",field);
+    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"inc: %d",field);
+    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"state: %d",field);
+    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"state seq: %ld",field64);
+	offset = dissect_ceph_entity_addr(tvb, ceph_mdsnode_tree, offset);
+	cephtime = (struct ceph_timespec *) tvb_get_ptr(tvb, offset, sizeof(struct ceph_timespec));
+	time = cephtime->tv_sec;
+	proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, sizeof(time), "Time: %s (%d ns)", ctime(&time), cephtime->tv_nsec);
+	offset += sizeof(struct ceph_timespec);
+	offset += sizeof(guint32);
+	offset += tvb_get_letohl(tvb,offset);
+	offset += sizeof(guint32);
+	//offset ++;
+	if (infoversion >= 2 ){
+		PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"num_export_targets: %d",num_export_targets);
+	}
+	else{
+		num_export_targets = 0;
+	}
+	for ( i = 0; i < num_export_targets ; i++){
+		PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"export_target: %d",field);
+	}
+
+	return offset;
+}
+
+static guint32 dissect_ceph_mon_map(tvbuff_t *tvb, proto_tree *tree, guint32 offset)
+{
+	guint32 epoch, num_mon, len, i;
+	guint16 version;
+	proto_item *ceph_item = proto_tree_get_parent(tree);
+	proto_tree *ceph_monmap_tree;
+	proto_item *ceph_sub_item = NULL;
+	ceph_monmap_tree = proto_item_add_subtree(ceph_item, ett_ceph);
+	len = tvb_get_letohl(tvb,offset);
+	ceph_sub_item = proto_tree_add_item(tree, hf_ceph_monmap, tvb, offset, len, TRUE );
+	ceph_monmap_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
+
+	PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohl,"length: %i",len);
+	PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohs,"version: %i",version);
+	offset = dissect_ceph_fsid(tvb, ceph_monmap_tree, offset);
+	PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohl,"epoch: %i",epoch);
+	PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohl,"%i monitor",num_mon);
+	for (i = 0; i < num_mon; i++)
+		offset = dissect_ceph_entity_name(tvb, ceph_monmap_tree, offset);
+		offset = dissect_ceph_entity_addr(tvb, ceph_monmap_tree, offset);
+
+	return offset;
+}
+
+static guint32 dissect_ceph_mds_map(tvbuff_t *tvb, proto_tree *tree, guint32 offset)
+{
+	guint16 version;
+	guint32 epoch, map_len, len, plop, i;
+	guint64 max_filesize;
+	proto_item *ceph_item = proto_tree_get_parent(tree);
+	proto_tree *ceph_mdsmap_tree;
+	proto_item *ceph_sub_item = NULL;
+	ceph_mdsmap_tree = proto_item_add_subtree(ceph_item, ett_ceph);
+	len = tvb_get_letohl(tvb,offset);
+	ceph_sub_item = proto_tree_add_item(tree, hf_ceph_mdsmap, tvb, offset, len, TRUE );
+	ceph_mdsmap_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
+	offset = dissect_ceph_fsid(tvb, ceph_mdsmap_tree, offset);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"epoch: %i",epoch);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"map length: %i",map_len);
+
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"version: %i",version);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_epoch: %i",plop);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_client_epoch: %i",plop);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_last_failure: %i",plop);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_root: %i",plop);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_session_timeout: %i",plop);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_session_autoclose: %i",plop);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letoh64,"m_maxfile_size: %ld",max_filesize);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_max_mds: %i",plop);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"n: %i",len);
+
+
+	for (i = 0; i < len; i++){
+		 offset = dissect_ceph_mdsmap_node(tvb, ceph_mdsmap_tree, offset);
+	}
+	offset = dissect_ceph_pgpools(tvb, ceph_mdsmap_tree, offset);
+	return offset;
+}
+
+static guint32 dissect_ceph_front(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, guint32 offset, guint16 type)
 {
 	switch (type) {
+/*	case CEPH_MSG_AUTH:
+		offset = dissect_ceph_auth();
+		break;*/
+	case CEPH_MSG_AUTH_REPLY:
+		offset = dissect_ceph_auth_reply(tvb, tree, offset);
+		break;
+	case CEPH_MSG_MON_MAP:
+		offset = dissect_ceph_mon_map(tvb, tree, offset);
+		break;
+	case CEPH_MSG_MDS_MAP:
+		offset = dissect_ceph_mds_map(tvb, tree, offset);
+		break;
 	case CEPH_MSG_STATFS:
 		offset = dissect_ceph_mon_statfs(tvb, tree, offset);
 		break;
@@ -835,18 +1089,23 @@ static guint32 dissect_ceph_generic(tvbuff_t *tvb, packet_info *pinfo, proto_tre
 	proto_item *ceph_item = proto_tree_get_parent(tree);
 	guint32 front_len, middle_len, data_len;
 	guint8 tag;
+	guint32 hlen;
 	guint32 orig_ofs = offset;
 	guint16 type;
 	guint64 seq;
 	struct ceph_msg_header *header;
     unsigned int data_crc = 0;
 
+    tag = tvb_get_guint8(tvb, offset);
+    hlen = ( tag == CEPH_MSGR_TAG_ACK ) ? ACK_MSG_SIZE:0;
+    hlen += sizeof(struct ceph_msg_header);
+    hlen++;
+
 	ceph_header_tree = proto_item_add_subtree(ceph_item, ett_ceph);
 
-	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_header, tvb, offset, -1, TRUE );
+	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_header, tvb, offset, hlen, TRUE );
 	ceph_header_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
 
-	tag = tvb_get_guint8(tvb, offset);
 
 	if (tag == CEPH_MSGR_TAG_ACK) {
 		proto_tree_add_item(ceph_header_tree, hf_ceph_hdr_tag, tvb, offset, 1, TRUE);
@@ -867,23 +1126,22 @@ static guint32 dissect_ceph_generic(tvbuff_t *tvb, packet_info *pinfo, proto_tre
 	PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_header, hf_ceph_hdr_middle_len, header, middle_len);
 	PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_header, hf_ceph_hdr_data_off, header, data_off);
 	PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_header, hf_ceph_hdr_data_len, header, data_len);
-	dissect_ceph_entity_inst(tvb, ceph_header_tree, offset + offsetof(struct ceph_msg_header, src));
-	dissect_ceph_entity_inst(tvb, ceph_header_tree, offset + offsetof(struct ceph_msg_header, orig_src));
 	PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_header, hf_ceph_hdr_crc, header, crc);
-	
-	offset += sizeof(struct ceph_msg_header);
-	
+
+	// Bad location
+	dissect_ceph_entity_name(tvb, ceph_header_tree, offset + offsetof(struct ceph_msg_header, src));
+	//dissect_ceph_entity_inst(tvb, ceph_header_tree, offset + offsetof(struct ceph_msg_header, orig_src));
+
 	type = TVB_MSG_FIELD(tvb_get_letohl, tvb, orig_ofs, type);
 	seq = TVB_MSG_FIELD(tvb_get_letoh64, tvb, orig_ofs, seq);
 	front_len = TVB_MSG_FIELD(tvb_get_letohs, tvb, orig_ofs, front_len);
 	middle_len = TVB_MSG_FIELD(tvb_get_letohs, tvb, orig_ofs, middle_len);
 	data_len = TVB_MSG_FIELD(tvb_get_letohl, tvb, orig_ofs, data_len);
 
-	if (front_len) {
-	/*	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_front, tvb, offset, front_len, TRUE );
-		offset += front_len; */
+	offset += sizeof(struct ceph_msg_header);
 
-		dissect_ceph_client_front(tvb, pinfo, tree, offset, type);
+	if (front_len) {
+		dissect_ceph_front(tvb, pinfo, tree, offset, type);
 		offset += front_len;
 	}
 
@@ -895,17 +1153,32 @@ static guint32 dissect_ceph_generic(tvbuff_t *tvb, packet_info *pinfo, proto_tre
 		char *data;
 		ceph_sub_item = proto_tree_add_item( tree, hf_ceph_data, tvb, offset, data_len, TRUE );
 	    data = (char *)tvb_get_ptr(tvb, offset, data_len);
-
-		data_crc = crc32c_le(0, data, data_len);
-
+		data_crc = ceph_crc32c_le(0, data, data_len);
 		offset += data_len;
 	}
-
 	offset = dissect_ceph_footer(tvb, tree, offset, data_crc);
-
 	return offset;
 }
 
+
+static const char *ceph_protocol_to_text(guint32 proto){
+	if ( proto == CEPH_OSD_PROTOCOL )
+		return "osd";
+	if ( proto == CEPH_MDS_PROTOCOL )
+		return "mds";
+	if ( proto == CEPH_MON_PROTOCOL )
+		return "mon";
+	if ( proto == CEPH_OSDC_PROTOCOL )
+		return "osd";
+	if ( proto == CEPH_MDSC_PROTOCOL )
+		return "mds";
+	if ( proto == CEPH_MONC_PROTOCOL )
+		return "mon";
+	else{
+		return "???";
+	}
+}
+
 static const char *entity_name_by_type(int type)
 {
 	if (type < 4)
@@ -936,6 +1209,7 @@ dissect_ceph_client(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
 	proto_item *ceph_item = NULL;
 	proto_tree *ceph_tree = NULL;
 	guint16 type = 0;
+	guint32 proto = 0;
 	const guchar *ptr;
 	guint32 pos = 0;
 	int have_banner = 0;
@@ -955,7 +1229,8 @@ dissect_ceph_client(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
 
 	// This is not a good way of dissecting packets.  The tvb length should
 	// be sanity checked so we aren't going past the actual size of the buffer.
-	type = tvb_get_guint8( tvb, 4 ); // Get the type byte
+	type = tvb_get_guint8(tvb,4); // Get the type byte
+
 
 	if (check_col(pinfo->cinfo, COL_INFO)) {
 		const char *entity_str = NULL;
@@ -963,9 +1238,11 @@ dissect_ceph_client(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
 		if (have_banner) {
 			if (IS_MON(pinfo))
 				entity_str = MON_STR;
-			else 
-				entity_str = "???";
-
+			else{
+				// Guess communication type from "struct ceph_msg_connect"
+				proto = tvb_get_letohl(tvb,9 + sizeof(struct ceph_entity_addr) + 20);
+				entity_str = ceph_protocol_to_text(proto);
+			}
 			col_add_fstr(pinfo->cinfo, COL_INFO, "[%s] Connect Request", entity_str);
 		} else {
 			type = TVB_MSG_FIELD(tvb_get_letohl, tvb, 0, type);
@@ -1021,8 +1298,9 @@ dissect_ceph_server(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
 		const char *entity_str;
 			if (IS_MON(pinfo))
 				entity_str = MON_STR;
-			else 
+			else{
 				entity_str = "???";
+			}
 		if (have_banner) {
 			col_add_fstr(pinfo->cinfo, COL_INFO, "[%s] Connect Response", entity_str);
 		} else {
@@ -1084,19 +1362,19 @@ static guint get_ceph_message_len(packet_info *pinfo, tvbuff_t *tvb, int offset)
 	const char *ptr;
 	guint32 len;
 	guint32 pos = 0;
-
-	ptr = tvb_get_ptr(tvb, offset, /* sizeof(CEPH_BANNER) */tvb->length-offset);
+	guint32 tlen = (int) tvb->length;
+	ptr = tvb_get_ptr(tvb, offset, tlen - offset);
+	//ptr = tvb_get_ptr(tvb, offset, /* sizeof(CEPH_BANNER) */ (tvb->length)-offset);
 	if (ptr && memcmp(ptr, "ceph", 4) == 0) {
 		if (DEST_PORT_CEPH) {
 			len = sizeof(CEPH_BANNER) - 1 +
 				sizeof(struct ceph_entity_addr) +
-				sizeof(struct ceph_msg_connect);
+				sizeof(struct ceph_msg_connect) + AUTH_LEN;
 		} else
 			len = sizeof(CEPH_BANNER) - 1 +
 				sizeof(struct ceph_entity_addr) +
 				sizeof(struct ceph_entity_addr) +
 				sizeof(struct ceph_msg_connect_reply);
-
 		return len;
 	}
 
@@ -1114,18 +1392,39 @@ static guint get_ceph_message_len(packet_info *pinfo, tvbuff_t *tvb, int offset)
 }
 
 
-static void dissect_ceph(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
-{
+static void dissect_ceph(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree){
 	const char *ptr;
-
 	ptr = tvb_get_ptr(tvb, 0, 6);
-
-	if ((*ptr == CEPH_MSGR_TAG_MSG) || 
-            (memcmp(ptr, CEPH_BANNER, 4) == 0) || 
-	   ((ptr[0] == CEPH_MSGR_TAG_ACK) && (ptr[5] == CEPH_MSGR_TAG_MSG))
-	)  {
+	if(*ptr == CEPH_MSGR_TAG_RESETSESSION){
+		col_set_str(pinfo->cinfo, COL_PROTOCOL, PROTO_TAG_CEPH);
+		col_add_fstr(pinfo->cinfo, COL_INFO, "Ceph reset session");
+	}
+	else if(*ptr == CEPH_MSGR_TAG_WAIT){
+		col_set_str(pinfo->cinfo, COL_PROTOCOL, PROTO_TAG_CEPH);
+		col_add_fstr(pinfo->cinfo, COL_INFO, "Ceph I am waiting");
+	}
+	else if(*ptr == CEPH_MSGR_TAG_RETRY_SESSION){
+		col_set_str(pinfo->cinfo, COL_PROTOCOL, PROTO_TAG_CEPH);
+		col_add_fstr(pinfo->cinfo, COL_INFO, "Ceph retry session");
+	}
+	else if(*ptr == CEPH_MSGR_TAG_RETRY_GLOBAL){
+		col_set_str(pinfo->cinfo, COL_PROTOCOL, PROTO_TAG_CEPH);
+		col_add_fstr(pinfo->cinfo, COL_INFO, "Ceph retry global");
+	}
+	else if(*ptr == CEPH_MSGR_TAG_CLOSE){
+		col_set_str(pinfo->cinfo, COL_PROTOCOL, PROTO_TAG_CEPH);
+		col_add_fstr(pinfo->cinfo, COL_INFO, "Ceph close");
+	}
+	else if(*ptr == CEPH_MSGR_TAG_KEEPALIVE){
+		col_set_str(pinfo->cinfo, COL_PROTOCOL, PROTO_TAG_CEPH);
+		col_add_fstr(pinfo->cinfo, COL_INFO, "Ceph keep alive");
+	}
+	else if ((*ptr == CEPH_MSGR_TAG_MSG) ||
+			(memcmp(ptr, CEPH_BANNER, 4) == 0) ||
+			((ptr[0] == CEPH_MSGR_TAG_ACK) && (ptr[9] == CEPH_MSGR_TAG_MSG))
+	){
 		tcp_dissect_pdus(tvb, pinfo, tree, TRUE, TVB_MSG_HEADER_POS(src),
-			get_ceph_message_len, dissect_ceph_message);
+				get_ceph_message_len, dissect_ceph_message);
 	} else {
 		dissect_ceph_acks(tvb, pinfo, tree);
 	}
diff --git a/wireshark/ceph/rados.h b/wireshark/ceph/rados.h
index 2b7833c..0a99099 100644
--- a/wireshark/ceph/rados.h
+++ b/wireshark/ceph/rados.h
@@ -9,6 +9,14 @@
 #include "msgr.h"
 
 /*
+ * osdmap encoding versions
+ */
+#define CEPH_OSDMAP_INC_VERSION     5
+#define CEPH_OSDMAP_INC_VERSION_EXT 6
+#define CEPH_OSDMAP_VERSION         5
+#define CEPH_OSDMAP_VERSION_EXT     6
+
+/*
  * fs id
  */
 struct ceph_fsid {
@@ -50,18 +58,16 @@ struct ceph_timespec {
 #define CEPH_PG_LAYOUT_LINEAR 2
 #define CEPH_PG_LAYOUT_HYBRID 3
 
+#define CEPH_PG_MAX_SIZE      16  /* max # osds in a single pg */
 
 /*
  * placement group.
  * we encode this into one __le64.
  */
-union ceph_pg {
-	__u64 pg64;
-	struct {
-		__s16 preferred; /* preferred primary osd */
-		__u16 ps;        /* placement seed */
-		__u32 pool;      /* object pool */
-	} __attribute__ ((packed)) pg;
+struct ceph_pg {
+	__le16 preferred; /* preferred primary osd */
+	__le16 ps;        /* placement seed */
+	__le32 pool;      /* object pool */
 } __attribute__ ((packed));
 
 /*
@@ -83,17 +89,20 @@ union ceph_pg {
  */
 #define CEPH_PG_TYPE_REP     1
 #define CEPH_PG_TYPE_RAID4   2
+#define CEPH_PG_POOL_VERSION 2
 struct ceph_pg_pool {
 	__u8 type;                /* CEPH_PG_TYPE_* */
 	__u8 size;                /* number of osds in each pg */
 	__u8 crush_ruleset;       /* crush placement rule */
+	__u8 object_hash;         /* hash mapping object name to ps */
 	__le32 pg_num, pgp_num;   /* number of pg's */
 	__le32 lpg_num, lpgp_num; /* number of localized pg's */
 	__le32 last_change;       /* most recent epoch changed */
 	__le64 snap_seq;          /* seq for per-pool snapshot */
 	__le32 snap_epoch;        /* epoch of last snap */
 	__le32 num_snaps;
-	__le32 num_removed_snap_intervals;
+	__le32 num_removed_snap_intervals; /* if non-empty, NO per-pool snaps */
+	__le64 auid;               /* who owns the pg */
 } __attribute__ ((packed));
 
 /*
@@ -117,7 +126,7 @@ static inline int ceph_stable_mod(int x, int b, int bmask)
  * object layout - how a given object should be stored.
  */
 struct ceph_object_layout {
-	__le64 ol_pgid;           /* raw pg, with _full_ ps precision. */
+	struct ceph_pg ol_pgid;   /* raw pg, with _full_ ps precision. */
 	__le32 ol_stripe_unit;    /* for per-object parity, if any */
 } __attribute__ ((packed));
 
@@ -159,7 +168,6 @@ struct ceph_eversion {
 #define CEPH_OSD_OP_MODE_WR    0x2000
 #define CEPH_OSD_OP_MODE_RMW   0x3000
 #define CEPH_OSD_OP_MODE_SUB   0x4000
-#define CEPH_OSD_OP_MODE_EXEC  0x8000
 
 #define CEPH_OSD_OP_TYPE       0x0f00
 #define CEPH_OSD_OP_TYPE_LOCK  0x0100
@@ -173,9 +181,17 @@ enum {
 	/* read */
 	CEPH_OSD_OP_READ      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 1,
 	CEPH_OSD_OP_STAT      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 2,
+	CEPH_OSD_OP_MAPEXT    = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 3,
 
 	/* fancy read */
-	CEPH_OSD_OP_MASKTRUNC = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 4,
+	CEPH_OSD_OP_MASKTRUNC   = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 4,
+	CEPH_OSD_OP_SPARSE_READ = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 5,
+
+	CEPH_OSD_OP_NOTIFY    = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 6,
+	CEPH_OSD_OP_NOTIFY_ACK = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 7,
+
+	/* versioning */
+	CEPH_OSD_OP_ASSERT_VER = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 8,
 
 	/* write */
 	CEPH_OSD_OP_WRITE     = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 1,
@@ -195,11 +211,15 @@ enum {
 	CEPH_OSD_OP_TMAPGET = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 12,
 
 	CEPH_OSD_OP_CREATE  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 13,
+	CEPH_OSD_OP_ROLLBACK= CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 14,
+
+	CEPH_OSD_OP_WATCH   = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 15,
 
 	/** attrs **/
 	/* read */
 	CEPH_OSD_OP_GETXATTR  = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_ATTR | 1,
 	CEPH_OSD_OP_GETXATTRS = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_ATTR | 2,
+	CEPH_OSD_OP_CMPXATTR  = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_ATTR | 3,
 
 	/* write */
 	CEPH_OSD_OP_SETXATTR  = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_ATTR | 1,
@@ -208,11 +228,14 @@ enum {
 	CEPH_OSD_OP_RMXATTR   = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_ATTR | 4,
 
 	/** subop **/
-	CEPH_OSD_OP_PULL           = CEPH_OSD_OP_MODE_SUB | 1,
-	CEPH_OSD_OP_PUSH           = CEPH_OSD_OP_MODE_SUB | 2,
-	CEPH_OSD_OP_BALANCEREADS   = CEPH_OSD_OP_MODE_SUB | 3,
-	CEPH_OSD_OP_UNBALANCEREADS = CEPH_OSD_OP_MODE_SUB | 4,
-	CEPH_OSD_OP_SCRUB          = CEPH_OSD_OP_MODE_SUB | 5,
+	CEPH_OSD_OP_PULL            = CEPH_OSD_OP_MODE_SUB | 1,
+	CEPH_OSD_OP_PUSH            = CEPH_OSD_OP_MODE_SUB | 2,
+	CEPH_OSD_OP_BALANCEREADS    = CEPH_OSD_OP_MODE_SUB | 3,
+	CEPH_OSD_OP_UNBALANCEREADS  = CEPH_OSD_OP_MODE_SUB | 4,
+	CEPH_OSD_OP_SCRUB           = CEPH_OSD_OP_MODE_SUB | 5,
+	CEPH_OSD_OP_SCRUB_RESERVE   = CEPH_OSD_OP_MODE_SUB | 6,
+	CEPH_OSD_OP_SCRUB_UNRESERVE = CEPH_OSD_OP_MODE_SUB | 7,
+	CEPH_OSD_OP_SCRUB_STOP      = CEPH_OSD_OP_MODE_SUB | 8,
 
 	/** lock **/
 	CEPH_OSD_OP_WRLOCK    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 1,
@@ -263,6 +286,10 @@ static inline int ceph_osd_op_mode_modify(int op)
 	return (op & CEPH_OSD_OP_MODE) == CEPH_OSD_OP_MODE_WR;
 }
 
+/*
+ * note that the following tmap stuff is also defined in the ceph librados.h
+ * any modification here needs to be updated there
+ */
 #define CEPH_OSD_TMAP_HDR 'h'
 #define CEPH_OSD_TMAP_SET 's'
 #define CEPH_OSD_TMAP_RM  'r'
@@ -287,6 +314,8 @@ enum {
 	CEPH_OSD_FLAG_BALANCE_READS = 256,
 	CEPH_OSD_FLAG_PARALLELEXEC = 512, /* execute op in parallel */
 	CEPH_OSD_FLAG_PGOP = 1024,      /* pg op, no object */
+	CEPH_OSD_FLAG_EXEC = 2048,      /* op may exec */
+	CEPH_OSD_FLAG_EXEC_PUBLIC = 4096, /* op may exec (public) */
 };
 
 enum {
@@ -296,6 +325,24 @@ enum {
 #define EOLDSNAPC    ERESTART  /* ORDERSNAP flag set; writer has old snapc*/
 #define EBLACKLISTED ESHUTDOWN /* blacklisted */
 
+/* xattr comparison */
+enum {
+	CEPH_OSD_CMPXATTR_OP_NOP = 0,
+	CEPH_OSD_CMPXATTR_OP_EQ  = 1,
+	CEPH_OSD_CMPXATTR_OP_NE  = 2,
+	CEPH_OSD_CMPXATTR_OP_GT  = 3,
+	CEPH_OSD_CMPXATTR_OP_GTE = 4,
+	CEPH_OSD_CMPXATTR_OP_LT  = 5,
+	CEPH_OSD_CMPXATTR_OP_LTE = 6
+};
+
+enum {
+	CEPH_OSD_CMPXATTR_MODE_STRING = 1,
+	CEPH_OSD_CMPXATTR_MODE_U64    = 2
+};
+
+#define RADOS_NOTIFY_VER	1
+
 /*
  * an individual object operation.  each may be accompanied by some data
  * payload
@@ -306,16 +353,16 @@ struct ceph_osd_op {
 	union {
 		struct {
 			__le64 offset, length;
+			__le64 truncate_size;
+			__le32 truncate_seq;
 		} __attribute__ ((packed)) extent;
 		struct {
 			__le32 name_len;
 			__le32 value_len;
+			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
+			__u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
 		} __attribute__ ((packed)) xattr;
 		struct {
-			__le64 truncate_size;
-			__le32 truncate_seq;
-		} __attribute__ ((packed)) trunc;
-		struct {
 			__u8 class_len;
 			__u8 method_len;
 			__u8 argc;
@@ -324,7 +371,15 @@ struct ceph_osd_op {
 		struct {
 			__le64 cookie, count;
 		} __attribute__ ((packed)) pgls;
-	};
+	        struct {
+		        __le64 snapid;
+	        } __attribute__ ((packed)) snap;
+		struct {
+			__le64 cookie;
+			__le64 ver;
+			__u8 flag;	/* 0 = unwatch, 1 = watch */
+		} __attribute__ ((packed)) watch;
+};
 	__le32 payload_len;
 } __attribute__ ((packed));
 
@@ -333,7 +388,6 @@ struct ceph_osd_op {
  * ceph_osd_op object operations.
  */
 struct ceph_osd_request_head {
-	__le64 tid;                        /* transaction id */
 	__le32 client_inc;                 /* client incarnation */
 	struct ceph_object_layout layout;  /* pgid */
 	__le32 osdmap_epoch;               /* client's osdmap epoch */
@@ -354,7 +408,6 @@ struct ceph_osd_request_head {
 } __attribute__ ((packed));
 
 struct ceph_osd_reply_head {
-	__le64 tid;                       /* transaction id */
 	__le32 client_inc;                /* client incarnation */
 	__le32 flags;
 	struct ceph_object_layout layout;
@@ -369,4 +422,5 @@ struct ceph_osd_reply_head {
 } __attribute__ ((packed));
 
 
+
 #endif
diff --git a/wireshark/ceph/sctp_crc32.c b/wireshark/ceph/sctp_crc32.c
index 43c06b4..1385834 100644
--- a/wireshark/ceph/sctp_crc32.c
+++ b/wireshark/ceph/sctp_crc32.c
@@ -31,15 +31,22 @@
 /* $KAME: sctp_crc32.c,v 1.12 2005/03/06 16:04:17 itojun Exp $	 */
 
 
-//#include <sys/cdefs.h>
+#include <sys/cdefs.h>
+#if 0
+__FBSDID("$FreeBSD: src/sys/netinet/sctp_crc32.c,v 1.8 2007/05/08 17:01:10 rrs Exp $");
 
-#include <glib.h>
 
-typedef guint8  uint8_t;
-typedef guint32 uint32_t;
-typedef unsigned long uintptr_t;
+#include <netinet/sctp_os.h>
+#include <netinet/sctp_crc32.h>
+#endif
 
+#include <stdint.h>
 
+#if defined(__FreeBSD__)
+#include <sys/endian.h>
+#else
+#include <endian.h>
+#endif
 
 #ifndef SCTP_USE_ADLER32
 
@@ -588,7 +595,7 @@ sctp_crc32c_sb8_64_bit(uint32_t crc,
  *
  *		none
  */
-uint32_t
+static uint32_t
 update_crc32(uint32_t crc32c,
     unsigned char const *buffer,
     unsigned int length)
@@ -672,7 +679,8 @@ uint32_t sctp_crc_c[256] = {
 
 #define SCTP_CRC32C(c,d) (c=(c>>8)^sctp_crc_c[(c^(d))&0xFF])
 
-uint32_t
+#if 0
+static uint32_t
 old_update_crc32(uint32_t crc32c,
     unsigned char const *buffer,
     unsigned int length)
@@ -686,7 +694,7 @@ old_update_crc32(uint32_t crc32c,
 }
 
 
-uint32_t
+static uint32_t
 sctp_csum_finalize(uint32_t crc32c)
 {
 	uint32_t result;
@@ -718,8 +726,9 @@ sctp_csum_finalize(uint32_t crc32c)
 #endif
 	return (crc32c);
 }
+#endif
 
-uint32_t crc32c_le(uint32_t crc, unsigned char const *data, unsigned length)
+uint32_t ceph_crc32c_le(uint32_t crc, unsigned char const *data, unsigned length)
 {
 	return update_crc32(crc, data, length);
 }
diff --git a/wireshark/wireshark.patch b/wireshark/wireshark.patch
index eb765c9..2e3b873 100644
--- a/wireshark/wireshark.patch
+++ b/wireshark/wireshark.patch
@@ -26,24 +26,14 @@ Index: plugins/Makefile.nmake
 ===================================================================
 --- plugins/Makefile.nmake	(revision 29691)
 +++ plugins/Makefile.nmake	(working copy)
-@@ -33,6 +33,9 @@
- 	cd asn1
- 	$(MAKE) /$(MAKEFLAGS) -f Makefile.nmake $(PLUGIN_TARGET)
- 	cd ..
-+	cd ceph
-+	$(MAKE) /$(MAKEFLAGS) -f Makefile.nmake $(PLUGIN_TARGET)
-+	cd ..
- 	cd docsis
- 	$(MAKE) /$(MAKEFLAGS) -f Makefile.nmake $(PLUGIN_TARGET)
- 	cd ..
-@@ -86,6 +89,7 @@
- !IFDEF ENABLE_LIBWIRESHARK
- 	cd..
- 	xcopy plugins\asn1\*.dll $(INSTALL_DIR)\plugins\$(VERSION) /d
-+	xcopy plugins\ceph\*.dll $(INSTALL_DIR)\plugins\$(VERSION) /d
- 	xcopy plugins\docsis\*.dll $(INSTALL_DIR)\plugins\$(VERSION) /d
- 	xcopy plugins\ethercat\*.dll $(INSTALL_DIR)\plugins\$(VERSION) /d
- 	xcopy plugins\giop\*.dll $(INSTALL_DIR)\plugins\$(VERSION) /d
+@@ -8,6 +8,7 @@
+ 
+ PLUGIN_LIST = \
+	asn1        \
++	ceph        \
+	docsis      \
+	ethercat    \
+	giop        \
 Index: plugins/Makefile.am
 ===================================================================
 --- plugins/Makefile.am	(revision 29691)
-- 
1.7.5.4

