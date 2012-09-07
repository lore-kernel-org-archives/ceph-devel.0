From: Alex Elder <elder@inktank.com>
Subject: [PATCH 9/9] rbd: activate v2 image support
Date: Fri, 07 Sep 2012 16:15:40 -0500
Message-ID: <504A63FC.1080005@inktank.com>
References: <504A6273.7030807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41314 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab2IGVPn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:15:43 -0400
Received: by iahk25 with SMTP id k25so23159iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:15:42 -0700 (PDT)
In-Reply-To: <504A6273.7030807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that v2 images support is fully implemented, have
rbd_dev_v2_probe() return 0 to indicate a successful probe.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b466393..2f83f71 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2973,7 +2973,7 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 	dout("discovered version 2 image, header name is %s\n",
 		rbd_dev->header_name);

-	return -ENOTSUPP;
+	return 0;
 out_err:
 	kfree(rbd_dev->header_name);
 	rbd_dev->header_name = NULL;
-- 
1.7.9.5

