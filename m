From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 06/12] ceph: use getattr request to fetch inline data
Date: Mon, 17 Nov 2014 15:57:00 +0800
Message-ID: <1416211026-11524-7-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKQH54 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:57:56 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Add a new parameter 'locked_page' to ceph_do_getattr(). If inline data
in getattr reply will be copied to the page.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/inode.c              | 34 +++++++++++++++++++++++++---------
 fs/ceph/mds_client.h         |  1 +
 fs/ceph/super.h              |  7 ++++++-
 include/linux/ceph/ceph_fs.h |  2 ++
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index feea6a8..0bdabd1 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -659,7 +659,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
  * Populate an inode based on info from mds.  May be called on new or
  * existing inodes.
  */
-static int fill_inode(struct inode *inode,
+static int fill_inode(struct inode *inode, struct page *locked_page,
 		      struct ceph_mds_reply_info_in *iinfo,
 		      struct ceph_mds_reply_dirfrag *dirinfo,
 		      struct ceph_mds_session *session,
@@ -883,14 +883,15 @@ static int fill_inode(struct inode *inode,
 		int cache_caps = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 		ci->i_inline_version = iinfo->inline_version;
 		if (ci->i_inline_version != CEPH_INLINE_NONE &&
-		    (le32_to_cpu(info->cap.caps) & cache_caps))
+		    (locked_page ||
+		     (le32_to_cpu(info->cap.caps) & cache_caps)))
 			fill_inline = true;
 	}
 
 	spin_unlock(&ci->i_ceph_lock);
 
 	if (fill_inline)
-		ceph_fill_inline_data(inode, NULL,
+		ceph_fill_inline_data(inode, locked_page,
 				      iinfo->inline_data, iinfo->inline_len);
 
 	if (wake)
@@ -1080,7 +1081,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 		struct inode *dir = req->r_locked_dir;
 
 		if (dir) {
-			err = fill_inode(dir, &rinfo->diri, rinfo->dirfrag,
+			err = fill_inode(dir, NULL,
+					 &rinfo->diri, rinfo->dirfrag,
 					 session, req->r_request_started, -1,
 					 &req->r_caps_reservation);
 			if (err < 0)
@@ -1150,7 +1152,7 @@ retry_lookup:
 		}
 		req->r_target_inode = in;
 
-		err = fill_inode(in, &rinfo->targeti, NULL,
+		err = fill_inode(in, req->r_locked_page, &rinfo->targeti, NULL,
 				session, req->r_request_started,
 				(!req->r_aborted && rinfo->head->result == 0) ?
 				req->r_fmode : -1,
@@ -1321,7 +1323,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 			dout("new_inode badness got %d\n", err);
 			continue;
 		}
-		rc = fill_inode(in, &rinfo->dir_in[i], NULL, session,
+		rc = fill_inode(in, NULL, &rinfo->dir_in[i], NULL, session,
 				req->r_request_started, -1,
 				&req->r_caps_reservation);
 		if (rc < 0) {
@@ -1437,7 +1439,7 @@ retry_lookup:
 			}
 		}
 
-		if (fill_inode(in, &rinfo->dir_in[i], NULL, session,
+		if (fill_inode(in, NULL, &rinfo->dir_in[i], NULL, session,
 			       req->r_request_started, -1,
 			       &req->r_caps_reservation) < 0) {
 			pr_err("fill_inode badness on %p\n", in);
@@ -1920,7 +1922,8 @@ out_put:
  * Verify that we have a lease on the given mask.  If not,
  * do a getattr against an mds.
  */
-int ceph_do_getattr(struct inode *inode, int mask, bool force)
+int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+		      int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1932,7 +1935,8 @@ int ceph_do_getattr(struct inode *inode, int mask, bool force)
 		return 0;
 	}
 
-	dout("do_getattr inode %p mask %s mode 0%o\n", inode, ceph_cap_string(mask), inode->i_mode);
+	dout("do_getattr inode %p mask %s mode 0%o\n",
+	     inode, ceph_cap_string(mask), inode->i_mode);
 	if (!force && ceph_caps_issued_mask(ceph_inode(inode), mask, 1))
 		return 0;
 
@@ -1943,7 +1947,19 @@ int ceph_do_getattr(struct inode *inode, int mask, bool force)
 	ihold(inode);
 	req->r_num_caps = 1;
 	req->r_args.getattr.mask = cpu_to_le32(mask);
+	req->r_locked_page = locked_page;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	if (locked_page && err == 0) {
+		u64 inline_version = req->r_reply_info.targeti.inline_version;
+		if (inline_version == 0) {
+			/* the reply is supposed to contain inline data */
+			err = -EINVAL;
+		} else if (inline_version == CEPH_INLINE_NONE) {
+			err = -ENODATA;
+		} else {
+			err = req->r_reply_info.targeti.inline_len;
+		}
+	}
 	ceph_mdsc_put_request(req);
 	dout("do_getattr result=%d\n", err);
 	return err;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 01f5e4c..e2817d0 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -223,6 +223,7 @@ struct ceph_mds_request {
 	int r_request_release_offset;
 	struct ceph_msg  *r_reply;
 	struct ceph_mds_reply_info_parsed r_reply_info;
+	struct page *r_locked_page;
 	int r_err;
 	bool r_aborted;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f675dd9..90f79b5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -744,7 +744,12 @@ extern void ceph_queue_vmtruncate(struct inode *inode);
 extern void ceph_queue_invalidate(struct inode *inode);
 extern void ceph_queue_writeback(struct inode *inode);
 
-extern int ceph_do_getattr(struct inode *inode, int mask, bool force);
+extern int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+			     int mask, bool force);
+static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
+{
+	return __ceph_do_getattr(inode, NULL, mask, force);
+}
 extern int ceph_permission(struct inode *inode, int mask);
 extern int ceph_setattr(struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct vfsmount *mnt, struct dentry *dentry,
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 2d4acfa..c0dadaa 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -617,6 +617,8 @@ int ceph_flags_to_mode(int flags);
 				 CEPH_CAP_LINK_SHARED |	\
 				 CEPH_CAP_FILE_SHARED |	\
 				 CEPH_CAP_XATTR_SHARED)
+#define CEPH_STAT_CAP_INLINE_DATA (CEPH_CAP_FILE_SHARED | \
+				   CEPH_CAP_FILE_RD)
 
 #define CEPH_CAP_ANY_SHARED (CEPH_CAP_AUTH_SHARED |			\
 			      CEPH_CAP_LINK_SHARED |			\
-- 
1.9.3

