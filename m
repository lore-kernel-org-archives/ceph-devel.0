From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 06/20] libceph: a few more osd data cleanups
Date: Fri, 05 Apr 2013 11:17:38 -0700
Message-ID: <515F1542.6010307@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED98C.5010709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:39743 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162360Ab3DESSA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 14:18:00 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so1695192dad.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 11:17:59 -0700 (PDT)
In-Reply-To: <515ED98C.5010709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:02 AM, Alex Elder wrote:
> These are very small changes that make use osd_data local pointers
> as shorthands for structures being operated on.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   fs/ceph/addr.c |   30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 8507389..c46b9d3 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -236,6 +236,7 @@ static int ceph_readpage(struct file *filp, struct
> page *page)
>   static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
>   {
>   	struct inode *inode = req->r_inode;
> +	struct ceph_osd_data *osd_data;
>   	int rc = req->r_result;
>   	int bytes = le32_to_cpu(msg->hdr.data_len);
>   	int num_pages;
> @@ -244,11 +245,12 @@ static void finish_read(struct ceph_osd_request
> *req, struct ceph_msg *msg)
>   	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);
>
>   	/* unlock all pages, zeroing any data we didn't read */
> -	BUG_ON(req->r_data_in.type != CEPH_OSD_DATA_TYPE_PAGES);
> -	num_pages = calc_pages_for((u64)req->r_data_in.alignment,
> -					(u64)req->r_data_in.length);
> +	osd_data = &req->r_data_in;
> +	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
> +	num_pages = calc_pages_for((u64)osd_data->alignment,
> +					(u64)osd_data->length);
>   	for (i = 0; i < num_pages; i++) {
> -		struct page *page = req->r_data_in.pages[i];
> +		struct page *page = osd_data->pages[i];
>
>   		if (bytes < (int)PAGE_CACHE_SIZE) {
>   			/* zero (remainder of) page */
> @@ -263,7 +265,7 @@ static void finish_read(struct ceph_osd_request
> *req, struct ceph_msg *msg)
>   		page_cache_release(page);
>   		bytes -= PAGE_CACHE_SIZE;
>   	}
> -	kfree(req->r_data_in.pages);
> +	kfree(osd_data->pages);
>   }
>
>   static void ceph_unlock_page_vector(struct page **pages, int num_pages)
> @@ -557,6 +559,7 @@ static void writepages_finish(struct
> ceph_osd_request *req,
>   {
>   	struct inode *inode = req->r_inode;
>   	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct ceph_osd_data *osd_data;
>   	unsigned wrote;
>   	struct page *page;
>   	int num_pages;
> @@ -569,9 +572,10 @@ static void writepages_finish(struct
> ceph_osd_request *req,
>   	long writeback_stat;
>   	unsigned issued = ceph_caps_issued(ci);
>
> -	BUG_ON(req->r_data_out.type != CEPH_OSD_DATA_TYPE_PAGES);
> -	num_pages = calc_pages_for((u64)req->r_data_out.alignment,
> -					(u64)req->r_data_out.length);
> +	osd_data = &req->r_data_out;
> +	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
> +	num_pages = calc_pages_for((u64)osd_data->alignment,
> +					(u64)osd_data->length);
>   	if (rc >= 0) {
>   		/*
>   		 * Assume we wrote the pages we originally sent.  The
> @@ -589,7 +593,7 @@ static void writepages_finish(struct
> ceph_osd_request *req,
>
>   	/* clean all pages */
>   	for (i = 0; i < num_pages; i++) {
> -		page = req->r_data_out.pages[i];
> +		page = osd_data->pages[i];
>   		BUG_ON(!page);
>   		WARN_ON(!PageUptodate(page));
>
> @@ -620,12 +624,12 @@ static void writepages_finish(struct
> ceph_osd_request *req,
>   	dout("%p wrote+cleaned %d pages\n", inode, wrote);
>   	ceph_put_wrbuffer_cap_refs(ci, num_pages, snapc);
>
> -	ceph_release_pages(req->r_data_out.pages, num_pages);
> -	if (req->r_data_out.pages_from_pool)
> -		mempool_free(req->r_data_out.pages,
> +	ceph_release_pages(osd_data->pages, num_pages);
> +	if (osd_data->pages_from_pool)
> +		mempool_free(osd_data->pages,
>   			     ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
>   	else
> -		kfree(req->r_data_out.pages);
> +		kfree(osd_data->pages);
>   	ceph_osdc_put_request(req);
>   }
>

