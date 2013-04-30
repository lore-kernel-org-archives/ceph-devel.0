From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] rbd: fix up the layering warning message
Date: Tue, 30 Apr 2013 07:23:20 -0500
Message-ID: <517FB7B8.6060600@inktank.com>
References: <517FB770.1070500@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59242 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760529Ab3D3MXY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:23:24 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so474376ieb.39
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:23:24 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id q3sm24403493igw.0.2013.04.30.05.23.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:23:20 -0700 (PDT)
In-Reply-To: <517FB770.1070500@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A warning gets spewed for any image being probed, including parent
images.  Set up a condition such that the warning message only gets
printed for the image being mapped, not any of its parents.

Also, I didn't like the way the warning ended up being so long.
Make it a terse warning instead.  People experimenting with layering
will know what the message means.

This is part of:
    http://tracker.ceph.com/issues/4867

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8b30d83..176a3d7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4624,8 +4624,15 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 		ret = rbd_dev_v2_parent_info(rbd_dev);
 		if (ret)
 			goto out_err;
-		rbd_warn(rbd_dev, "WARNING: kernel support for "
-					"layered rbd images is EXPERIMENTAL!");
+
+		/*
+		 * Don't print a warning for parent images.  We can
+		 * tell this point because we won't know its pool
+		 * name yet (just its pool id).
+		 */
+		if (rbd_dev->spec->pool_name)
+			rbd_warn(rbd_dev, "WARNING: kernel layering "
+					"is EXPERIMENTAL!");
 	}

 	/* If the image supports fancy striping, get its parameters */
-- 
1.7.9.5

