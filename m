From: Alex Elder <elder@inktank.com>
Subject: [PATCH 8/9] rbd: set initial capacity in rbd_init_disk()
Date: Fri, 07 Sep 2012 10:45:25 -0500
Message-ID: <504A1695.8060504@inktank.com>
References: <504A152E.4000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36790 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab2IGPp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:45:29 -0400
Received: by mail-iy0-f174.google.com with SMTP id k25so3327563iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 08:45:28 -0700 (PDT)
In-Reply-To: <504A152E.4000905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move the setting of the initial capacity for an rbd image mapping
into rb_init_disk().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e6af38f..51e1d21 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1901,6 +1901,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)

 	rbd_dev->disk = disk;

+	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
+
 	return 0;
 out_disk:
 	put_disk(disk);
@@ -2642,7 +2644,6 @@ static ssize_t rbd_add(struct bus_type *bus,

 	/* Everything's ready.  Announce the disk to the world. */

-	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	add_disk(rbd_dev->disk);
 	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
 		(unsigned long long) rbd_dev->mapping.size);
-- 
1.7.9.5

