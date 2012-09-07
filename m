From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/9] rbd: drop dev registration check for new snap
Date: Fri, 07 Sep 2012 10:45:18 -0500
Message-ID: <504A168E.6090906@inktank.com>
References: <504A152E.4000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57175 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab2IGPpU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:45:20 -0400
Received: by ieje11 with SMTP id e11so5262969iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 08:45:20 -0700 (PDT)
In-Reply-To: <504A152E.4000905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

By the time rbd_dev_snaps_register() gets called during rbd device
initialization, the main device will have already been registered.
Similarly, a header refresh will only occur for an rbd device whose
Linux device is registered.  There is therefore no need to verify
the main device is registered when registering a snapshot device.

For the time being, turn the check into a WARN_ON(), but it can
eventually just go away.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e82610..e6af38f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2253,8 +2253,8 @@ static int rbd_dev_snaps_register(struct
rbd_device *rbd_dev)
 	int ret = 0;

 	dout("%s called\n", __func__);
-	if (!device_is_registered(&rbd_dev->dev))
-		return 0;
+	if (WARN_ON(!device_is_registered(&rbd_dev->dev)))
+		return -EIO;

 	list_for_each_entry(snap, &rbd_dev->snaps, node) {
 		if (!rbd_snap_registered(snap)) {
-- 
1.7.9.5

