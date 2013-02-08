From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: add barriers near done flag operations
Date: Fri, 08 Feb 2013 13:44:37 -0800
Message-ID: <511571C5.1020200@inktank.com>
References: <51127469.1070903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57993 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947110Ab3BHVpJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 16:45:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2269938pab.5
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 13:45:08 -0800 (PST)
In-Reply-To: <51127469.1070903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/06/2013 07:19 AM, Alex Elder wrote:
> Somehow, I missed this little item in Documentation/atomic_ops.txt:
>      *** WARNING: atomic_read() and atomic_set() DO NOT IMPLY BARRIERS! ***
>
> Create and use some helper functions that include the proper memory
> barriers for manipulating the done field.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 91983a60..982963e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1216,10 +1216,28 @@ static int rbd_obj_request_wait(struct
> rbd_obj_request *obj_request)
>   	return wait_for_completion_interruptible(&obj_request->completion);
>   }
>
> +static void obj_request_done_init(struct rbd_obj_request *obj_request)
> +{
> +	atomic_set(&obj_request->done, 0);
> +	smp_wmb();
> +}
> +
> +static void obj_request_done_set(struct rbd_obj_request *obj_request)
> +{
> +	atomic_set(&obj_request->done, 1);
> +	smp_wmb();
> +}
> +
> +static bool obj_request_done_test(struct rbd_obj_request *obj_request)
> +{
> +	smp_rmb();
> +	return atomic_read(&obj_request->done) != 0;
> +}
> +
>   static void rbd_osd_trivial_callback(struct rbd_obj_request *obj_request,
>   				struct ceph_osd_op *op)
>   {
> -	atomic_set(&obj_request->done, 1);
> +	obj_request_done_set(obj_request);
>   }
>
>   static void rbd_obj_request_complete(struct rbd_obj_request *obj_request)
> @@ -1249,14 +1267,14 @@ static void rbd_osd_read_callback(struct
> rbd_obj_request *obj_request,
>   		xferred = obj_request->length;
>   	}
>   	obj_request->xferred = xferred;
> -	atomic_set(&obj_request->done, 1);
> +	obj_request_done_set(obj_request);
>   }
>
>   static void rbd_osd_write_callback(struct rbd_obj_request *obj_request,
>   				struct ceph_osd_op *op)
>   {
>   	obj_request->xferred = le64_to_cpu(op->extent.length);
> -	atomic_set(&obj_request->done, 1);
> +	obj_request_done_set(obj_request);
>   }
>
>   static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
> @@ -1300,7 +1318,7 @@ static void rbd_osd_req_callback(struct
> ceph_osd_request *osd_req,
>   		break;
>   	}
>
> -	if (atomic_read(&obj_request->done))
> +	if (obj_request_done_test(obj_request))
>   		rbd_obj_request_complete(obj_request);
>   }
>
> @@ -1407,7 +1425,7 @@ static struct rbd_obj_request
> *rbd_obj_request_create(const char *object_name,
>   	obj_request->which = BAD_WHICH;
>   	obj_request->type = type;
>   	INIT_LIST_HEAD(&obj_request->links);
> -	atomic_set(&obj_request->done, 0);
> +	obj_request_done_init(obj_request);
>   	init_completion(&obj_request->completion);
>   	kref_init(&obj_request->kref);
>
> @@ -1611,7 +1629,7 @@ static void rbd_img_obj_callback(struct
> rbd_obj_request *obj_request)
>   		rbd_assert(more);
>   		rbd_assert(which < img_request->obj_request_count);
>
> -		if (!atomic_read(&obj_request->done))
> +		if (!obj_request_done_test(obj_request))
>   			break;
>
>   		rbd_assert(obj_request->xferred <= (u64) UINT_MAX);
>

