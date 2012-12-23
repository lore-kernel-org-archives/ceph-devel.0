From: Fengguang Wu <fengguang.wu@intel.com>
Subject: drivers/block/rbd.c:2170:19: sparse: symbol 'rbd_dev_create' was not
 declared. Should it be static?
Date: Sun, 23 Dec 2012 09:37:56 +0800
Message-ID: <20121223013756.GB11275@localhost>
References: <50d3c4c4.+GYegH2UzJwRTkBr%yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40975 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406Ab2LWBh7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 22 Dec 2012 20:37:59 -0500
Content-Disposition: inline
In-Reply-To: <50d3c4c4.+GYegH2UzJwRTkBr%yuanhan.liu@linux.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
head:   c3e946ce7276faf0b302acd25c7b874edbeba661
commit: c53d589337e9a211413484a604c76072e8474dc0 rbd: define rbd_dev_{create,destroy}() helpers
date:   7 weeks ago

drivers/block/rbd.c:1293:42: sparse: Using plain integer as NULL pointer
drivers/block/rbd.c:1341:26: sparse: incorrect type in assignment (different base types)
drivers/block/rbd.c:1341:26:    expected unsigned long long [unsigned] [usertype] ver
drivers/block/rbd.c:1341:26:    got restricted __le64 [usertype] <noident>
drivers/block/rbd.c:1351:46: sparse: Using plain integer as NULL pointer
drivers/block/rbd.c:1395:26: sparse: incorrect type in assignment (different base types)
drivers/block/rbd.c:1395:26:    expected unsigned long long [unsigned] [usertype] ver
drivers/block/rbd.c:1395:26:    got restricted __le64 [usertype] <noident>
drivers/block/rbd.c:1396:29: sparse: incorrect type in assignment (different base types)
drivers/block/rbd.c:1396:29:    expected unsigned long long [unsigned] [usertype] cookie
drivers/block/rbd.c:1396:29:    got restricted __le64 [usertype] <noident>
drivers/block/rbd.c:1434:29: sparse: incorrect type in assignment (different base types)
drivers/block/rbd.c:1434:29:    expected unsigned long long [unsigned] [usertype] cookie
drivers/block/rbd.c:1434:29:    got restricted __le64 [usertype] <noident>
+ drivers/block/rbd.c:2170:19: sparse: symbol 'rbd_dev_create' was not declared. Should it be static?
drivers/block/rbd.c:2529:17: sparse: incorrect type in assignment (different base types)
drivers/block/rbd.c:2529:17:    expected restricted __le64 [usertype] snap_id
drivers/block/rbd.c:2529:17:    got unsigned long long [unsigned] [long] [long long] <noident>
drivers/block/rbd.c:2530:46: sparse: incorrect type in argument 2 (different base types)
drivers/block/rbd.c:2530:46:    expected unsigned long long [unsigned] [usertype] snap_id
drivers/block/rbd.c:2530:46:    got restricted __le64 [usertype] snap_id
drivers/block/rbd.c:2533:50: sparse: incorrect type in argument 2 (different base types)
drivers/block/rbd.c:2533:50:    expected unsigned long long [unsigned] [usertype] snap_id
drivers/block/rbd.c:2533:50:    got restricted __le64 [usertype] snap_id
drivers/block/rbd.c:1551:32: sparse: context imbalance in 'rbd_rq_fn' - unexpected unlock

Please consider folding the attached diff :-)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

--MW5yreqqjyrRcusr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="make-it-static-c53d589.diff"

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a8ad8f8..077e177 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2167,7 +2167,7 @@ static void rbd_spec_free(struct kref *kref)
 	kfree(spec);
 }
 
-struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
+static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 				struct rbd_spec *spec)
 {
 	struct rbd_device *rbd_dev;

--MW5yreqqjyrRcusr--
