From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 10/20] libceph: add data pointers in osd op structures
Date: Mon, 08 Apr 2013 11:13:31 -0700
Message-ID: <516308CB.9010401@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED9CB.3090501@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:37869 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935506Ab3DHSVM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 14:21:12 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so2699027dal.40
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 11:21:10 -0700 (PDT)
In-Reply-To: <515ED9CB.3090501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:03 AM, Alex Elder wrote:
> An extent type osd operation currently implies that there will
> be corresponding data supplied in the data portion of the request
> (for write) or response (for read) message.  Similarly, an osd class
> method operation implies a data item will be supplied to receive
> the response data from the operation.
>
> Add a ceph_osd_data pointer to each of those structures, and assign
> it to point to eithre the incoming or the outgoing data structure in
> the osd message.  The data is not always available when an op is
> initially set up, so add two new functions to allow setting them
> after the op has been initialized.
>
> Begin to make use of the data item pointer available in the osd
> operation rather than the request data in or out structure in
> places where it's convenient.  Add some assertions to verify
> pointers are always set the way they're expected to be.
>
> This is a sort of stepping stone toward really moving the data
> into the osd request ops, to allow for some validation before
> making that jump.
>
> This is the first in a series of patches that resolve:
>      http://tracker.ceph.com/issues/4657
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c             |   24 ++++++++++++++++++++----
>   fs/ceph/addr.c                  |    8 +++++---
>   fs/ceph/file.c                  |    5 +++--
>   include/linux/ceph/osd_client.h |    6 ++++++
>   net/ceph/osd_client.c           |   26 +++++++++++++++++++++++++-
>   5 files changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e6e2191..59f9db1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1315,23 +1315,39 @@ static void rbd_osd_req_format_op(struct
> rbd_obj_request *obj_request,
>   					bool write_request)
>   {
>   	struct rbd_img_request *img_request = obj_request->img_request;
> +	struct ceph_osd_request *osd_req = obj_request->osd_req;
> +	struct ceph_osd_data *osd_data = NULL;
>   	struct ceph_snap_context *snapc = NULL;
>   	u64 snap_id = CEPH_NOSNAP;
>   	struct timespec *mtime = NULL;
>   	struct timespec now;
>
> -	rbd_assert(obj_request->osd_req != NULL);
> +	rbd_assert(osd_req != NULL);
>
>   	if (write_request) {
> +		osd_data = &osd_req->r_data_out;
>   		now = CURRENT_TIME;
>   		mtime = &now;
>   		if (img_request)
>   			snapc = img_request->snapc;
> -	} else if (img_request) {
> -		snap_id = img_request->snap_id;
> +	} else {
> +		osd_data = &osd_req->r_data_in;
> +		if (img_request)
> +			snap_id = img_request->snap_id;
>   	}
> +	if (obj_request->type != OBJ_REQUEST_NODATA) {
> +		struct ceph_osd_req_op *op = &obj_request->osd_req->r_ops[0];
>
> -	ceph_osdc_build_request(obj_request->osd_req, obj_request->offset,
> +		/*
> +		 * If it has data, it's either a object class method
> +		 * call (cls) or it's an extent operation.
> +		 */
> +		if (op->op == CEPH_OSD_OP_CALL)
> +			osd_req_op_cls_response_data(op, osd_data);
> +		else
> +			osd_req_op_extent_osd_data(op, osd_data);
> +	}
> +	ceph_osdc_build_request(osd_req, obj_request->offset,
>   			snapc, snap_id, mtime);
>   }
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 12bbba7..3caadb0 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -343,7 +343,8 @@ static int start_read(struct inode *inode, struct
> list_head *page_list, int max)
>   		}
>   		pages[i] = page;
>   	}
> -	ceph_osd_data_pages_init(&req->r_data_in, pages, len, 0,
> +	BUG_ON(req->r_ops[0].extent.osd_data != &req->r_data_in);
> +	ceph_osd_data_pages_init(req->r_ops[0].extent.osd_data, pages, len, 0,
>   					false, false);
>   	req->r_callback = finish_read;
>   	req->r_inode = inode;
> @@ -916,8 +917,9 @@ get_more_pages:
>   		dout("writepages got %d pages at %llu~%llu\n",
>   		     locked_pages, offset, len);
>
> -		ceph_osd_data_pages_init(&req->r_data_out, pages, len, 0,
> -						!!pool, false);
> +		BUG_ON(req->r_ops[0].extent.osd_data != &req->r_data_out);
> +		ceph_osd_data_pages_init(req->r_ops[0].extent.osd_data, pages,
> +						len, 0, !!pool, false);
>
>   		pages = NULL;	/* request message now owns the pages array */
>   		pool = NULL;
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index a1d85a8..66d0938 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -574,8 +574,9 @@ more:
>   			own_pages = true;
>   		}
>   	}
> -	ceph_osd_data_pages_init(&req->r_data_out, pages, len, page_align,
> -					false, own_pages);
> +	BUG_ON(req->r_ops[0].extent.osd_data != &req->r_data_out);
> +	ceph_osd_data_pages_init(req->r_ops[0].extent.osd_data, pages, len,
> +					page_align, false, own_pages);
>
>   	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
>   	ceph_osdc_build_request(req, pos, snapc, vino.snap, &mtime);
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index a9c4089..ae51935 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -87,12 +87,14 @@ struct ceph_osd_req_op {
>   			u64 offset, length;
>   			u64 truncate_size;
>   			u32 truncate_seq;
> +			struct ceph_osd_data *osd_data;
>   		} extent;
>   		struct {
>   			const char *class_name;
>   			const char *method_name;
>   			const void *request_data;
>   			u32 request_data_len;
> +			struct ceph_osd_data *response_data;
>   			__u8 class_len;
>   			__u8 method_len;
>   			__u8 argc;
> @@ -236,10 +238,14 @@ extern void osd_req_op_extent_init(struct
> ceph_osd_req_op *op, u16 opcode,
>   					u64 offset, u64 length,
>   					u64 truncate_size, u32 truncate_seq);
>   extern void osd_req_op_extent_update(struct ceph_osd_req_op *op, u64
> length);
> +extern void osd_req_op_extent_osd_data(struct ceph_osd_req_op *op,
> +					struct ceph_osd_data *osd_data);
>   extern void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
>   					const char *class, const char *method,
>   					const void *request_data,
>   					size_t request_data_size);
> +extern void osd_req_op_cls_response_data(struct ceph_osd_req_op *op,
> +					struct ceph_osd_data *response_data);
>   extern void osd_req_op_watch_init(struct ceph_osd_req_op *op, u16 opcode,
>   					u64 cookie, u64 version, int flag);
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index e74e454..2a14187 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -372,6 +372,13 @@ void osd_req_op_extent_update(struct
> ceph_osd_req_op *op, u64 length)
>   }
>   EXPORT_SYMBOL(osd_req_op_extent_update);
>
> +void osd_req_op_extent_osd_data(struct ceph_osd_req_op *op,
> +				struct ceph_osd_data *osd_data)
> +{
> +	op->extent.osd_data = osd_data;
> +}
> +EXPORT_SYMBOL(osd_req_op_extent_osd_data);
> +
>   void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
>   			const char *class, const char *method,
>   			const void *request_data, size_t request_data_size)
> @@ -406,6 +413,13 @@ void osd_req_op_cls_init(struct ceph_osd_req_op
> *op, u16 opcode,
>   }
>   EXPORT_SYMBOL(osd_req_op_cls_init);
>
> +void osd_req_op_cls_response_data(struct ceph_osd_req_op *op,
> +				struct ceph_osd_data *response_data)
> +{
> +	op->cls.response_data = response_data;
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_response_data);
> +
>   void osd_req_op_watch_init(struct ceph_osd_req_op *op, u16 opcode,
>   				u64 cookie, u64 version, int flag)
>   {
> @@ -449,6 +463,10 @@ static u64 osd_req_encode_op(struct
> ceph_osd_request *req,
>   			cpu_to_le64(src->extent.truncate_size);
>   		dst->extent.truncate_seq =
>   			cpu_to_le32(src->extent.truncate_seq);
> +		if (src->op == CEPH_OSD_OP_WRITE)
> +			WARN_ON(src->extent.osd_data != &req->r_data_out);
> +		else
> +			WARN_ON(src->extent.osd_data != &req->r_data_in);
>   		break;
>   	case CEPH_OSD_OP_CALL:
>   		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
> @@ -464,8 +482,9 @@ static u64 osd_req_encode_op(struct ceph_osd_request
> *req,
>   				     src->cls.method_len);
>   		ceph_pagelist_append(pagelist, src->cls.request_data,
>   				     src->cls.request_data_len);
> -
>   		ceph_osd_data_pagelist_init(&req->r_data_out, pagelist);
> +
> +		WARN_ON(src->cls.response_data != &req->r_data_in);
>   		request_data_len = pagelist->length;
>   		break;
>   	case CEPH_OSD_OP_STARTSYNC:
> @@ -609,6 +628,7 @@ struct ceph_osd_request
> *ceph_osdc_new_request(struct ceph_osd_client *osdc,
>   					       bool use_mempool)
>   {
>   	struct ceph_osd_request *req;
> +	struct ceph_osd_data *osd_data;
>   	struct ceph_osd_req_op *op;
>   	u64 objnum = 0;
>   	u64 objoff = 0;
> @@ -623,6 +643,8 @@ struct ceph_osd_request
> *ceph_osdc_new_request(struct ceph_osd_client *osdc,
>   					GFP_NOFS);
>   	if (!req)
>   		return ERR_PTR(-ENOMEM);
> +	osd_data = opcode == CEPH_OSD_OP_WRITE ? &req->r_data_out
> +					       : &req->r_data_in;
>
>   	req->r_flags = flags;
>
> @@ -646,6 +668,8 @@ struct ceph_osd_request
> *ceph_osdc_new_request(struct ceph_osd_client *osdc,
>   	op = &req->r_ops[0];
>   	osd_req_op_extent_init(op, opcode, objoff, objlen,
>   				truncate_size, truncate_seq);
> +	osd_req_op_extent_osd_data(op, osd_data);
> +
>   	/*
>   	 * A second op in the ops array means the caller wants to
>   	 * also issue a include a 'startsync' command so that the
>

