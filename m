From: Guangliang Zhao <gzhao@suse.com>
Subject: [PATCH] rbd: fix the repeat initialization of semaphore
Date: Thu, 19 Jul 2012 22:25:08 +0800
Message-ID: <1342707908-7747-1-git-send-email-gzhao@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:57673 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2GSO0J (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 19 Jul 2012 10:26:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: yehuda@inktank.com, sage@inktank.com

The header_rwsem of rbd_dev initializes twice in
function rbd_add.

Signed-off-by: Guangliang Zhao <gzhao@suse.com>
---
 drivers/block/rbd.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 013c7a5..50117dd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2381,8 +2381,6 @@ static ssize_t rbd_add(struct bus_type *bus,
 	INIT_LIST_HEAD(&rbd_dev->snaps);
 	init_rwsem(&rbd_dev->header_rwsem);
 
-	init_rwsem(&rbd_dev->header_rwsem);
-
 	/* generate unique id: find highest unique id, add one */
 	rbd_id_get(rbd_dev);
 
-- 
1.7.3.4

