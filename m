From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/7] rbd: move stripe_unit and stripe_count into header
Date: Fri, 26 Apr 2013 13:00:11 -0500
Message-ID: <517AC0AB.9070308@inktank.com>
References: <517AC047.6060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:62496 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3DZSAO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 14:00:14 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so863557iak.15
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 11:00:13 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ve9sm4395975igb.3.2013.04.26.11.00.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 11:00:12 -0700 (PDT)
In-Reply-To: <517AC047.6060000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This commit added fetching if fancy striping parameters:
    09186ddb rbd: get and check striping parameters

They are almost unused, but the two fields storing the information
really belonged in the rbd_image_header structure.

This patch moves them there.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d989914..fd4f678 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -108,6 +108,9 @@ struct rbd_image_header {
 	char *snap_names;
 	u64 *snap_sizes;

+	u64 stripe_unit;
+	u64 stripe_count;
+
 	u64 obj_version;
 };

@@ -316,9 +319,6 @@ struct rbd_device {
 	u64			parent_overlap;
 	struct rbd_device	*parent;

-	u64			stripe_unit;
-	u64			stripe_count;
-
 	/* protects updating the header */
 	struct rw_semaphore     header_rwsem;

@@ -3695,8 +3695,8 @@ static int rbd_dev_v2_striping_info(struct
rbd_device *rbd_dev)
 				"(got %llu want 1)", stripe_count);
 		return -EINVAL;
 	}
-	rbd_dev->stripe_unit = stripe_unit;
-	rbd_dev->stripe_count = stripe_count;
+	rbd_dev->header.stripe_unit = stripe_unit;
+	rbd_dev->header.stripe_count = stripe_count;

 	return 0;
 }
-- 
1.7.9.5

