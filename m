From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 01/10] rbd: add obj request execution helper
Date: Wed, 29 Apr 2015 16:33:13 -0500
Message-ID: <55414E19.5050200@ieee.org>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com> <1430258747-12506-2-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33610 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbD2Vdf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 17:33:35 -0400
Received: by pacwv17 with SMTP id wv17so39219744pac.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2015 14:33:35 -0700 (PDT)
In-Reply-To: <1430258747-12506-2-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com, ceph-devel@vger.kernel.org

On 04/28/2015 05:05 PM, mchristi@redhat.com wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
>
> This patch breaks out the code that allocates buffers and executes
> the request from rbd_obj_method_sync, so future functions in this
> patchset can use it.
>
> It also adds support for OBJ_OP_WRITE requests which is needed for
> the locking functions which will be added in the next patches.

I would rather see the restructuring you do here (creation of
rbd_obj_request_sync()) be done in a way that preserved exactly
the same functionality.  Then, in a second patch, you should
add the new ability to allocate a page vector for the inbound
data.  This is only a comment on the composition of your series,
not the content of this patch (which otherwise looks good).

A few more remarks below.

					-Alex

> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
> ---
>   drivers/block/rbd.c | 156 ++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 95 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b40af32..fafe558 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3224,89 +3224,123 @@ static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
>   }
>
>   /*
> - * Synchronous osd object method call.  Returns the number of bytes
> - * returned in the outbound buffer, or a negative error code.
> + * Synchronous osd object op call.  Returns the number of bytes
> + * returned in the inbound buffer, or a negative error code.
>    */
> -static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
> -			     const char *object_name,
> -			     const char *class_name,
> -			     const char *method_name,
> -			     const void *outbound,
> -			     size_t outbound_size,
> -			     void *inbound,
> -			     size_t inbound_size)
> +static int rbd_obj_request_sync(struct rbd_device *rbd_dev,
> +				struct rbd_obj_request *obj_request,
> +				const void *outbound, size_t outbound_size,
> +				void *inbound, size_t inbound_size)
>   {
>   	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> -	struct rbd_obj_request *obj_request;
> -	struct page **pages;
> -	u32 page_count;
> -	int ret;
> -
> -	/*
> -	 * Method calls are ultimately read operations.  The result
> -	 * should placed into the inbound buffer provided.  They
> -	 * also supply outbound data--parameters for the object
> -	 * method.  Currently if this is present it will be a
> -	 * snapshot id.
> -	 */
> -	page_count = (u32)calc_pages_for(0, inbound_size);
> -	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
> -	if (IS_ERR(pages))
> -		return PTR_ERR(pages);
> -
> -	ret = -ENOMEM;
> -	obj_request = rbd_obj_request_create(object_name, 0, inbound_size,
> -							OBJ_REQUEST_PAGES);
> -	if (!obj_request)
> -		goto out;
> -
> -	obj_request->pages = pages;
> -	obj_request->page_count = page_count;
> -
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
> -						  obj_request);
> -	if (!obj_request->osd_req)
> -		goto out;
> +	struct page **pages = NULL;
> +	u32 page_count = 0;
> +	int ret = -ENOMEM;
> +	u16 op = obj_request->osd_req->r_ops[0].op;
> +	struct ceph_pagelist *pagelist;
> +
> +	if (inbound_size) {
> +		page_count = (u32)calc_pages_for(0, inbound_size);
> +		pages = ceph_alloc_page_vector(page_count, GFP_NOIO);

I don't know now whether GFP_NOIO is right (or wrong).  I just call
attention to it because it's different from the GFP_KERNEL that was
used before.  (I'll let you figure it out...)  In any case, that
change (and any others like it below) probably warrants its own patch.

> +		if (IS_ERR(pages))
> +			return PTR_ERR(pages);
> +
> +		obj_request->pages = pages;
> +		obj_request->page_count = page_count;
> +
> +		switch (op) {
> +		case CEPH_OSD_OP_CALL:
> +			osd_req_op_cls_response_data_pages(obj_request->osd_req,
> +							   0, pages,
> +							   inbound_size,
> +							   0, false, false);
> +			break;
> +		default:
> +			BUG();

You should use rbd_assert() rather than directly calling BUG().
(We really should not be calling BUG() there either, but that's
another matter.)

> +		}
> +	}
>
> -	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
> -					class_name, method_name);
>   	if (outbound_size) {
> -		struct ceph_pagelist *pagelist;
> -
> -		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
> +		pagelist = kmalloc(sizeof (*pagelist), GFP_NOIO);
>   		if (!pagelist)
> -			goto out;
> +			goto free_pages;
>
>   		ceph_pagelist_init(pagelist);
>   		ceph_pagelist_append(pagelist, outbound, outbound_size);
> -		osd_req_op_cls_request_data_pagelist(obj_request->osd_req, 0,
> -						pagelist);
> +
> +		switch (op) {
> +		case CEPH_OSD_OP_CALL:
> +			osd_req_op_cls_request_data_pagelist(
> +							obj_request->osd_req, 0,
> +							pagelist);
> +			break;
> +		default:
> +			BUG();

You already verified op was valid.  Really, since this is just
setting up a method call, the only op should be CEPH_OSD_OP_CALL
(I *think*, though you may have other plans).  If that's the case,
just do an rbd_assert(op == CEPH_OSD_OP_CALL) at the top and
move on without these case statements.

> +		}
>   	}
> -	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
> -					obj_request->pages, inbound_size,
> -					0, false, false);
> -	rbd_osd_req_format_read(obj_request);
> +
> +	if (inbound_size)
> +		rbd_osd_req_format_read(obj_request);
> +	else
> +		rbd_osd_req_format_write(obj_request);
>
>   	ret = rbd_obj_request_submit(osdc, obj_request);
>   	if (ret)
> -		goto out;
> +		goto done;
>   	ret = rbd_obj_request_wait(obj_request);
>   	if (ret)
> -		goto out;
> +		goto done;
>
>   	ret = obj_request->result;
>   	if (ret < 0)
> -		goto out;
> +		goto done;
>
>   	rbd_assert(obj_request->xferred < (u64)INT_MAX);
>   	ret = (int)obj_request->xferred;
> -	ceph_copy_from_page_vector(pages, inbound, 0, obj_request->xferred);
> -out:
> -	if (obj_request)
> -		rbd_obj_request_put(obj_request);
> -	else
> -		ceph_release_page_vector(pages, page_count);
> +	if (inbound_size)
> +		ceph_copy_from_page_vector(pages, inbound, 0,
> +					   obj_request->xferred);
> +done:
> +	return ret;
> +
> +free_pages:
> +	ceph_release_page_vector(pages, page_count);
> +	return ret;
> +}
>
> +/*
> + * Synchronous osd object method call.  Returns the number of bytes
> + * returned in the inbound buffer, or a negative error code.
> + */
> +static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
> +			       const char *object_name,
> +			       const char *class_name,
> +			       const char *method_name,
> +			       const void *outbound,
> +			       size_t outbound_size,
> +			       void *inbound,
> +			       size_t inbound_size)
> +{
> +	struct rbd_obj_request *obj_request;
> +	int ret = -ENOMEM;
> +
> +	obj_request = rbd_obj_request_create(object_name, 0, inbound_size,
> +					     OBJ_REQUEST_PAGES);
> +	if (!obj_request)
> +		return -ENOMEM;
> +
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev,
> +					inbound ? OBJ_OP_READ : OBJ_OP_WRITE,
> +					1, obj_request);
> +	if (!obj_request->osd_req)
> +		goto out;
> +
> +	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
> +			    class_name, method_name);
> +	ret = rbd_obj_request_sync(rbd_dev, obj_request, outbound, outbound_size,
> +				   inbound, inbound_size);
> +out:
> +	rbd_obj_request_put(obj_request);
>   	return ret;
>   }
>
>

