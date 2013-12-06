From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/12] libceph: define {required,supported}_features as u64
Date: Fri,  6 Dec 2013 16:46:33 +0800
Message-ID: <1386319603-2610-3-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23353 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757148Ab3LFIqu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:50 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/super.c                    |  4 +--
 include/linux/ceph/ceph_features.h | 67 ++++++++++++++++++++------------------
 include/linux/ceph/libceph.h       |  8 ++---
 include/linux/ceph/messenger.h     |  8 ++---
 net/ceph/ceph_common.c             |  4 +--
 net/ceph/messenger.c               |  4 +--
 6 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index e58bd4a..7567a54 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -490,10 +490,10 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 					struct ceph_options *opt)
 {
 	struct ceph_fs_client *fsc;
-	const unsigned supported_features =
+	const u64 supported_features =
 		CEPH_FEATURE_FLOCK |
 		CEPH_FEATURE_DIRLAYOUTHASH;
-	const unsigned required_features = 0;
+	const u64 required_features = 0;
 	int page_count;
 	size_t size;
 	int err = -ENOMEM;
diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 4c420803..bd11e55 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -4,37 +4,42 @@
 /*
  * feature bits
  */
-#define CEPH_FEATURE_UID            (1<<0)
-#define CEPH_FEATURE_NOSRCADDR      (1<<1)
-#define CEPH_FEATURE_MONCLOCKCHECK  (1<<2)
-#define CEPH_FEATURE_FLOCK          (1<<3)
-#define CEPH_FEATURE_SUBSCRIBE2     (1<<4)
-#define CEPH_FEATURE_MONNAMES       (1<<5)
-#define CEPH_FEATURE_RECONNECT_SEQ  (1<<6)
-#define CEPH_FEATURE_DIRLAYOUTHASH  (1<<7)
-#define CEPH_FEATURE_OBJECTLOCATOR  (1<<8)
-#define CEPH_FEATURE_PGID64         (1<<9)
-#define CEPH_FEATURE_INCSUBOSDMAP   (1<<10)
-#define CEPH_FEATURE_PGPOOL3        (1<<11)
-#define CEPH_FEATURE_OSDREPLYMUX    (1<<12)
-#define CEPH_FEATURE_OSDENC         (1<<13)
-#define CEPH_FEATURE_OMAP           (1<<14)
-#define CEPH_FEATURE_MONENC         (1<<15)
-#define CEPH_FEATURE_QUERY_T        (1<<16)
-#define CEPH_FEATURE_INDEP_PG_MAP   (1<<17)
-#define CEPH_FEATURE_CRUSH_TUNABLES (1<<18)
-#define CEPH_FEATURE_CHUNKY_SCRUB   (1<<19)
-#define CEPH_FEATURE_MON_NULLROUTE  (1<<20)
-#define CEPH_FEATURE_MON_GV         (1<<21)
-#define CEPH_FEATURE_BACKFILL_RESERVATION (1<<22)
-#define CEPH_FEATURE_MSG_AUTH	    (1<<23)
-#define CEPH_FEATURE_RECOVERY_RESERVATION (1<<24)
-#define CEPH_FEATURE_CRUSH_TUNABLES2 (1<<25)
-#define CEPH_FEATURE_CREATEPOOLID   (1<<26)
-#define CEPH_FEATURE_REPLY_CREATE_INODE   (1<<27)
-#define CEPH_FEATURE_OSD_HBMSGS     (1<<28)
-#define CEPH_FEATURE_MDSENC         (1<<29)
-#define CEPH_FEATURE_OSDHASHPSPOOL  (1<<30)
+#define CEPH_FEATURE_UID            (1ULL<<0)
+#define CEPH_FEATURE_NOSRCADDR      (1ULL<<1)
+#define CEPH_FEATURE_MONCLOCKCHECK  (1ULL<<2)
+#define CEPH_FEATURE_FLOCK          (1ULL<<3)
+#define CEPH_FEATURE_SUBSCRIBE2     (1ULL<<4)
+#define CEPH_FEATURE_MONNAMES       (1ULL<<5)
+#define CEPH_FEATURE_RECONNECT_SEQ  (1ULL<<6)
+#define CEPH_FEATURE_DIRLAYOUTHASH  (1ULL<<7)
+#define CEPH_FEATURE_OBJECTLOCATOR  (1ULL<<8)
+#define CEPH_FEATURE_PGID64         (1ULL<<9)
+#define CEPH_FEATURE_INCSUBOSDMAP   (1ULL<<10)
+#define CEPH_FEATURE_PGPOOL3        (1ULL<<11)
+#define CEPH_FEATURE_OSDREPLYMUX    (1ULL<<12)
+#define CEPH_FEATURE_OSDENC         (1ULL<<13)
+#define CEPH_FEATURE_OMAP           (1ULL<<14)
+#define CEPH_FEATURE_MONENC         (1ULL<<15)
+#define CEPH_FEATURE_QUERY_T        (1ULL<<16)
+#define CEPH_FEATURE_INDEP_PG_MAP   (1ULL<<17)
+#define CEPH_FEATURE_CRUSH_TUNABLES (1ULL<<18)
+#define CEPH_FEATURE_CHUNKY_SCRUB   (1ULL<<19)
+#define CEPH_FEATURE_MON_NULLROUTE  (1ULL<<20)
+#define CEPH_FEATURE_MON_GV         (1ULL<<21)
+#define CEPH_FEATURE_BACKFILL_RESERVATION (1ULL<<22)
+#define CEPH_FEATURE_MSG_AUTH	    (1ULL<<23)
+#define CEPH_FEATURE_RECOVERY_RESERVATION (1ULL<<24)
+#define CEPH_FEATURE_CRUSH_TUNABLES2 (1ULL<<25)
+#define CEPH_FEATURE_CREATEPOOLID   (1ULL<<26)
+#define CEPH_FEATURE_REPLY_CREATE_INODE   (1ULL<<27)
+#define CEPH_FEATURE_OSD_HBMSGS     (1ULL<<28)
+#define CEPH_FEATURE_MDSENC         (1ULL<<29)
+#define CEPH_FEATURE_OSDHASHPSPOOL  (1ULL<<30)
+#define CEPH_FEATURE_MON_SINGLE_PAXOS (1ULL<<31)
+#define CEPH_FEATURE_OSD_SNAPMAPPER (1ULL<<32)
+#define CEPH_FEATURE_MON_SCRUB      (1ULL<<33)
+#define CEPH_FEATURE_OSD_PACKED_RECOVERY (1ULL<<34)
+#define CEPH_FEATURE_OSD_CACHEPOOL (1ULL<<35)
 
 /*
  * Features supported.
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 2e30248..7d704db 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -122,8 +122,8 @@ struct ceph_client {
 
 	int (*extra_mon_dispatch)(struct ceph_client *, struct ceph_msg *);
 
-	u32 supported_features;
-	u32 required_features;
+	u64 supported_features;
+	u64 required_features;
 
 	struct ceph_messenger msgr;   /* messenger instance */
 	struct ceph_mon_client monc;
@@ -192,8 +192,8 @@ extern int ceph_compare_options(struct ceph_options *new_opt,
 				struct ceph_client *client);
 extern struct ceph_client *ceph_create_client(struct ceph_options *opt,
 					      void *private,
-					      unsigned supported_features,
-					      unsigned required_features);
+					      u64 supported_features,
+					      u64 required_features);
 extern u64 ceph_client_id(struct ceph_client *client);
 extern void ceph_destroy_client(struct ceph_client *client);
 extern int __ceph_open_session(struct ceph_client *client,
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 7c1420b..83bb654 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -60,8 +60,8 @@ struct ceph_messenger {
 	u32 global_seq;
 	spinlock_t global_seq_lock;
 
-	u32 supported_features;
-	u32 required_features;
+	u64 supported_features;
+	u64 required_features;
 };
 
 enum ceph_msg_data_type {
@@ -256,8 +256,8 @@ extern void ceph_msgr_flush(void);
 
 extern void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
-			u32 supported_features,
-			u32 required_features,
+			u64 supported_features,
+			u64 required_features,
 			bool nocrc);
 
 extern void ceph_con_init(struct ceph_connection *con, void *private,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 34b11ee..43d8177 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -461,8 +461,8 @@ EXPORT_SYMBOL(ceph_client_id);
  * create a fresh client instance
  */
 struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
-				       unsigned int supported_features,
-				       unsigned int required_features)
+				       u64 supported_features,
+				       u64 required_features)
 {
 	struct ceph_client *client;
 	struct ceph_entity_addr *myaddr = NULL;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 4a5df7b..2606705 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2853,8 +2853,8 @@ static void con_fault(struct ceph_connection *con)
  */
 void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
-			u32 supported_features,
-			u32 required_features,
+			u64 supported_features,
+			u64 required_features,
 			bool nocrc)
 {
 	msgr->supported_features = supported_features;
-- 
1.8.1.4

