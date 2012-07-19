From: Alex Elder <elder@inktank.com>
Subject: [PATCH 03/12] rbd: clean up a few dout() calls
Date: Thu, 19 Jul 2012 16:08:26 -0500
Message-ID: <5008774A.8000008@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:54224 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2GSVI2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:08:28 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so3302374ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:08:28 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There was a dout() call in rbd_do_request() that was reporting
the reporting the offset as the length and vice versa.  While
fixing that I did a quick scan of other dout() calls and fixed
a couple of other minor things.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 74e6a33..93b2447 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -895,7 +895,7 @@ static int rbd_do_request(struct request *rq,
 	}

 	dout("rbd_do_request object_name=%s ofs=%lld len=%lld\n",
-		object_name, len, ofs);
+		object_name, ofs, len);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	req = ceph_osdc_alloc_request(osdc, flags, snapc, ops,
@@ -1315,8 +1315,7 @@ static void rbd_notify_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		return;

 	dout("rbd_notify_cb %s notify_id=%lld opcode=%d\n",
-				rbd_dev->header_name,
-		notify_id, (int)opcode);
+			rbd_dev->header_name, notify_id, (int) opcode);
 }

 /*
@@ -1664,7 +1663,7 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,

 	monc = &rbd_dev->rbd_client->client->monc;
 	ret = ceph_monc_create_snapid(monc, rbd_dev->pool_id, &new_snapid);
-	dout("created snapid=%lld\n", new_snapid);
+	dout("created snapid=%llu\n", new_snapid);
 	if (ret < 0)
 		return ret;

-- 
1.7.5.4

