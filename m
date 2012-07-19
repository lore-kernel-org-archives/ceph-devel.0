From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6] rbd: set image size when header is updated
Date: Thu, 19 Jul 2012 07:34:55 -0500
Message-ID: <5007FEEF.20809@inktank.com>
References: <5007FDEA.9010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46515 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2GSMe5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:34:57 -0400
Received: by gglu4 with SMTP id u4so2680725ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:34:57 -0700 (PDT)
In-Reply-To: <5007FDEA.9010605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The image may have been resized.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9c3a1db..a6bbda2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1746,6 +1746,7 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 	kfree(rbd_dev->header.snap_names);
 	kfree(rbd_dev->header.snapc);

+	rbd_dev->header.image_size = h.image_size;
 	rbd_dev->header.total_snaps = h.total_snaps;
 	rbd_dev->header.snapc = h.snapc;
 	rbd_dev->header.snap_names = h.snap_names;
-- 
1.7.5.4

