From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] ceph: check POOL_FLAG_FULL/NEARFULL in addition to OSDMAP_FULL/NEARFULL
Date: Mon, 16 Mar 2020 10:03:08 +0100
Message-ID: <20200316090308.29004-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgCPJDO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2020 05:03:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so17045581wmi.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2020 02:03:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Yanhu Cao <gmayyyha@gmail.com>, Jeff Layton <jlayton@kernel.org>

CEPH_OSDMAP_FULL/NEARFULL aren't set since mimic, so we need to consult
per-pool flags as well.  Unfortunately the backwards compatibility here
is lacking:

- the change that deprecated OSDMAP_FULL/NEARFULL went into mimic, but
  was guarded by require_osd_release >= RELEASE_LUMINOUS
- it was subsequently backported to luminous in v12.2.2, but that makes
  no difference to clients that only check OSDMAP_FULL/NEARFULL because
  require_osd_release is not client-facing -- it is for OSDs

Since all kernels are affected, the best we can do here is just start
checking both map flags and pool flags and send that to stable.

These checks are best effort, so take osdc->lock and look up pool flags
just once.  Remove the FIXME, since filesystem quotas are checked above
and RADOS quotas are reflected in POOL_FLAG_FULL: when the pool reaches
its quota, both POOL_FLAG_FULL and POOL_FLAG_FULL_QUOTA are set.

Cc: stable@vger.kernel.org
Reported-by: Yanhu Cao <gmayyyha@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/file.c              | 14 +++++++++++---
 include/linux/ceph/osdmap.h |  4 ++++
 include/linux/ceph/rados.h  |  6 ++++--
 net/ceph/osdmap.c           |  9 +++++++++
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index aa08fdff0d98..8e4002280c2b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1689,10 +1689,13 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
 	int err, want, got;
 	bool direct_lock = false;
+	u32 map_flags;
+	u64 pool_flags;
 	loff_t pos;
 	loff_t limit = max(i_size_read(inode), fsc->max_file_size);
 
@@ -1755,8 +1758,12 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 	}
 
-	/* FIXME: not complete since it doesn't account for being at quota */
-	if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL)) {
+	down_read(&osdc->lock);
+	map_flags = osdc->osdmap->flags;
+	pool_flags = ceph_pg_pool_flags(osdc->osdmap, ci->i_layout.pool_id);
+	up_read(&osdc->lock);
+	if ((map_flags & CEPH_OSDMAP_FULL) ||
+	    (pool_flags & CEPH_POOL_FLAG_FULL)) {
 		err = -ENOSPC;
 		goto out;
 	}
@@ -1849,7 +1856,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	if (written >= 0) {
-		if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_NEARFULL))
+		if ((map_flags & CEPH_OSDMAP_NEARFULL) ||
+		    (pool_flags & CEPH_POOL_FLAG_NEARFULL))
 			iocb->ki_flags |= IOCB_DSYNC;
 		written = generic_write_sync(iocb, written);
 	}
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index e081b56f1c1d..5e601975745f 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -37,6 +37,9 @@ int ceph_spg_compare(const struct ceph_spg *lhs, const struct ceph_spg *rhs);
 #define CEPH_POOL_FLAG_HASHPSPOOL	(1ULL << 0) /* hash pg seed and pool id
 						       together */
 #define CEPH_POOL_FLAG_FULL		(1ULL << 1) /* pool is full */
+#define CEPH_POOL_FLAG_FULL_QUOTA	(1ULL << 10) /* pool ran out of quota,
+							will set FULL too */
+#define CEPH_POOL_FLAG_NEARFULL		(1ULL << 11) /* pool is nearfull */
 
 struct ceph_pg_pool_info {
 	struct rb_node node;
@@ -304,5 +307,6 @@ extern struct ceph_pg_pool_info *ceph_pg_pool_by_id(struct ceph_osdmap *map,
 
 extern const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64 id);
 extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name);
+u64 ceph_pg_pool_flags(struct ceph_osdmap *map, u64 id);
 
 #endif
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 59bdfd470100..88ed3c5c04c5 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -143,8 +143,10 @@ extern const char *ceph_osd_state_name(int s);
 /*
  * osd map flag bits
  */
-#define CEPH_OSDMAP_NEARFULL (1<<0)  /* sync writes (near ENOSPC) */
-#define CEPH_OSDMAP_FULL     (1<<1)  /* no data writes (ENOSPC) */
+#define CEPH_OSDMAP_NEARFULL (1<<0)  /* sync writes (near ENOSPC),
+					not set since ~luminous */
+#define CEPH_OSDMAP_FULL     (1<<1)  /* no data writes (ENOSPC),
+					not set since ~luminous */
 #define CEPH_OSDMAP_PAUSERD  (1<<2)  /* pause all reads */
 #define CEPH_OSDMAP_PAUSEWR  (1<<3)  /* pause all writes */
 #define CEPH_OSDMAP_PAUSEREC (1<<4)  /* pause recovery */
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 4e0de14f80bb..2a6e63a8edbe 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -710,6 +710,15 @@ int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name)
 }
 EXPORT_SYMBOL(ceph_pg_poolid_by_name);
 
+u64 ceph_pg_pool_flags(struct ceph_osdmap *map, u64 id)
+{
+	struct ceph_pg_pool_info *pi;
+
+	pi = __lookup_pg_pool(&map->pg_pools, id);
+	return pi ? pi->flags : 0;
+}
+EXPORT_SYMBOL(ceph_pg_pool_flags);
+
 static void __remove_pg_pool(struct rb_root *root, struct ceph_pg_pool_info *pi)
 {
 	rb_erase(&pi->node, root);
-- 
2.19.2
