From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: protect against concurrent unmaps
Date: Fri, 31 May 2013 20:20:26 -0500
Message-ID: <51A94C5A.20807@inktank.com>
References: <51A94BC0.4080703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:50027 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3FABU2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 21:20:28 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so5770988iec.16
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 18:20:28 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ji5sm6490138igb.0.2013.05.31.18.20.27
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 18:20:27 -0700 (PDT)
In-Reply-To: <51A94BC0.4080703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Make sure two concurrent unmap operations on the same rbd device
won't collide, by only proceeding with the removal and cleanup of a
device if is not already underway.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 716ef1f..380940d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5153,6 +5153,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	struct list_head *tmp;
 	int dev_id;
 	unsigned long ul;
+	bool already = false;
 	int ret;

 	ret = strict_strtoul(buf, 10, &ul);
@@ -5180,11 +5181,12 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		if (rbd_dev->open_count)
 			ret = -EBUSY;
 		else
-			set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
+			already = test_and_set_bit(RBD_DEV_FLAG_REMOVING,
+							&rbd_dev->flags);
 		spin_unlock_irq(&rbd_dev->lock);
 	}
 	spin_unlock(&rbd_dev_list_lock);
-	if (ret < 0)
+	if (ret < 0 || already)
 		goto done;

 	rbd_bus_del_dev(rbd_dev);
-- 
1.7.9.5

