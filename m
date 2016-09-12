From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 08/47] block-rbd: Rename jump labels in
 rbd_dev_v2_snap_context()
Date: Mon, 12 Sep 2016 20:49:50 +0200
Message-ID: <81e205ce-9e99-397d-79dc-d06da3921fa1@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:65402 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754071AbcILSuC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 14:50:02 -0400
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 17:55:51 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4164551..45109ff 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5465,13 +5465,13 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
 				reply_buf, size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
-		goto out;
+		goto free_buffer;
 
 	p = reply_buf;
 	end = reply_buf + ret;
 	ret = -ERANGE;
-	ceph_decode_64_safe(&p, end, seq, out);
-	ceph_decode_32_safe(&p, end, snap_count, out);
+	ceph_decode_64_safe(&p, end, seq, free_buffer);
+	ceph_decode_32_safe(&p, end, snap_count, free_buffer);
 
 	/*
 	 * Make sure the reported number of snapshot ids wouldn't go
@@ -5482,16 +5482,16 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
 	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
 				 / sizeof (u64)) {
 		ret = -EINVAL;
-		goto out;
+		goto free_buffer;
 	}
 	if (!ceph_has_room(&p, end, snap_count * sizeof (__le64)))
-		goto out;
+		goto free_buffer;
 	ret = 0;
 
 	snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
 	if (!snapc) {
 		ret = -ENOMEM;
-		goto out;
+		goto free_buffer;
 	}
 	snapc->seq = seq;
 	for (i = 0; i < snap_count; i++)
@@ -5502,7 +5502,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
 
 	dout("  snap context seq = %llu, snap_count = %u\n",
 		(unsigned long long)seq, (unsigned int)snap_count);
-out:
+ free_buffer:
 	kfree(reply_buf);
 
 	return ret;
-- 
2.10.0

