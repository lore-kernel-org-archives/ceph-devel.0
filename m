From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/2] libceph: all features fields must be u64
Date: Tue, 24 Dec 2013 21:41:51 +0200
Message-ID: <1387914112-17809-2-git-send-email-ilya.dryomov@inktank.com>
References: <1387914112-17809-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:58814 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab3LXTmo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Dec 2013 14:42:44 -0500
Received: by mail-ea0-f169.google.com with SMTP id l9so2603014eaj.14
        for <ceph-devel@vger.kernel.org>; Tue, 24 Dec 2013 11:42:43 -0800 (PST)
In-Reply-To: <1387914112-17809-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

In preparation for ceph_features.h update, change all features fields
from unsigned int/u32 to u64.  (ceph.git has ~40 feature bits at this
point.)

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 fs/ceph/mds_client.c           |   14 +++++++-------
 fs/ceph/super.c                |    4 ++--
 include/linux/ceph/libceph.h   |    8 ++++----
 include/linux/ceph/messenger.h |   10 +++++-----
 net/ceph/ceph_common.c         |    4 ++--
 net/ceph/messenger.c           |    4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d90861f45210..4a13f6e72069 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -63,7 +63,7 @@ static const struct ceph_connection_operations mds_con_ops;
  */
 static int parse_reply_info_in(void **p, void *end,
 			       struct ceph_mds_reply_info_in *info,
-			       int features)
+			       u64 features)
 {
 	int err = -EIO;
 
@@ -98,7 +98,7 @@ bad:
  */
 static int parse_reply_info_trace(void **p, void *end,
 				  struct ceph_mds_reply_info_parsed *info,
-				  int features)
+				  u64 features)
 {
 	int err;
 
@@ -145,7 +145,7 @@ out_bad:
  */
 static int parse_reply_info_dir(void **p, void *end,
 				struct ceph_mds_reply_info_parsed *info,
-				int features)
+				u64 features)
 {
 	u32 num, i = 0;
 	int err;
@@ -217,7 +217,7 @@ out_bad:
  */
 static int parse_reply_info_filelock(void **p, void *end,
 				     struct ceph_mds_reply_info_parsed *info,
-				     int features)
+				     u64 features)
 {
 	if (*p + sizeof(*info->filelock_reply) > end)
 		goto bad;
@@ -238,7 +238,7 @@ bad:
  */
 static int parse_reply_info_create(void **p, void *end,
 				  struct ceph_mds_reply_info_parsed *info,
-				  int features)
+				  u64 features)
 {
 	if (features & CEPH_FEATURE_REPLY_CREATE_INODE) {
 		if (*p == end) {
@@ -262,7 +262,7 @@ bad:
  */
 static int parse_reply_info_extra(void **p, void *end,
 				  struct ceph_mds_reply_info_parsed *info,
-				  int features)
+				  u64 features)
 {
 	if (info->head->op == CEPH_MDS_OP_GETFILELOCK)
 		return parse_reply_info_filelock(p, end, info, features);
@@ -280,7 +280,7 @@ static int parse_reply_info_extra(void **p, void *end,
  */
 static int parse_reply_info(struct ceph_msg *msg,
 			    struct ceph_mds_reply_info_parsed *info,
-			    int features)
+			    u64 features)
 {
 	void *p, *end;
 	u32 len;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c6740e43a351..2df963f1cf5a 100644
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
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 2e3024881a5e..7d704db60cbb 100644
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
index 7c1420bb1dce..c1d3f5a65273 100644
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
@@ -192,7 +192,7 @@ struct ceph_connection {
 
 	struct ceph_entity_name peer_name; /* peer name */
 
-	unsigned peer_features;
+	u64 peer_features;
 	u32 connect_seq;      /* identify the most recent connection
 				 attempt for this connection, client */
 	u32 peer_global_seq;  /* peer's global seq for this connection */
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
index 34b11ee8124e..43d8177a52e1 100644
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
index 4a5df7b1cc9f..260670558746 100644
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
1.7.10.4

