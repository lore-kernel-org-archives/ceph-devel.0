From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: fix parent request size assumption
Date: Mon, 13 May 2013 11:48:18 -0700
Message-ID: <51913572.80204@inktank.com>
References: <518E81E1.2000806@inktank.com> <518E9B84.20100@inktank.com> <519129D1.7050807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:49293 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab3EMStc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 14:49:32 -0400
Received: by mail-da0-f41.google.com with SMTP id y19so3782777dan.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 11:49:31 -0700 (PDT)
In-Reply-To: <519129D1.7050807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/13/2013 10:58 AM, Alex Elder wrote:
> I have inserted this patch into a series I posted over the
> weekend to address an issue that Josh's comment raised in
> the review for:
>      [PATCH] rbd: support reading parent page data for writes
> This patch, along with the updated series, is available in the
> "review/wip-flatten-1" branch of the ceph-client git repository.
>
>
>
>
>
> The code that reads object data from the parent for a copyup on
> write request currently assumes that the size of that request is the
> size of a "full" object from the original target image.
>
> That is not necessarily the case.  The parent overlap could reduce
> the request size below that.  To fix that assumption we need to
> record the number of pages in the copyup_pages array, for both an
> image request and an object request.  Rename a local variable in
> rbd_img_obj_parent_read_full_callback() to reflect we're recording
> the length of the parent read request, not the size of the target
> object.
>
> This resolves:
>      http://tracker.ceph.com/issues/5038
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 51c45e7..597b9bb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -224,6 +224,7 @@ struct rbd_obj_request {
>   		};
>   	};
>   	struct page		**copyup_pages;
> +	u32			copyup_page_count;
>
>   	struct ceph_osd_request	*osd_req;
>
> @@ -256,6 +257,7 @@ struct rbd_img_request {
>   		struct rbd_obj_request	*obj_request;	/* obj req initiator */
>   	};
>   	struct page		**copyup_pages;
> +	u32			copyup_page_count;
>   	spinlock_t		completion_lock;/* protects next_completion */
>   	u32			next_completion;
>   	rbd_img_callback_t	callback;
> @@ -2119,7 +2121,7 @@ rbd_img_obj_copyup_callback(struct rbd_obj_request
> *obj_request)
>   {
>   	struct rbd_img_request *img_request;
>   	struct rbd_device *rbd_dev;
> -	u64 length;
> +	struct page **pages;
>   	u32 page_count;
>
>   	rbd_assert(obj_request->type == OBJ_REQUEST_BIO);
> @@ -2129,12 +2131,14 @@ rbd_img_obj_copyup_callback(struct
> rbd_obj_request *obj_request)
>
>   	rbd_dev = img_request->rbd_dev;
>   	rbd_assert(rbd_dev);
> -	length = (u64)1 << rbd_dev->header.obj_order;
> -	page_count = (u32)calc_pages_for(0, length);
>
> -	rbd_assert(obj_request->copyup_pages);
> -	ceph_release_page_vector(obj_request->copyup_pages, page_count);
> +	pages = obj_request->copyup_pages;
> +	rbd_assert(pages != NULL);
>   	obj_request->copyup_pages = NULL;
> +	page_count = obj_request->copyup_page_count;
> +	rbd_assert(page_count);
> +	obj_request->copyup_page_count = 0;
> +	ceph_release_page_vector(pages, page_count);
>
>   	/*
>   	 * We want the transfer count to reflect the size of the
> @@ -2158,9 +2162,9 @@ rbd_img_obj_parent_read_full_callback(struct
> rbd_img_request *img_request)
>   	struct ceph_osd_client *osdc;
>   	struct rbd_device *rbd_dev;
>   	struct page **pages;
> +	u32 page_count;
>   	int result;
> -	u64 obj_size;
> -	u64 xferred;
> +	u64 parent_length;
>
>   	rbd_assert(img_request_child_test(img_request));
>
> @@ -2169,19 +2173,21 @@ rbd_img_obj_parent_read_full_callback(struct
> rbd_img_request *img_request)
>   	pages = img_request->copyup_pages;
>   	rbd_assert(pages != NULL);
>   	img_request->copyup_pages = NULL;
> +	page_count = img_request->copyup_page_count;
> +	rbd_assert(page_count);
> +	img_request->copyup_page_count = 0;
>
>   	orig_request = img_request->obj_request;
>   	rbd_assert(orig_request != NULL);
>   	rbd_assert(orig_request->type == OBJ_REQUEST_BIO);
>   	result = img_request->result;
> -	obj_size = img_request->length;
> -	xferred = img_request->xferred;
> +	parent_length = img_request->length;
> +	rbd_assert(parent_length == img_request->xferred);
>   	rbd_img_request_put(img_request);
>
>   	rbd_assert(orig_request->img_request);
>   	rbd_dev = orig_request->img_request->rbd_dev;
>   	rbd_assert(rbd_dev);
> -	rbd_assert(obj_size == (u64)1 << rbd_dev->header.obj_order);
>
>   	if (result)
>   		goto out_err;
> @@ -2195,11 +2201,12 @@ rbd_img_obj_parent_read_full_callback(struct
> rbd_img_request *img_request)
>   		goto out_err;
>   	orig_request->osd_req = osd_req;
>   	orig_request->copyup_pages = pages;
> +	orig_request->copyup_page_count = page_count;
>
>   	/* Initialize the copyup op */
>
>   	osd_req_op_cls_init(osd_req, 0, CEPH_OSD_OP_CALL, "rbd", "copyup");
> -	osd_req_op_cls_request_data_pages(osd_req, 0, pages, obj_size, 0,
> +	osd_req_op_cls_request_data_pages(osd_req, 0, pages, parent_length, 0,
>   						false, false);
>
>   	/* Then the original write request op */
> @@ -2312,6 +2319,7 @@ static int rbd_img_obj_parent_read_full(struct
> rbd_obj_request *obj_request)
>   	if (result)
>   		goto out_err;
>   	parent_request->copyup_pages = pages;
> +	parent_request->copyup_page_count = page_count;
>
>   	parent_request->callback = rbd_img_obj_parent_read_full_callback;
>   	result = rbd_img_request_submit(parent_request);
> @@ -2319,6 +2327,7 @@ static int rbd_img_obj_parent_read_full(struct
> rbd_obj_request *obj_request)
>   		return 0;
>
>   	parent_request->copyup_pages = NULL;
> +	parent_request->copyup_page_count = 0;
>   	parent_request->obj_request = NULL;
>   	rbd_obj_request_put(obj_request);
>   out_err:
>

