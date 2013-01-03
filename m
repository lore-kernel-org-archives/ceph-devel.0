From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 1/5] rbd: drop oid parameters from ceph_osdc_build_request()
Date: Thu, 03 Jan 2013 17:18:35 -0600
Message-ID: <50E611CB.1020500@inktank.com>
References: <50E61175.7010103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:61488 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3ACXSi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:18:38 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so19072251iej.32
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:18:38 -0800 (PST)
In-Reply-To: <50E61175.7010103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The last two parameters to ceph_osd_build_request() describe the
object id, but the values passed always come from the osd request
structure whose address is also provided.  Get rid of those last
two parameters.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    6 +-----
 include/linux/ceph/osd_client.h |    4 +---
 net/ceph/osd_client.c           |   13 +++++--------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e030d1..5bca129 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1176,11 +1176,7 @@ static int rbd_do_request(struct request *rq,
 				snapid, ofs, &len, &bno, osd_req, ops);
 	rbd_assert(ret == 0);

-	ceph_osdc_build_request(osd_req, ofs, &len,
-				ops,
-				snapc,
-				&mtime,
-				osd_req->r_oid, osd_req->r_oid_len);
+	ceph_osdc_build_request(osd_req, ofs, &len, ops, snapc, &mtime);

 	if (linger_req) {
 		ceph_osdc_set_request_linger(osdc, osd_req);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index d9b880e..f2e5d2c 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -227,9 +227,7 @@ extern void ceph_osdc_build_request(struct
ceph_osd_request *req,
 				    u64 off, u64 *plen,
 				    struct ceph_osd_req_op *src_ops,
 				    struct ceph_snap_context *snapc,
-				    struct timespec *mtime,
-				    const char *oid,
-				    int oid_len);
+				    struct timespec *mtime);

 extern struct ceph_osd_request *ceph_osdc_new_request(struct
ceph_osd_client *,
 				      struct ceph_file_layout *layout,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5f9f65a..89e7587 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -368,9 +368,7 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 			     u64 off, u64 *plen,
 			     struct ceph_osd_req_op *src_ops,
 			     struct ceph_snap_context *snapc,
-			     struct timespec *mtime,
-			     const char *oid,
-			     int oid_len)
+			     struct timespec *mtime)
 {
 	struct ceph_msg *msg = req->r_request;
 	struct ceph_osd_request_head *head;
@@ -397,9 +395,9 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,


 	/* fill in oid */
-	head->object_len = cpu_to_le32(oid_len);
-	memcpy(p, oid, oid_len);
-	p += oid_len;
+	head->object_len = cpu_to_le32(req->r_oid_len);
+	memcpy(p, req->r_oid, req->r_oid_len);
+	p += req->r_oid_len;

 	src_op = src_ops;
 	while (src_op->op) {
@@ -498,8 +496,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,

 	ceph_osdc_build_request(req, off, plen, ops,
 				snapc,
-				mtime,
-				req->r_oid, req->r_oid_len);
+				mtime);

 	return req;
 }
-- 
1.7.9.5

