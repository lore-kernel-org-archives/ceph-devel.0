From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/5] rbd: pass flags to rbd_req_sync_exec()
Date: Tue, 11 Sep 2012 08:14:57 -0700
Message-ID: <504F5571.70409@inktank.com>
References: <504A39E0.1040107@inktank.com> <504A3AA1.6090603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42089 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab2IKPPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 11:15:00 -0400
Received: by pbbrr13 with SMTP id rr13so926664pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 08:15:00 -0700 (PDT)
In-Reply-To: <504A3AA1.6090603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 11:19 AM, Alex Elder wrote:
> In order to allow both read requests and write requests to be
> initiated using rbd_req_sync_exec(), add an OSD flags value
> which can be passed down to rbd_req_sync_op().  Rename the "data"
> and "len" parameters to be more clear that they represent data
> that is outbound.
>
> At this point, this function is still only used (and only works) for
> write requests.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index daa428e3..4e84f99 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1437,23 +1437,33 @@ fail:
>   }
>
>   /*
> - * Request sync osd read
> + * Synchronous osd object method call
>    */
>   static int rbd_req_sync_exec(struct rbd_device *rbd_dev,
>   			     const char *object_name,
>   			     const char *class_name,
>   			     const char *method_name,
> -			     const char *data,
> -			     int len,
> +			     const char *outbound,
> +			     size_t outbound_size,
> +			     int flags,
>   			     u64 *ver)
>   {
>   	struct ceph_osd_req_op *ops;
>   	int class_name_len = strlen(class_name);
>   	int method_name_len = strlen(method_name);
> +	int payload_size;
>   	int ret;
>
> -	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_CALL,
> -				    class_name_len + method_name_len + len);
> +	/*
> +	 * Any input parameters required by the method we're calling
> +	 * will be sent along with the class and method names as
> +	 * part of the message payload.  That data and its size are
> +	 * supplied via the indata and indata_len fields (named from
> +	 * the perspective of the server side) in the OSD request
> +	 * operation.
> +	 */
> +	payload_size = class_name_len + method_name_len + outbound_size;
> +	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_CALL, payload_size);
>   	if (!ops)
>   		return -ENOMEM;
>
> @@ -1462,13 +1472,12 @@ static int rbd_req_sync_exec(struct rbd_device
> *rbd_dev,
>   	ops[0].cls.method_name = method_name;
>   	ops[0].cls.method_len = (__u8) method_name_len;
>   	ops[0].cls.argc = 0;
> -	ops[0].cls.indata = data;
> -	ops[0].cls.indata_len = len;
> +	ops[0].cls.indata = outbound;
> +	ops[0].cls.indata_len = outbound_size;
>
>   	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			       CEPH_NOSNAP,
> -			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> -			       ops,
> +			       flags, ops,
>   			       object_name, 0, 0, NULL, NULL, ver);
>
>   	rbd_destroy_ops(ops);
> @@ -1780,7 +1789,9 @@ static int rbd_header_add_snap(struct rbd_device
> *rbd_dev,
>
>   	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
>   				"rbd", "snap_add",
> -				data, p - data, NULL);
> +				data, (size_t) (p - data),
> +				CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> +				NULL);
>
>   	kfree(data);
>

