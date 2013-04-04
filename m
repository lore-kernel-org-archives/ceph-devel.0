From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/9] libceph: don't build request in ceph_osdc_new_request()
Date: Thu, 04 Apr 2013 11:19:24 -0500
Message-ID: <515DA80C.2080708@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:46531 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762888Ab3DDQT1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:19:27 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so2348159iac.5
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:19:26 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This patch moves the call to ceph_osdc_build_request() out of
ceph_osdc_new_request() and into its caller.

This is in order to defer formatting osd operation information into
the request message until just before request is started.

The only unusual (ab)user of ceph_osdc_build_request() is
ceph_writepages_start(), where the final length of write request may
change (downward) based on the current inode size or the oldest
snapshot context with dirty data for the inode.

The remaining callers don't change anything in the request after has
been built.

This means the ops array is now supplied by the caller.  It also
means there is no need to pass the mtime to ceph_osdc_new_request()
(it gets provided to ceph_osdc_build_request()).  And rather than
passing a do_sync flag, have the number of ops in the ops array
supplied imply adding a second STARTSYNC operation after the READ or
WRITE requested.

This and some of the patches that follow are related to having the
messenger (only) be responsible for filling the content of the
message header, as described here:
    http://tracker.ceph.com/issues/4589

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c                  |   36 ++++++++++++++++++++++-------------
 fs/ceph/file.c                  |   20 +++++++++++++-------
 include/linux/ceph/osd_client.h |   12 ++++++------
 net/ceph/osd_client.c           |   40
++++++++++++++++++++-------------------
 4 files changed, 63 insertions(+), 45 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6a5a08e..de7aac0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -284,7 +284,9 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 		&ceph_inode_to_client(inode)->client->osdc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct page *page = list_entry(page_list->prev, struct page, lru);
+	struct ceph_vino vino;
 	struct ceph_osd_request *req;
+	struct ceph_osd_req_op op;
 	u64 off;
 	u64 len;
 	int i;
@@ -308,16 +310,17 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	len = nr_pages << PAGE_CACHE_SHIFT;
 	dout("start_read %p nr_pages %d is %lld~%lld\n", inode, nr_pages,
 	     off, len);
-
-	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode),
-				    off, &len,
-				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
-				    NULL, 0,
+	vino = ceph_vino(inode);
+	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len,
+				    1, &op, CEPH_OSD_OP_READ,
+				    CEPH_OSD_FLAG_READ, NULL,
 				    ci->i_truncate_seq, ci->i_truncate_size,
-				    NULL, false);
+				    false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

+	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
+
 	/* build page vector */
 	nr_pages = calc_pages_for(0, len);
 	pages = kmalloc(sizeof(*pages) * nr_pages, GFP_NOFS);
@@ -736,6 +739,7 @@ retry:
 	last_snapc = snapc;

 	while (!done && index <= end) {
+		struct ceph_osd_req_op ops[2];
 		unsigned i;
 		int first;
 		pgoff_t next;
@@ -825,20 +829,22 @@ get_more_pages:

 			/* ok */
 			if (locked_pages == 0) {
+				struct ceph_vino vino;
+				int num_ops = do_sync ? 2 : 1;
+
 				/* prepare async write request */
 				offset = (u64) page_offset(page);
 				len = wsize;
+				vino = ceph_vino(inode);
+				/* BUG_ON(vino.snap != CEPH_NOSNAP); */
 				req = ceph_osdc_new_request(&fsc->client->osdc,
-					    &ci->i_layout,
-					    ceph_vino(inode),
-					    offset, &len,
+					    &ci->i_layout, vino, offset, &len,
+					    num_ops, ops,
 					    CEPH_OSD_OP_WRITE,
 					    CEPH_OSD_FLAG_WRITE |
 						    CEPH_OSD_FLAG_ONDISK,
-					    snapc, do_sync,
-					    ci->i_truncate_seq,
-					    ci->i_truncate_size,
-					    &inode->i_mtime, true);
+					    snapc, ci->i_truncate_seq,
+					    ci->i_truncate_size, true);

 				if (IS_ERR(req)) {
 					rc = PTR_ERR(req);
@@ -846,6 +852,10 @@ get_more_pages:
 					break;
 				}

+				ceph_osdc_build_request(req, offset,
+					num_ops, ops, snapc, vino.snap,
+					&inode->i_mtime);
+
 				req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
 				req->r_data_out.length = len;
 				req->r_data_out.alignment = 0;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 0e8230d..f341c90 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -475,14 +475,17 @@ static ssize_t ceph_sync_write(struct file *file,
const char __user *data,
 	struct inode *inode = file->f_dentry->d_inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_snap_context *snapc;
+	struct ceph_vino vino;
 	struct ceph_osd_request *req;
+	struct ceph_osd_req_op ops[2];
+	int num_ops = 1;
 	struct page **pages;
 	int num_pages;
 	long long unsigned pos;
 	u64 len;
 	int written = 0;
 	int flags;
-	int do_sync = 0;
 	int check_caps = 0;
 	int page_align, io_align;
 	unsigned long buf_align;
@@ -516,7 +519,7 @@ static ssize_t ceph_sync_write(struct file *file,
const char __user *data,
 	if ((file->f_flags & (O_SYNC|O_DIRECT)) == 0)
 		flags |= CEPH_OSD_FLAG_ACK;
 	else
-		do_sync = 1;
+		num_ops++;	/* Also include a 'startsync' command. */

 	/*
 	 * we may need to do multiple writes here if we span an object
@@ -527,16 +530,19 @@ more:
 	buf_align = (unsigned long)data & ~PAGE_MASK;
 	len = left;

+	snapc = ci->i_snap_realm->cached_context;
+	vino = ceph_vino(inode);
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
-				    ceph_vino(inode), pos, &len,
-				    CEPH_OSD_OP_WRITE, flags,
-				    ci->i_snap_realm->cached_context,
-				    do_sync,
+				    vino, pos, &len, num_ops, ops,
+				    CEPH_OSD_OP_WRITE, flags, snapc,
 				    ci->i_truncate_seq, ci->i_truncate_size,
-				    &mtime, false);
+				    false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

+	ceph_osdc_build_request(req, pos, num_ops, ops,
+				snapc, vino.snap, &mtime);
+
 	/* write from beginning of first page, regardless of io alignment */
 	page_align = file->f_flags & O_DIRECT ? buf_align : io_align;
 	num_pages = calc_pages_for(page_align, len);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index fdda93e..ffaf907 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -243,12 +243,12 @@ extern void osd_req_op_watch_init(struct
ceph_osd_req_op *op, u16 opcode,

 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct
ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
-					       unsigned int num_op,
+					       unsigned int num_ops,
 					       bool use_mempool,
 					       gfp_t gfp_flags);

 extern void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
-				    unsigned int num_op,
+				    unsigned int num_ops,
 				    struct ceph_osd_req_op *src_ops,
 				    struct ceph_snap_context *snapc,
 				    u64 snap_id,
@@ -257,11 +257,11 @@ extern void ceph_osdc_build_request(struct
ceph_osd_request *req, u64 off,
 extern struct ceph_osd_request *ceph_osdc_new_request(struct
ceph_osd_client *,
 				      struct ceph_file_layout *layout,
 				      struct ceph_vino vino,
-				      u64 offset, u64 *len, int op, int flags,
+				      u64 offset, u64 *len,
+				      int num_ops, struct ceph_osd_req_op *ops,
+				      int opcode, int flags,
 				      struct ceph_snap_context *snapc,
-				      int do_sync, u32 truncate_seq,
-				      u64 truncate_size,
-				      struct timespec *mtime,
+				      u32 truncate_seq, u64 truncate_size,
 				      bool use_mempool);

 extern void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0b4951e..115790a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -512,9 +512,7 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 	msg->front.iov_len = msg_size;
 	msg->hdr.front_len = cpu_to_le32(msg_size);

-	dout("build_request msg_size was %d num_ops %d\n", (int)msg_size,
-	     num_ops);
-	return;
+	dout("build_request msg_size was %d\n", (int)msg_size);
 }
 EXPORT_SYMBOL(ceph_osdc_build_request);

@@ -532,18 +530,15 @@ EXPORT_SYMBOL(ceph_osdc_build_request);
 struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client
*osdc,
 					       struct ceph_file_layout *layout,
 					       struct ceph_vino vino,
-					       u64 off, u64 *plen,
+					       u64 off, u64 *plen, int num_ops,
+					       struct ceph_osd_req_op *ops,
 					       int opcode, int flags,
 					       struct ceph_snap_context *snapc,
-					       int do_sync,
 					       u32 truncate_seq,
 					       u64 truncate_size,
-					       struct timespec *mtime,
 					       bool use_mempool)
 {
-	struct ceph_osd_req_op ops[2];
 	struct ceph_osd_request *req;
-	unsigned int num_op = do_sync ? 2 : 1;
 	u64 objnum = 0;
 	u64 objoff = 0;
 	u64 objlen = 0;
@@ -553,7 +548,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,

 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE);

-	req = ceph_osdc_alloc_request(osdc, snapc, num_op, use_mempool,
+	req = ceph_osdc_alloc_request(osdc, snapc, num_ops, use_mempool,
 					GFP_NOFS);
 	if (!req)
 		return ERR_PTR(-ENOMEM);
@@ -578,7 +573,12 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,

 	osd_req_op_extent_init(&ops[0], opcode, objoff, objlen,
 				truncate_size, truncate_seq);
-	if (do_sync)
+	/*
+	 * A second op in the ops array means the caller wants to
+	 * also issue a include a 'startsync' command so that the
+	 * osd will flush data quickly.
+	 */
+	if (num_ops > 1)
 		osd_req_op_init(&ops[1], CEPH_OSD_OP_STARTSYNC);

 	req->r_file_layout = *layout;  /* keep a copy */
@@ -587,9 +587,6 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 		vino.ino, objnum);
 	req->r_oid_len = strlen(req->r_oid);

-	ceph_osdc_build_request(req, off, num_op, ops,
-				snapc, vino.snap, mtime);
-
 	return req;
 }
 EXPORT_SYMBOL(ceph_osdc_new_request);
@@ -2047,17 +2044,20 @@ int ceph_osdc_readpages(struct ceph_osd_client
*osdc,
 {
 	struct ceph_osd_request *req;
 	struct ceph_osd_data *osd_data;
+	struct ceph_osd_req_op op;
 	int rc = 0;

 	dout("readpages on ino %llx.%llx on %llu~%llu\n", vino.ino,
 	     vino.snap, off, *plen);
-	req = ceph_osdc_new_request(osdc, layout, vino, off, plen,
+	req = ceph_osdc_new_request(osdc, layout, vino, off, plen, 1, &op,
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
-				    NULL, 0, truncate_seq, truncate_size, NULL,
+				    NULL, truncate_seq, truncate_size,
 				    false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

+	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
+
 	/* it may be a short read due to an object boundary */

 	osd_data = &req->r_data_in;
@@ -2092,19 +2092,21 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 {
 	struct ceph_osd_request *req;
 	struct ceph_osd_data *osd_data;
+	struct ceph_osd_req_op op;
 	int rc = 0;
 	int page_align = off & ~PAGE_MASK;

-	BUG_ON(vino.snap != CEPH_NOSNAP);
-	req = ceph_osdc_new_request(osdc, layout, vino, off, &len,
+	BUG_ON(vino.snap != CEPH_NOSNAP);	/* snapshots aren't writeable */
+	req = ceph_osdc_new_request(osdc, layout, vino, off, &len, 1, &op,
 				    CEPH_OSD_OP_WRITE,
 				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
-				    snapc, 0,
-				    truncate_seq, truncate_size, mtime,
+				    snapc, truncate_seq, truncate_size,
 				    true);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

+	ceph_osdc_build_request(req, off, 1, &op, snapc, CEPH_NOSNAP, mtime);
+
 	/* it may be a short write due to an object boundary */
 	osd_data = &req->r_data_out;
 	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
-- 
1.7.9.5

