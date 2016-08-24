From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 11/16] rbd: print capacity in decimal and features in hex
Date: Wed, 24 Aug 2016 15:18:35 +0200
Message-ID: <1472044720-29116-12-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35668 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753874AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yw0-f195.google.com with SMTP id r9so789536ywg.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:19:03 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.19.02
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:19:02 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

With exclusive-lock added and more to come, print features into dmesg.
Change capacity to decimal while at it.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7cda1cc60c2c..fd1a9891b348 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6006,8 +6006,9 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	spin_unlock(&rbd_dev_list_lock);
 
 	add_disk(rbd_dev->disk);
-	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
-		(unsigned long long) rbd_dev->mapping.size);
+	pr_info("%s: capacity %llu features 0x%llx\n", rbd_dev->disk->disk_name,
+		(unsigned long long)get_capacity(rbd_dev->disk) << SECTOR_SHIFT,
+		rbd_dev->header.features);
 
 	return ret;
 
-- 
2.4.3

