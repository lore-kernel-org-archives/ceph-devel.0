From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: don't assign page info in ceph_osdc_new_request()
Date: Mon, 04 Mar 2013 12:15:51 -0600
Message-ID: <5134E4D7.70200@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E46C.9020402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:57216 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758434Ab3CDSPv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:15:51 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so6555335ied.16
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:15:50 -0800 (PST)
In-Reply-To: <5134E46C.9020402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently ceph_osdc_new_request() assigns an osd request's
r_num_pages and r_alignment fields.  The only thing it does
after that is call ceph_osdc_build_request(), and that doesn't
need those fields to be assigned.

Move the assignment of those fields out of ceph_osdc_new_request()
and into its caller.  As a result, the page_align parameter is no
longer used, so get rid of it.

Note that in ceph_sync_write(), the value for req->r_num_pages had
already been calculated earlier (as num_pages, and fortunately
it was computed the same way).  So don't bother recomputing it,
but because it's not needed earlier, move that calculation after the
call to ceph_osdc_new_request().  Hold off making the assignment to
r_alignment, doing it instead r_pages and r_num_pages are
getting set.

Similarly, in start_read(), nr_pages already holds the number of
pages in the array (and is calculated the same way), so there's no
need to recompute it.  Move the assignment of the page alignment
down with the others there as well.

This and the next few patches are preparation work for:
    http://tracker.ceph.com/issues/4127

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c                  |    7 +++++--
 fs/ceph/file.c                  |    9 +++++----
 include/linux/ceph/osd_client.h |    2 +-
 net/ceph/osd_client.c           |   19 ++++++++-----------
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a284a1f..e46e944 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -309,7 +309,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 				    NULL, 0,
 				    ci->i_truncate_seq, ci->i_truncate_size,
-				    NULL, false, 0);
+				    NULL, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

@@ -338,6 +338,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	}
 	req->r_pages = pages;
 	req->r_num_pages = nr_pages;
+	req->r_page_alignment = 0;
 	req->r_callback = finish_read;
 	req->r_inode = inode;

@@ -820,7 +821,7 @@ get_more_pages:
 					    snapc, do_sync,
 					    ci->i_truncate_seq,
 					    ci->i_truncate_size,
-					    &inode->i_mtime, true, 0);
+					    &inode->i_mtime, true);

 				if (IS_ERR(req)) {
 					rc = PTR_ERR(req);
@@ -828,6 +829,8 @@ get_more_pages:
 					break;
 				}

+				req->r_num_pages = calc_pages_for(0, len);
+				req->r_page_alignment = 0;
 				max_pages = req->r_num_pages;

 				alloc_page_vec(fsc, req);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 805678e..fe7f711 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -527,19 +527,19 @@ more:
 	buf_align = (unsigned long)data & ~PAGE_MASK;
 	len = left;

-	/* write from beginning of first page, regardless of io alignment */
-	page_align = file->f_flags & O_DIRECT ? buf_align : io_align;
-	num_pages = calc_pages_for(page_align, len);
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), pos, &len,
 				    CEPH_OSD_OP_WRITE, flags,
 				    ci->i_snap_realm->cached_context,
 				    do_sync,
 				    ci->i_truncate_seq, ci->i_truncate_size,
-				    &mtime, false, page_align);
+				    &mtime, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

+	/* write from beginning of first page, regardless of io alignment */
+	page_align = file->f_flags & O_DIRECT ? buf_align : io_align;
+	num_pages = calc_pages_for(page_align, len);
 	if (file->f_flags & O_DIRECT) {
 		pages = ceph_get_direct_page_vector(data, num_pages, false);
 		if (IS_ERR(pages)) {
@@ -573,6 +573,7 @@ more:
 	}
 	req->r_pages = pages;
 	req->r_num_pages = num_pages;
+	req->r_page_alignment = page_align;
 	req->r_inode = inode;

 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index ec33588..803a9db 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -247,7 +247,7 @@ extern struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *,
 				      int do_sync, u32 truncate_seq,
 				      u64 truncate_size,
 				      struct timespec *mtime,
-				      bool use_mempool, int page_align);
+				      bool use_mempool);

 extern void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
 					 struct ceph_osd_request *req);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 38d09d1..de427cc 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -432,8 +432,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					       u32 truncate_seq,
 					       u64 truncate_size,
 					       struct timespec *mtime,
-					       bool use_mempool,
-					       int page_align)
+					       bool use_mempool)
 {
 	struct ceph_osd_req_op ops[2];
 	struct ceph_osd_request *req;
@@ -470,11 +469,6 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
 	req->r_oid_len = strlen(req->r_oid);

-	/* The alignment may differ from the natural (file) alignment */
-
-	req->r_num_pages = calc_pages_for(page_align, *plen);
-	req->r_page_alignment = page_align;
-
 	ceph_osdc_build_request(req, off, *plen, num_op, ops,
 				snapc, vino.snap, mtime);

@@ -1945,12 +1939,14 @@ int ceph_osdc_readpages(struct ceph_osd_client
*osdc,
 	req = ceph_osdc_new_request(osdc, layout, vino, off, plen,
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 				    NULL, 0, truncate_seq, truncate_size, NULL,
-				    false, page_align);
+				    false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

 	/* it may be a short read due to an object boundary */
 	req->r_pages = pages;
+	req->r_num_pages = calc_pages_for(page_align, *plen);
+	req->r_page_alignment = page_align;

 	dout("readpages  final extent is %llu~%llu (%d pages align %d)\n",
 	     off, *plen, req->r_num_pages, page_align);
@@ -1986,14 +1982,15 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
 				    snapc, 0,
 				    truncate_seq, truncate_size, mtime,
-				    true, page_align);
+				    true);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

 	/* it may be a short write due to an object boundary */
 	req->r_pages = pages;
-	dout("writepages %llu~%llu (%d pages)\n", off, len,
-	     req->r_num_pages);
+	req->r_num_pages = calc_pages_for(page_align, len);
+	req->r_page_alignment = page_align;
+	dout("writepages %llu~%llu (%d pages)\n", off, len, req->r_num_pages);

 	rc = ceph_osdc_start_request(osdc, req, true);
 	if (!rc)
-- 
1.7.9.5

