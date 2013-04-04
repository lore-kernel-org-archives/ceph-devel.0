From: Alex Elder <elder@inktank.com>
Subject: [PATCH 8/9] libceph: hold off building osd request
Date: Thu, 04 Apr 2013 11:20:06 -0500
Message-ID: <515DA836.6010204@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:54626 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762991Ab3DDQUI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:20:08 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so2396146iak.10
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:20:07 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Defer building the osd request until just before submitting it in
all callers except ceph_writepages_start().  (That caller will be
handed in the next patch.)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c        |    4 ++--
 fs/ceph/file.c        |    7 ++++---
 net/ceph/osd_client.c |    8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e976c6d..125d0a8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -319,8 +319,6 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	if (IS_ERR(req))
 		return PTR_ERR(req);

-	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
-
 	/* build page vector */
 	nr_pages = calc_pages_for(0, len);
 	pages = kmalloc(sizeof(*pages) * nr_pages, GFP_NOFS);
@@ -351,6 +349,8 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	req->r_callback = finish_read;
 	req->r_inode = inode;

+	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
+
 	dout("start_read %p starting %p %lld~%lld\n", inode, req, off, len);
 	ret = ceph_osdc_start_request(osdc, req, false);
 	if (ret < 0)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f341c90..66b8469 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -540,9 +540,6 @@ more:
 	if (IS_ERR(req))
 		return PTR_ERR(req);

-	ceph_osdc_build_request(req, pos, num_ops, ops,
-				snapc, vino.snap, &mtime);
-
 	/* write from beginning of first page, regardless of io alignment */
 	page_align = file->f_flags & O_DIRECT ? buf_align : io_align;
 	num_pages = calc_pages_for(page_align, len);
@@ -583,6 +580,10 @@ more:
 	req->r_data_out.alignment = page_align;
 	req->r_inode = inode;

+	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
+	ceph_osdc_build_request(req, pos, num_ops, ops,
+				snapc, vino.snap, &mtime);
+
 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!ret) {
 		if (req->r_safe_callback) {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 115790a..9ca693d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2056,8 +2056,6 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 	if (IS_ERR(req))
 		return PTR_ERR(req);

-	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
-
 	/* it may be a short read due to an object boundary */

 	osd_data = &req->r_data_in;
@@ -2069,6 +2067,8 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 	dout("readpages  final extent is %llu~%llu (%llu bytes align %d)\n",
 	     off, *plen, osd_data->length, page_align);

+	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
+
 	rc = ceph_osdc_start_request(osdc, req, false);
 	if (!rc)
 		rc = ceph_osdc_wait_request(osdc, req);
@@ -2105,8 +2105,6 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 	if (IS_ERR(req))
 		return PTR_ERR(req);

-	ceph_osdc_build_request(req, off, 1, &op, snapc, CEPH_NOSNAP, mtime);
-
 	/* it may be a short write due to an object boundary */
 	osd_data = &req->r_data_out;
 	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
@@ -2115,6 +2113,8 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 	osd_data->alignment = page_align;
 	dout("writepages %llu~%llu (%llu bytes)\n", off, len, osd_data->length);

+	ceph_osdc_build_request(req, off, 1, &op, snapc, CEPH_NOSNAP, mtime);
+
 	rc = ceph_osdc_start_request(osdc, req, true);
 	if (!rc)
 		rc = ceph_osdc_wait_request(osdc, req);
-- 
1.7.9.5

