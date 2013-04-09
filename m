From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: make method call data be a separate data item
Date: Mon, 08 Apr 2013 17:33:29 -0700
Message-ID: <516361D9.1070106@inktank.com>
References: <515F60DC.8020901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38121 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761641Ab3DIAdz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 20:33:55 -0400
Received: by mail-pd0-f181.google.com with SMTP id y10so3463232pdj.40
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 17:33:54 -0700 (PDT)
In-Reply-To: <515F60DC.8020901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 04:40 PM, Alex Elder wrote:
> (This patch is available on the end of the last series I
> posted in the "review/wip-3761-3" branch of the ceph-client
> git repository.  Note that the series was updated, reflect
> version 2 of the patch "libceph: implement multiple data
> items in a message".)
>
>
> Right now the data for a method call is specified via a pointer and
> length, and it's copied--along with the class and method name--into
> a pagelist data item to be sent to the osd.  Instead, encode the
> data in a data item separate from the class and method names.
>
> This will allow large amounts of data to be supplied to methods
> without copying.  Only rbd uses the class functionality right now,
> and when it really needs this it will probably need to use a page
> array rather than a page list.  But this simple implementation
> demonstrates the functionality on the osd client, and that's enough
> for now.
>
> This resolves:
>      http://tracker.ceph.com/issues/4104
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c             |   15 ++++++++--
>   include/linux/ceph/osd_client.h |   10 +++----
>   net/ceph/osd_client.c           |   61
> +++++++++++++++++++++++++++------------
>   3 files changed, 61 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2e524e4..ed2ef0b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1847,8 +1847,19 @@ static int rbd_obj_method_sync(struct rbd_device
> *rbd_dev,
>   		goto out;
>
>   	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
> -					class_name, method_name,
> -					outbound, outbound_size);
> +					class_name, method_name);
> +	if (outbound_size) {
> +		struct ceph_pagelist *pagelist;
> +
> +		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
> +		if (!pagelist)
> +			goto out;
> +
> +		ceph_pagelist_init(pagelist);
> +		ceph_pagelist_append(pagelist, outbound, outbound_size);
> +		osd_req_op_cls_request_data_pagelist(obj_request->osd_req, 0,
> +						pagelist);
> +	}
>   	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
>   					obj_request->pages, inbound_size,
>   					0, false, false);
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 4ec46c0..2a68a74 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -92,10 +92,9 @@ struct ceph_osd_req_op {
>   		struct {
>   			const char *class_name;
>   			const char *method_name;
> -			const void *request_data;
>   			struct ceph_osd_data request_info;
> +			struct ceph_osd_data request_data;
>   			struct ceph_osd_data response_data;
> -			u32 request_data_len;
>   			__u8 class_len;
>   			__u8 method_len;
>   			__u8 argc;
> @@ -259,6 +258,9 @@ extern void osd_req_op_extent_osd_data_bio(struct
> ceph_osd_request *,
>   					struct bio *bio, size_t bio_length);
>   #endif /* CONFIG_BLOCK */
>
> +extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
> +					unsigned int which,
> +					struct ceph_pagelist *pagelist);
>   extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
>   					unsigned int which,
>   					struct page **pages, u64 length,
> @@ -267,9 +269,7 @@ extern void
> osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
>
>   extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
>   					unsigned int which, u16 opcode,
> -					const char *class, const char *method,
> -					const void *request_data,
> -					size_t request_data_size);
> +					const char *class, const char *method);
>   extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>   					unsigned int which, u16 opcode,
>   					u64 cookie, u64 version, int flag);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 7322785..151c45f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -136,6 +136,16 @@ osd_req_op_cls_request_info(struct ceph_osd_request
> *osd_req,
>   EXPORT_SYMBOL(osd_req_op_cls_request_info);	/* ??? */
>
>   struct ceph_osd_data *
> +osd_req_op_cls_request_data(struct ceph_osd_request *osd_req,
> +			unsigned int which)
> +{
> +	BUG_ON(which >= osd_req->r_num_ops);
> +
> +	return &osd_req->r_ops[which].cls.request_data;
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_request_data);	/* ??? */
> +
> +struct ceph_osd_data *
>   osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
>   			unsigned int which)
>   {
> @@ -192,6 +202,17 @@ static void osd_req_op_cls_request_info_pagelist(
>   	ceph_osd_data_pagelist_init(osd_data, pagelist);
>   }
>
> +void osd_req_op_cls_request_data_pagelist(
> +			struct ceph_osd_request *osd_req,
> +			unsigned int which, struct ceph_pagelist *pagelist)
> +{
> +	struct ceph_osd_data *osd_data;
> +
> +	osd_data = osd_req_op_cls_request_data(osd_req, which);
> +	ceph_osd_data_pagelist_init(osd_data, pagelist);
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
> +
>   void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
>   			unsigned int which, struct page **pages, u64 length,
>   			u32 alignment, bool pages_from_pool, bool own_pages)
> @@ -251,6 +272,7 @@ static void osd_req_op_data_release(struct
> ceph_osd_request *osd_req,
>   		break;
>   	case CEPH_OSD_OP_CALL:
>   		ceph_osd_data_release(&op->cls.request_info);
> +		ceph_osd_data_release(&op->cls.request_data);
>   		ceph_osd_data_release(&op->cls.response_data);
>   		break;
>   	default:
> @@ -492,8 +514,7 @@ void osd_req_op_extent_update(struct
> ceph_osd_request *osd_req,
>   EXPORT_SYMBOL(osd_req_op_extent_update);
>
>   void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int
> which,
> -			u16 opcode, const char *class, const char *method,
> -			const void *request_data, size_t request_data_size)
> +			u16 opcode, const char *class, const char *method)
>   {
>   	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);
>   	struct ceph_pagelist *pagelist;
> @@ -520,12 +541,6 @@ void osd_req_op_cls_init(struct ceph_osd_request
> *osd_req, unsigned int which,
>   	ceph_pagelist_append(pagelist, method, size);
>   	payload_len += size;
>
> -	op->cls.request_data = request_data;
> -	BUG_ON(request_data_size > (size_t) U32_MAX);
> -	op->cls.request_data_len = (u32) request_data_size;
> -	ceph_pagelist_append(pagelist, request_data, request_data_size);
> -	payload_len += request_data_size;
> -
>   	osd_req_op_cls_request_info_pagelist(osd_req, which, pagelist);
>
>   	op->cls.argc = 0;	/* currently unused */
> @@ -576,6 +591,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request
> *req,
>   			      struct ceph_osd_op *dst, unsigned int which)
>   {
>   	struct ceph_osd_req_op *src;
> +	struct ceph_osd_data *osd_data;
>   	u64 request_data_len = 0;
>
>   	BUG_ON(which >= req->r_num_ops);
> @@ -599,22 +615,31 @@ static u64 osd_req_encode_op(struct
> ceph_osd_request *req,
>   			cpu_to_le64(src->extent.truncate_size);
>   		dst->extent.truncate_seq =
>   			cpu_to_le32(src->extent.truncate_seq);
> +		osd_data = &src->extent.osd_data;
>   		if (src->op == CEPH_OSD_OP_WRITE)
> -			ceph_osdc_msg_data_add(req->r_request,
> -						&src->extent.osd_data);
> +			ceph_osdc_msg_data_add(req->r_request, osd_data);
>   		else
> -			ceph_osdc_msg_data_add(req->r_reply,
> -						&src->extent.osd_data);
> +			ceph_osdc_msg_data_add(req->r_reply, osd_data);
>   		break;
>   	case CEPH_OSD_OP_CALL:
>   		dst->cls.class_len = src->cls.class_len;
>   		dst->cls.method_len = src->cls.method_len;
> -		dst->cls.indata_len = cpu_to_le32(src->cls.request_data_len);
> -		ceph_osdc_msg_data_add(req->r_reply, &src->cls.response_data);
> -		ceph_osdc_msg_data_add(req->r_request, &src->cls.request_info);
> -		BUG_ON(src->cls.request_info.type !=
> -					CEPH_OSD_DATA_TYPE_PAGELIST);
> -		request_data_len = src->cls.request_info.pagelist->length;
> +		osd_data = &src->cls.request_info;
> +		ceph_osdc_msg_data_add(req->r_request, osd_data);
> +		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGELIST);
> +		request_data_len = osd_data->pagelist->length;
> +
> +		osd_data = &src->cls.request_data;
> +		if (osd_data->type != CEPH_OSD_DATA_TYPE_NONE) {
> +			u64 data_length = ceph_osd_data_length(osd_data);
> +
> +			dst->cls.indata_len = cpu_to_le32(data_length);
> +			ceph_osdc_msg_data_add(req->r_request, osd_data);
> +			src->payload_len += data_length;
> +			request_data_len += data_length;
> +		}
> +		osd_data = &src->cls.response_data;
> +		ceph_osdc_msg_data_add(req->r_reply, osd_data);
>   		break;
>   	case CEPH_OSD_OP_STARTSYNC:
>   		break;
>

