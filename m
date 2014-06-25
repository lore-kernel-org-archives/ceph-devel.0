From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 11/14] rbd: add rbd_obj_watch_request_helper() helper
Date: Wed, 25 Jun 2014 21:16:44 +0400
Message-ID: <1403716607-13535-12-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:44583 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671AbaFYRRT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:19 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so999630lab.10
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:18 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id kh4sm4217245lbc.29.2014.06.25.10.17.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:17 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In the past, rbd_dev_header_watch_sync() used to handle both watch and
unwatch requests and was entangled and leaky.  Commit b30a01f2a307
("rbd: fix osd_request memory leak in __rbd_dev_header_watch_sync()")
split it into two separate functions.  This commit cleanly abstracts
the common bits, relying on the fixed rbd_obj_request_wait().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 20147aec86f3..02cf7aba7679 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2971,6 +2971,59 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
 }
 
 /*
+ * Send a (un)watch request and wait for the ack.  Return a request
+ * with a ref held on success or error.
+ */
+static struct rbd_obj_request *rbd_obj_watch_request_helper(
+						struct rbd_device *rbd_dev,
+						bool watch)
+{
+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct rbd_obj_request *obj_request;
+	int ret;
+
+	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
+					     OBJ_REQUEST_NODATA);
+	if (!obj_request)
+		return ERR_PTR(-ENOMEM);
+
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
+						  obj_request);
+	if (!obj_request->osd_req) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
+			      rbd_dev->watch_event->cookie, 0, watch);
+	rbd_osd_req_format_write(obj_request);
+
+	if (watch)
+		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
+
+	ret = rbd_obj_request_submit(osdc, obj_request);
+	if (ret)
+		goto out;
+
+	ret = rbd_obj_request_wait(obj_request);
+	if (ret)
+		goto out;
+
+	ret = obj_request->result;
+	if (ret) {
+		if (watch)
+			rbd_obj_request_end(obj_request);
+		goto out;
+	}
+
+	return obj_request;
+
+out:
+	rbd_obj_request_put(obj_request);
+	return ERR_PTR(ret);
+}
+
+/*
  * Initiate a watch request, synchronously.
  */
 static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
-- 
1.7.10.4

