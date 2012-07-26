From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/7] rbd: pass null version pointer in add_snap()
Date: Thu, 26 Jul 2012 14:08:43 -0500
Message-ID: <501195BB.8030401@inktank.com>
References: <50119421.1090702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:64259 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GZTIo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 15:08:44 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so2340802ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 12:08:44 -0700 (PDT)
In-Reply-To: <50119421.1090702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_header_add_snap() passes the address of a version variable to
rbd_req_sync_exec(), but it ignores the result.  Just pass a null
pointer instead.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4d8b52c..eacf255 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1664,7 +1664,6 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,
 	u64 new_snapid;
 	int ret;
 	void *data, *p, *e;
-	u64 ver;
 	struct ceph_mon_client *monc;

 	/* we should create a snapshot only if we're pointing at the head */
@@ -1689,7 +1688,7 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,

 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "snap_add",
-				data, p - data, &ver);
+				data, p - data, NULL);

 	kfree(data);

-- 
1.7.9.5

