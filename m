From: Yanhu Cao <gmayyyha@gmail.com>
Subject: [v2] ceph: using POOL FULL flag instead of OSDMAP FULL flag
Date: Tue,  3 Mar 2020 17:33:27 +0800
Message-ID: <20200303093327.8720-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, davem@davemloft.net, kuba@kernel.org, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>
List-Id: ceph-devel.vger.kernel.org

CEPH_OSDMAP_FULL/NEARFULL has been deprecated since mimic, so it
does not work well in new versions, added POOL flags to handle it.

Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
---
 fs/ceph/file.c                  |  9 +++++++--
 include/linux/ceph/osd_client.h |  2 ++
 include/linux/ceph/osdmap.h     |  3 ++-
 net/ceph/osd_client.c           | 23 +++++++++++++----------
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7e0190b1f821..84ec44f9d77a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1482,7 +1482,9 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* FIXME: not complete since it doesn't account for being at quota */
-	if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL)) {
+	if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL) ||
+	    pool_flag(&fsc->client->osdc, ci->i_layout.pool_id,
+						CEPH_POOL_FLAG_FULL)) {
 		err = -ENOSPC;
 		goto out;
 	}
@@ -1575,7 +1577,10 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	if (written >= 0) {
-		if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_NEARFULL))
+		if (ceph_osdmap_flag(&fsc->client->osdc,
+					CEPH_OSDMAP_NEARFULL) ||
+		    pool_flag(&fsc->client->osdc, ci->i_layout.pool_id,
+					CEPH_POOL_FLAG_NEARFULL))
 			iocb->ki_flags |= IOCB_DSYNC;
 		written = generic_write_sync(iocb, written);
 	}
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 5a62dbd3f4c2..be9007b93862 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -375,6 +375,8 @@ static inline bool ceph_osdmap_flag(struct ceph_osd_client *osdc, int flag)
 	return osdc->osdmap->flags & flag;
 }
 
+bool pool_flag(struct ceph_osd_client *osdc, s64 pool_id, int flag);
+
 extern int ceph_osdc_setup(void);
 extern void ceph_osdc_cleanup(void);
 
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index e081b56f1c1d..88faacc11f55 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -36,7 +36,8 @@ int ceph_spg_compare(const struct ceph_spg *lhs, const struct ceph_spg *rhs);
 
 #define CEPH_POOL_FLAG_HASHPSPOOL	(1ULL << 0) /* hash pg seed and pool id
 						       together */
-#define CEPH_POOL_FLAG_FULL		(1ULL << 1) /* pool is full */
+#define CEPH_POOL_FLAG_FULL		(1ULL << 1)  /* pool is full */
+#define CEPH_POOL_FLAG_NEARFULL	(1ULL << 11) /* pool is nearfull */
 
 struct ceph_pg_pool_info {
 	struct rb_node node;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b68b376d8c2f..9ad2b96c3e78 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1447,9 +1447,9 @@ static void unlink_request(struct ceph_osd *osd, struct ceph_osd_request *req)
 		atomic_dec(&osd->o_osdc->num_homeless);
 }
 
-static bool __pool_full(struct ceph_pg_pool_info *pi)
+static bool __pool_flag(struct ceph_pg_pool_info *pi, int flag)
 {
-	return pi->flags & CEPH_POOL_FLAG_FULL;
+	return pi->flags & flag;
 }
 
 static bool have_pool_full(struct ceph_osd_client *osdc)
@@ -1460,14 +1460,14 @@ static bool have_pool_full(struct ceph_osd_client *osdc)
 		struct ceph_pg_pool_info *pi =
 		    rb_entry(n, struct ceph_pg_pool_info, node);
 
-		if (__pool_full(pi))
+		if (__pool_flag(pi, CEPH_POOL_FLAG_FULL))
 			return true;
 	}
 
 	return false;
 }
 
-static bool pool_full(struct ceph_osd_client *osdc, s64 pool_id)
+bool pool_flag(struct ceph_osd_client *osdc, s64 pool_id, int flag)
 {
 	struct ceph_pg_pool_info *pi;
 
@@ -1475,8 +1475,10 @@ static bool pool_full(struct ceph_osd_client *osdc, s64 pool_id)
 	if (!pi)
 		return false;
 
-	return __pool_full(pi);
+	return __pool_flag(pi, flag);
 }
+EXPORT_SYMBOL(pool_flag);
+
 
 /*
  * Returns whether a request should be blocked from being sent
@@ -1489,7 +1491,7 @@ static bool target_should_be_paused(struct ceph_osd_client *osdc,
 	bool pauserd = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD);
 	bool pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		       ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
-		       __pool_full(pi);
+		       __pool_flag(pi, CEPH_POOL_FLAG_FULL);
 
 	WARN_ON(pi->id != t->target_oloc.pool);
 	return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
@@ -2320,7 +2322,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 		   !(req->r_flags & (CEPH_OSD_FLAG_FULL_TRY |
 				     CEPH_OSD_FLAG_FULL_FORCE)) &&
 		   (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
-		    pool_full(osdc, req->r_t.base_oloc.pool))) {
+		   pool_flag(osdc, req->r_t.base_oloc.pool,
+			     CEPH_POOL_FLAG_FULL))) {
 		dout("req %p full/pool_full\n", req);
 		if (ceph_test_opt(osdc->client, ABORT_ON_FULL)) {
 			err = -ENOSPC;
@@ -2539,7 +2542,7 @@ static int abort_on_full_fn(struct ceph_osd_request *req, void *arg)
 
 	if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
 	    (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
-	     pool_full(osdc, req->r_t.base_oloc.pool))) {
+	     pool_flag(osdc, req->r_t.base_oloc.pool, CEPH_POOL_FLAG_FULL))) {
 		if (!*victims) {
 			update_epoch_barrier(osdc, osdc->osdmap->epoch);
 			*victims = true;
@@ -3707,7 +3710,7 @@ static void set_pool_was_full(struct ceph_osd_client *osdc)
 		struct ceph_pg_pool_info *pi =
 		    rb_entry(n, struct ceph_pg_pool_info, node);
 
-		pi->was_full = __pool_full(pi);
+		pi->was_full = __pool_flag(pi, CEPH_POOL_FLAG_FULL);
 	}
 }
 
@@ -3719,7 +3722,7 @@ static bool pool_cleared_full(struct ceph_osd_client *osdc, s64 pool_id)
 	if (!pi)
 		return false;
 
-	return pi->was_full && !__pool_full(pi);
+	return pi->was_full && !__pool_flag(pi, CEPH_POOL_FLAG_FULL);
 }
 
 static enum calc_target_result
-- 
2.21.1
