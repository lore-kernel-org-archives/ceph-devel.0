From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/9] rbd: call set_snap() before snap_devs_update()
Date: Fri, 07 Sep 2012 10:44:41 -0500
Message-ID: <504A1669.7030300@inktank.com>
References: <504A152E.4000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63393 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab2IGPoo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:44:44 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5261193iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 08:44:44 -0700 (PDT)
In-Reply-To: <504A152E.4000905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_header_set_snap() is a simple initialization routine for an rbd
device's mapping.  It has to be called after the snapshot context
for the rbd_dev has been updated, but can be done before snapshot
devices have been registered.

Change the name to rbd_dev_set_mapping() to better reflect its
purpose, and call it a little sooner, before registering snapshot
devices.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d03fb0f..d60db25 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -640,7 +640,7 @@ static int snap_by_name(struct rbd_device *rbd_dev,
const char *snap_name)
 	return -ENOENT;
 }

-static int rbd_header_set_snap(struct rbd_device *rbd_dev, char *snap_name)
+static int rbd_dev_set_mapping(struct rbd_device *rbd_dev, char *snap_name)
 {
 	int ret;

@@ -2621,11 +2621,12 @@ static ssize_t rbd_add(struct bus_type *bus,
 	rc = rbd_dev_snaps_update(rbd_dev);
 	if (rc)
 		goto err_out_unlock;
-	rc = rbd_dev_snaps_register(rbd_dev);
+
+	rc = rbd_dev_set_mapping(rbd_dev, snap_name);
 	if (rc)
 		goto err_out_unlock;

-	rc = rbd_header_set_snap(rbd_dev, snap_name);
+	rc = rbd_dev_snaps_register(rbd_dev);
 	if (rc)
 		goto err_out_unlock;

-- 
1.7.9.5

