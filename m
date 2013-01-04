From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 1/6] libceph: pass length to ceph_osdc_build_request()
Date: Fri, 04 Jan 2013 08:33:10 -0600
Message-ID: <50E6E826.2070001@inktank.com>
References: <50E6E7C2.2020604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:40581 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3ADOdM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:33:12 -0500
Received: by mail-ia0-f176.google.com with SMTP id y26so13606002iab.7
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:33:12 -0800 (PST)
In-Reply-To: <50E6E7C2.2020604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The len argument to ceph_osdc_build_request() is set up to be
passed by address, but that function never updates its value
so there's no need to do this.  Tighten up the interface by
passing the length directly.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    2 +-
 include/linux/ceph/osd_client.h |    2 +-
 net/ceph/osd_client.c           |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cc12154..1a241a7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1172,7 +1172,7 @@ static int rbd_do_request(struct request *rq,
 				snapid, ofs, &len, &bno, osd_req, ops);
 	rbd_assert(ret == 0);

-	ceph_osdc_build_request(osd_req, ofs, &len, ops, snapc, &mtime);
+	ceph_osdc_build_request(osd_req, ofs, len, ops, snapc, &mtime);

 	if (linger_req) {
 		ceph_osdc_set_request_linger(osdc, osd_req);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 61562c7..4bfb458 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -224,7 +224,7 @@ extern struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *
 					       struct bio *bio);

 extern void ceph_osdc_build_request(struct ceph_osd_request *req,
-				    u64 off, u64 *plen,
+				    u64 off, u64 len,
 				    struct ceph_osd_req_op *src_ops,
 				    struct ceph_snap_context *snapc,
 				    struct timespec *mtime);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2adbfcc..cdf40c6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -328,7 +328,7 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
  *
  */
 void ceph_osdc_build_request(struct ceph_osd_request *req,
-			     u64 off, u64 *plen,
+			     u64 off, u64 len,
 			     struct ceph_osd_req_op *src_ops,
 			     struct ceph_snap_context *snapc,
 			     struct timespec *mtime)
@@ -382,7 +382,7 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,

 	if (flags & CEPH_OSD_FLAG_WRITE) {
 		req->r_request->hdr.data_off = cpu_to_le16(off);
-		req->r_request->hdr.data_len = cpu_to_le32(*plen + data_len);
+		req->r_request->hdr.data_len = cpu_to_le32(len + data_len);
 	} else if (data_len) {
 		req->r_request->hdr.data_off = 0;
 		req->r_request->hdr.data_len = cpu_to_le32(data_len);
@@ -456,7 +456,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_num_pages = calc_pages_for(page_align, *plen);
 	req->r_page_alignment = page_align;

-	ceph_osdc_build_request(req, off, plen, ops,
+	ceph_osdc_build_request(req, off, *plen, ops,
 				snapc,
 				mtime);

-- 
1.7.9.5

