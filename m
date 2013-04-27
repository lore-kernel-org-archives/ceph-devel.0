From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: defer setting disk capacity
Date: Sat, 27 Apr 2013 07:33:38 -0500
Message-ID: <517BC5A2.5000604@inktank.com>
References: <517BC525.8090403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41033 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3D0Mdl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:33:41 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so5783563iec.23
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:33:39 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id hi4sm8436500igc.6.2013.04.27.05.33.38
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:33:38 -0700 (PDT)
In-Reply-To: <517BC525.8090403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Don't set the disk capacity until right before we announce the
device as available for use.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b04e3e1..12bc89f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3147,8 +3147,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)

 	rbd_dev->disk = disk;

-	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
-
 	return 0;
 out_disk:
 	put_disk(disk);
@@ -4778,6 +4776,7 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)

 	/* Everything's ready.  Announce the disk to the world. */

+	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	add_disk(rbd_dev->disk);

-- 
1.7.9.5

