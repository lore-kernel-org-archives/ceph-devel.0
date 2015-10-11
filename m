From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: don't leak parent_spec in rbd_dev_probe_parent()
Date: Sun, 11 Oct 2015 20:03:11 +0200
Message-ID: <1444586591-24141-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33049 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbJKQXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Oct 2015 12:23:30 -0400
Received: by wiclk2 with SMTP id lk2so124830807wic.0
        for <ceph-devel@vger.kernel.org>; Sun, 11 Oct 2015 09:23:29 -0700 (PDT)
Received: from orange.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x7sm7358104wia.10.2015.10.11.09.23.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2015 09:23:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently we leak parent_spec and trigger a "parent reference
underflow" warning if rbd_dev_create() in rbd_dev_probe_parent() fails.
The problem is we take the !parent out_err branch and that only drops
refcounts; parent_spec that would've been freed had we called
rbd_dev_unparent() remains and triggers rbd_warn() in
rbd_dev_parent_put() - at that point we have parent_spec != NULL and
parent_ref == 0, so counter ends up being -1 after the decrement.

Redo rbd_dev_probe_parent() to fix this.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cd00e4653e49..ccbc3cbbf24e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5134,41 +5134,37 @@ out_err:
 static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
 {
 	struct rbd_device *parent = NULL;
-	struct rbd_spec *parent_spec;
-	struct rbd_client *rbdc;
 	int ret;
 
 	if (!rbd_dev->parent_spec)
 		return 0;
-	/*
-	 * We need to pass a reference to the client and the parent
-	 * spec when creating the parent rbd_dev.  Images related by
-	 * parent/child relationships always share both.
-	 */
-	parent_spec = rbd_spec_get(rbd_dev->parent_spec);
-	rbdc = __rbd_get_client(rbd_dev->rbd_client);
 
-	ret = -ENOMEM;
-	parent = rbd_dev_create(rbdc, parent_spec, NULL);
-	if (!parent)
+	parent = rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec,
+				NULL);
+	if (!parent) {
+		ret = -ENOMEM;
 		goto out_err;
+	}
+
+	/*
+	 * Images related by parent/child relationships always share
+	 * rbd_client and spec/parent_spec, so bump their refcounts.
+	 */
+	__rbd_get_client(rbd_dev->rbd_client);
+	rbd_spec_get(rbd_dev->parent_spec);
 
 	ret = rbd_dev_image_probe(parent, false);
 	if (ret < 0)
 		goto out_err;
+
 	rbd_dev->parent = parent;
 	atomic_set(&rbd_dev->parent_ref, 1);
-
 	return 0;
+
 out_err:
-	if (parent) {
-		rbd_dev_unparent(rbd_dev);
+	rbd_dev_unparent(rbd_dev);
+	if (parent)
 		rbd_dev_destroy(parent);
-	} else {
-		rbd_put_client(rbdc);
-		rbd_spec_put(parent_spec);
-	}
-
 	return ret;
 }
 
-- 
2.4.3

