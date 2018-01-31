From: jlayton@poochiereds.net
Subject: [nfs-ganesha RFC PATCH 2/6] SAL: add new try_lift_grace recovery operation
Date: Wed, 31 Jan 2018 09:12:15 -0500
Message-ID: <20180131141219.16929-3-jlayton@poochiereds.net>
References: <20180131141219.16929-1-jlayton@poochiereds.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753184AbeAaOMZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:12:25 -0500
In-Reply-To: <20180131141219.16929-1-jlayton@poochiereds.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nfs-ganesha-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

When running in a clustered environment, we can't just lift the grace
period once the local machine is ready. We must instead wait until no
other cluster nodes still need it.

Add a new can_lift_grace op, and use that to do extra vetting before
allowing the local grace period to be lifted. If it returns true, then
we can go ahead and lift the grace period.

Change-Id: Ic8060a083ac9d8581d78357ab7f1351793625264
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 src/SAL/nfs4_recovery.c              | 27 ++++++++++++++++++++++++---
 src/SAL/recovery/recovery_fs.c       |  1 +
 src/SAL/recovery/recovery_fs_ng.c    |  1 +
 src/SAL/recovery/recovery_rados_kv.c |  1 +
 src/SAL/recovery/recovery_rados_ng.c |  1 +
 src/include/sal_functions.h          |  2 ++
 6 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/src/SAL/nfs4_recovery.c b/src/SAL/nfs4_recovery.c
index 06b3e0ab77e5..619352f02575 100644
--- a/src/SAL/nfs4_recovery.c
+++ b/src/SAL/nfs4_recovery.c
@@ -196,12 +196,31 @@ bool nfs_in_grace(void)
 	return atomic_fetch_time_t(&current_grace);
 }
 
+/**
+ * @brief Determine whether we can lift the grace period
+ *
+ * @retval true if so
+ * @retval false if not
+ *
+ * In a clustered environment, we must take care not to lift the grace period
+ * until it's no longer needed cluster-wide. Try to lift the grace period, and
+ * return true or false depending on whether it succeeded.
+ *
+ * In the case of a single host, we always assume that the grace period can
+ * be lifted.
+ */
+bool simple_try_lift_grace(void)
+{
+	return true;
+}
+
 void nfs_try_lift_grace(void)
 {
 	bool in_grace = true;
 	int32_t rc_count = 0;
 	time_t current = atomic_fetch_time_t(&current_grace);
 
+	/* Already lifted? Just return */
 	if (!current)
 		return;
 
@@ -223,9 +242,11 @@ void nfs_try_lift_grace(void)
 	 * try to do it.
 	 */
 	if (!in_grace) {
-		PTHREAD_MUTEX_lock(&grace_mutex);
-		nfs_lift_grace_locked(current);
-		PTHREAD_MUTEX_unlock(&grace_mutex);
+		if (recovery_backend->try_lift_grace()) {
+			PTHREAD_MUTEX_lock(&grace_mutex);
+			nfs_lift_grace_locked(current);
+			PTHREAD_MUTEX_unlock(&grace_mutex);
+		}
 	}
 }
 
diff --git a/src/SAL/recovery/recovery_fs.c b/src/SAL/recovery/recovery_fs.c
index fe8cdcd7e171..fc1e3429d3f3 100644
--- a/src/SAL/recovery/recovery_fs.c
+++ b/src/SAL/recovery/recovery_fs.c
@@ -784,6 +784,7 @@ struct nfs4_recovery_backend fs_backend = {
 	.add_clid = fs_add_clid,
 	.rm_clid = fs_rm_clid,
 	.add_revoke_fh = fs_add_revoke_fh,
+	.try_lift_grace = simple_try_lift_grace,
 };
 
 void fs_backend_init(struct nfs4_recovery_backend **backend)
diff --git a/src/SAL/recovery/recovery_fs_ng.c b/src/SAL/recovery/recovery_fs_ng.c
index 2e7b2968dbf3..4b11d58128f4 100644
--- a/src/SAL/recovery/recovery_fs_ng.c
+++ b/src/SAL/recovery/recovery_fs_ng.c
@@ -377,6 +377,7 @@ static struct nfs4_recovery_backend fs_ng_backend = {
 	.add_clid = fs_add_clid,
 	.rm_clid = fs_rm_clid,
 	.add_revoke_fh = fs_add_revoke_fh,
+	.try_lift_grace = simple_try_lift_grace,
 };
 
 void fs_ng_backend_init(struct nfs4_recovery_backend **backend)
diff --git a/src/SAL/recovery/recovery_rados_kv.c b/src/SAL/recovery/recovery_rados_kv.c
index 55f0a25e182c..bb6f70c76b41 100644
--- a/src/SAL/recovery/recovery_rados_kv.c
+++ b/src/SAL/recovery/recovery_rados_kv.c
@@ -601,6 +601,7 @@ struct nfs4_recovery_backend rados_kv_backend = {
 	.add_clid = rados_kv_add_clid,
 	.rm_clid = rados_kv_rm_clid,
 	.add_revoke_fh = rados_kv_add_revoke_fh,
+	.try_lift_grace = simple_try_lift_grace,
 };
 
 void rados_kv_backend_init(struct nfs4_recovery_backend **backend)
diff --git a/src/SAL/recovery/recovery_rados_ng.c b/src/SAL/recovery/recovery_rados_ng.c
index 7e71812df48d..91b2b5ff0837 100644
--- a/src/SAL/recovery/recovery_rados_ng.c
+++ b/src/SAL/recovery/recovery_rados_ng.c
@@ -318,6 +318,7 @@ struct nfs4_recovery_backend rados_ng_backend = {
 	.add_clid = rados_ng_add_clid,
 	.rm_clid = rados_ng_rm_clid,
 	.add_revoke_fh = rados_ng_add_revoke_fh,
+	.try_lift_grace = simple_try_lift_grace,
 };
 
 void rados_ng_backend_init(struct nfs4_recovery_backend **backend)
diff --git a/src/include/sal_functions.h b/src/include/sal_functions.h
index 4ae9826a55cc..259d911254a9 100644
--- a/src/include/sal_functions.h
+++ b/src/include/sal_functions.h
@@ -967,6 +967,7 @@ void blocked_lock_polling(struct fridgethr_context *ctx);
 
 void nfs_start_grace(nfs_grace_start_t *gsp);
 bool nfs_in_grace(void);
+bool simple_try_lift_grace(void);
 void nfs_try_lift_grace(void);
 void nfs4_add_clid(nfs_client_id_t *);
 void nfs4_rm_clid(nfs_client_id_t *);
@@ -1012,6 +1013,7 @@ struct nfs4_recovery_backend {
 	void (*add_clid)(nfs_client_id_t *);
 	void (*rm_clid)(nfs_client_id_t *);
 	void (*add_revoke_fh)(nfs_client_id_t *, nfs_fh4 *);
+	bool (*try_lift_grace)(void);
 };
 
 void fs_backend_init(struct nfs4_recovery_backend **);
-- 
2.14.3

