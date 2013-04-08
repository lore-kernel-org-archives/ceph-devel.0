From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 15/20] libceph: format class info at init time
Date: Mon, 08 Apr 2013 11:16:59 -0700
Message-ID: <5163099B.4040607@inktank.com>
References: <515ED849.9060901@inktank.com> <515EDA11.5080106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:63692 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935110Ab3DHSR0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 14:17:26 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so3387419pad.2
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 11:17:25 -0700 (PDT)
In-Reply-To: <515EDA11.5080106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:05 AM, Alex Elder wrote:
> An object class method is formatted using a pagelist which contains
> the class name, the method name, and the data concatenated into an
> osd request's outbound data.
>
> Currently when a class op is initialized in osd_req_op_cls_init(),
> the lengths of and pointers to these three items are recorded.
> Later, when the op is getting formatted into the request message, a
> new pagelist is created and that is when these items get copied into
> the pagelist.
>
> This patch makes it so the pagelist to hold these items is created
> when the op is initialized instead.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/osd_client.h |    3 ++-
>   net/ceph/osd_client.c           |   29 +++++++++++++++--------------
>   2 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 144d57c..71c4157 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -93,8 +93,9 @@ struct ceph_osd_req_op {
>   			const char *class_name;
>   			const char *method_name;
>   			const void *request_data;
> -			u32 request_data_len;
> +			struct ceph_osd_data *request_info;
>   			struct ceph_osd_data *response_data;
> +			u32 request_data_len;
>   			__u8 class_len;
>   			__u8 method_len;
>   			__u8 argc;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index e698ccf..6c6d7b8 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -399,28 +399,39 @@ void osd_req_op_cls_init(struct ceph_osd_request
> *osd_req, unsigned int which,
>   			const void *request_data, size_t request_data_size)
>   {
>   	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);
> +	struct ceph_pagelist *pagelist;
>   	size_t payload_len = 0;
>   	size_t size;
>
>   	BUG_ON(opcode != CEPH_OSD_OP_CALL);
>
> +	pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
> +	BUG_ON(!pagelist);
> +	ceph_pagelist_init(pagelist);
> +
>   	op->cls.class_name = class;
>   	size = strlen(class);
>   	BUG_ON(size > (size_t) U8_MAX);
>   	op->cls.class_len = size;
> +	ceph_pagelist_append(pagelist, class, size);
>   	payload_len += size;
>
>   	op->cls.method_name = method;
>   	size = strlen(method);
>   	BUG_ON(size > (size_t) U8_MAX);
>   	op->cls.method_len = size;
> +	ceph_pagelist_append(pagelist, method, size);
>   	payload_len += size;
>
>   	op->cls.request_data = request_data;
>   	BUG_ON(request_data_size > (size_t) U32_MAX);
>   	op->cls.request_data_len = (u32) request_data_size;
> +	ceph_pagelist_append(pagelist, request_data, request_data_size);
>   	payload_len += request_data_size;
>
> +	op->cls.request_info = &osd_req->r_data_out;
> +	ceph_osd_data_pagelist_init(op->cls.request_info, pagelist);
> +
>   	op->cls.argc = 0;	/* currently unused */
>
>   	op->payload_len = payload_len;
> @@ -456,7 +467,6 @@ static u64 osd_req_encode_op(struct ceph_osd_request
> *req,
>   {
>   	struct ceph_osd_req_op *src;
>   	u64 request_data_len = 0;
> -	struct ceph_pagelist *pagelist;
>
>   	BUG_ON(which >= req->r_num_ops);
>   	src = &req->r_ops[which];
> @@ -485,23 +495,14 @@ static u64 osd_req_encode_op(struct
> ceph_osd_request *req,
>   			WARN_ON(src->extent.osd_data != &req->r_data_in);
>   		break;
>   	case CEPH_OSD_OP_CALL:
> -		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
> -		BUG_ON(!pagelist);
> -		ceph_pagelist_init(pagelist);
> -
>   		dst->cls.class_len = src->cls.class_len;
>   		dst->cls.method_len = src->cls.method_len;
>   		dst->cls.indata_len = cpu_to_le32(src->cls.request_data_len);
> -		ceph_pagelist_append(pagelist, src->cls.class_name,
> -				     src->cls.class_len);
> -		ceph_pagelist_append(pagelist, src->cls.method_name,
> -				     src->cls.method_len);
> -		ceph_pagelist_append(pagelist, src->cls.request_data,
> -				     src->cls.request_data_len);
> -		ceph_osd_data_pagelist_init(&req->r_data_out, pagelist);
> -
>   		WARN_ON(src->cls.response_data != &req->r_data_in);
> -		request_data_len = pagelist->length;
> +		WARN_ON(src->cls.request_info != &req->r_data_out);
> +		BUG_ON(src->cls.request_info->type !=
> +					CEPH_OSD_DATA_TYPE_PAGELIST);
> +		request_data_len = src->cls.request_info->pagelist->length;
>   		break;
>   	case CEPH_OSD_OP_STARTSYNC:
>   		break;
>

