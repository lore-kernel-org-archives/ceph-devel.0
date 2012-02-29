From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/4] rbd: do not duplicate ceph_client pointer in rbd_device
Date: Tue, 28 Feb 2012 19:35:11 -0800
Message-ID: <4F4D9CEF.90109@dreamhost.com>
References: <4F4D9BF6.5070102@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51012 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030712Ab2B2DfM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:35:12 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id EF95924318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:11 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id DD05124314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:11 -0800 (PST)
In-Reply-To: <4F4D9BF6.5070102@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rbd_device structure maintains a duplicate copy of the
ceph_client pointer maintained in its rbd_client structure.  There
appears to be no good reason for this, and its presence presents a
risk of them getting out of synch or otherwise misused.  So kill it
off, and use the rbd_client copy only.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   44 ++++++++++++++++++++++----------------------
  1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0430642..3d0f8cf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -140,7 +140,6 @@ struct rbd_device {
  	struct gendisk		*disk;		/* blkdev's gendisk and rq */
  	struct request_queue	*q;

-	struct ceph_client	*client;
  	struct rbd_client	*rbd_client;

  	char			name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
@@ -388,7 +387,6 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  		/* using an existing client */
  		kref_get(&rbdc->kref);
  		rbd_dev->rbd_client = rbdc;
-		rbd_dev->client = rbdc->client;
  		spin_unlock(&node_lock);
  		return 0;
  	}
@@ -401,7 +399,6 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  	}

  	rbd_dev->rbd_client = rbdc;
-	rbd_dev->client = rbdc->client;
  	return 0;
  done_err:
  	kfree(rbd_opts);
@@ -435,7 +432,6 @@ static void rbd_put_client(struct rbd_device *rbd_dev)
  	kref_put(&rbd_dev->rbd_client->kref, rbd_client_release);
  	spin_unlock(&node_lock);
  	rbd_dev->rbd_client = NULL;
-	rbd_dev->client = NULL;
  }

  /*
@@ -858,6 +854,7 @@ static int rbd_do_request(struct request *rq,
  	struct rbd_request *req_data;
  	struct ceph_osd_request_head *reqhead;
  	struct rbd_image_header *header = &dev->header;
+	struct ceph_osd_client *osdc;

  	req_data = kzalloc(sizeof(*req_data), GFP_NOIO);
  	if (!req_data) {
@@ -876,11 +873,9 @@ static int rbd_do_request(struct request *rq,

  	down_read(&header->snap_rwsem);

-	req = ceph_osdc_alloc_request(&dev->client->osdc, flags,
-				      snapc,
-				      ops,
-				      false,
-				      GFP_NOIO, pages, bio);
+	osdc = &dev->rbd_client->client->osdc;
+	req = ceph_osdc_alloc_request(osdc, flags, snapc, ops,
+					false, GFP_NOIO, pages, bio);
  	if (!req) {
  		up_read(&header->snap_rwsem);
  		ret = -ENOMEM;
@@ -909,8 +904,8 @@ static int rbd_do_request(struct request *rq,
  	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
  	layout->fl_pg_preferred = cpu_to_le32(-1);
  	layout->fl_pg_pool = cpu_to_le32(dev->poolid);
-	ceph_calc_raw_layout(&dev->client->osdc, layout, snapid,
-			     ofs, &len, &bno, req, ops);
+	ceph_calc_raw_layout(osdc, layout, snapid, ofs, &len, &bno,
+				req, ops);

  	ceph_osdc_build_request(req, ofs, &len,
  				ops,
@@ -920,16 +915,16 @@ static int rbd_do_request(struct request *rq,
  	up_read(&header->snap_rwsem);

  	if (linger_req) {
-		ceph_osdc_set_request_linger(&dev->client->osdc, req);
+		ceph_osdc_set_request_linger(osdc, req);
  		*linger_req = req;
  	}

-	ret = ceph_osdc_start_request(&dev->client->osdc, req, false);
+	ret = ceph_osdc_start_request(osdc, req, false);
  	if (ret < 0)
  		goto done_err;

  	if (!rbd_cb) {
-		ret = ceph_osdc_wait_request(&dev->client->osdc, req);
+		ret = ceph_osdc_wait_request(osdc, req);
  		if (ver)
  			*ver = le64_to_cpu(req->r_reassert_version.version);
  		dout("reassert_ver=%lld\n",
@@ -1227,7 +1222,7 @@ static int rbd_req_sync_watch(struct rbd_device *dev,
  			      u64 ver)
  {
  	struct ceph_osd_req_op *ops;
-	struct ceph_osd_client *osdc = &dev->client->osdc;
+	struct ceph_osd_client *osdc = &dev->rbd_client->client->osdc;

  	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_WATCH, 0);
  	if (ret < 0)
@@ -1314,7 +1309,7 @@ static int rbd_req_sync_notify(struct rbd_device *dev,
  		          const char *obj)
  {
  	struct ceph_osd_req_op *ops;
-	struct ceph_osd_client *osdc = &dev->client->osdc;
+	struct ceph_osd_client *osdc = &dev->rbd_client->client->osdc;
  	struct ceph_osd_event *event;
  	struct rbd_notify_info info;
  	int payload_len = sizeof(u32) + sizeof(u32);
@@ -1623,13 +1618,14 @@ static int rbd_header_add_snap(struct rbd_device 
*dev,
  	int ret;
  	void *data, *p, *e;
  	u64 ver;
+	struct ceph_mon_client *monc;

  	/* we should create a snapshot only if we're pointing at the head */
  	if (dev->cur_snap)
  		return -EINVAL;

-	ret = ceph_monc_create_snapid(&dev->client->monc, dev->poolid,
-				      &new_snapid);
+	monc = &dev->rbd_client->client->monc;
+	ret = ceph_monc_create_snapid(monc, dev->poolid, &new_snapid);
  	dout("created snapid=%lld\n", new_snapid);
  	if (ret < 0)
  		return ret;
@@ -1809,7 +1805,8 @@ static ssize_t rbd_client_id_show(struct device *dev,
  {
  	struct rbd_device *rbd_dev = dev_to_rbd(dev);

-	return sprintf(buf, "client%lld\n", ceph_client_id(rbd_dev->client));
+	return sprintf(buf, "client%lld\n",
+			ceph_client_id(rbd_dev->rbd_client->client));
  }

  static ssize_t rbd_pool_show(struct device *dev,
@@ -2231,7 +2228,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	mutex_unlock(&ctl_mutex);

  	/* pick the pool */
-	osdc = &rbd_dev->client->osdc;
+	osdc = &rbd_dev->rbd_client->client->osdc;
  	rc = ceph_pg_poolid_by_name(osdc->osdmap, rbd_dev->pool_name);
  	if (rc < 0)
  		goto err_out_client;
@@ -2310,9 +2307,12 @@ static void rbd_dev_release(struct device *dev)
  	struct rbd_device *rbd_dev =
  			container_of(dev, struct rbd_device, dev);

-	if (rbd_dev->watch_request)
-		ceph_osdc_unregister_linger_request(&rbd_dev->client->osdc,
+	if (rbd_dev->watch_request) {
+		struct ceph_client *client = rbd_dev->rbd_client->client;
+
+		ceph_osdc_unregister_linger_request(&client->osdc,
  						    rbd_dev->watch_request);
+	}
  	if (rbd_dev->watch_event)
  		rbd_req_sync_unwatch(rbd_dev, rbd_dev->obj_md_name);

-- 
1.7.5.4

