From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] rbd: kill rbd_dev_clear_mapping()
Date: Mon, 06 May 2013 20:38:16 -0500
Message-ID: <51885B08.6080907@inktank.com>
References: <51885A97.9070005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63886 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983Ab3EGBiS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:38:18 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so52415ieb.38
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:38:18 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xf4sm5147767igb.8.2013.05.06.18.38.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:38:17 -0700 (PDT)
In-Reply-To: <51885A97.9070005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This function is a duplicate of rbd_dev_mapping_clear(), and was
added by mistake.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5eebf6d..530793a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -966,13 +966,6 @@ static void rbd_dev_mapping_clear(struct rbd_device
*rbd_dev)
 	rbd_dev->mapping.read_only = true;
 }

-static void rbd_dev_clear_mapping(struct rbd_device *rbd_dev)
-{
-	rbd_dev->mapping.size = 0;
-	rbd_dev->mapping.features = 0;
-	rbd_dev->mapping.read_only = true;
-}
-
 static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
 {
 	char *name;
@@ -4910,7 +4903,7 @@ static void rbd_dev_device_release(struct device *dev)

 	rbd_free_disk(rbd_dev);
 	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
-	rbd_dev_clear_mapping(rbd_dev);
+	rbd_dev_mapping_clear(rbd_dev);
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
 	rbd_dev->major = 0;
 	rbd_dev_id_put(rbd_dev);
-- 
1.7.9.5

