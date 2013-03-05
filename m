From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/3] libceph: distinguish page and bio requests
Date: Mon, 04 Mar 2013 18:14:28 -0800
Message-ID: <51355504.608@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E515.6010006@inktank.com> <5134E560.4020204@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:38040 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3CECPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 21:15:00 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so3761016pbc.28
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 18:15:00 -0800 (PST)
In-Reply-To: <5134E560.4020204@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 03/04/2013 10:18 AM, Alex Elder wrote:
> An osd request uses either pages or a bio list for its data.  Use a
> union to record information about the two, and add a data type
> tag to select between them.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c             |    4 +++
>   fs/ceph/file.c                  |    1 +
>   include/linux/ceph/osd_client.h |   11 +++++++-
>   net/ceph/osd_client.c           |   56
> +++++++++++++++++++++++++--------------
>   4 files changed, 51 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index dcf08f2..70c3b39 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1412,12 +1412,16 @@ static struct ceph_osd_request *rbd_osd_req_create(
>   		break;		/* Nothing to do */
>   	case OBJ_REQUEST_BIO:
>   		rbd_assert(obj_request->bio_list != NULL);
> +		osd_req->r_data.type = CEPH_OSD_DATA_TYPE_BIO;
>   		osd_req->r_data.bio = obj_request->bio_list;
>   		break;
>   	case OBJ_REQUEST_PAGES:
> +		osd_req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
>   		osd_req->r_data.pages = obj_request->pages;
>   		osd_req->r_data.num_pages = obj_request->page_count;
>   		osd_req->r_data.alignment = offset & ~PAGE_MASK;
> +		osd_req->r_data.pages_from_pool = false;
> +		osd_req->r_data.own_pages = false;
>   		break;
>   	}
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 76739049..0f7b3f4 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -571,6 +571,7 @@ more:
>   			req->r_data.own_pages = 1;
>   		}
>   	}
> +	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
>   	req->r_data.pages = pages;
>   	req->r_data.num_pages = num_pages;
>   	req->r_data.alignment = page_align;
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 600b827..56604b3 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -50,8 +50,17 @@ struct ceph_osd {
>
>   #define CEPH_OSD_MAX_OP 10
>
> +enum ceph_osd_data_type {
> +	CEPH_OSD_DATA_TYPE_NONE,
> +	CEPH_OSD_DATA_TYPE_PAGES,
> +#ifdef CONFIG_BLOCK
> +	CEPH_OSD_DATA_TYPE_BIO,
> +#endif /* CONFIG_BLOCK */
> +};
> +
>   struct ceph_osd_data {
> -	struct {
> +	enum ceph_osd_data_type	type;
> +	union {
>   		struct {
>   			struct page	**pages;
>   			u32		num_pages;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1f8c7a7..591e1b0 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -122,7 +122,8 @@ void ceph_osdc_release_request(struct kref *kref)
>   	}
>   	if (req->r_reply)
>   		ceph_msg_put(req->r_reply);
> -	if (req->r_data.own_pages)
> +	if (req->r_data.type == CEPH_OSD_DATA_TYPE_PAGES &&
> +			req->r_data.own_pages)
>   		ceph_release_page_vector(req->r_data.pages,
>   					 req->r_data.num_pages);
>   	ceph_put_snap_context(req->r_snapc);
> @@ -188,6 +189,7 @@ struct ceph_osd_request
> *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
>   	}
>   	req->r_reply = msg;
>
> +	req->r_data.type = CEPH_OSD_DATA_TYPE_NONE;
>   	ceph_pagelist_init(&req->r_trail);
>
>   	/* create request message; allow space for oid */
> @@ -1739,12 +1741,17 @@ int ceph_osdc_start_request(struct
> ceph_osd_client *osdc,
>   {
>   	int rc = 0;
>
> -	req->r_request->pages = req->r_data.pages;
> -	req->r_request->page_count = req->r_data.num_pages;
> -	req->r_request->page_alignment = req->r_data.alignment;
> +	if (req->r_data.type == CEPH_OSD_DATA_TYPE_PAGES) {
> +		req->r_request->pages = req->r_data.pages;
> +		req->r_request->page_count = req->r_data.num_pages;
> +		req->r_request->page_alignment = req->r_data.alignment;
>   #ifdef CONFIG_BLOCK
> -	req->r_request->bio = req->r_data.bio;
> +	} else if (req->r_data.type == CEPH_OSD_DATA_TYPE_BIO) {
> +		req->r_request->bio = req->r_data.bio;
>   #endif
> +	} else {
> +		pr_err("unknown request data type %d\n", req->r_data.type);
> +	}
>   	req->r_request->trail = &req->r_trail;
>
>   	register_request(osdc, req);
> @@ -1944,6 +1951,7 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
>   		return PTR_ERR(req);
>
>   	/* it may be a short read due to an object boundary */
> +	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
>   	req->r_data.pages = pages;
>   	req->r_data.num_pages = calc_pages_for(page_align, *plen);
>   	req->r_data.alignment = page_align;
> @@ -1987,6 +1995,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
> *osdc, struct ceph_vino vino,
>   		return PTR_ERR(req);
>
>   	/* it may be a short write due to an object boundary */
> +	req->r_data.type = CEPH_OSD_DATA_TYPE_PAGES;
>   	req->r_data.pages = pages;
>   	req->r_data.num_pages = calc_pages_for(page_align, len);
>   	req->r_data.alignment = page_align;
> @@ -2083,23 +2092,30 @@ static struct ceph_msg *get_reply(struct
> ceph_connection *con,
>   	m = ceph_msg_get(req->r_reply);
>
>   	if (data_len > 0) {
> -		int want = calc_pages_for(req->r_data.alignment, data_len);
> -
> -		if (req->r_data.pages && unlikely(req->r_data.num_pages < want)) {
> -			pr_warning("tid %lld reply has %d bytes %d pages, we"
> -				   " had only %d pages ready\n", tid, data_len,
> -				   want, req->r_data.num_pages);
> -			*skip = 1;
> -			ceph_msg_put(m);
> -			m = NULL;
> -			goto out;
> -		}
> -		m->pages = req->r_data.pages;
> -		m->page_count = req->r_data.num_pages;
> -		m->page_alignment = req->r_data.alignment;
> +		if (req->r_data.type == CEPH_OSD_DATA_TYPE_PAGES) {
> +			int want;
> +
> +			want = calc_pages_for(req->r_data.alignment, data_len);
> +			if (req->r_data.pages &&
> +				unlikely(req->r_data.num_pages < want)) {
> +
> +				pr_warning("tid %lld reply has %d bytes %d "
> +					"pages, we had only %d pages ready\n",
> +					tid, data_len, want,
> +					req->r_data.num_pages);
> +				*skip = 1;
> +				ceph_msg_put(m);
> +				m = NULL;
> +				goto out;
> +			}
> +			m->pages = req->r_data.pages;
> +			m->page_count = req->r_data.num_pages;
> +			m->page_alignment = req->r_data.alignment;
>   #ifdef CONFIG_BLOCK
> -		m->bio = req->r_data.bio;
> +		} else if (req->r_data.type == CEPH_OSD_DATA_TYPE_BIO) {
> +			m->bio = req->r_data.bio;
>   #endif
> +		}
>   	}
>   	*skip = 0;
>   	req->r_con_filling_msg = con->ops->get(con);
>

