From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 03/20] libceph: define osd data initialization helpers
Date: Fri, 05 Apr 2013 11:16:09 -0700
Message-ID: <515F14E9.2000204@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED959.3090204@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43483 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162323Ab3DESQa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 14:16:30 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so2142314pdi.15
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 11:16:30 -0700 (PDT)
In-Reply-To: <515ED959.3090204@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:02 AM, Alex Elder wrote:
> Define and use functions that encapsulate the initializion of a
> ceph_osd_data structure.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c             |   14 ++++------
>   fs/ceph/addr.c                  |   13 +++------
>   fs/ceph/file.c                  |   10 +++----
>   include/linux/ceph/osd_client.h |   11 ++++++++
>   net/ceph/osd_client.c           |   55
> +++++++++++++++++++++++++++------------
>   5 files changed, 63 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 5e579fa..a9d88a0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1350,17 +1350,13 @@ static struct ceph_osd_request *rbd_osd_req_create(
>   		break;		/* Nothing to do */
>   	case OBJ_REQUEST_BIO:
>   		rbd_assert(obj_request->bio_list != NULL);
> -		osd_data->type = CEPH_OSD_DATA_TYPE_BIO;
> -		osd_data->bio = obj_request->bio_list;
> -		osd_data->bio_length = obj_request->length;
> +		ceph_osd_data_bio_init(osd_data, obj_request->bio_list,
> +					obj_request->length);
>   		break;
>   	case OBJ_REQUEST_PAGES:
> -		osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
> -		osd_data->pages = obj_request->pages;
> -		osd_data->length = obj_request->length;
> -		osd_data->alignment = offset & ~PAGE_MASK;
> -		osd_data->pages_from_pool = false;
> -		osd_data->own_pages = false;
> +		ceph_osd_data_pages_init(osd_data, obj_request->pages,
> +				obj_request->length, offset & ~PAGE_MASK,
> +				false, false);
>   		break;
>   	}
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e0dd74c..8507389 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -342,10 +342,8 @@ static int start_read(struct inode *inode, struct
> list_head *page_list, int max)
>   		}
>   		pages[i] = page;
>   	}
> -	req->r_data_in.type = CEPH_OSD_DATA_TYPE_PAGES;
> -	req->r_data_in.pages = pages;
> -	req->r_data_in.length = len;
> -	req->r_data_in.alignment = 0;
> +	ceph_osd_data_pages_init(&req->r_data_in, pages, len, 0,
> +					false, false);
>   	req->r_callback = finish_read;
>   	req->r_inode = inode;
>
> @@ -917,11 +915,8 @@ get_more_pages:
>   		dout("writepages got %d pages at %llu~%llu\n",
>   		     locked_pages, offset, len);
>
> -		req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
> -		req->r_data_out.pages = pages;
> -		req->r_data_out.length = len;
> -		req->r_data_out.alignment = 0;
> -		req->r_data_out.pages_from_pool = !!pool;
> +		ceph_osd_data_pages_init(&req->r_data_out, pages, len, 0,
> +						!!pool, false);
>
>   		pages = NULL;	/* request message now owns the pages array */
>   		pool = NULL;
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 66b8469..2f2d0a1 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -491,6 +491,7 @@ static ssize_t ceph_sync_write(struct file *file,
> const char __user *data,
>   	unsigned long buf_align;
>   	int ret;
>   	struct timespec mtime = CURRENT_TIME;
> +	bool own_pages = false;
>
>   	if (ceph_snap(file->f_dentry->d_inode) != CEPH_NOSNAP)
>   		return -EROFS;
> @@ -571,14 +572,11 @@ more:
>   		if ((file->f_flags & O_SYNC) == 0) {
>   			/* get a second commit callback */
>   			req->r_safe_callback = sync_write_commit;
> -			req->r_data_out.own_pages = 1;
> +			own_pages = true;
>   		}
>   	}
> -	req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGES;
> -	req->r_data_out.pages = pages;
> -	req->r_data_out.length = len;
> -	req->r_data_out.alignment = page_align;
> -	req->r_inode = inode;
> +	ceph_osd_data_pages_init(&req->r_data_out, pages, len, page_align,
> +					false, own_pages);
>
>   	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
>   	ceph_osdc_build_request(req, pos, num_ops, ops,
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 5ee1a37..af60dac 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -280,6 +280,17 @@ static inline void ceph_osdc_put_request(struct
> ceph_osd_request *req)
>   	kref_put(&req->r_kref, ceph_osdc_release_request);
>   }
>
> +extern void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
> +				     struct page **pages, u64 length,
> +				     u32 alignment, bool pages_from_pool,
> +				     bool own_pages);
> +extern void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
> +					struct ceph_pagelist *pagelist);
> +#ifdef CONFIG_BLOCK
> +extern void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
> +				   struct bio *bio, size_t bio_length);
> +#endif /* CONFIG_BLOCK */
> +
>   extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>   				   struct ceph_osd_request *req,
>   				   bool nofail);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1379b33..f8f8561 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -79,6 +79,38 @@ static int calc_layout(struct ceph_file_layout
> *layout, u64 off, u64 *plen,
>   	return 0;
>   }
>
> +void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
> +			struct page **pages, u64 length, u32 alignment,
> +			bool pages_from_pool, bool own_pages)
> +{
> +	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
> +	osd_data->pages = pages;
> +	osd_data->length = length;
> +	osd_data->alignment = alignment;
> +	osd_data->pages_from_pool = pages_from_pool;
> +	osd_data->own_pages = own_pages;
> +}
> +EXPORT_SYMBOL(ceph_osd_data_pages_init);
> +
> +void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
> +			struct ceph_pagelist *pagelist)
> +{
> +	osd_data->type = CEPH_OSD_DATA_TYPE_PAGELIST;
> +	osd_data->pagelist = pagelist;
> +}
> +EXPORT_SYMBOL(ceph_osd_data_pagelist_init);
> +
> +#ifdef CONFIG_BLOCK
> +void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
> +			struct bio *bio, size_t bio_length)
> +{
> +	osd_data->type = CEPH_OSD_DATA_TYPE_BIO;
> +	osd_data->bio = bio;
> +	osd_data->bio_length = bio_length;
> +}
> +EXPORT_SYMBOL(ceph_osd_data_bio_init);
> +#endif /* CONFIG_BLOCK */
> +
>   /*
>    * requests
>    */
> @@ -400,8 +432,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request
> *req,
>   		ceph_pagelist_append(pagelist, src->cls.indata,
>   				     src->cls.indata_len);
>
> -		req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGELIST;
> -		req->r_data_out.pagelist = pagelist;
> +		ceph_osd_data_pagelist_init(&req->r_data_out, pagelist);
>   		out_data_len = pagelist->length;
>   		break;
>   	case CEPH_OSD_OP_STARTSYNC:
> @@ -2056,7 +2087,6 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
>   			struct page **pages, int num_pages, int page_align)
>   {
>   	struct ceph_osd_request *req;
> -	struct ceph_osd_data *osd_data;
>   	struct ceph_osd_req_op op;
>   	int rc = 0;
>
> @@ -2071,14 +2101,11 @@ int ceph_osdc_readpages(struct ceph_osd_client
> *osdc,
>
>   	/* it may be a short read due to an object boundary */
>
> -	osd_data = &req->r_data_in;
> -	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
> -	osd_data->pages = pages;
> -	osd_data->length = *plen;
> -	osd_data->alignment = page_align;
> +	ceph_osd_data_pages_init(&req->r_data_in, pages, *plen, page_align,
> +				false, false);
>
>   	dout("readpages  final extent is %llu~%llu (%llu bytes align %d)\n",
> -	     off, *plen, osd_data->length, page_align);
> +	     off, *plen, *plen, page_align);
>
>   	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
>
> @@ -2104,7 +2131,6 @@ int ceph_osdc_writepages(struct ceph_osd_client
> *osdc, struct ceph_vino vino,
>   			 struct page **pages, int num_pages)
>   {
>   	struct ceph_osd_request *req;
> -	struct ceph_osd_data *osd_data;
>   	struct ceph_osd_req_op op;
>   	int rc = 0;
>   	int page_align = off & ~PAGE_MASK;
> @@ -2119,12 +2145,9 @@ int ceph_osdc_writepages(struct ceph_osd_client
> *osdc, struct ceph_vino vino,
>   		return PTR_ERR(req);
>
>   	/* it may be a short write due to an object boundary */
> -	osd_data = &req->r_data_out;
> -	osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
> -	osd_data->pages = pages;
> -	osd_data->length = len;
> -	osd_data->alignment = page_align;
> -	dout("writepages %llu~%llu (%llu bytes)\n", off, len, osd_data->length);
> +	ceph_osd_data_pages_init(&req->r_data_out, pages, len, page_align,
> +				false, false);
> +	dout("writepages %llu~%llu (%llu bytes)\n", off, len, len);
>
>   	ceph_osdc_build_request(req, off, 1, &op, snapc, CEPH_NOSNAP, mtime);
>

