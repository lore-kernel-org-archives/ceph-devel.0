From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/7] rbd: make rbd_create_rw_ops() return a pointer
Date: Mon, 30 Jul 2012 13:46:19 -0700
Message-ID: <5016F29B.7010001@inktank.com>
References: <50119421.1090702@inktank.com> <501195B2.1050503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42536 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195Ab2G3UqW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 16:46:22 -0400
Received: by pbbrp8 with SMTP id rp8so10399586pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 13:46:22 -0700 (PDT)
In-Reply-To: <501195B2.1050503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 12:08 PM, Alex Elder wrote:
> Either rbd_create_rw_ops() will succeed, or it will fail because a
> memory allocation failed.  Have it just return a valid pointer or
> null rather than stuffing a pointer into a provided address and
> returning an errno.
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |   70
> ++++++++++++++++++++++++++++-----------------------
>   1 file changed, 39 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fd91964..4d8b52c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -789,22 +789,24 @@ err_out:
>   /*
>    * helpers for osd request op vectors.
>    */
> -static int rbd_create_rw_ops(struct ceph_osd_req_op **ops,
> -			    int num_ops,
> -			    int opcode,
> -			    u32 payload_len)
> -{
> -	*ops = kzalloc(sizeof(struct ceph_osd_req_op) * (num_ops + 1),
> -		       GFP_NOIO);
> -	if (!*ops)
> -		return -ENOMEM;
> -	(*ops)[0].op = opcode;
> +static struct ceph_osd_req_op *rbd_create_rw_ops(int num_ops,
> +					int opcode, u32 payload_len)
> +{
> +	struct ceph_osd_req_op *ops;
> +
> +	ops = kzalloc(sizeof (*ops) * (num_ops + 1), GFP_NOIO);
> +	if (!ops)
> +		return NULL;
> +
> +	ops[0].op = opcode;
> +
>   	/*
>   	 * op extent offset and length will be set later on
>   	 * in calc_raw_layout()
>   	 */
> -	(*ops)[0].payload_len = payload_len;
> -	return 0;
> +	ops[0].payload_len = payload_len;
> +
> +	return ops;
>   }
>
>   static void rbd_destroy_ops(struct ceph_osd_req_op *ops)
> @@ -1039,8 +1041,9 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
>
>   	if (!orig_ops) {
>   		payload_len = (flags & CEPH_OSD_FLAG_WRITE ? len : 0);
> -		ret = rbd_create_rw_ops(&ops, 1, opcode, payload_len);
> -		if (ret < 0)
> +		ret = -ENOMEM;
> +		ops = rbd_create_rw_ops(1, opcode, payload_len);
> +		if (!ops)
>   			goto done;
>
>   		if ((flags & CEPH_OSD_FLAG_WRITE) && buf) {
> @@ -1103,8 +1106,9 @@ static int rbd_do_op(struct request *rq,
>
>   	payload_len = (flags & CEPH_OSD_FLAG_WRITE ? seg_len : 0);
>
> -	ret = rbd_create_rw_ops(&ops, 1, opcode, payload_len);
> -	if (ret < 0)
> +	ret = -ENOMEM;
> +	ops = rbd_create_rw_ops(1, opcode, payload_len);
> +	if (!ops)
>   		goto done;
>
>   	/* we've taken care of segment sizes earlier when we
> @@ -1190,9 +1194,9 @@ static int rbd_req_sync_notify_ack(struct
> rbd_device *rbd_dev,
>   	struct ceph_osd_req_op *ops;
>   	int ret;
>
> -	ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_NOTIFY_ACK, 0);
> -	if (ret < 0)
> -		return ret;
> +	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_NOTIFY_ACK, 0);
> +	if (!ops)
> +		return -ENOMEM;
>
>   	ops[0].watch.ver = cpu_to_le64(ver);
>   	ops[0].watch.cookie = notify_id;
> @@ -1239,10 +1243,11 @@ static int rbd_req_sync_watch(struct rbd_device
> *rbd_dev)
>   {
>   	struct ceph_osd_req_op *ops;
>   	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> +	int ret;
>
> -	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_WATCH, 0);
> -	if (ret < 0)
> -		return ret;
> +	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_WATCH, 0);
> +	if (!ops)
> +		return -ENOMEM;
>
>   	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0,
>   				     (void *)rbd_dev, &rbd_dev->watch_event);
> @@ -1282,10 +1287,11 @@ fail:
>   static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev)
>   {
>   	struct ceph_osd_req_op *ops;
> +	int ret;
>
> -	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_WATCH, 0);
> -	if (ret < 0)
> -		return ret;
> +	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_WATCH, 0);
> +	if (!ops)
> +		return -ENOMEM;
>
>   	ops[0].watch.ver = 0;
>   	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
> @@ -1332,9 +1338,9 @@ static int rbd_req_sync_notify(struct rbd_device
> *rbd_dev)
>   	int payload_len = sizeof(u32) + sizeof(u32);
>   	int ret;
>
> -	ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_NOTIFY, payload_len);
> -	if (ret < 0)
> -		return ret;
> +	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_NOTIFY, payload_len);
> +	if (!ops)
> +		return -ENOMEM;
>
>   	info.rbd_dev = rbd_dev;
>
> @@ -1385,10 +1391,12 @@ static int rbd_req_sync_exec(struct rbd_device
> *rbd_dev,
>   	struct ceph_osd_req_op *ops;
>   	int class_name_len = strlen(class_name);
>   	int method_name_len = strlen(method_name);
> -	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_CALL,
> +	int ret;
> +
> +	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_CALL,
>   				    class_name_len + method_name_len + len);
> -	if (ret < 0)
> -		return ret;
> +	if (!ops)
> +		return -ENOMEM;
>
>   	ops[0].cls.class_name = class_name;
>   	ops[0].cls.class_len = (__u8) class_name_len;
>

