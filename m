From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: allow STAT osd operations
Date: Tue, 19 Feb 2013 11:16:34 -0800
Message-ID: <5123CF92.10804@inktank.com>
References: <511525B3.30108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47712 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933747Ab3BSTQs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 14:16:48 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so3601510pad.28
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 11:16:48 -0800 (PST)
In-Reply-To: <511525B3.30108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/08/2013 08:20 AM, Alex Elder wrote:
> Add support for CEPH_OSD_OP_STAT operations in the osd client
> and in rbd.
>
> This operation sends no data to the osd; everything required is
> encoded in identity of the target object.
>
> The result will be ENOENT if the object doesn't exist.  If it does
> exist and no other error occurs the server returns the size and last
> modification time of the target object as output data (in little
> endian format).  The size is a 64 bit unsigned and the time is
> ceph_timespec structure (two unsigned 32-bit integers, representing
> a seconds and nanoseconds value).
>
> This resolves:
>      http://tracker.ceph.com/issues/4007
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c   |   15 +++++++++++++++
>   net/ceph/osd_client.c |    3 ++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6e9e2c2..37361bd 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1148,6 +1148,8 @@ struct ceph_osd_req_op *rbd_osd_req_op_create(u16
> opcode, ...)
>   		if (opcode == CEPH_OSD_OP_WRITE)
>   			op->payload_len = op->extent.length;
>   		break;
> +	case CEPH_OSD_OP_STAT:
> +		break;
>   	case CEPH_OSD_OP_CALL:
>   		/* rbd_osd_req_op_create(CALL, class, method, data, datalen) */
>   		op->cls.class_name = va_arg(args, char *);
> @@ -1277,6 +1279,16 @@ static void rbd_osd_write_callback(struct
> rbd_obj_request *obj_request,
>   	obj_request_done_set(obj_request);
>   }
>
> +/*
> + * For a simple stat call there's nothing to do.  We'll do more if
> + * this is part of a write sequence for a layered image.
> + */
> +static void rbd_osd_stat_callback(struct rbd_obj_request *obj_request,
> +				struct ceph_osd_op *op)
> +{
> +	obj_request_done_set(obj_request);
> +}
> +
>   static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>   				struct ceph_msg *msg)
>   {
> @@ -1307,6 +1319,9 @@ static void rbd_osd_req_callback(struct
> ceph_osd_request *osd_req,
>   	case CEPH_OSD_OP_WRITE:
>   		rbd_osd_write_callback(obj_request, op);
>   		break;
> +	case CEPH_OSD_OP_STAT:
> +		rbd_osd_stat_callback(obj_request, op);
> +		break;
>   	case CEPH_OSD_OP_CALL:
>   	case CEPH_OSD_OP_NOTIFY_ACK:
>   	case CEPH_OSD_OP_WATCH:
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index d9d58bb..3e4d8c4 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -244,7 +244,8 @@ static void osd_req_encode_op(struct
> ceph_osd_request *req,
>   		dst->extent.truncate_seq =
>   			cpu_to_le32(src->extent.truncate_seq);
>   		break;
> -
> +	case CEPH_OSD_OP_STAT:
> +		break;
>   	case CEPH_OSD_OP_GETXATTR:
>   	case CEPH_OSD_OP_SETXATTR:
>   	case CEPH_OSD_OP_CMPXATTR:
>

