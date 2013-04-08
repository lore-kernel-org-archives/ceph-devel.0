From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 19/20] libceph: set the data pointers when encoding ops
Date: Mon, 08 Apr 2013 13:03:20 -0700
Message-ID: <51632288.1020903@inktank.com>
References: <515ED849.9060901@inktank.com> <515EDA4C.4090305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55299 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935850Ab3DHUJq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 16:09:46 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so3186384pdj.20
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 13:09:45 -0700 (PDT)
In-Reply-To: <515EDA4C.4090305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:06 AM, Alex Elder wrote:
> Still using the osd request r_data_in and r_data_out pointer, but
> we're basically only referring to it via the data pointers in the
> osd ops.  And we're transferring that information to the request
> or reply message only when the op indicates it's needed, in
> osd_req_encode_op().
>
> To avoid a forward reference, ceph_osdc_msg_data_set() was moved up
> in the file.
>
> Don't bother calling ceph_osd_data_init(), in ceph_osd_alloc(),
> because the ops array will already be zeroed anyway.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/osd_client.h |    2 +-
>   net/ceph/osd_client.c           |   63
> +++++++++++++++++++--------------------
>   2 files changed, 32 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index f8a00b4..dd4ca4ba 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -51,7 +51,7 @@ struct ceph_osd {
>   #define CEPH_OSD_MAX_OP	2
>
>   enum ceph_osd_data_type {
> -	CEPH_OSD_DATA_TYPE_NONE,
> +	CEPH_OSD_DATA_TYPE_NONE = 0,
>   	CEPH_OSD_DATA_TYPE_PAGES,
>   	CEPH_OSD_DATA_TYPE_PAGELIST,
>   #ifdef CONFIG_BLOCK
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 86cb524..cc4003f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -339,9 +339,6 @@ struct ceph_osd_request
> *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
>   	}
>   	req->r_reply = msg;
>
> -	ceph_osd_data_init(&req->r_data_in);
> -	ceph_osd_data_init(&req->r_data_out);
> -
>   	/* create request message; allow space for oid */
>   	if (use_mempool)
>   		msg = ceph_msgpool_get(&osdc->msgpool_op, 0);
> @@ -549,6 +546,28 @@ void osd_req_op_watch_init(struct ceph_osd_request
> *osd_req,
>   }
>   EXPORT_SYMBOL(osd_req_op_watch_init);
>
> +static void ceph_osdc_msg_data_set(struct ceph_msg *msg,
> +				struct ceph_osd_data *osd_data)
> +{
> +	u64 length = ceph_osd_data_length(osd_data);
> +
> +	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
> +		BUG_ON(length > (u64) SIZE_MAX);
> +		if (length)
> +			ceph_msg_data_set_pages(msg, osd_data->pages,
> +					length, osd_data->alignment);
> +	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
> +		BUG_ON(!length);
> +		ceph_msg_data_set_pagelist(msg, osd_data->pagelist);
> +#ifdef CONFIG_BLOCK
> +	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
> +		ceph_msg_data_set_bio(msg, osd_data->bio, length);
> +#endif
> +	} else {
> +		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
> +	}
> +}
> +
>   static u64 osd_req_encode_op(struct ceph_osd_request *req,
>   			      struct ceph_osd_op *dst, unsigned int which)
>   {
> @@ -576,17 +595,24 @@ static u64 osd_req_encode_op(struct
> ceph_osd_request *req,
>   			cpu_to_le64(src->extent.truncate_size);
>   		dst->extent.truncate_seq =
>   			cpu_to_le32(src->extent.truncate_seq);
> -		if (src->op == CEPH_OSD_OP_WRITE)
> +		if (src->op == CEPH_OSD_OP_WRITE) {
>   			WARN_ON(src->extent.osd_data != &req->r_data_out);
> -		else
> +			ceph_osdc_msg_data_set(req->r_request,
> +						src->extent.osd_data);
> +		} else {
>   			WARN_ON(src->extent.osd_data != &req->r_data_in);
> +			ceph_osdc_msg_data_set(req->r_reply,
> +						src->extent.osd_data);
> +		}
>   		break;
>   	case CEPH_OSD_OP_CALL:
>   		dst->cls.class_len = src->cls.class_len;
>   		dst->cls.method_len = src->cls.method_len;
>   		dst->cls.indata_len = cpu_to_le32(src->cls.request_data_len);
>   		WARN_ON(src->cls.response_data != &req->r_data_in);
> +		ceph_osdc_msg_data_set(req->r_reply, src->cls.response_data);
>   		WARN_ON(src->cls.request_info != &req->r_data_out);
> +		ceph_osdc_msg_data_set(req->r_request, src->cls.request_info);
>   		BUG_ON(src->cls.request_info->type !=
>   					CEPH_OSD_DATA_TYPE_PAGELIST);
>   		request_data_len = src->cls.request_info->pagelist->length;
> @@ -1930,28 +1956,6 @@ bad:
>   	return;
>   }
>
> -static void ceph_osdc_msg_data_set(struct ceph_msg *msg,
> -				struct ceph_osd_data *osd_data)
> -{
> -	u64 length = ceph_osd_data_length(osd_data);
> -
> -	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
> -		BUG_ON(length > (u64) SIZE_MAX);
> -		if (length)
> -			ceph_msg_data_set_pages(msg, osd_data->pages,
> -					length, osd_data->alignment);
> -	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
> -		BUG_ON(!length);
> -		ceph_msg_data_set_pagelist(msg, osd_data->pagelist);
> -#ifdef CONFIG_BLOCK
> -	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
> -		ceph_msg_data_set_bio(msg, osd_data->bio, length);
> -#endif
> -	} else {
> -		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
> -	}
> -}
> -
>   /*
>    * build new request AND message
>    *
> @@ -1967,11 +1971,6 @@ void ceph_osdc_build_request(struct
> ceph_osd_request *req, u64 off,
>   	u64 data_len;
>   	unsigned int i;
>
> -	/* Set up response incoming data and request outgoing data fields */
> -
> -	ceph_osdc_msg_data_set(req->r_reply, &req->r_data_in);
> -	ceph_osdc_msg_data_set(req->r_request, &req->r_data_out);
> -
>   	req->r_snapid = snap_id;
>   	req->r_snapc = ceph_get_snap_context(snapc);
>

