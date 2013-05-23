From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: wait for safe callback for write requests
Date: Thu, 23 May 2013 11:45:15 -0700
Message-ID: <519E63BB.80908@inktank.com>
References: <519E0777.6010904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35229 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757613Ab3EWSqm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 14:46:42 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so3287353pad.8
        for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 11:46:42 -0700 (PDT)
In-Reply-To: <519E0777.6010904@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/23/2013 05:11 AM, Alex Elder wrote:
> A write request sent to the osd will get either one or two
> responses.  One is simply an acknowledgement of receipt, and
> another is an indication that the state change described by
> the request (typically a write of data) is durable on the osd.
>
> A response with the ONDISK flag set indicates the change is durable.
> Sometimes this flag is set in the first (only) response, but if not,
> a second response will eventually arrive with that flag set.  The
> initiator of the request is notified via one callback when the
> acknowledgement arrives, and via a different callback when the
> ONDISK response arrives.
>
> Currently the rbd client waits for the non-durable response for all
> requests, which isn't safe for writes.  Fix that by defining and
> using a different callback function that marks write requests done
> only when the ONDISK notification arrives.
>
> This resolves:
>      http://tracker.ceph.com/issues/5146
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   32 +++++++++++++++++++++++++++-----
>   1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3296db5..6e377a0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1681,14 +1681,17 @@ static void rbd_osd_req_callback(struct
> ceph_osd_request *osd_req,
>   		rbd_osd_read_callback(obj_request);
>   		break;
>   	case CEPH_OSD_OP_WRITE:
> +		rbd_assert(!msg);
>   		rbd_osd_write_callback(obj_request);
>   		break;
>   	case CEPH_OSD_OP_STAT:
>   		rbd_osd_stat_callback(obj_request);
>   		break;
> +	case CEPH_OSD_OP_WATCH:
> +		rbd_assert(!msg);
> +		/* fall through */
>   	case CEPH_OSD_OP_CALL:
>   	case CEPH_OSD_OP_NOTIFY_ACK:
> -	case CEPH_OSD_OP_WATCH:
>   		rbd_osd_trivial_callback(obj_request);
>   		break;
>   	default:
> @@ -1701,6 +1704,24 @@ static void rbd_osd_req_callback(struct
> ceph_osd_request *osd_req,
>   		rbd_obj_request_complete(obj_request);
>   }
>
> +/*
> + * This is called twice:  once (with unsafe == true) when the
> + * request message is first handed to the messenger for delivery;
> + * and the second time (with unsafe == false) after we get
> + * confirmation the change is durable on the osd.  We ignore the
> + * first, and let the "normal" callback routine handle the second.
> + */
> +static void rbd_osd_req_unsafe_callback(struct ceph_osd_request *osd_req,
> +				bool unsafe)
> +{
> +	dout("%s: osd_req %p unsafe %s op 0x%hx\n", __func__, osd_req,
> +		unsafe ? "true" : "false", osd_req->r_ops[0].op);
> +
> +	rbd_assert(osd_req->r_flags & CEPH_OSD_FLAG_WRITE);
> +	if (!unsafe)
> +		rbd_osd_req_callback(osd_req, NULL);
> +}
> +
>   static void rbd_osd_req_format_read(struct rbd_obj_request *obj_request)
>   {
>   	struct rbd_img_request *img_request = obj_request->img_request;
> @@ -1753,12 +1774,13 @@ static struct ceph_osd_request *rbd_osd_req_create(
>   	if (!osd_req)
>   		return NULL;	/* ENOMEM */
>
> -	if (write_request)
> +	if (write_request) {
>   		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
> -	else
> +		osd_req->r_unsafe_callback = rbd_osd_req_unsafe_callback;
> +	} else {
>   		osd_req->r_flags = CEPH_OSD_FLAG_READ;
> -
> -	osd_req->r_callback = rbd_osd_req_callback;
> +		osd_req->r_callback = rbd_osd_req_callback;
> +	}
>   	osd_req->r_priv = obj_request;
>
>   	osd_req->r_oid_len = strlen(obj_request->object_name);
>

