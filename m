From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: preallocate buffer for readdir reply
Date: Sat, 29 Mar 2014 16:26:59 +0800
Message-ID: <1396081619-24551-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9352 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbaC2I1F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 29 Mar 2014 04:27:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: milosz@adfin.com, "Yan, Zheng" <zheng.z.yan@intel.com>

Preallocate buffer for readdir reply. Limit number of entries in
readdir reply according to the buffer size.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c        | 10 ++++----
 fs/ceph/mds_client.c | 66 ++++++++++++++++++++++++++++++++++++++++------------
 fs/ceph/mds_client.h |  4 +++-
 3 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ff2864a..46cd092 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -252,8 +252,6 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	int err;
 	u32 ftype;
 	struct ceph_mds_reply_info_parsed *rinfo;
-	const int max_entries = fsc->mount_options->max_readdir;
-	const int max_bytes = fsc->mount_options->max_readdir_bytes;
 
 	dout("readdir %p file %p frag %u off %u\n", inode, file, frag, off);
 	if (fi->flags & CEPH_F_ATEND)
@@ -327,6 +325,11 @@ more:
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
+		err = ceph_alloc_readdir_reply_buffer(req, inode);
+		if (err) {
+			ceph_mdsc_put_request(req);
+			return err;
+		}
 		req->r_inode = inode;
 		ihold(inode);
 		req->r_dentry = dget(file->f_dentry);
@@ -337,9 +340,6 @@ more:
 		req->r_path2 = kstrdup(fi->last_name, GFP_NOFS);
 		req->r_readdir_offset = fi->next_offset;
 		req->r_args.readdir.frag = cpu_to_le32(frag);
-		req->r_args.readdir.max_entries = cpu_to_le32(max_entries);
-		req->r_args.readdir.max_bytes = cpu_to_le32(max_bytes);
-		req->r_num_caps = max_entries + 1;
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err < 0) {
 			ceph_mdsc_put_request(req);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 77640ada4..19fbfc4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3,6 +3,7 @@
 #include <linux/fs.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -165,21 +166,18 @@ static int parse_reply_info_dir(void **p, void *end,
 	if (num == 0)
 		goto done;
 
-	/* alloc large array */
-	info->dir_nr = num;
-	info->dir_in = kcalloc(num, sizeof(*info->dir_in) +
-			       sizeof(*info->dir_dname) +
-			       sizeof(*info->dir_dname_len) +
-			       sizeof(*info->dir_dlease),
-			       GFP_NOFS);
-	if (info->dir_in == NULL) {
-		err = -ENOMEM;
-		goto out_bad;
-	}
+	BUG_ON(!info->dir_in);
 	info->dir_dname = (void *)(info->dir_in + num);
 	info->dir_dname_len = (void *)(info->dir_dname + num);
 	info->dir_dlease = (void *)(info->dir_dname_len + num);
+	if ((unsigned long)(info->dir_dlease + num) >
+	    (unsigned long)info->dir_in + info->dir_buf_size) {
+		pr_err("dir contents are larger than expected\n");
+		WARN_ON(1);
+		goto bad;
+	}
 
+	info->dir_nr = num;
 	while (num) {
 		/* dentry */
 		ceph_decode_need(p, end, sizeof(u32)*2, bad);
@@ -327,7 +325,9 @@ out_bad:
 
 static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 {
-	kfree(info->dir_in);
+	if (!info->dir_in)
+		return;
+	free_pages((unsigned long)info->dir_in, get_order(info->dir_buf_size));
 }
 
 
@@ -512,12 +512,11 @@ void ceph_mdsc_release_request(struct kref *kref)
 	struct ceph_mds_request *req = container_of(kref,
 						    struct ceph_mds_request,
 						    r_kref);
+	destroy_reply_info(&req->r_reply_info);
 	if (req->r_request)
 		ceph_msg_put(req->r_request);
-	if (req->r_reply) {
+	if (req->r_reply)
 		ceph_msg_put(req->r_reply);
-		destroy_reply_info(&req->r_reply_info);
-	}
 	if (req->r_inode) {
 		ceph_put_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
 		iput(req->r_inode);
@@ -1496,6 +1495,43 @@ static void discard_cap_releases(struct ceph_mds_client *mdsc,
  * requests
  */
 
+int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
+				    struct inode *dir)
+{
+	struct ceph_inode_info *ci = ceph_inode(dir);
+	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
+	struct ceph_mount_options *opt = req->r_mdsc->fsc->mount_options;
+	size_t size = sizeof(*rinfo->dir_in) + sizeof(*rinfo->dir_dname_len) +
+		      sizeof(*rinfo->dir_dname) + sizeof(*rinfo->dir_dlease);
+	int order, num_entries;
+
+	spin_lock(&ci->i_ceph_lock);
+	num_entries = ci->i_files + ci->i_subdirs;
+	spin_unlock(&ci->i_ceph_lock);
+	num_entries = max(num_entries, 1);
+	num_entries = min(num_entries, opt->max_readdir);
+
+	order = get_order(size * num_entries);
+	while (order >= 0) {
+		rinfo->dir_in = (void*)__get_free_pages(GFP_NOFS | __GFP_NOWARN,
+							order);
+		if (rinfo->dir_in)
+			break;
+		order--;
+	}
+	if (!rinfo->dir_in)
+		return -ENOMEM;
+
+	num_entries = (PAGE_SIZE << order) / size;
+	num_entries = min(num_entries, opt->max_readdir);
+
+	rinfo->dir_buf_size = PAGE_SIZE << order;
+	req->r_num_caps = num_entries + 1;
+	req->r_args.readdir.max_entries = cpu_to_le32(num_entries);
+	req->r_args.readdir.max_bytes = cpu_to_le32(opt->max_readdir_bytes);
+	return 0;
+}
+
 /*
  * Create an mds request.
  */
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 6828891..e90cfcc 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -67,6 +67,7 @@ struct ceph_mds_reply_info_parsed {
 		/* for readdir results */
 		struct {
 			struct ceph_mds_reply_dirfrag *dir_dir;
+			size_t			      dir_buf_size;
 			int                           dir_nr;
 			char                          **dir_dname;
 			u32                           *dir_dname_len;
@@ -346,7 +347,8 @@ extern void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc,
 				    struct dentry *dn);
 
 extern void ceph_invalidate_dir_request(struct ceph_mds_request *req);
-
+extern int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
+					   struct inode *dir);
 extern struct ceph_mds_request *
 ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode);
 extern void ceph_mdsc_submit_request(struct ceph_mds_client *mdsc,
-- 
1.8.5.3

