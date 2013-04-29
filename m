From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: don't have device release destroy rbd_dev
Date: Mon, 29 Apr 2013 13:00:59 -0500
Message-ID: <517EB55B.7060709@inktank.com>
References: <517EB4F0.1070607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:64748 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758590Ab3D2SBC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 14:01:02 -0400
Received: by mail-qa0-f42.google.com with SMTP id dx4so1162269qab.8
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 11:01:01 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id j9sm26808564qas.3.2013.04.29.11.00.59
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 11:01:00 -0700 (PDT)
In-Reply-To: <517EB4F0.1070607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently an rbd_device structure gets destroyed from the release
routine for the device embedded within it.  Stop doing that, instead
calling rbd_dev_image_release() right after rbd_bus_del_dev()
wherever the latter is called.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 595d7b3..ff850e9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5013,8 +5013,6 @@ static void rbd_dev_device_release(struct device *dev)
 	rbd_dev->major = 0;
 	rbd_dev_id_put(rbd_dev);
 	rbd_dev_mapping_clear(rbd_dev);
-
-	rbd_dev_image_release(rbd_dev);
 }

 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
@@ -5034,6 +5032,7 @@ static void rbd_dev_remove_parent(struct
rbd_device *rbd_dev)
 		}
 		rbd_assert(second);
 		rbd_bus_del_dev(second);
+		rbd_dev_image_release(second);
 		first->parent = NULL;
 		first->parent_overlap = 0;

@@ -5079,6 +5078,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		goto done;
 	ret = count;
 	rbd_bus_del_dev(rbd_dev);
+	rbd_dev_image_release(rbd_dev);
 	module_put(THIS_MODULE);
 done:
 	mutex_unlock(&ctl_mutex);
-- 
1.7.9.5

