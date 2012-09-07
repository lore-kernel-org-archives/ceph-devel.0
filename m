From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: support data returned from OSD methods
Date: Fri, 07 Sep 2012 13:19:21 -0500
Message-ID: <504A3AA9.80004@inktank.com>
References: <504A39E0.1040107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41755 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2IGSTY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 14:19:24 -0400
Received: by iahk25 with SMTP id k25so3471231iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 11:19:24 -0700 (PDT)
In-Reply-To: <504A39E0.1040107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An OSD object method call can be made using rbd_req_sync_exec().
Until now this has only been used for creating a new RBD snapshot,
and that has only required sending data out, not receiving anything
back from the OSD.

We will now need to get data back from an OSD on a method call, so
add parameters to rbd_req_sync_exec() that allow a buffer into which
returned data should be placed to be specified, along with its size.

Previously, rbd_req_sync_exec() passed a null pointer and zero
size to rbd_req_sync_op(); change this so the new inbound buffer
information is provided instead.

Rename the "buf" and "len" parameters in rbd_req_sync_op() to
make it more obvious they are describing inbound data.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4e84f99..ba68566 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1098,8 +1098,8 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			   int flags,
 			   struct ceph_osd_req_op *ops,
 			   const char *object_name,
-			   u64 ofs, u64 len,
-			   char *buf,
+			   u64 ofs, u64 inbound_size,
+			   char *inbound,
 			   struct ceph_osd_request **linger_req,
 			   u64 *ver)
 {
@@ -1109,13 +1109,13 @@ static int rbd_req_sync_op(struct rbd_device
*rbd_dev,

 	rbd_assert(ops != NULL);

-	num_pages = calc_pages_for(ofs , len);
+	num_pages = calc_pages_for(ofs, inbound_size);
 	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);

 	ret = rbd_do_request(NULL, rbd_dev, snapc, snapid,
-			  object_name, ofs, len, NULL,
+			  object_name, ofs, inbound_size, NULL,
 			  pages, num_pages,
 			  flags,
 			  ops,
@@ -1125,8 +1125,8 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 	if (ret < 0)
 		goto done;

-	if ((flags & CEPH_OSD_FLAG_READ) && buf)
-		ret = ceph_copy_from_page_vector(pages, buf, ofs, ret);
+	if ((flags & CEPH_OSD_FLAG_READ) && inbound)
+		ret = ceph_copy_from_page_vector(pages, inbound, ofs, ret);

 done:
 	ceph_release_page_vector(pages, num_pages);
@@ -1445,6 +1445,8 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 			     const char *method_name,
 			     const char *outbound,
 			     size_t outbound_size,
+			     char *inbound,
+			     size_t inbound_size,
 			     int flags,
 			     u64 *ver)
 {
@@ -1478,7 +1480,8 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	ret = rbd_req_sync_op(rbd_dev, NULL,
 			       CEPH_NOSNAP,
 			       flags, ops,
-			       object_name, 0, 0, NULL, NULL, ver);
+			       object_name, 0, inbound_size, inbound,
+			       NULL, ver);

 	rbd_destroy_ops(ops);

@@ -1789,7 +1792,7 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,

 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "snap_add",
-				data, (size_t) (p - data),
+				data, (size_t) (p - data), NULL, 0,
 				CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 				NULL);

-- 
1.7.9.5

