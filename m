From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] rbd: remove parent devices on probe error
Date: Sat, 27 Apr 2013 07:37:51 -0500
Message-ID: <517BC69F.6020906@inktank.com>
References: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:47561 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab3D0Mhw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:37:52 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so4307171iar.2
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:37:52 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id s16sm7749429ign.4.2013.04.27.05.37.51
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:37:51 -0700 (PDT)
In-Reply-To: <517BC608.5030008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When an error occurs while finishing probing a device it is assumed
that parent devices get cleaned up when deleting a device.  They
don't.  Add a call to clean them up.  Note that this means the
parent spec will already be cleaned up so it doesn't have to be
in one of the rbd_add() error paths.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 99d231b..c81b319 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4806,8 +4806,8 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	return ret;

 err_out_bus:
-	/* this will also clean up rest of rbd_dev stuff */
-
+	if (rbd_dev->parent)
+		rbd_dev_remove_parent(rbd_dev);
 	rbd_bus_del_dev(rbd_dev);

 	return ret;
@@ -4922,7 +4922,6 @@ static ssize_t rbd_add(struct bus_type *bus,

 	return count;
 err_out_rbd_dev:
-	rbd_spec_put(rbd_dev->parent_spec);
 	kfree(rbd_dev->header_name);
 	rbd_dev_destroy(rbd_dev);
 err_out_client:
-- 
1.7.9.5

