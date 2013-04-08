From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 09/20] libceph: rename data out field in osd request op
Date: Mon, 08 Apr 2013 11:12:22 -0700
Message-ID: <51630886.2010301@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED9BE.8050705@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:39349 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934959Ab3DHSMs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 14:12:48 -0400
Received: by mail-da0-f48.google.com with SMTP id p8so2697205dan.7
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 11:12:47 -0700 (PDT)
In-Reply-To: <515ED9BE.8050705@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:03 AM, Alex Elder wrote:
> There are fields "indata" and "indata_len" defined the ceph osd
> request op structure.  The "in" part is with from the point of view
> of the osd server, but is a little confusing here on the client
> side.  Change their names to use "request" instead of "in" to
> indicate that it defines data provided with the request (as opposed
> the data returned in the response).
>
> Rename the local variable in osd_req_encode_op() to match.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/osd_client.h |    4 ++--
>   net/ceph/osd_client.c           |   18 +++++++++---------
>   2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index f4c1a2a..a9c4089 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -91,8 +91,8 @@ struct ceph_osd_req_op {
>   		struct {
>   			const char *class_name;
>   			const char *method_name;
> -			const void *indata;
> -			u32 indata_len;
> +			const void *request_data;
> +			u32 request_data_len;
>   			__u8 class_len;
>   			__u8 method_len;
>   			__u8 argc;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index ed4493d..e74e454 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -395,9 +395,9 @@ void osd_req_op_cls_init(struct ceph_osd_req_op *op,
> u16 opcode,
>   	op->cls.method_len = size;
>   	payload_len += size;
>
> -	op->cls.indata = request_data;
> +	op->cls.request_data = request_data;
>   	BUG_ON(request_data_size > (size_t) U32_MAX);
> -	op->cls.indata_len = (u32) request_data_size;
> +	op->cls.request_data_len = (u32) request_data_size;
>   	payload_len += request_data_size;
>
>   	op->cls.argc = 0;	/* currently unused */
> @@ -425,7 +425,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request
> *req,
>   			      struct ceph_osd_op *dst, unsigned int which)
>   {
>   	struct ceph_osd_req_op *src;
> -	u64 out_data_len = 0;
> +	u64 request_data_len = 0;
>   	struct ceph_pagelist *pagelist;
>
>   	BUG_ON(which >= req->r_num_ops);
> @@ -442,7 +442,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request
> *req,
>   	case CEPH_OSD_OP_READ:
>   	case CEPH_OSD_OP_WRITE:
>   		if (src->op == CEPH_OSD_OP_WRITE)
> -			out_data_len = src->extent.length;
> +			request_data_len = src->extent.length;
>   		dst->extent.offset = cpu_to_le64(src->extent.offset);
>   		dst->extent.length = cpu_to_le64(src->extent.length);
>   		dst->extent.truncate_size =
> @@ -457,16 +457,16 @@ static u64 osd_req_encode_op(struct
> ceph_osd_request *req,
>
>   		dst->cls.class_len = src->cls.class_len;
>   		dst->cls.method_len = src->cls.method_len;
> -		dst->cls.indata_len = cpu_to_le32(src->cls.indata_len);
> +		dst->cls.indata_len = cpu_to_le32(src->cls.request_data_len);
>   		ceph_pagelist_append(pagelist, src->cls.class_name,
>   				     src->cls.class_len);
>   		ceph_pagelist_append(pagelist, src->cls.method_name,
>   				     src->cls.method_len);
> -		ceph_pagelist_append(pagelist, src->cls.indata,
> -				     src->cls.indata_len);
> +		ceph_pagelist_append(pagelist, src->cls.request_data,
> +				     src->cls.request_data_len);
>
>   		ceph_osd_data_pagelist_init(&req->r_data_out, pagelist);
> -		out_data_len = pagelist->length;
> +		request_data_len = pagelist->length;
>   		break;
>   	case CEPH_OSD_OP_STARTSYNC:
>   		break;
> @@ -486,7 +486,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request
> *req,
>   	dst->op = cpu_to_le16(src->op);
>   	dst->payload_len = cpu_to_le32(src->payload_len);
>
> -	return out_data_len;
> +	return request_data_len;
>   }
>
>   /*
>

