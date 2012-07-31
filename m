From: Sage Weil <sage@inktank.com>
Subject: [PATCH v2] ceph: simplify+fix atomic_open
Date: Mon, 30 Jul 2012 18:39:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207301831520.3171@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49359 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab2GaBjf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 21:39:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: miklos@szeredi.hu
Cc: ceph-devel@vger.kernel.org

Hi Miklos,

I've updated the ceph code to take better advantage of the new 
->atomic_open(), but ran into several bumps understanding the new 
interface.  If you don't mind, can you make sure I got it right?

Basically:

 - on success,
	return finish_open(original file, original dentry, ...)
 - on symlink,
	return finish_no_open(original file, original dentry)
 - if we have to splice in a different dentry (e.g., d_splice_alias()),
	return finish_no_open(original file, existing dentry)
 - on ENOENT,
 	return finish_no_open(original file, original negative dentry)

Basically, give finish_no_open whatever ->lookup() would have returned.  
Is that right?

Thanks!
sage

----

From bf9923b3c98dc14df4fad567862348a185368f76 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@inktank.com>
Date: Mon, 30 Jul 2012 16:36:26 -0700
Subject: [PATCH] ceph: simplify+fix atomic_open

The initial ->atomic_open op was carried over from the old intent code,
which was incomplete and didn't really work.  Replace it with a fresh
method.  In particular:

 * always attempt to do an atomic open+lookup, both for the create case
   and for lookups of existing files.
 * fix symlink handling by returning 1 to the VFS so that we can follow
   the link to its destination. This fixes a longstanding ceph bug (#2392).

Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/dir.c   |   38 ------------------------------------
 fs/ceph/file.c  |   57 ++++++++++++++++++++++++++++++------------------------
 fs/ceph/super.h |    6 ++--
 3 files changed, 35 insertions(+), 66 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f391f1e..e5b7731 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -633,44 +633,6 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	return dentry;
 }
 
-int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
-		     struct file *file, unsigned flags, umode_t mode,
-		     int *opened)
-{
-	int err;
-	struct dentry *res = NULL;
-
-	if (!(flags & O_CREAT)) {
-		if (dentry->d_name.len > NAME_MAX)
-			return -ENAMETOOLONG;
-
-		err = ceph_init_dentry(dentry);
-		if (err < 0)
-			return err;
-
-		return ceph_lookup_open(dir, dentry, file, flags, mode, opened);
-	}
-
-	if (d_unhashed(dentry)) {
-		res = ceph_lookup(dir, dentry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		if (res)
-			dentry = res;
-	}
-
-	/* We don't deal with positive dentries here */
-	if (dentry->d_inode)
-		return finish_no_open(file, res);
-
-	*opened |= FILE_CREATED;
-	err = ceph_lookup_open(dir, dentry, file, flags, mode, opened);
-	dput(res);
-
-	return err;
-}
-
 /*
  * If we do a create but get no trace back from the MDS, follow up with
  * a lookup (the VFS expects us to link up the provided dentry).
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 1b81d6c..f2c66eb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -4,6 +4,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/writeback.h>
 
@@ -106,9 +107,6 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * If the filp already has private_data, that means the file was
- * already opened by intent during lookup, and we do nothing.
- *
  * If we already have the requisite capabilities, we can satisfy
  * the open request locally (no need to request new caps from the
  * MDS).  We do, however, need to inform the MDS (asynchronously)
@@ -207,24 +205,29 @@ out:
 
 
 /*
- * Do a lookup + open with a single request.
- *
- * If this succeeds, but some subsequent check in the vfs
- * may_open() fails, the struct *file gets cleaned up (i.e.
- * ceph_release gets called).  So fear not!
+ * Do a lookup + open with a single request.  If we get a non-existent
+ * file or symlink, return 1 so the VFS can retry.
  */
-int ceph_lookup_open(struct inode *dir, struct dentry *dentry,
+int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode,
 		     int *opened)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
-	struct dentry *ret;
+	struct dentry *dn;
 	int err;
 
-	dout("ceph_lookup_open dentry %p '%.*s' flags %d mode 0%o\n",
-	     dentry, dentry->d_name.len, dentry->d_name.name, flags, mode);
+	dout("atomic_open %p dentry %p '%.*s' flags %d mode 0%o\n",
+	     dir, dentry, dentry->d_name.len, dentry->d_name.name,
+	     flags, mode);
+
+	if (dentry->d_name.len > NAME_MAX)
+		return -ENAMETOOLONG;
+
+	err = ceph_init_dentry(dentry);
+	if (err < 0)
+		return err;
 
 	/* do the open */
 	req = prepare_open_request(dir->i_sb, flags, mode);
@@ -241,22 +244,26 @@ int ceph_lookup_open(struct inode *dir, struct dentry *dentry,
 				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
 				   req);
 	err = ceph_handle_snapdir(req, dentry, err);
-	if (err)
-		goto out;
-	if ((flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
+	if (err == 0 && (flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
-	if (err)
-		goto out;
-	err = finish_open(file, req->r_dentry, ceph_open, opened);
-out:
-	ret = ceph_finish_lookup(req, dentry, err);
-	ceph_mdsc_put_request(req);
-	dout("ceph_lookup_open result=%p\n", ret);
 
-	if (IS_ERR(ret))
-		return PTR_ERR(ret);
+	dn = ceph_finish_lookup(req, dentry, err);
+	if (IS_ERR(dn)) {
+		err = PTR_ERR(dn);
+		goto out_err;
+	}
+	if (dn || dentry->d_inode == NULL || S_ISLNK(dentry->d_inode->i_mode)) {
+		/* make vfs retry on splice, ENOENT, or symlink */
+		dout("atomic_open finish_no_open on dn %p\n", dn);
+		err = finish_no_open(file, dn);
+	} else {
+		dout("atomic_open finish_open on dn %p\n", dn);
+		err = finish_open(file, dentry, ceph_open, opened);
+	}
 
-	dput(ret);
+out_err:
+	ceph_mdsc_put_request(req);
+	dout("atomic_open result=%d\n", err);
 	return err;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index ebc95cc..66ebe72 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -806,9 +806,9 @@ extern int ceph_copy_from_page_vector(struct page **pages,
 				    loff_t off, size_t len);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
 extern int ceph_open(struct inode *inode, struct file *file);
-extern int ceph_lookup_open(struct inode *dir, struct dentry *dentry,
-			     struct file *od, unsigned flags,
-			     umode_t mode, int *opened);
+extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
+			    struct file *file, unsigned flags, umode_t mode,
+			    int *opened);
 extern int ceph_release(struct inode *inode, struct file *filp);
 
 /* dir.c */
-- 
1.7.9

