From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 18/20] libceph: combine initializing and setting osd data
Date: Mon, 08 Apr 2013 12:59:21 -0700
Message-ID: <51632199.1060509@inktank.com>
References: <515ED849.9060901@inktank.com> <515EDA3C.9060401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55272 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762330Ab3DHT77 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 15:59:59 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so3433590pab.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 12:59:58 -0700 (PDT)
In-Reply-To: <515EDA3C.9060401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:05 AM, Alex Elder wrote:
> This ends up being a rather large patch but what it's doing is
> somewhat straightforward.
>
> Basically, this is replacing two calls with one.  The first of the
> two calls is initializing a struct ceph_osd_data with data (either a
> page array, a page list, or a bio list); the second is setting an
> osd request op so it associates that data with one of the op's
> parameters.  In place of those two will be a single function that
> initializes the op directly.
>
> That means we sort of fan out a set of the needed functions:
>      - extent ops with pages data
>      - extent ops with pagelist data
>      - extent ops with bio list data
> and
>      - class ops with page data for receiving a response
>
> We also have define another one, but it's only used internally:
>      - class ops with pagelist data for request parameters
>
> Note that we *still* haven't gotten rid of the osd request's
> r_data_in and r_data_out fields.  All the osd ops refer to them for
> their data.  For now, these data fields are pointers assigned to the
> appropriate r_data_* field when these new functions are called.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c             |   20 ++---
>   fs/ceph/addr.c                  |   12 ++-
>   fs/ceph/file.c                  |    3 +-
>   include/linux/ceph/osd_client.h |   43 +++++++----
>   net/ceph/osd_client.c           |  157
> ++++++++++++++++++++++++++++++---------
>   5 files changed, 162 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3e8e6d5..7db244e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1592,7 +1592,6 @@ static int rbd_img_request_fill_bio(struct
> rbd_img_request *img_request,
>   	rbd_assert(resid > 0);
>   	while (resid) {
>   		struct ceph_osd_request *osd_req;
> -		struct ceph_osd_data *osd_data;
>   		const char *object_name;
>   		unsigned int clone_size;
>   		u64 offset;
> @@ -1625,13 +1624,10 @@ static int rbd_img_request_fill_bio(struct
> rbd_img_request *img_request,
>   		obj_request->osd_req = osd_req;
>   		obj_request->callback = rbd_img_obj_callback;
>
> -		osd_data = write_request ? &osd_req->r_data_out
> -					 : &osd_req->r_data_in;
>   		osd_req_op_extent_init(osd_req, 0, opcode, offset, length,
>   						0, 0);
> -		ceph_osd_data_bio_init(osd_data, obj_request->bio_list,
> -					obj_request->length);
> -		osd_req_op_extent_osd_data(osd_req, 0, osd_data);
> +		osd_req_op_extent_osd_data_bio(osd_req, 0, write_request,
> +				obj_request->bio_list, obj_request->length);
>   		rbd_osd_req_format(obj_request, write_request);
>
>   		rbd_img_obj_request_add(img_request, obj_request);
> @@ -1821,7 +1817,6 @@ static int rbd_obj_method_sync(struct rbd_device
> *rbd_dev,
>   {
>   	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>   	struct rbd_obj_request *obj_request;
> -	struct ceph_osd_data *osd_data;
>   	struct page **pages;
>   	u32 page_count;
>   	int ret;
> @@ -1851,13 +1846,12 @@ static int rbd_obj_method_sync(struct rbd_device
> *rbd_dev,
>   	if (!obj_request->osd_req)
>   		goto out;
>
> -	osd_data = &obj_request->osd_req->r_data_in;
>   	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
>   					class_name, method_name,
>   					outbound, outbound_size);
> -	ceph_osd_data_pages_init(osd_data, obj_request->pages, 0, 0,
> +	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
> +					obj_request->pages, 0, 0,
>   					false, false);
> -	osd_req_op_cls_response_data(obj_request->osd_req, 0, osd_data);
>   	rbd_osd_req_format(obj_request, false);
>
>   	ret = rbd_obj_request_submit(osdc, obj_request);
> @@ -2037,7 +2031,6 @@ static int rbd_obj_read_sync(struct rbd_device
> *rbd_dev,
>   {
>   	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>   	struct rbd_obj_request *obj_request;
> -	struct ceph_osd_data *osd_data;
>   	struct page **pages = NULL;
>   	u32 page_count;
>   	size_t size;
> @@ -2061,14 +2054,13 @@ static int rbd_obj_read_sync(struct rbd_device
> *rbd_dev,
>   	if (!obj_request->osd_req)
>   		goto out;
>
> -	osd_data = &obj_request->osd_req->r_data_in;
>   	osd_req_op_extent_init(obj_request->osd_req, 0, CEPH_OSD_OP_READ,
>   					offset, length, 0, 0);
> -	ceph_osd_data_pages_init(osd_data, obj_request->pages,
> +	osd_req_op_extent_osd_data_pages(obj_request->osd_req, 0, false,
> +					obj_request->pages,
>   					obj_request->length,
>   					obj_request->offset & ~PAGE_MASK,
>   					false, false);
> -	osd_req_op_extent_osd_data(obj_request->osd_req, 0, osd_data);
>   	rbd_osd_req_format(obj_request, false);
>
>   	ret = rbd_obj_request_submit(osdc, obj_request);
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index dd5d263..068d2c8 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -245,7 +245,7 @@ static void finish_read(struct ceph_osd_request
> *req, struct ceph_msg *msg)
>   	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);
>
>   	/* unlock all pages, zeroing any data we didn't read */
> -	osd_data = &req->r_data_in;
> +	osd_data = osd_req_op_extent_osd_data(req, 0, false);
>   	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
>   	num_pages = calc_pages_for((u64)osd_data->alignment,
>   					(u64)osd_data->length);
> @@ -343,8 +343,7 @@ static int start_read(struct inode *inode, struct
> list_head *page_list, int max)
>   		}
>   		pages[i] = page;
>   	}
> -	BUG_ON(req->r_ops[0].extent.osd_data != &req->r_data_in);
> -	ceph_osd_data_pages_init(req->r_ops[0].extent.osd_data, pages, len, 0,
> +	osd_req_op_extent_osd_data_pages(req, 0, false, pages, len, 0,
>   					false, false);
>   	req->r_callback = finish_read;
>   	req->r_inode = inode;
> @@ -572,7 +571,7 @@ static void writepages_finish(struct
> ceph_osd_request *req,
>   	long writeback_stat;
>   	unsigned issued = ceph_caps_issued(ci);
>
> -	osd_data = &req->r_data_out;
> +	osd_data = osd_req_op_extent_osd_data(req, 0, true);
>   	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
>   	num_pages = calc_pages_for((u64)osd_data->alignment,
>   					(u64)osd_data->length);
> @@ -917,9 +916,8 @@ get_more_pages:
>   		dout("writepages got %d pages at %llu~%llu\n",
>   		     locked_pages, offset, len);
>
> -		BUG_ON(req->r_ops[0].extent.osd_data != &req->r_data_out);
> -		ceph_osd_data_pages_init(req->r_ops[0].extent.osd_data, pages,
> -						len, 0, !!pool, false);
> +		osd_req_op_extent_osd_data_pages(req, 0, true, pages, len, 0,
> +							!!pool, false);
>
>   		pages = NULL;	/* request message now owns the pages array */
>   		pool = NULL;
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 66d0938..b7e6caa 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -574,8 +574,7 @@ more:
>   			own_pages = true;
>   		}
>   	}
> -	BUG_ON(req->r_ops[0].extent.osd_data != &req->r_data_out);
> -	ceph_osd_data_pages_init(req->r_ops[0].extent.osd_data, pages, len,
> +	osd_req_op_extent_osd_data_pages(req, 0, true, pages, len,
>   					page_align, false, own_pages);
>
>   	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 71c4157..f8a00b4 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -240,17 +240,39 @@ extern void osd_req_op_extent_init(struct
> ceph_osd_request *osd_req,
>   					u64 truncate_size, u32 truncate_seq);
>   extern void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
>   					unsigned int which, u64 length);
> -extern void osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
> +
> +extern struct ceph_osd_data *osd_req_op_extent_osd_data(
> +					struct ceph_osd_request *osd_req,
> +					unsigned int which, bool write_request);
> +extern struct ceph_osd_data *osd_req_op_cls_response_data(
> +					struct ceph_osd_request *osd_req,
> +					unsigned int which);
> +
> +extern void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *,
> +					unsigned int which, bool write_request,
> +					struct page **pages, u64 length,
> +					u32 alignment, bool pages_from_pool,
> +					bool own_pages);
> +extern void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *,
> +					unsigned int which, bool write_request,
> +					struct ceph_pagelist *pagelist);
> +#ifdef CONFIG_BLOCK
> +extern void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *,
> +					unsigned int which, bool write_request,
> +					struct bio *bio, size_t bio_length);
> +#endif /* CONFIG_BLOCK */
> +
> +extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
>   					unsigned int which,
> -					struct ceph_osd_data *osd_data);
> +					struct page **pages, u64 length,
> +					u32 alignment, bool pages_from_pool,
> +					bool own_pages);
> +
>   extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
>   					unsigned int which, u16 opcode,
>   					const char *class, const char *method,
>   					const void *request_data,
>   					size_t request_data_size);
> -extern void osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
> -					unsigned int which,
> -					struct ceph_osd_data *response_data);
>   extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>   					unsigned int which, u16 opcode,
>   					u64 cookie, u64 version, int flag);
> @@ -290,17 +312,6 @@ static inline void ceph_osdc_put_request(struct
> ceph_osd_request *req)
>   	kref_put(&req->r_kref, ceph_osdc_release_request);
>   }
>
> -extern void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
> -				     struct page **pages, u64 length,
> -				     u32 alignment, bool pages_from_pool,
> -				     bool own_pages);
> -extern void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
> -					struct ceph_pagelist *pagelist);
> -#ifdef CONFIG_BLOCK
> -extern void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
> -				   struct bio *bio, size_t bio_length);
> -#endif /* CONFIG_BLOCK */
> -
>   extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>   				   struct ceph_osd_request *req,
>   				   bool nofail);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 40466ab..86cb524 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1,3 +1,4 @@
> +
>   #include <linux/ceph/ceph_debug.h>
>
>   #include <linux/module.h>
> @@ -81,11 +82,11 @@ static int calc_layout(struct ceph_file_layout
> *layout, u64 off, u64 *plen,
>
>   static void ceph_osd_data_init(struct ceph_osd_data *osd_data)
>   {
> -	memset(osd_data, 0, sizeof *osd_data);
> +	memset(osd_data, 0, sizeof (*osd_data));
>   	osd_data->type = CEPH_OSD_DATA_TYPE_NONE;
>   }
>
> -void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
> +static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
>   			struct page **pages, u64 length, u32 alignment,
>   			bool pages_from_pool, bool own_pages)
>   {
> @@ -96,27 +97,131 @@ void ceph_osd_data_pages_init(struct ceph_osd_data
> *osd_data,
>   	osd_data->pages_from_pool = pages_from_pool;
>   	osd_data->own_pages = own_pages;
>   }
> -EXPORT_SYMBOL(ceph_osd_data_pages_init);
>
> -void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
> +static void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
>   			struct ceph_pagelist *pagelist)
>   {
>   	osd_data->type = CEPH_OSD_DATA_TYPE_PAGELIST;
>   	osd_data->pagelist = pagelist;
>   }
> -EXPORT_SYMBOL(ceph_osd_data_pagelist_init);
>
>   #ifdef CONFIG_BLOCK
> -void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
> +static void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
>   			struct bio *bio, size_t bio_length)
>   {
>   	osd_data->type = CEPH_OSD_DATA_TYPE_BIO;
>   	osd_data->bio = bio;
>   	osd_data->bio_length = bio_length;
>   }
> -EXPORT_SYMBOL(ceph_osd_data_bio_init);
>   #endif /* CONFIG_BLOCK */
>
> +struct ceph_osd_data *
> +osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
> +			unsigned int which, bool write_request)
> +{
> +	BUG_ON(which >= osd_req->r_num_ops);
> +
> +	/* return &osd_req->r_ops[which].extent.osd_data; */
> +	return write_request ? &osd_req->r_data_out : &osd_req->r_data_in;
> +}
> +EXPORT_SYMBOL(osd_req_op_extent_osd_data);
> +
> +struct ceph_osd_data *
> +osd_req_op_cls_request_info(struct ceph_osd_request *osd_req,
> +			unsigned int which)
> +{
> +	BUG_ON(which >= osd_req->r_num_ops);
> +
> +	/* return &osd_req->r_ops[which].cls.request_info; */
> +	return &osd_req->r_data_out;	/* Request data is outgoing */
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_request_info);	/* ??? */
> +
> +struct ceph_osd_data *
> +osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
> +			unsigned int which)
> +{
> +	BUG_ON(which >= osd_req->r_num_ops);
> +
> +	/* return &osd_req->r_ops[which].cls.response_data; */
> +	return &osd_req->r_data_in;	/* Response data is incoming */
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_response_data);	/* ??? */
> +
> +void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
> +			unsigned int which, bool write_request,
> +			struct page **pages, u64 length, u32 alignment,
> +			bool pages_from_pool, bool own_pages)
> +{
> +	struct ceph_osd_data *osd_data;
> +
> +	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
> +	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
> +				pages_from_pool, own_pages);
> +
> +	osd_req->r_ops[which].extent.osd_data =
> +		osd_req_op_extent_osd_data(osd_req, which, write_request);
> +}
> +EXPORT_SYMBOL(osd_req_op_extent_osd_data_pages);
> +
> +void osd_req_op_extent_osd_data_pagelist(struct ceph_osd_request *osd_req,
> +			unsigned int which, bool write_request,
> +			struct ceph_pagelist *pagelist)
> +{
> +	struct ceph_osd_data *osd_data;
> +
> +	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
> +	ceph_osd_data_pagelist_init(osd_data, pagelist);
> +
> +	osd_req->r_ops[which].extent.osd_data =
> +		osd_req_op_extent_osd_data(osd_req, which, write_request);
> +}
> +EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);
> +
> +#ifdef CONFIG_BLOCK
> +void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *osd_req,
> +			unsigned int which, bool write_request,
> +			struct bio *bio, size_t bio_length)
> +{
> +	struct ceph_osd_data *osd_data;
> +
> +	osd_data = osd_req_op_extent_osd_data(osd_req, which, write_request);
> +	ceph_osd_data_bio_init(osd_data, bio, bio_length);
> +
> +	osd_req->r_ops[which].extent.osd_data =
> +		osd_req_op_extent_osd_data(osd_req, which, write_request);
> +}
> +EXPORT_SYMBOL(osd_req_op_extent_osd_data_bio);
> +#endif /* CONFIG_BLOCK */
> +
> +static void osd_req_op_cls_request_info_pagelist(
> +			struct ceph_osd_request *osd_req,
> +			unsigned int which, struct ceph_pagelist *pagelist)
> +{
> +	struct ceph_osd_data *osd_data;
> +
> +	osd_data = osd_req_op_cls_request_info(osd_req, which);
> +	ceph_osd_data_pagelist_init(osd_data, pagelist);
> +
> +	osd_req->r_ops[which].cls.request_info =
> +		osd_req_op_cls_request_info(osd_req, which);
> +}
> +
> +void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
> +			unsigned int which, struct page **pages, u64 length,
> +			u32 alignment, bool pages_from_pool, bool own_pages)
> +{
> +	struct ceph_osd_data *osd_data;
> +
> +	osd_data = osd_req_op_cls_response_data(osd_req, which);
> +	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
> +				pages_from_pool, own_pages);
> +
> +	osd_req->r_ops[which].cls.response_data =
> +		osd_req_op_cls_response_data(osd_req, which);
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_response_data_pages);
> +
>   static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
>   {
>   	switch (osd_data->type) {
> @@ -385,15 +490,6 @@ void osd_req_op_extent_update(struct
> ceph_osd_request *osd_req,
>   }
>   EXPORT_SYMBOL(osd_req_op_extent_update);
>
> -void osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
> -				unsigned int which,
> -				struct ceph_osd_data *osd_data)
> -{
> -	BUG_ON(which >= osd_req->r_num_ops);
> -	osd_req->r_ops[which].extent.osd_data = osd_data;
> -}
> -EXPORT_SYMBOL(osd_req_op_extent_osd_data);
> -
>   void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int
> which,
>   			u16 opcode, const char *class, const char *method,
>   			const void *request_data, size_t request_data_size)
> @@ -429,22 +525,13 @@ void osd_req_op_cls_init(struct ceph_osd_request
> *osd_req, unsigned int which,
>   	ceph_pagelist_append(pagelist, request_data, request_data_size);
>   	payload_len += request_data_size;
>
> -	op->cls.request_info = &osd_req->r_data_out;
> -	ceph_osd_data_pagelist_init(op->cls.request_info, pagelist);
> +	osd_req_op_cls_request_info_pagelist(osd_req, which, pagelist);
>
>   	op->cls.argc = 0;	/* currently unused */
>
>   	op->payload_len = payload_len;
>   }
>   EXPORT_SYMBOL(osd_req_op_cls_init);
> -void osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
> -				unsigned int which,
> -				struct ceph_osd_data *response_data)
> -{
> -	BUG_ON(which >= osd_req->r_num_ops);
> -	osd_req->r_ops[which].cls.response_data = response_data;
> -}
> -EXPORT_SYMBOL(osd_req_op_cls_response_data);
>
>   void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>   				unsigned int which, u16 opcode,
> @@ -547,7 +634,6 @@ struct ceph_osd_request
> *ceph_osdc_new_request(struct ceph_osd_client *osdc,
>   					       bool use_mempool)
>   {
>   	struct ceph_osd_request *req;
> -	struct ceph_osd_data *osd_data;
>   	u64 objnum = 0;
>   	u64 objoff = 0;
>   	u64 objlen = 0;
> @@ -561,8 +647,6 @@ struct ceph_osd_request
> *ceph_osdc_new_request(struct ceph_osd_client *osdc,
>   					GFP_NOFS);
>   	if (!req)
>   		return ERR_PTR(-ENOMEM);
> -	osd_data = opcode == CEPH_OSD_OP_WRITE ? &req->r_data_out
> -					       : &req->r_data_in;
>
>   	req->r_flags = flags;
>
> @@ -585,7 +669,6 @@ struct ceph_osd_request
> *ceph_osdc_new_request(struct ceph_osd_client *osdc,
>
>   	osd_req_op_extent_init(req, 0, opcode, objoff, objlen,
>   				truncate_size, truncate_seq);
> -	osd_req_op_extent_osd_data(req, 0, osd_data);
>
>   	/*
>   	 * A second op in the ops array means the caller wants to
> @@ -2171,8 +2254,8 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
>
>   	/* it may be a short read due to an object boundary */
>
> -	ceph_osd_data_pages_init(&req->r_data_in, pages, *plen, page_align,
> -				false, false);
> +	osd_req_op_extent_osd_data_pages(req, 0, false,
> +				pages, *plen, page_align, false, false);
>
>   	dout("readpages  final extent is %llu~%llu (%llu bytes align %d)\n",
>   	     off, *plen, *plen, page_align);
> @@ -2214,7 +2297,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
> *osdc, struct ceph_vino vino,
>   		return PTR_ERR(req);
>
>   	/* it may be a short write due to an object boundary */
> -	ceph_osd_data_pages_init(&req->r_data_out, pages, len, page_align,
> +	osd_req_op_extent_osd_data_pages(req, 0, true, pages, len, page_align,
>   				false, false);
>   	dout("writepages %llu~%llu (%llu bytes)\n", off, len, len);
>
> @@ -2308,8 +2391,14 @@ static struct ceph_msg *get_reply(struct
> ceph_connection *con,
>   	m = ceph_msg_get(req->r_reply);
>
>   	if (data_len > 0) {
> -		struct ceph_osd_data *osd_data = &req->r_data_in;
> +		struct ceph_osd_data *osd_data;
>
> +		/*
> +		 * XXX This is assuming there is only one op containing
> +		 * XXX page data.  Probably OK for reads, but this
> +		 * XXX ought to be done more generally.
> +		 */
> +		osd_data = osd_req_op_extent_osd_data(req, 0, false);
>   		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
>   			if (osd_data->pages &&
>   				unlikely(osd_data->length < data_len)) {
>

