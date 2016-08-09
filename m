From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: destroy header_oloc in rbd_dev_release()
Date: Tue,  9 Aug 2016 16:40:13 +0200
Message-ID: <1470753613-5365-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33788 "EHLO
	mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbcHIOwB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 10:52:01 -0400
Received: by mail-yb0-f193.google.com with SMTP id e125so337691ybc.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 07:52:01 -0700 (PDT)
Received: from dhcp-1-133.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e190sm16212369ywh.6.2016.08.09.07.40.27
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2016 07:40:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Purely cosmetic at this point, as rbd doesn't use RADOS namespaces and
hence rbd_dev->header_oloc->pool_ns is always NULL.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1a04af6d2421..07668a6f0607 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3950,6 +3950,7 @@ static void rbd_dev_release(struct device *dev)
 	bool need_put = !!rbd_dev->opts;
 
 	ceph_oid_destroy(&rbd_dev->header_oid);
+	ceph_oloc_destroy(&rbd_dev->header_oloc);
 
 	rbd_put_client(rbd_dev->rbd_client);
 	rbd_spec_put(rbd_dev->spec);
-- 
2.4.3

