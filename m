From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/2] ceph: avoid dereferencing invalid pointer during cached readdir
Date: Tue,  5 Dec 2017 09:51:35 +0800
Message-ID: <20171205015135.12944-2-zyan@redhat.com>
References: <20171205015135.12944-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31123 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751744AbdLEBvq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Dec 2017 20:51:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCEB481DF6
        for <ceph-devel@vger.kernel.org>; Tue,  5 Dec 2017 01:51:45 +0000 (UTC)
In-Reply-To: <20171205015135.12944-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

Readdir cache keeps array of dentry pointers in page cache. If any
dentry in readdir cache gets pruned, ceph_d_prune() disables readdir
cache for later readdir syscall. The problem is that ceph_d_prune()
ignores unhashed dentry. Ideally MDS should have already revoked
CEPH_CAP_FILE_SHARED (which also disables readdir cache) when dentry
gets unhashed. But if it is somehow MDS does not properly revoke
CEPH_CAP_FILE_SHARED and the unhashed dentry gets pruned later,
ceph_d_prune() will not disable readdir cache, later readdir may
reference invalid dentry pointer.

The fix is make ceph_d_prune() do extra check for unhashed dentry.
Disable readdir cache if the unhashed dentry is still referenced
by readdir cache.

Another fix in this patch is handle d_splice_alias(). If a dentry
gets spliced into new parent dentry, treat it as if it was pruned
(call ceph_d_prune() for it).

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/dir.c   | 46 +++++++++++++++++++++++++++++++++-------------
 fs/ceph/inode.c | 40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0a23a4d9fde8..793306f5352c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -231,11 +231,17 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 			goto out;
 		}
 
-		di = ceph_dentry(dentry);
 		spin_lock(&dentry->d_lock);
-		if (di->lease_shared_gen == shared_gen &&
-		    d_really_is_positive(dentry) &&
-		    fpos_cmp(ctx->pos, di->offset) <= 0) {
+		di = ceph_dentry(dentry);
+		if (d_unhashed(dentry) ||
+		    d_really_is_negative(dentry) ||
+		    di->lease_shared_gen != shared_gen) {
+			spin_unlock(&dentry->d_lock);
+			dput(dentry);
+			err = -EAGAIN;
+			goto out;
+		}
+		if (fpos_cmp(ctx->pos, di->offset) <= 0) {
 			emit_dentry = true;
 		}
 		spin_unlock(&dentry->d_lock);
@@ -1324,24 +1330,38 @@ static void ceph_d_release(struct dentry *dentry)
  */
 static void ceph_d_prune(struct dentry *dentry)
 {
-	dout("ceph_d_prune %p\n", dentry);
+	struct inode *dir;
+	struct ceph_dentry_info *di;
+
+	dout("ceph_d_prune %pd %p\n", dentry, dentry);
 
 	/* do we have a valid parent? */
 	if (IS_ROOT(dentry))
 		return;
 
-	/* if we are not hashed, we don't affect dir's completeness */
-	if (d_unhashed(dentry))
+	/* we hold d_lock, so d_parent is stable */
+	dir = d_inode(dentry->d_parent);
+	if (ceph_snap(dir) == CEPH_SNAPDIR)
 		return;
 
-	if (ceph_snap(d_inode(dentry->d_parent)) == CEPH_SNAPDIR)
+	/* who calls d_delete() should also disable dcache readdir */
+	if (d_really_is_negative(dentry))
 		return;
 
-	/*
-	 * we hold d_lock, so d_parent is stable, and d_fsdata is never
-	 * cleared until d_release
-	 */
-	ceph_dir_clear_complete(d_inode(dentry->d_parent));
+	/* d_fsdata does not get cleared until d_release */
+	if (!d_unhashed(dentry)) {
+		ceph_dir_clear_complete(dir);
+		return;
+	}
+
+	/* Disable dcache readdir just in case that someone called d_drop()
+	 * or d_invalidate(), but MDS didn't revoke CEPH_CAP_FILE_SHARED
+	 * properly (dcache readdir is still enabled) */
+	di = ceph_dentry(dentry);
+	if (di->offset > 0 &&
+	    di->lease_shared_gen ==
+	    atomic64_read(&ceph_inode(dir)->i_shared_gen))
+		ceph_dir_clear_ordered(dir);
 }
 
 /*
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a9de83f012bf..01e5b460efb8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1080,6 +1080,27 @@ static struct dentry *splice_dentry(struct dentry *dn, struct inode *in)
 
 	BUG_ON(d_inode(dn));
 
+	if (S_ISDIR(in->i_mode)) {
+		/* If inode is directory, d_splice_alias() below will remove
+		 * 'realdn' from its origin parent. We need to ensure that
+		 * origin parent's readdir cache will not reference 'realdn'
+		 */
+		realdn = d_find_any_alias(in);
+		if (realdn) {
+			struct ceph_dentry_info *di = ceph_dentry(realdn);
+			spin_lock(&realdn->d_lock);
+
+			realdn->d_op->d_prune(realdn);
+
+			di->time = jiffies;
+			di->lease_shared_gen = 0;
+			di->offset = 0;
+
+			spin_unlock(&realdn->d_lock);
+			dput(realdn);
+		}
+	}
+
 	/* dn must be unhashed */
 	if (!d_unhashed(dn))
 		d_drop(dn);
@@ -1295,8 +1316,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		if (!rinfo->head->is_target) {
 			dout("fill_trace null dentry\n");
 			if (d_really_is_positive(dn)) {
-				ceph_dir_clear_ordered(dir);
 				dout("d_delete %p\n", dn);
+				ceph_dir_clear_ordered(dir);
 				d_delete(dn);
 			} else if (have_lease) {
 				if (d_unhashed(dn))
@@ -1323,7 +1344,6 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			dout(" %p links to %p %llx.%llx, not %llx.%llx\n",
 			     dn, d_inode(dn), ceph_vinop(d_inode(dn)),
 			     ceph_vinop(in));
-			ceph_dir_clear_ordered(dir);
 			d_invalidate(dn);
 			have_lease = false;
 		}
@@ -1573,9 +1593,19 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		} else if (d_really_is_positive(dn) &&
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
+			struct ceph_dentry_info *di = ceph_dentry(dn);
 			dout(" dn %p points to wrong inode %p\n",
 			     dn, d_inode(dn));
-			__ceph_dir_clear_ordered(ci);
+
+			spin_lock(&dn->d_lock);
+			if (di->offset > 0 &&
+			    di->lease_shared_gen ==
+			    atomic64_read(&ci->i_shared_gen)) {
+				__ceph_dir_clear_ordered(ci);
+				di->offset = 0;
+			}
+			spin_unlock(&dn->d_lock);
+
 			d_delete(dn);
 			dput(dn);
 			goto retry_lookup;
@@ -1600,9 +1630,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 				 &req->r_caps_reservation);
 		if (ret < 0) {
 			pr_err("fill_inode badness on %p\n", in);
-			if (d_really_is_positive(dn))
-				__ceph_dir_clear_ordered(ci);
-			else
+			if (d_really_is_negative(dn))
 				iput(in);
 			d_drop(dn);
 			err = ret;
-- 
2.13.6

