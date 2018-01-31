From: jlayton@poochiereds.net
Subject: [nfs-ganesha RFC PATCH 1/6] SAL: make some rados_kv symbols public
Date: Wed, 31 Jan 2018 09:12:14 -0500
Message-ID: <20180131141219.16929-2-jlayton@poochiereds.net>
References: <20180131141219.16929-1-jlayton@poochiereds.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753195AbeAaOMY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:12:24 -0500
In-Reply-To: <20180131141219.16929-1-jlayton@poochiereds.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nfs-ganesha-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Change-Id: I3b3bcf6bf1c1100bc6a261030a0e93094a93b27e
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 src/SAL/recovery/recovery_rados.h    | 9 +++++++++
 src/SAL/recovery/recovery_rados_kv.c | 6 +++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/SAL/recovery/recovery_rados.h b/src/SAL/recovery/recovery_rados.h
index 93e13f7767ea..16aae1315220 100644
--- a/src/SAL/recovery/recovery_rados.h
+++ b/src/SAL/recovery/recovery_rados.h
@@ -28,6 +28,7 @@
 extern rados_t		rados_recov_cluster;
 extern rados_ioctx_t	rados_recov_io_ctx;
 extern char		rados_recov_oid[NI_MAXHOST];
+extern char		rados_recov_old_oid[NI_MAXHOST];
 
 struct rados_kv_parameter {
 	/** Connection to ceph cluster */
@@ -51,10 +52,18 @@ typedef struct pop_args {
 int rados_kv_connect(rados_ioctx_t *io_ctx, const char *userid,
 			const char *conf, const char *pool);
 void rados_kv_shutdown(void);
+int rados_kv_put(char *key, char *val, char *object);
 int rados_kv_get(char *key, char **val, size_t *val_len, char *object);
+void rados_kv_add_clid(nfs_client_id_t *clientid);
+void rados_kv_rm_clid(nfs_client_id_t *clientid);
+void rados_kv_add_revoke_fh(nfs_client_id_t *delr_clid, nfs_fh4 *delr_handle);
 void rados_kv_create_key(nfs_client_id_t *clientid, char *key);
 void rados_kv_create_val(nfs_client_id_t *clientid, char *val);
 int rados_kv_traverse(pop_clid_entry_t pop_func, pop_args_t pop_args,
 			const char *object);
 void rados_kv_append_val_rdfh(char *val, char *rdfh, int rdfh_len);
+void rados_kv_pop_clid_entry(char *key, char *val,
+				add_clid_entry_hook add_clid_entry,
+				add_rfh_entry_hook add_rfh_entry,
+				bool old, bool takeover);
 #endif	/* _RECOVERY_RADOS_H */
diff --git a/src/SAL/recovery/recovery_rados_kv.c b/src/SAL/recovery/recovery_rados_kv.c
index 78857f2aae72..55f0a25e182c 100644
--- a/src/SAL/recovery/recovery_rados_kv.c
+++ b/src/SAL/recovery/recovery_rados_kv.c
@@ -21,7 +21,7 @@
 static rados_t clnt;
 rados_ioctx_t rados_recov_io_ctx;
 char rados_recov_oid[NI_MAXHOST];
-static char rados_recov_old_oid[NI_MAXHOST];
+char rados_recov_old_oid[NI_MAXHOST];
 
 struct rados_kv_parameter rados_kv_param;
 
@@ -132,7 +132,7 @@ void rados_kv_create_val(nfs_client_id_t *clientid, char *val)
 		 clientid->cid_recov_tag);
 }
 
-static int rados_kv_put(char *key, char *val, char *object)
+int rados_kv_put(char *key, char *val, char *object)
 {
 	int ret;
 	char *keys[1];
@@ -444,7 +444,7 @@ void rados_kv_rm_clid(nfs_client_id_t *clientid)
 	clientid->cid_recov_tag = NULL;
 }
 
-static void rados_kv_pop_clid_entry(char *key,
+void rados_kv_pop_clid_entry(char *key,
 				    char *val,
 				    add_clid_entry_hook add_clid_entry,
 				    add_rfh_entry_hook add_rfh_entry,
-- 
2.14.3

