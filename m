From: Ronny Hegewald <ronny.hegewald@online.de>
Subject: [PATCH] mark rbd requiring stable pages
Date: Thu, 15 Oct 2015 18:50:46 +0000
Message-ID: <201510151850.48348.ronny.hegewald@online.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:61518 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbJOStJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 14:49:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

rbd requires stable pages, as it performs a crc of the page data before they 
are send to the OSDs.

But since kernel 3.9 (patch 1d1d1a767206fbe5d4c69493b7e6d2a8d08cc0a0 "mm: only
enforce stable page writes if the backing device requires it") it is not 
assumed anymore that block devices require stable pages.

This patch sets the necessary flag to get stable pages back for rbd.

In a ceph installation that provides multiple ext4 formatted rbd devices "bad 
crc" messages appeared regularly (ca 1 message every 1-2 minutes on every OSD 
that provided the data for the rbd) in the OSD-logs before this patch. After 
this patch this messages are pretty much gone (only ca 1-2 / month / OSD).

This patch seems also to fix data and filesystem corruptions on ext4 formatted 
rbd devices that were previously seen on pretty much a daily basis. But it is 
unknown at the moment why this is the case.  

Signed-off-by: Ronny Hegewald <Ronny.Hegewald@online.de>

---

That the mentioned corruption issue is really affected through this patch 
i could verify through the system logs. Since installation of this patch i 
have seen only a 2-3 filesystem corruptions. But these could be also just 
leftovers of corruptions that happened before the installation but got noticed 
from ext4 only later after the patched kernel was installed. This seems even 
more likely as i have seen not a single data corruption issue since the patch. 

--- linux/drivers/block/rbd.c.org	2015-10-07 01:32:55.906666667 +0000
+++ linux/drivers/block/rbd.c	2015-09-04 02:21:22.349999999 +0000
@@ -3786,6 +3786,7 @@
 
 	blk_queue_merge_bvec(q, rbd_merge_bvec);
 	disk->queue = q;
+	disk->queue->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
 
 	q->queuedata = rbd_dev;
 
