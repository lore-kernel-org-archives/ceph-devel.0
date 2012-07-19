From: Alex Elder <elder@inktank.com>
Subject: [PATCH 08/12] rbd: drop rbd_req_sync_exec() "ver" parameter
Date: Thu, 19 Jul 2012 16:08:48 -0500
Message-ID: <50087760.5070204@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:54224 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab2GSVIv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:08:51 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so3302374ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:08:50 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The only place that passes a version pointer to rbd_req_sync_exec()
is in rbd_header_add_snap(), and that spot ignores the result.

The only thing rbd_req_sync_exec() does with its "ver" parameter is
pass it directly to rbd_req_sync_op().  So we can just use a null
pointer there, and drop the "ver" parameter to rbd_req_sync_exec().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 955d75d..d4a8d9e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1374,8 +1374,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 			     const char *class_name,
 			     const char *method_name,
 			     const char *data,
-			     int len,
-			     u64 *ver)
+			     int len)
 {
 	struct ceph_osd_req_op *ops;
 	int class_name_len = strlen(class_name);
@@ -1398,7 +1397,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 			       0,
 			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			       ops,
-			       object_name, 0, 0, NULL, NULL, ver);
+			       object_name, 0, 0, NULL, NULL, NULL);

 	rbd_destroy_ops(ops);

@@ -1651,7 +1650,6 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,
 	u64 new_snapid;
 	int ret;
 	void *data, *p, *e;
-	u64 ver;
 	struct ceph_mon_client *monc;

 	/* we should create a snapshot only if we're pointing at the head */
@@ -1676,7 +1674,7 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,

 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "snap_add",
-				data, p - data, &ver);
+				data, p - data);

 	kfree(data);

-- 
1.7.5.4

