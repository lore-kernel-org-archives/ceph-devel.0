From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: fix leak of format 2 snapshot context
Date: Mon, 06 May 2013 20:33:43 -0500
Message-ID: <518859F7.8060708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60536 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670Ab3EGBdq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:33:46 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so52788iet.14
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:33:45 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id lr1sm6628226igb.6.2013.05.06.18.33.44
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:33:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When rbd_dev_v2_refresh() is called, the rbd device already has a
snapshot context associated with it.  But that never gets freed,
the pointer just gets overwritten.

Fix this by dropping the rbd device's reference to the snapshot
context before overwriting the pointer.

Because ceph_put_snap_context() already handles for a null pointer
we don't need to check for that (for the probe case, where no
context has yet been assigned).

This resolves:
    http://tracker.ceph.com/issues/4912

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c2ca181..4263743 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4004,6 +4004,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev)
 	for (i = 0; i < snap_count; i++)
 		snapc->snaps[i] = ceph_decode_64(&p);

+	ceph_put_snap_context(rbd_dev->header.snapc);
 	rbd_dev->header.snapc = snapc;

 	dout("  snap context seq = %llu, snap_count = %u\n",
-- 
1.7.9.5

