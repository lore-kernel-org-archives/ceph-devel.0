From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 04/20] libceph: define a few more helpers
Date: Fri, 05 Apr 2013 11:17:06 -0700
Message-ID: <515F1522.5030402@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED966.50704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:62310 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162334Ab3DESR1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 14:17:27 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so2152541pbc.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 11:17:27 -0700 (PDT)
In-Reply-To: <515ED966.50704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There's a sizeof without parentheses, but after fixing that:

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:02 AM, Alex Elder wrote:
> Define ceph_osd_data_init() and ceph_osd_data_release() to clean up
> a little code.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |   44 ++++++++++++++++++++++++++------------------
>   1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index f8f8561..df0f856 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -79,6 +79,12 @@ static int calc_layout(struct ceph_file_layout
> *layout, u64 off, u64 *plen,
>   	return 0;
>   }
>
> +static void ceph_osd_data_init(struct ceph_osd_data *osd_data)
> +{
> +	memset(osd_data, 0, sizeof *osd_data);
> +	osd_data->type = CEPH_OSD_DATA_TYPE_NONE;
> +}
> +
>   void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
>   			struct page **pages, u64 length, u32 alignment,
>   			bool pages_from_pool, bool own_pages)
> @@ -111,16 +117,28 @@ void ceph_osd_data_bio_init(struct ceph_osd_data
> *osd_data,
>   EXPORT_SYMBOL(ceph_osd_data_bio_init);
>   #endif /* CONFIG_BLOCK */
>
> +static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
> +{
> +	if (osd_data->type != CEPH_OSD_DATA_TYPE_PAGES)
> +		return;
> +
> +	if (osd_data->own_pages) {
> +		int num_pages;
> +
> +		num_pages = calc_pages_for((u64)osd_data->alignment,
> +						(u64)osd_data->length);
> +		ceph_release_page_vector(osd_data->pages, num_pages);
> +	}
> +}
> +
>   /*
>    * requests
>    */
>   void ceph_osdc_release_request(struct kref *kref)
>   {
> -	int num_pages;
> -	struct ceph_osd_request *req = container_of(kref,
> -						    struct ceph_osd_request,
> -						    r_kref);
> +	struct ceph_osd_request *req;
>
> +	req = container_of(kref, struct ceph_osd_request, r_kref);
>   	if (req->r_request)
>   		ceph_msg_put(req->r_request);
>   	if (req->r_reply) {
> @@ -128,18 +146,8 @@ void ceph_osdc_release_request(struct kref *kref)
>   		ceph_msg_put(req->r_reply);
>   	}
>
> -	if (req->r_data_in.type == CEPH_OSD_DATA_TYPE_PAGES &&
> -			req->r_data_in.own_pages) {
> -		num_pages = calc_pages_for((u64)req->r_data_in.alignment,
> -						(u64)req->r_data_in.length);
> -		ceph_release_page_vector(req->r_data_in.pages, num_pages);
> -	}
> -	if (req->r_data_out.type == CEPH_OSD_DATA_TYPE_PAGES &&
> -			req->r_data_out.own_pages) {
> -		num_pages = calc_pages_for((u64)req->r_data_out.alignment,
> -						(u64)req->r_data_out.length);
> -		ceph_release_page_vector(req->r_data_out.pages, num_pages);
> -	}
> +	ceph_osd_data_release(&req->r_data_in);
> +	ceph_osd_data_release(&req->r_data_out);
>
>   	ceph_put_snap_context(req->r_snapc);
>   	if (req->r_mempool)
> @@ -203,8 +211,8 @@ struct ceph_osd_request
> *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
>   	}
>   	req->r_reply = msg;
>
> -	req->r_data_in.type = CEPH_OSD_DATA_TYPE_NONE;
> -	req->r_data_out.type = CEPH_OSD_DATA_TYPE_NONE;
> +	ceph_osd_data_init(&req->r_data_in);
> +	ceph_osd_data_init(&req->r_data_out);
>
>   	/* create request message; allow space for oid */
>   	if (use_mempool)
>

