From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6] rbd: fix rbd_dev_remove_parent()
Date: Sat, 27 Apr 2013 07:37:31 -0500
Message-ID: <517BC68B.3040806@inktank.com>
References: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:50697 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874Ab3D0Mhd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:37:33 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so5984944iec.28
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:37:33 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id y5sm8449137igg.7.2013.04.27.05.37.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:37:32 -0700 (PDT)
In-Reply-To: <517BC608.5030008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In certain error paths, it is possible for an rbd device to have a
parent spec but no parent rbd_dev.  In rbd_dev_remove_parent() use
the parent field rather than parent_spec in determining whether to
try to remove any parent devices.  Use assertions to indicate that
any non-null parent pointer has parent_spec associated with it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9936067..99d231b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4984,7 +4984,7 @@ static void rbd_dev_release(struct device *dev)

 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
 {
-	while (rbd_dev->parent_spec) {
+	while (rbd_dev->parent) {
 		struct rbd_device *first = rbd_dev;
 		struct rbd_device *second = first->parent;
 		struct rbd_device *third;
@@ -4997,12 +4997,15 @@ static void rbd_dev_remove_parent(struct
rbd_device *rbd_dev)
 			first = second;
 			second = third;
 		}
+		rbd_assert(second);
 		rbd_remove_all_snaps(second);
 		rbd_bus_del_dev(second);
+		first->parent = NULL;
+		first->parent_overlap = 0;
+
+		rbd_assert(first->parent_spec);
 		rbd_spec_put(first->parent_spec);
 		first->parent_spec = NULL;
-		first->parent_overlap = 0;
-		first->parent = NULL;
 	}
 }

-- 
1.7.9.5

