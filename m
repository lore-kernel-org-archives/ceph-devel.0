From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: Directory listing issue in testing branch
Date: Sat, 29 Mar 2014 14:01:05 +0800
Message-ID: <533661A1.2010805@intel.com>
References: <CANP1eJGf_HK4gApTvUmJ0=kL4oQmSAV7zDmCXum8dziOVzsrNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60218 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbaC2GBI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 29 Mar 2014 02:01:08 -0400
In-Reply-To: <CANP1eJGf_HK4gApTvUmJ0=kL4oQmSAV7zDmCXum8dziOVzsrNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: Zheng Yan <ukernel@gmail.com>

On 03/29/2014 02:37 AM, Milosz Tanski wrote:
> I try to run the testing branch of the kernel client on one set of my
> clients. And currently in testing
> (a139081b7a9d10a9610f1b5a551fa2d95c04c80d to be exact) I'm seeing a
> bug where I only see part of the directory structure. I looked at the
> patches in that branch since then and I haven't seen anything that
> would like a fix for this.
> 
I think the issue is revealed by memory management subsystem changes.

> For example I'll run ls | wc -l one time and it shows me ~4000 entries
> and a second run right away shows around ~8000. This is with no
> changes to the directory at all.
> 
> I'm also seeing some OOMs in Ceph code around that time. This seams to
> be happening when reading MDS replies. In fact it dumps the whole MDS
> message to the kernel log (which ends being like 300k or so in size).
> I've attached the message in a attachment (it's really large).
> 
> For now I'm going to revert the 3 boxes in a question to an older
> kernel we built on 3.13 that doesn't experience this problem.
> 

Please try below patch, it should fix this issue
---

From 15a26a1d78f24a4a83a2ee319ad10701eb68cd56 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Sat, 29 Mar 2014 13:41:15 +0800
Subject: [PATCH] ceph: preallocate buffer for readdir reply

Preallocate buffer for readdir reply. Limit number of entries in
readdir reply according to the buffer size.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c        |  5 -----
 fs/ceph/mds_client.c | 53 ++++++++++++++++++++++++++++++++++++++++------------
 fs/ceph/mds_client.h |  2 +-
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ff2864a..e46795e 100644
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
@@ -337,9 +335,6 @@ more:
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
index 77640ada4..25ab2f4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -166,16 +166,14 @@ static int parse_reply_info_dir(void **p, void *end,
 		goto done;
 
 	/* alloc large array */
-	info->dir_nr = num;
-	info->dir_in = kcalloc(num, sizeof(*info->dir_in) +
-			       sizeof(*info->dir_dname) +
-			       sizeof(*info->dir_dname_len) +
-			       sizeof(*info->dir_dlease),
-			       GFP_NOFS);
-	if (info->dir_in == NULL) {
-		err = -ENOMEM;
-		goto out_bad;
+	BUG_ON(!info->dir_in);
+	if (num > info->dir_nr_max) {
+		pr_err("dir contents are larger than expected\n");
+		WARN_ON(1);
+		num = info->dir_nr_max;
 	}
+
+	info->dir_nr = num;
 	info->dir_dname = (void *)(info->dir_in + num);
 	info->dir_dname_len = (void *)(info->dir_dname + num);
 	info->dir_dlease = (void *)(info->dir_dname_len + num);
@@ -512,12 +510,11 @@ void ceph_mdsc_release_request(struct kref *kref)
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
@@ -1496,6 +1493,30 @@ static void discard_cap_releases(struct ceph_mds_client *mdsc,
  * requests
  */
 
+static int __alloc_reply_info_dir(struct ceph_fs_client *fsc,
+				  struct ceph_mds_request *req) {
+	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
+	int max_bytes = fsc->mount_options->max_readdir_bytes;
+	int max_entries = fsc->mount_options->max_readdir;
+	size_t size = sizeof(*rinfo->dir_in) + sizeof(*rinfo->dir_dname_len) +
+		      sizeof(*rinfo->dir_dname) + sizeof(*rinfo->dir_dlease);
+
+	while (max_entries > 0) {
+		rinfo->dir_in = kcalloc(max_entries, size,
+					GFP_NOFS | __GFP_NOWARN);
+		if (rinfo->dir_in)
+			break;
+		max_entries >>= 1;
+	}
+	if (!rinfo->dir_in)
+		return -ENOMEM;
+
+	rinfo->dir_nr_max = max_entries;
+	req->r_num_caps = max_entries + 1;
+	req->r_args.readdir.max_entries = cpu_to_le32(max_entries);
+	req->r_args.readdir.max_bytes = cpu_to_le32(max_bytes);
+	return 0;
+}
 /*
  * Create an mds request.
  */
@@ -1507,6 +1528,14 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	if (!req)
 		return ERR_PTR(-ENOMEM);
 
+	if (op == CEPH_MDS_OP_READDIR || op == CEPH_MDS_OP_LSSNAP) {
+		int err = __alloc_reply_info_dir(mdsc->fsc, req);
+		if (err) {
+			kfree(req);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
 	mutex_init(&req->r_fill_mutex);
 	req->r_mdsc = mdsc;
 	req->r_started = jiffies;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 6828891..b06035c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -67,7 +67,7 @@ struct ceph_mds_reply_info_parsed {
 		/* for readdir results */
 		struct {
 			struct ceph_mds_reply_dirfrag *dir_dir;
-			int                           dir_nr;
+			int                           dir_nr, dir_nr_max;
 			char                          **dir_dname;
 			u32                           *dir_dname_len;
 			struct ceph_mds_reply_lease   **dir_dlease;
-- 
1.8.5.3

