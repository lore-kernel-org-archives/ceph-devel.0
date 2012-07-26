From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] rbd: drop extra header_rwsem init
Date: Thu, 26 Jul 2012 13:44:39 -0500
Message-ID: <50119017.2010903@inktank.com>
References: <50118F33.7080502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59777 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab2GZSol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:44:41 -0400
Received: by gglu4 with SMTP id u4so2311502ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:44:41 -0700 (PDT)
In-Reply-To: <50118F33.7080502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In commit c666601a there was inadvertently added an extra
initialization of rbd_dev->header_rwsem.  This gets rid of the
duplicate.

Reported-by: Guangliang Zhao <gzhao@suse.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6df8c62..b9895fe 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2458,8 +2458,6 @@ static ssize_t rbd_add(struct bus_type *bus,
 	INIT_LIST_HEAD(&rbd_dev->snaps);
 	init_rwsem(&rbd_dev->header_rwsem);

-	init_rwsem(&rbd_dev->header_rwsem);
-
 	/* generate unique id: find highest unique id, add one */
 	rbd_id_get(rbd_dev);

-- 
1.7.9.5

