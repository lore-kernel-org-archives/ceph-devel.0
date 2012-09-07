From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: move locking out of rbd_header_set_snap()
Date: Fri, 07 Sep 2012 09:50:12 -0500
Message-ID: <504A09A4.7050404@inktank.com>
References: <504A090F.7000706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54481 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990Ab2IGOuP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 10:50:15 -0400
Received: by ieje11 with SMTP id e11so5147910iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 07:50:14 -0700 (PDT)
In-Reply-To: <504A090F.7000706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move the calls to get the header semaphore out of
rbd_header_set_snap() and into its caller.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 634a16c..214c937 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -647,8 +647,6 @@ static int rbd_header_set_snap(struct rbd_device
*rbd_dev, char *snap_name)
 {
 	int ret;

-	down_write(&rbd_dev->header_rwsem);
-
 	if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME,
 		    sizeof (RBD_SNAP_HEAD_NAME))) {
 		rbd_dev->mapping.snap_id = CEPH_NOSNAP;
@@ -666,7 +664,6 @@ static int rbd_header_set_snap(struct rbd_device
*rbd_dev, char *snap_name)

 	ret = 0;
 done:
-	up_write(&rbd_dev->header_rwsem);
 	return ret;
 }

@@ -2608,7 +2605,9 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (rc)
 		goto err_out_bus;

+	down_write(&rbd_dev->header_rwsem);
 	rc = rbd_header_set_snap(rbd_dev, snap_name);
+	up_write(&rbd_dev->header_rwsem);
 	if (rc)
 		goto err_out_bus;

-- 
1.7.9.5

