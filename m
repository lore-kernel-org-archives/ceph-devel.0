From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/6] rbd: only reset capacity when pointing to head
Date: Thu, 19 Jul 2012 07:34:41 -0500
Message-ID: <5007FEE1.40100@inktank.com>
References: <5007FDEA.9010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39184 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2GSMen (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:34:43 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so2682359ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:34:43 -0700 (PDT)
In-Reply-To: <5007FDEA.9010605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Snapshots cannot be resized, and the new capacity of head should not
be reflected by the snapshot.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 730d0ce..f171ceb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1725,7 +1725,12 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 		return ret;

 	/* resized? */
-	set_capacity(rbd_dev->disk, h.image_size / SECTOR_SIZE);
+	if (rbd_dev->snap_id == CEPH_NOSNAP) {
+		sector_t size = (sector_t) h.image_size / SECTOR_SIZE;
+
+		dout("setting size to %llu sectors", (unsigned long long) size);
+		set_capacity(rbd_dev->disk, size);
+	}

 	down_write(&rbd_dev->header_rwsem);

-- 
1.7.5.4

