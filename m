From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 12/16] rbd: use rbd_dev consistently
Date: Wed, 11 Jul 2012 13:56:19 -0700
Message-ID: <4FFDE873.3000703@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD877F.404@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62888 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab2GKU4W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 16:56:22 -0400
Received: by pbbrp8 with SMTP id rp8so2543437pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 13:56:21 -0700 (PDT)
In-Reply-To: <4FFD877F.404@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 07/11/2012 07:02 AM, Alex Elder wrote:
> Most variables that represent a struct rbd_device are named
> "rbd_dev", but in some cases "dev" is used instead.  Change all the
> "dev" references so they use "rbd_dev" consistently, to make it
> clear from the name that we're working with an RBD device (as
> opposed to, for example, a struct device).  Similarly, change the
> name of the "dev" field in struct rbd_notify_info to be "rbd_dev".
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   drivers/block/rbd.c |  125
> ++++++++++++++++++++++++++-------------------------
>   1 files changed, 64 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 90fb388..c38246b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -581,35 +581,36 @@ static int snap_by_name(struct rbd_image_header
> *header, const char *snap_name,
>   	return -ENOENT;
>   }
>
> -static int rbd_header_set_snap(struct rbd_device *dev, u64 *size)
> +static int rbd_header_set_snap(struct rbd_device *rbd_dev, u64 *size)
>   {
> -	struct rbd_image_header *header =&dev->header;
> +	struct rbd_image_header *header =&rbd_dev->header;
>   	struct ceph_snap_context *snapc = header->snapc;
>   	int ret = -ENOENT;
>
> -	down_write(&dev->header_rwsem);
> +	down_write(&rbd_dev->header_rwsem);
>
> -	if (!memcmp(dev->snap_name, RBD_SNAP_HEAD_NAME,
> +	if (!memcmp(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>   		    sizeof (RBD_SNAP_HEAD_NAME))) {
>   		if (header->total_snaps)
>   			snapc->seq = header->snap_seq;
>   		else
>   			snapc->seq = 0;
> -		dev->snap_id = CEPH_NOSNAP;
> -		dev->read_only = 0;
> +		rbd_dev->snap_id = CEPH_NOSNAP;
> +		rbd_dev->read_only = 0;
>   		if (size)
>   			*size = header->image_size;
>   	} else {
> -		ret = snap_by_name(header, dev->snap_name,&snapc->seq, size);
> +		ret = snap_by_name(header, rbd_dev->snap_name,
> +					&snapc->seq, size);
>   		if (ret<  0)
>   			goto done;
> -		dev->snap_id = snapc->seq;
> -		dev->read_only = 1;
> +		rbd_dev->snap_id = snapc->seq;
> +		rbd_dev->read_only = 1;
>   	}
>
>   	ret = 0;
>   done:
> -	up_write(&dev->header_rwsem);
> +	up_write(&rbd_dev->header_rwsem);
>   	return ret;
>   }
>
> @@ -853,7 +854,7 @@ static void rbd_coll_end_req(struct rbd_request *req,
>    * Send ceph osd request
>    */
>   static int rbd_do_request(struct request *rq,
> -			  struct rbd_device *dev,
> +			  struct rbd_device *rbd_dev,
>   			  struct ceph_snap_context *snapc,
>   			  u64 snapid,
>   			  const char *obj, u64 ofs, u64 len,
> @@ -894,13 +895,13 @@ static int rbd_do_request(struct request *rq,
>
>   	dout("rbd_do_request obj=%s ofs=%lld len=%lld\n", obj, len, ofs);
>
> -	down_read(&dev->header_rwsem);
> +	down_read(&rbd_dev->header_rwsem);
>
> -	osdc =&dev->rbd_client->client->osdc;
> +	osdc =&rbd_dev->rbd_client->client->osdc;
>   	req = ceph_osdc_alloc_request(osdc, flags, snapc, ops,
>   					false, GFP_NOIO, pages, bio);
>   	if (!req) {
> -		up_read(&dev->header_rwsem);
> +		up_read(&rbd_dev->header_rwsem);
>   		ret = -ENOMEM;
>   		goto done_pages;
>   	}
> @@ -925,7 +926,7 @@ static int rbd_do_request(struct request *rq,
>   	layout->fl_stripe_unit = cpu_to_le32(1<<  RBD_MAX_OBJ_ORDER);
>   	layout->fl_stripe_count = cpu_to_le32(1);
>   	layout->fl_object_size = cpu_to_le32(1<<  RBD_MAX_OBJ_ORDER);
> -	layout->fl_pg_pool = cpu_to_le32(dev->pool_id);
> +	layout->fl_pg_pool = cpu_to_le32(rbd_dev->pool_id);
>   	ceph_calc_raw_layout(osdc, layout, snapid, ofs,&len,&bno,
>   				req, ops);
>
> @@ -934,7 +935,7 @@ static int rbd_do_request(struct request *rq,
>   				snapc,
>   				&mtime,
>   				req->r_oid, req->r_oid_len);
> -	up_read(&dev->header_rwsem);
> +	up_read(&rbd_dev->header_rwsem);
>
>   	if (linger_req) {
>   		ceph_osdc_set_request_linger(osdc, req);
> @@ -1011,7 +1012,7 @@ static void rbd_simple_req_cb(struct
> ceph_osd_request *req, struct ceph_msg *msg
>   /*
>    * Do a synchronous ceph osd operation
>    */
> -static int rbd_req_sync_op(struct rbd_device *dev,
> +static int rbd_req_sync_op(struct rbd_device *rbd_dev,
>   			   struct ceph_snap_context *snapc,
>   			   u64 snapid,
>   			   int opcode,
> @@ -1048,7 +1049,7 @@ static int rbd_req_sync_op(struct rbd_device *dev,
>   		}
>   	}
>
> -	ret = rbd_do_request(NULL, dev, snapc, snapid,
> +	ret = rbd_do_request(NULL, rbd_dev, snapc, snapid,
>   			  obj, ofs, len, NULL,
>   			  pages, num_pages,
>   			  flags,
> @@ -1075,7 +1076,7 @@ done:
>    * Do an asynchronous ceph osd operation
>    */
>   static int rbd_do_op(struct request *rq,
> -		     struct rbd_device *rbd_dev ,
> +		     struct rbd_device *rbd_dev,
>   		     struct ceph_snap_context *snapc,
>   		     u64 snapid,
>   		     int opcode, int flags, int num_reply,
> @@ -1167,7 +1168,7 @@ static int rbd_req_read(struct request *rq,
>   /*
>    * Request sync osd read
>    */
> -static int rbd_req_sync_read(struct rbd_device *dev,
> +static int rbd_req_sync_read(struct rbd_device *rbd_dev,
>   			  struct ceph_snap_context *snapc,
>   			  u64 snapid,
>   			  const char *obj,
> @@ -1175,7 +1176,7 @@ static int rbd_req_sync_read(struct rbd_device *dev,
>   			  char *buf,
>   			  u64 *ver)
>   {
> -	return rbd_req_sync_op(dev, NULL,
> +	return rbd_req_sync_op(rbd_dev, NULL,
>   			       snapid,
>   			       CEPH_OSD_OP_READ,
>   			       CEPH_OSD_FLAG_READ,
> @@ -1186,7 +1187,7 @@ static int rbd_req_sync_read(struct rbd_device *dev,
>   /*
>    * Request sync osd watch
>    */
> -static int rbd_req_sync_notify_ack(struct rbd_device *dev,
> +static int rbd_req_sync_notify_ack(struct rbd_device *rbd_dev,
>   				   u64 ver,
>   				   u64 notify_id,
>   				   const char *obj)
> @@ -1198,11 +1199,11 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *dev,
>   	if (ret<  0)
>   		return ret;
>
> -	ops[0].watch.ver = cpu_to_le64(dev->header.obj_version);
> +	ops[0].watch.ver = cpu_to_le64(rbd_dev->header.obj_version);
>   	ops[0].watch.cookie = notify_id;
>   	ops[0].watch.flag = 0;
>
> -	ret = rbd_do_request(NULL, dev, NULL, CEPH_NOSNAP,
> +	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
>   			  obj, 0, 0, NULL,
>   			  NULL, 0,
>   			  CEPH_OSD_FLAG_READ,
> @@ -1217,54 +1218,54 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *dev,
>
>   static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
>   {
> -	struct rbd_device *dev = (struct rbd_device *)data;
> +	struct rbd_device *rbd_dev = (struct rbd_device *)data;
>   	int rc;
>
> -	if (!dev)
> +	if (!rbd_dev)
>   		return;
>
> -	dout("rbd_watch_cb %s notify_id=%lld opcode=%d\n", dev->obj_md_name,
> +	dout("rbd_watch_cb %s notify_id=%lld opcode=%d\n", rbd_dev->obj_md_name,
>   		notify_id, (int)opcode);
>   	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> -	rc = __rbd_refresh_header(dev);
> +	rc = __rbd_refresh_header(rbd_dev);
>   	mutex_unlock(&ctl_mutex);
>   	if (rc)
>   		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
> -			   " update snaps: %d\n", dev->major, rc);
> +			   " update snaps: %d\n", rbd_dev->major, rc);
>
> -	rbd_req_sync_notify_ack(dev, ver, notify_id, dev->obj_md_name);
> +	rbd_req_sync_notify_ack(rbd_dev, ver, notify_id, rbd_dev->obj_md_name);
>   }
>
>   /*
>    * Request sync osd watch
>    */
> -static int rbd_req_sync_watch(struct rbd_device *dev,
> +static int rbd_req_sync_watch(struct rbd_device *rbd_dev,
>   			      const char *obj,
>   			      u64 ver)
>   {
>   	struct ceph_osd_req_op *ops;
> -	struct ceph_osd_client *osdc =&dev->rbd_client->client->osdc;
> +	struct ceph_osd_client *osdc =&rbd_dev->rbd_client->client->osdc;
>
>   	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_WATCH, 0);
>   	if (ret<  0)
>   		return ret;
>
>   	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0,
> -				     (void *)dev,&dev->watch_event);
> +				     (void *)rbd_dev,&rbd_dev->watch_event);
>   	if (ret<  0)
>   		goto fail;
>
>   	ops[0].watch.ver = cpu_to_le64(ver);
> -	ops[0].watch.cookie = cpu_to_le64(dev->watch_event->cookie);
> +	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
>   	ops[0].watch.flag = 1;
>
> -	ret = rbd_req_sync_op(dev, NULL,
> +	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			      CEPH_NOSNAP,
>   			      0,
>   			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			      ops,
>   			      1, obj, 0, 0, NULL,
> -			&dev->watch_request, NULL);
> +			&rbd_dev->watch_request, NULL);
>
>   	if (ret<  0)
>   		goto fail_event;
> @@ -1273,8 +1274,8 @@ static int rbd_req_sync_watch(struct rbd_device *dev,
>   	return 0;
>
>   fail_event:
> -	ceph_osdc_cancel_event(dev->watch_event);
> -	dev->watch_event = NULL;
> +	ceph_osdc_cancel_event(rbd_dev->watch_event);
> +	rbd_dev->watch_event = NULL;
>   fail:
>   	rbd_destroy_ops(ops);
>   	return ret;
> @@ -1283,7 +1284,7 @@ fail:
>   /*
>    * Request sync osd unwatch
>    */
> -static int rbd_req_sync_unwatch(struct rbd_device *dev,
> +static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev,
>   				const char *obj)
>   {
>   	struct ceph_osd_req_op *ops;
> @@ -1293,10 +1294,10 @@ static int rbd_req_sync_unwatch(struct
> rbd_device *dev,
>   		return ret;
>
>   	ops[0].watch.ver = 0;
> -	ops[0].watch.cookie = cpu_to_le64(dev->watch_event->cookie);
> +	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
>   	ops[0].watch.flag = 0;
>
> -	ret = rbd_req_sync_op(dev, NULL,
> +	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			      CEPH_NOSNAP,
>   			      0,
>   			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> @@ -1304,33 +1305,34 @@ static int rbd_req_sync_unwatch(struct
> rbd_device *dev,
>   			      1, obj, 0, 0, NULL, NULL, NULL);
>
>   	rbd_destroy_ops(ops);
> -	ceph_osdc_cancel_event(dev->watch_event);
> -	dev->watch_event = NULL;
> +	ceph_osdc_cancel_event(rbd_dev->watch_event);
> +	rbd_dev->watch_event = NULL;
>   	return ret;
>   }
>
>   struct rbd_notify_info {
> -	struct rbd_device *dev;
> +	struct rbd_device *rbd_dev;
>   };
>
>   static void rbd_notify_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
>   {
> -	struct rbd_device *dev = (struct rbd_device *)data;
> -	if (!dev)
> +	struct rbd_device *rbd_dev = (struct rbd_device *)data;
> +	if (!rbd_dev)
>   		return;
>
> -	dout("rbd_notify_cb %s notify_id=%lld opcode=%d\n", dev->obj_md_name,
> +	dout("rbd_notify_cb %s notify_id=%lld opcode=%d\n",
> +				rbd_dev->obj_md_name,
>   		notify_id, (int)opcode);
>   }
>
>   /*
>    * Request sync osd notify
>    */
> -static int rbd_req_sync_notify(struct rbd_device *dev,
> +static int rbd_req_sync_notify(struct rbd_device *rbd_dev,
>   		          const char *obj)
>   {
>   	struct ceph_osd_req_op *ops;
> -	struct ceph_osd_client *osdc =&dev->rbd_client->client->osdc;
> +	struct ceph_osd_client *osdc =&rbd_dev->rbd_client->client->osdc;
>   	struct ceph_osd_event *event;
>   	struct rbd_notify_info info;
>   	int payload_len = sizeof(u32) + sizeof(u32);
> @@ -1340,7 +1342,7 @@ static int rbd_req_sync_notify(struct rbd_device *dev,
>   	if (ret<  0)
>   		return ret;
>
> -	info.dev = dev;
> +	info.rbd_dev = rbd_dev;
>
>   	ret = ceph_osdc_create_event(osdc, rbd_notify_cb, 1,
>   				     (void *)&info,&event);
> @@ -1353,7 +1355,7 @@ static int rbd_req_sync_notify(struct rbd_device *dev,
>   	ops[0].watch.prot_ver = RADOS_NOTIFY_VER;
>   	ops[0].watch.timeout = 12;
>
> -	ret = rbd_req_sync_op(dev, NULL,
> +	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			       CEPH_NOSNAP,
>   			       0,
>   			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> @@ -1377,7 +1379,7 @@ fail:
>   /*
>    * Request sync osd read
>    */
> -static int rbd_req_sync_exec(struct rbd_device *dev,
> +static int rbd_req_sync_exec(struct rbd_device *rbd_dev,
>   			     const char *obj,
>   			     const char *cls,
>   			     const char *method,
> @@ -1401,7 +1403,7 @@ static int rbd_req_sync_exec(struct rbd_device *dev,
>   	ops[0].cls.indata = data;
>   	ops[0].cls.indata_len = len;
>
> -	ret = rbd_req_sync_op(dev, NULL,
> +	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			       CEPH_NOSNAP,
>   			       0,
>   			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> @@ -1632,7 +1634,7 @@ out_dh:
>   /*
>    * create a snapshot
>    */
> -static int rbd_header_add_snap(struct rbd_device *dev,
> +static int rbd_header_add_snap(struct rbd_device *rbd_dev,
>   			       const char *snap_name,
>   			       gfp_t gfp_flags)
>   {
> @@ -1644,11 +1646,11 @@ static int rbd_header_add_snap(struct rbd_device
> *dev,
>   	struct ceph_mon_client *monc;
>
>   	/* we should create a snapshot only if we're pointing at the head */
> -	if (dev->snap_id != CEPH_NOSNAP)
> +	if (rbd_dev->snap_id != CEPH_NOSNAP)
>   		return -EINVAL;
>
> -	monc =&dev->rbd_client->client->monc;
> -	ret = ceph_monc_create_snapid(monc, dev->pool_id,&new_snapid);
> +	monc =&rbd_dev->rbd_client->client->monc;
> +	ret = ceph_monc_create_snapid(monc, rbd_dev->pool_id,&new_snapid);
>   	dout("created snapid=%lld\n", new_snapid);
>   	if (ret<  0)
>   		return ret;
> @@ -1663,7 +1665,8 @@ static int rbd_header_add_snap(struct rbd_device *dev,
>   	ceph_encode_string_safe(&p, e, snap_name, name_len, bad);
>   	ceph_encode_64_safe(&p, e, new_snapid, bad);
>
> -	ret = rbd_req_sync_exec(dev, dev->obj_md_name, "rbd", "snap_add",
> +	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->obj_md_name,
> +				"rbd", "snap_add",
>   				data, p - data,&ver);
>
>   	kfree(data);
> @@ -1671,9 +1674,9 @@ static int rbd_header_add_snap(struct rbd_device *dev,
>   	if (ret<  0)
>   		return ret;
>
> -	down_write(&dev->header_rwsem);
> -	dev->header.snapc->seq = new_snapid;
> -	up_write(&dev->header_rwsem);
> +	down_write(&rbd_dev->header_rwsem);
> +	rbd_dev->header.snapc->seq = new_snapid;
> +	up_write(&rbd_dev->header_rwsem);
>
>   	return 0;
>   bad:

