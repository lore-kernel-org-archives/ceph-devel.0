From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: only set device exists flag when ready
Date: Sat, 27 Apr 2013 07:33:11 -0500
Message-ID: <517BC587.6000103@inktank.com>
References: <517BC525.8090403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:39488 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3D0MdN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:33:13 -0400
Received: by mail-ia0-f182.google.com with SMTP id w33so2069562iag.13
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:33:12 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ua6sm7775933igb.0.2013.04.27.05.33.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:33:11 -0700 (PDT)
In-Reply-To: <517BC525.8090403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hold off setting the EXISTS rbd device flag until just before we
announce the disk as available for use.  There's no point in doing
so any earlier than that, and at that point the device truly is
fully set up and ready to use.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b6f32c2..b04e3e1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -881,7 +881,6 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev)
 		rbd_dev->mapping.features = snap->features;
 		rbd_dev->mapping.read_only = true;
 	}
-	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);

 	return 0;
 }
@@ -4779,6 +4778,7 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)

 	/* Everything's ready.  Announce the disk to the world. */

+	set_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	add_disk(rbd_dev->disk);

 	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
-- 
1.7.9.5

