From: Alex Elder <elder@inktank.com>
Subject: [PATCH 02/16] rbd: drop a useless local variable
Date: Wed, 11 Jul 2012 09:00:48 -0500
Message-ID: <4FFD8710.60002@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:57488 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307Ab2GKOAu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:00:50 -0400
Received: by yhpp61 with SMTP id p61so1427205yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:00:50 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_req_sync_notify_ack(), a local variable was needlessly being
used to hold a null pointer.  Just pass NULL instead.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8f428a8..2ae3bb0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1187,7 +1187,6 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *dev,
 				   const char *obj)
 {
 	struct ceph_osd_req_op *ops;
-	struct page **pages = NULL;
 	int ret;

 	ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_NOTIFY_ACK, 0);
@@ -1200,7 +1199,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *dev,

 	ret = rbd_do_request(NULL, dev, NULL, CEPH_NOSNAP,
 			  obj, 0, 0, NULL,
-			  pages, 0,
+			  NULL, 0,
 			  CEPH_OSD_FLAG_READ,
 			  ops,
 			  1,
-- 
1.7.5.4

