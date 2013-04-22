From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/4] rbd: support page array image requests
Date: Mon, 22 Apr 2013 01:13:08 -0700
Message-ID: <5174F114.1030408@inktank.com>
References: <5171C963.2050402@inktank.com> <5171CA35.40409@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:55951 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab3DVINL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 04:13:11 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so2983923dad.32
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 01:13:11 -0700 (PDT)
In-Reply-To: <5171CA35.40409@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

One typo in a comment. Looks good otherwise.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/19/2013 03:50 PM, Alex Elder wrote:
> This patch adds the ability to build an image request whose data
> will be written from or read into memory described by a page array.
> (Previously only bio lists were supported.)
>
> Originally this was going to define a new function for this purpose
> but it was largely identical to the rbd_img_request_fill_bio().  So
> instead, rbd_img_request_fill_bio() has been generalized to handle
> both types of image request.
>
> For the moment we still only fill image requests with bio data.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   86
> +++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ac9abab..91fcf36 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1780,6 +1780,13 @@ static bool rbd_img_obj_end_request(struct
> rbd_obj_request *obj_request)
>   			img_request->result = result;
>   	}
>
> +	/* Image object requests don't own their page array */
> +
> +	if (obj_request->type == OBJ_REQUEST_PAGES) {
> +		obj_request->pages = NULL;
> +		obj_request->page_count = 0;
> +	}
> +
>   	if (img_request_child_test(img_request)) {
>   		rbd_assert(img_request->obj_request != NULL);
>   		more = obj_request->which < img_request->obj_request_count - 1;
> @@ -1830,30 +1837,48 @@ out:
>   		rbd_img_request_complete(img_request);
>   }
>
> -static int rbd_img_request_fill_bio(struct rbd_img_request *img_request,
> -					struct bio *bio_list)
> +/*
> + * Split up an image request into one or more object requests, each
> + * to a different object.  The the "type" parameter indicates

repeated "the"

> + * whether "data_desc" is the pointer to the head of a list of bio
> + * structures, or the base of a page array.  In either case this
> + * function assumes data_desc describes memory sufficient to hold
> + * all data described by the image request.
> + */
> +static int rbd_img_request_fill(struct rbd_img_request *img_request,
> +					enum obj_request_type type,
> +					void *data_desc)
>   {
>   	struct rbd_device *rbd_dev = img_request->rbd_dev;
>   	struct rbd_obj_request *obj_request = NULL;
>   	struct rbd_obj_request *next_obj_request;
>   	bool write_request = img_request_write_test(img_request);
> -	unsigned int bio_offset;
> +	struct bio *bio_list;
> +	unsigned int bio_offset = 0;
> +	struct page **pages;
>   	u64 img_offset;
>   	u64 resid;
>   	u16 opcode;
>
> -	dout("%s: img %p bio %p\n", __func__, img_request, bio_list);
> +	dout("%s: img %p type %d data_desc %p\n", __func__, img_request,
> +		(int)type, data_desc);
>
>   	opcode = write_request ? CEPH_OSD_OP_WRITE : CEPH_OSD_OP_READ;
> -	bio_offset = 0;
>   	img_offset = img_request->offset;
> -	rbd_assert(img_offset == bio_list->bi_sector << SECTOR_SHIFT);
>   	resid = img_request->length;
>   	rbd_assert(resid > 0);
> +
> +	if (type == OBJ_REQUEST_BIO) {
> +		bio_list = data_desc;
> +		rbd_assert(img_offset == bio_list->bi_sector << SECTOR_SHIFT);
> +	} else {
> +		rbd_assert(type == OBJ_REQUEST_PAGES);
> +		pages = data_desc;
> +	}
> +
>   	while (resid) {
>   		struct ceph_osd_request *osd_req;
>   		const char *object_name;
> -		unsigned int clone_size;
>   		u64 offset;
>   		u64 length;
>
> @@ -1863,19 +1888,33 @@ static int rbd_img_request_fill_bio(struct
> rbd_img_request *img_request,
>   		offset = rbd_segment_offset(rbd_dev, img_offset);
>   		length = rbd_segment_length(rbd_dev, img_offset, resid);
>   		obj_request = rbd_obj_request_create(object_name,
> -						offset, length,
> -						OBJ_REQUEST_BIO);
> +						offset, length, type);
>   		kfree(object_name);	/* object request has its own copy */
>   		if (!obj_request)
>   			goto out_unwind;
>
> -		rbd_assert(length <= (u64) UINT_MAX);
> -		clone_size = (unsigned int) length;
> -		obj_request->bio_list = bio_chain_clone_range(&bio_list,
> -						&bio_offset, clone_size,
> -						GFP_ATOMIC);
> -		if (!obj_request->bio_list)
> -			goto out_partial;
> +		if (type == OBJ_REQUEST_BIO) {
> +			unsigned int clone_size;
> +
> +			rbd_assert(length <= (u64)UINT_MAX);
> +			clone_size = (unsigned int)length;
> +			obj_request->bio_list =
> +					bio_chain_clone_range(&bio_list,
> +								&bio_offset,
> +								clone_size,
> +								GFP_ATOMIC);
> +			if (!obj_request->bio_list)
> +				goto out_partial;
> +		} else {
> +			unsigned int page_count;
> +
> +			obj_request->pages = pages;
> +			page_count = (u32)calc_pages_for(offset, length);
> +			obj_request->page_count = page_count;
> +			if ((offset + length) & ~PAGE_MASK)
> +				page_count--;	/* more on last page */
> +			pages += page_count;
> +		}
>
>   		osd_req = rbd_osd_req_create(rbd_dev, write_request,
>   						obj_request);
> @@ -1886,8 +1925,13 @@ static int rbd_img_request_fill_bio(struct
> rbd_img_request *img_request,
>
>   		osd_req_op_extent_init(osd_req, 0, opcode, offset, length,
>   						0, 0);
> -		osd_req_op_extent_osd_data_bio(osd_req, 0,
> -				obj_request->bio_list, obj_request->length);
> +		if (type == OBJ_REQUEST_BIO)
> +			osd_req_op_extent_osd_data_bio(osd_req, 0,
> +					obj_request->bio_list, length);
> +		else
> +			osd_req_op_extent_osd_data_pages(osd_req, 0,
> +					obj_request->pages, length,
> +					offset & ~PAGE_MASK, false, false);
>
>   		if (write_request)
>   			rbd_osd_req_format_write(obj_request);
> @@ -2120,7 +2164,8 @@ static void rbd_img_parent_read(struct
> rbd_obj_request *obj_request)
>   	rbd_obj_request_get(obj_request);
>   	img_request->obj_request = obj_request;
>
> -	result = rbd_img_request_fill_bio(img_request, obj_request->bio_list);
> +	result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
> +					obj_request->bio_list);
>   	if (result)
>   		goto out_err;
>
> @@ -2425,7 +2470,8 @@ static void rbd_request_fn(struct request_queue *q)
>
>   		img_request->rq = rq;
>
> -		result = rbd_img_request_fill_bio(img_request, rq->bio);
> +		result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
> +						rq->bio);
>   		if (!result)
>   			result = rbd_img_request_submit(img_request);
>   		if (result)
>

