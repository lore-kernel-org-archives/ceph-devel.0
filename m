From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: get rid of some version parameters
Date: Tue, 30 Apr 2013 07:30:15 -0500
Message-ID: <517FB957.1030502@inktank.com>
References: <517FB909.40309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43387 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760553Ab3D3MaS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:30:18 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so492564iej.2
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:30:17 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id qn10sm22263832igc.6.2013.04.30.05.30.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:30:16 -0700 (PDT)
In-Reply-To: <517FB909.40309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Several functions in rbd have parameters meant to allow the version
of an object to be passed in or out.  The purpose of those was to
allow the version of a header object to be maintained, but we no
longer do that.  As a result, these parameters are never actually
needed or used, so get rid of them.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c4707dc..0bfc3e9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2838,8 +2838,7 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)

 static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 				const char *object_name,
-				u64 offset, u64 length,
-				void *buf, u64 *version)
+				u64 offset, u64 length, void *buf)

 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -2890,10 +2889,8 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 	rbd_assert(obj_request->xferred <= (u64) SIZE_MAX);
 	size = (size_t) obj_request->xferred;
 	ceph_copy_from_page_vector(pages, buf, 0, size);
-	rbd_assert(size <= (size_t) INT_MAX);
-	ret = (int) size;
-	if (version)
-		*version = obj_request->version;
+	rbd_assert(size <= (size_t)INT_MAX);
+	ret = (int)size;
 out:
 	if (obj_request)
 		rbd_obj_request_put(obj_request);
@@ -2914,7 +2911,7 @@ out:
  * Returns a pointer-coded errno if a failure occurs.
  */
 static struct rbd_image_header_ondisk *
-rbd_dev_v1_header_read(struct rbd_device *rbd_dev, u64 *version)
+rbd_dev_v1_header_read(struct rbd_device *rbd_dev)
 {
 	struct rbd_image_header_ondisk *ondisk = NULL;
 	u32 snap_count = 0;
@@ -2942,7 +2939,7 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
u64 *version)
 			return ERR_PTR(-ENOMEM);

 		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
-				       0, size, ondisk, version);
+				       0, size, ondisk);
 		if (ret < 0)
 			goto out_err;
 		if ((size_t)ret < size) {
@@ -2977,10 +2974,9 @@ static int rbd_read_header(struct rbd_device
*rbd_dev,
 			   struct rbd_image_header *header)
 {
 	struct rbd_image_header_ondisk *ondisk;
-	u64 ver = 0;
 	int ret;

-	ondisk = rbd_dev_v1_header_read(rbd_dev, &ver);
+	ondisk = rbd_dev_v1_header_read(rbd_dev);
 	if (IS_ERR(ondisk))
 		return PTR_ERR(ondisk);
 	ret = rbd_header_from_disk(header, ondisk);
-- 
1.7.9.5

