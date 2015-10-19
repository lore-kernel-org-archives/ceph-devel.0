From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: set device_type::release instead of device::release
Date: Mon, 19 Oct 2015 20:07:26 +0200
Message-ID: <1445278046-58231-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38191 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbJSQ1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 12:27:31 -0400
Received: by wicll6 with SMTP id ll6so13918203wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 09:27:30 -0700 (PDT)
Received: from orange.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q1sm41120335wjy.31.2015.10.19.09.27.29
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2015 09:27:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

No point in providing an empty device_type::release callback and then
setting device::release for each rbd_dev dynamically.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4917de726bdb..fa6767e9ed2a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3986,14 +3986,12 @@ static const struct attribute_group *rbd_attr_groups[] = {
 	NULL
 };
 
-static void rbd_sysfs_dev_release(struct device *dev)
-{
-}
+static void rbd_dev_release(struct device *dev);
 
 static struct device_type rbd_device_type = {
 	.name		= "rbd",
 	.groups		= rbd_attr_groups,
-	.release	= rbd_sysfs_dev_release,
+	.release	= rbd_dev_release,
 };
 
 static struct rbd_spec *rbd_spec_get(struct rbd_spec *spec)
@@ -4074,7 +4072,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	rbd_dev->dev.bus = &rbd_bus_type;
 	rbd_dev->dev.type = &rbd_device_type;
 	rbd_dev->dev.parent = &rbd_root_dev;
-	rbd_dev->dev.release = rbd_dev_release;
 	device_initialize(&rbd_dev->dev);
 
 	rbd_dev->rbd_client = rbdc;
-- 
2.4.3

