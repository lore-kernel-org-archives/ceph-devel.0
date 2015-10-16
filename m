From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: use writefull op for object size writes
Date: Fri, 16 Oct 2015 07:24:43 -0500
Message-ID: <5620EC8B.3090300@ieee.org>
References: <1444237333-9677-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36226 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbJPMYq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 08:24:46 -0400
Received: by ioii196 with SMTP id i196so121331048ioi.3
        for <ceph-devel@vger.kernel.org>; Fri, 16 Oct 2015 05:24:45 -0700 (PDT)
In-Reply-To: <1444237333-9677-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 10/07/2015 12:02 PM, Ilya Dryomov wrote:
> This covers only the simplest case - an object size sized write, but
> it's still useful in tiering setups when EC is used for the base tier
> as writefull op can be proxied, saving an object promotion.
> 
> Even though updating ceph_osdc_new_request() to allow writefull should
> just be a matter of fixing an assert, I didn't do it because its only
> user is cephfs.  All other sites were updated.
> 
> Reflects ceph.git commit 7bfb7f9025a8ee0d2305f49bf0336d2424da5b5b.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c   |  9 +++++++--
>  net/ceph/osd_client.c | 13 +++++++++----
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 04e69b4df664..cd00e4653e49 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1863,9 +1863,11 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>  		rbd_osd_read_callback(obj_request);
>  		break;
>  	case CEPH_OSD_OP_SETALLOCHINT:
> -		rbd_assert(osd_req->r_ops[1].op == CEPH_OSD_OP_WRITE);
> +		rbd_assert(osd_req->r_ops[1].op == CEPH_OSD_OP_WRITE ||
> +			   osd_req->r_ops[1].op == CEPH_OSD_OP_WRITEFULL);
>  		/* fall through */
>  	case CEPH_OSD_OP_WRITE:
> +	case CEPH_OSD_OP_WRITEFULL:
>  		rbd_osd_write_callback(obj_request);
>  		break;
>  	case CEPH_OSD_OP_STAT:
> @@ -2401,7 +2403,10 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
>  				opcode = CEPH_OSD_OP_ZERO;
>  		}
>  	} else if (op_type == OBJ_OP_WRITE) {
> -		opcode = CEPH_OSD_OP_WRITE;
> +		if (!offset && length == object_size)
> +			opcode = CEPH_OSD_OP_WRITEFULL;
> +		else
> +			opcode = CEPH_OSD_OP_WRITE;
>  		osd_req_op_alloc_hint_init(osd_request, num_ops,
>  					object_size, object_size);
>  		num_ops++;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 80b94e37c94a..f79ccac6699f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -285,6 +285,7 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
>  	switch (op->op) {
>  	case CEPH_OSD_OP_READ:
>  	case CEPH_OSD_OP_WRITE:
> +	case CEPH_OSD_OP_WRITEFULL:
>  		ceph_osd_data_release(&op->extent.osd_data);
>  		break;
>  	case CEPH_OSD_OP_CALL:
> @@ -485,13 +486,14 @@ void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
>  	size_t payload_len = 0;
>  
>  	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE &&
> -	       opcode != CEPH_OSD_OP_ZERO && opcode != CEPH_OSD_OP_TRUNCATE);
> +	       opcode != CEPH_OSD_OP_WRITEFULL && opcode != CEPH_OSD_OP_ZERO &&
> +	       opcode != CEPH_OSD_OP_TRUNCATE);
>  
>  	op->extent.offset = offset;
>  	op->extent.length = length;
>  	op->extent.truncate_size = truncate_size;
>  	op->extent.truncate_seq = truncate_seq;
> -	if (opcode == CEPH_OSD_OP_WRITE)
> +	if (opcode == CEPH_OSD_OP_WRITE || opcode == CEPH_OSD_OP_WRITEFULL)
>  		payload_len += length;
>  
>  	op->payload_len = payload_len;
> @@ -670,9 +672,11 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
>  		break;
>  	case CEPH_OSD_OP_READ:
>  	case CEPH_OSD_OP_WRITE:
> +	case CEPH_OSD_OP_WRITEFULL:
>  	case CEPH_OSD_OP_ZERO:
>  	case CEPH_OSD_OP_TRUNCATE:
> -		if (src->op == CEPH_OSD_OP_WRITE)
> +		if (src->op == CEPH_OSD_OP_WRITE ||
> +		    src->op == CEPH_OSD_OP_WRITEFULL)
>  			request_data_len = src->extent.length;
>  		dst->extent.offset = cpu_to_le64(src->extent.offset);
>  		dst->extent.length = cpu_to_le64(src->extent.length);
> @@ -681,7 +685,8 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
>  		dst->extent.truncate_seq =
>  			cpu_to_le32(src->extent.truncate_seq);
>  		osd_data = &src->extent.osd_data;
> -		if (src->op == CEPH_OSD_OP_WRITE)
> +		if (src->op == CEPH_OSD_OP_WRITE ||
> +		    src->op == CEPH_OSD_OP_WRITEFULL)
>  			ceph_osdc_msg_data_add(req->r_request, osd_data);
>  		else
>  			ceph_osdc_msg_data_add(req->r_reply, osd_data);
> 

