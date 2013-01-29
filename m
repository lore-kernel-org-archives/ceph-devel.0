From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 05/12, v2] rbd: get rid of rbd_req_sync_read()
Date: Tue, 29 Jan 2013 02:48:53 -0800
Message-ID: <5107A915.5040502@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com> <51016261.8010609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:50241 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3A2KtA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 05:49:00 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp8so209043pbb.20
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 02:48:59 -0800 (PST)
In-Reply-To: <51016261.8010609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/24/2013 08:33 AM, Alex Elder wrote:
> Delete rbd_req_sync_read() is no longer used, so get rid of it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   24 ------------------------
>   1 file changed, 24 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 742236b..750fc73 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1315,29 +1315,6 @@ static void rbd_obj_request_complete(struct
> rbd_obj_request *obj_request)
>   }
>
>   /*
> - * Synchronously read a range from an object into a provided buffer
> - */
> -static int rbd_req_sync_read(struct rbd_device *rbd_dev,
> -			  const char *object_name,
> -			  u64 ofs, u64 len,
> -			  char *buf,
> -			  u64 *ver)
> -{
> -	struct ceph_osd_req_op *op;
> -	int ret;
> -
> -	op = rbd_osd_req_op_create(CEPH_OSD_OP_READ, ofs, len);
> -	if (!op)
> -		return -ENOMEM;
> -
> -	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
> -			       op, object_name, ofs, len, buf, ver);
> -	rbd_osd_req_op_destroy(op);
> -
> -	return ret;
> -}
> -
> -/*
>    * Request sync osd watch
>    */
>   static int rbd_req_sync_notify_ack(struct rbd_device *rbd_dev,
> @@ -2113,7 +2090,6 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
> u64 *version)
>   		if (!ondisk)
>   			return ERR_PTR(-ENOMEM);
>
> -		(void) rbd_req_sync_read;	/* avoid a warning */
>   		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
>   				       0, size,
>   				       (char *) ondisk, version);
>

