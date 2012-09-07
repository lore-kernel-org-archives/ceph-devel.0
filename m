From: Alex Elder <elder@inktank.com>
Subject: [PATCH 9/9] rbd: set up watch before announcing disk
Date: Fri, 07 Sep 2012 10:45:35 -0500
Message-ID: <504A169F.3070604@inktank.com>
References: <504A152E.4000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57175 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab2IGPph (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:45:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5262969iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 08:45:37 -0700 (PDT)
In-Reply-To: <504A152E.4000905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We're ready to handle header object (refresh) events at the point we
call rbd_bus_add_dev().  Set up the watch request on the rbd image
header just after that, and after we've registered the devices for
the snapshots for the initial snapshot context.  Do this before
announce the disk as available for use.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 51e1d21..daa428e3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2640,23 +2640,23 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (rc)
 		goto err_out_unlock;

+	rc = rbd_init_watch_dev(rbd_dev);
+	if (rc)
+		goto err_out_unlock;
+
 	up_write(&rbd_dev->header_rwsem);

 	/* Everything's ready.  Announce the disk to the world. */

 	add_disk(rbd_dev->disk);
+
 	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
 		(unsigned long long) rbd_dev->mapping.size);

-	rc = rbd_init_watch_dev(rbd_dev);
-	if (rc)
-		goto err_out_bus;
-
 	return count;

 err_out_unlock:
 	up_write(&rbd_dev->header_rwsem);
-err_out_bus:
 	/* this will also clean up rest of rbd_dev stuff */

 	rbd_bus_del_dev(rbd_dev);
-- 
1.7.9.5

