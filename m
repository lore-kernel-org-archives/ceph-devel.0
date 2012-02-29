From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] rbd: fix module sysfs setup/teardown code
Date: Tue, 28 Feb 2012 20:00:28 -0800
Message-ID: <4F4DA2DC.8010202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40265 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964833Ab2B2EA3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:00:29 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 38A1E24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:00:29 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 29A7724314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:00:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Once rbd_bus_type is registered, it allows an "add" operation via
the /sys/bus/rbd/add bus attribute, and adding a new rbd device that
way establishes a connection between the device and rbd_root_dev.
But rbd_root_dev is not registered until after the rbd_bus_type
registration is complete.  This could (in principle anyway) result
in an invalid state.

Since rbd_root_dev has no tie to rbd_bus_type we can reorder these
two initializations and never be faced with this scenario.

In addition, unregister the device in the event the bus registration
fails at module init time.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    8 +++++---
  1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bc539cd..b7c9af5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2560,19 +2560,21 @@ static int rbd_sysfs_init(void)
  {
  	int ret;

-	ret = bus_register(&rbd_bus_type);
+	ret = device_register(&rbd_root_dev);
  	if (ret < 0)
  		return ret;

-	ret = device_register(&rbd_root_dev);
+	ret = bus_register(&rbd_bus_type);
+	if (ret)
+		device_unregister(&rbd_root_dev);

  	return ret;
  }

  static void rbd_sysfs_cleanup(void)
  {
-	device_unregister(&rbd_root_dev);
  	bus_unregister(&rbd_bus_type);
+	device_unregister(&rbd_root_dev);
  }

  int __init rbd_init(void)
-- 
1.7.5.4

