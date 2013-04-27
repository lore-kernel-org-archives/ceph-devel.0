From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: defer setting the mapping size and features
Date: Sat, 27 Apr 2013 07:33:52 -0500
Message-ID: <517BC5B0.3040106@inktank.com>
References: <517BC525.8090403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:46071 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab3D0Mdy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:33:54 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so4348130iae.6
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:33:53 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ve9sm8452062igb.3.2013.04.27.05.33.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:33:53 -0700 (PDT)
In-Reply-To: <517BC525.8090403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There's no need to set the size/features for a mapped device until
we're about to make it available for use.  So wait until then to do
it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 12bc89f..b10348c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4712,10 +4712,6 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto err_out_snaps;

-	ret = rbd_dev_set_mapping(rbd_dev);
-	if (ret)
-		goto err_out_snaps;
-
 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);

@@ -4774,10 +4770,15 @@ static int rbd_dev_probe_finish(struct
rbd_device *rbd_dev)
 	if (ret)
 		goto err_out_bus;

-	/* Everything's ready.  Announce the disk to the world. */
+	ret = rbd_dev_set_mapping(rbd_dev);
+	if (ret)
+		goto err_out_bus;

 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
+
+	/* Everything's ready.  Announce the disk to the world. */
+
 	add_disk(rbd_dev->disk);

 	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
-- 
1.7.9.5

