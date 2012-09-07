From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/9] rbd: get the snapshot context for a v2 image
Date: Fri, 07 Sep 2012 16:13:56 -0500
Message-ID: <504A6394.203@inktank.com>
References: <504A6273.7030807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59251 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757177Ab2IGVN7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:13:59 -0400
Received: by mail-iy0-f174.google.com with SMTP id k25so21774iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:13:58 -0700 (PDT)
In-Reply-To: <504A6273.7030807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Fetch the snapshot context for an rbd format 2 image by calling
the "get_snapcontext" method on its header object.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   85
+++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d48f025..8ff84fd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -62,6 +62,7 @@
 #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */

 #define RBD_MAX_SNAP_NAME_LEN	32
+#define RBD_MAX_SNAP_COUNT	510	/* allows max snapc to fit in 4KB */
 #define RBD_MAX_OPT_LEN		1024

 #define RBD_SNAP_HEAD_NAME	"-"
@@ -2234,6 +2235,84 @@ static int rbd_dev_v2_features(struct rbd_device
*rbd_dev)
 						&rbd_dev->header.features);
 }

+static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
+{
+	size_t size;
+	int ret;
+	void *reply_buf;
+	void *p;
+	void *end;
+	u64 seq;
+	u32 snap_count;
+	struct ceph_snap_context *snapc;
+	u32 i;
+
+	/*
+	 * We'll need room for the seq value (maximum snapshot id),
+	 * snapshot count, and array of that many snapshot ids.
+	 * For now we have a fixed upper limit on the number we're
+	 * prepared to receive.
+	 */
+	size = sizeof (__le64) + sizeof (__le32) +
+			RBD_MAX_SNAP_COUNT * sizeof (__le64);
+	reply_buf = kzalloc(size, GFP_KERNEL);
+	if (!reply_buf)
+		return -ENOMEM;
+
+	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+				"rbd", "get_snapcontext",
+				NULL, 0,
+				reply_buf, size,
+				CEPH_OSD_FLAG_READ, NULL);
+	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	if (ret < 0)
+		goto out;
+
+	ret = -ERANGE;
+	p = reply_buf;
+	end = (char *) reply_buf + size;
+	ceph_decode_64_safe(&p, end, seq, out);
+	ceph_decode_32_safe(&p, end, snap_count, out);
+
+	/*
+	 * Make sure the reported number of snapshot ids wouldn't go
+	 * beyond the end of our buffer.  But before checking that,
+	 * make sure the computed size of the snapshot context we
+	 * allocate is representable in a size_t.
+	 */
+	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
+				 / sizeof (u64)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (!ceph_has_room(&p, end, snap_count * sizeof (__le64)))
+		goto out;
+
+	size = sizeof (struct ceph_snap_context) +
+				snap_count * sizeof (snapc->snaps[0]);
+	snapc = kmalloc(size, GFP_KERNEL);
+	if (!snapc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	atomic_set(&snapc->nref, 1);
+	snapc->seq = seq;
+	snapc->num_snaps = snap_count;
+	for (i = 0; i < snap_count; i++)
+		snapc->snaps[i] = ceph_decode_64(&p);
+
+	rbd_dev->header.snapc = snapc;
+
+	dout("  snap context seq = %llu, snap_count = %u\n",
+		(unsigned long long) seq, (unsigned int) snap_count);
+
+out:
+	kfree(reply_buf);
+
+	return 0;
+}
+
 /*
  * Scan the rbd device's current snapshot list and compare it to the
  * newly-received snapshot context.  Remove any existing snapshots
@@ -2773,6 +2852,12 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 	ret = rbd_dev_v2_features(rbd_dev);
 	if (ret < 0)
 		goto out_err;
+
+	/* Get the snapshot context */
+
+	ret = rbd_dev_v2_snap_context(rbd_dev);
+	if (ret)
+		goto out_err;
 	rbd_dev->image_format = 2;

 	dout("discovered version 2 image, header name is %s\n",
-- 
1.7.9.5

