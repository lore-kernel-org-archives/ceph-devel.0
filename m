From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] rbd: kill __rbd_remove()
Date: Sat, 27 Apr 2013 07:37:19 -0500
Message-ID: <517BC67F.5060806@inktank.com>
References: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43040 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3D0MhV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:37:21 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so5918741iee.34
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:37:20 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id qn10sm7717798igc.6.2013.04.27.05.37.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:37:20 -0700 (PDT)
In-Reply-To: <517BC608.5030008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The function __rbd_remove() is used in two spots, and it's fairly
simple.  It combines cleanup of part of the ceph-side state as well
as cleaning up the Linux-side state.  Just open code it in the two
callers and eliminate the function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fa703db..9936067 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4982,12 +4982,6 @@ static void rbd_dev_release(struct device *dev)
 	module_put(THIS_MODULE);
 }

-static void __rbd_remove(struct rbd_device *rbd_dev)
-{
-	rbd_remove_all_snaps(rbd_dev);
-	rbd_bus_del_dev(rbd_dev);
-}
-
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
 {
 	while (rbd_dev->parent_spec) {
@@ -5003,7 +4997,8 @@ static void rbd_dev_remove_parent(struct
rbd_device *rbd_dev)
 			first = second;
 			second = third;
 		}
-		__rbd_remove(second);
+		rbd_remove_all_snaps(second);
+		rbd_bus_del_dev(second);
 		rbd_spec_put(first->parent_spec);
 		first->parent_spec = NULL;
 		first->parent_overlap = 0;
@@ -5049,8 +5044,8 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	if (rbd_dev->parent)
 		rbd_dev_remove_parent(rbd_dev);

-	__rbd_remove(rbd_dev);
-
+	rbd_remove_all_snaps(rbd_dev);
+	rbd_bus_del_dev(rbd_dev);
 done:
 	mutex_unlock(&ctl_mutex);

-- 
1.7.9.5

