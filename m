From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: fix bug in rbd_dev_id_put()
Date: Thu, 11 Oct 2012 08:34:22 -0700
Message-ID: <5076E6FE.9070400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:61071 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab2JKPe0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Oct 2012 11:34:26 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so817474dak.19
        for <ceph-devel@vger.kernel.org>; Thu, 11 Oct 2012 08:34:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_dev_id_put(), there's a loop that's intended to determine
the maximum device id in use.  But it isn't doing that at all,
the effect of how it's written is to simply use the just-put id
number, which ignores whole purpose of this function.

Fix the bug.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ca28036..cf5d109 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2642,8 +2642,8 @@ static void rbd_dev_id_put(struct rbd_device *rbd_dev)
  		struct rbd_device *rbd_dev;

  		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_id > max_id)
-			max_id = rbd_id;
+		if (rbd_dev->dev_id > max_id)
+			max_id = rbd_dev->dev_id;
  	}
  	spin_unlock(&rbd_dev_list_lock);

-- 
1.7.9.5

