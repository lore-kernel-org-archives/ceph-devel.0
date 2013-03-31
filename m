From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: page offset must be less than page size
Date: Sat, 30 Mar 2013 17:59:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303301759500.12367@cobra.newdream.net>
References: <51575915.3060806@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44207 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab3CaA75 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Mar 2013 20:59:57 -0400
In-Reply-To: <51575915.3060806@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Sage Weil <sage@inktank.com>

On Sat, 30 Mar 2013, Alex Elder wrote:

> Currently ceph_msg_data_pages_advance() allows the page offset value
> to be PAGE_SIZE, apparently assuming ceph_msg_data_pages_next() will
> treat it as 0.  But that doesn't happen, and the result led to a
> helpful assertion failure.
> 
> Change ceph_msg_data_pages_advance() to truncate the offset to 0
> before returning if it reaches PAGE_SIZE.
> 
> Make a few other minor adjustments in this area (comments and a
> better assertion) while modifying it.
> 
> This resolves a second issue described in:
>     http://tracker.ceph.com/issues/4598
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 24f3aba..198b902 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -766,8 +766,8 @@ static struct page *ceph_msg_data_bio_next(struct
> ceph_msg_data *data,
>  		*length = cursor->resid;
>  	else
>  		*length = (size_t) (bio_vec->bv_len - cursor->vector_offset);
> -	BUG_ON(*length > PAGE_SIZE);
>  	BUG_ON(*length > cursor->resid);
> +	BUG_ON(*page_offset + *length > PAGE_SIZE);
> 
>  	return bio_vec->bv_page;
>  }
> @@ -876,14 +876,13 @@ static bool ceph_msg_data_pages_advance(struct
> ceph_msg_data *data,
>  	/* Advance the cursor page offset */
> 
>  	cursor->resid -= bytes;
> -	cursor->page_offset += bytes;
> -	if (!bytes || cursor->page_offset & ~PAGE_MASK)
> +	cursor->page_offset = (cursor->page_offset + bytes) & ~PAGE_MASK;
> +	if (!bytes || cursor->page_offset)
>  		return false;	/* more bytes to process in the current page */
> 
> -	/* Move on to the next page */
> +	/* Move on to the next page; offset is already at 0 */
> 
>  	BUG_ON(cursor->page_index >= cursor->page_count);
> -	cursor->page_offset = 0;
>  	cursor->page_index++;
>  	cursor->last_piece = cursor->resid <= PAGE_SIZE;
> 
> @@ -934,8 +933,9 @@ static struct page
> *ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
>  	BUG_ON(!cursor->page);
>  	BUG_ON(cursor->offset + cursor->resid != pagelist->length);
> 
> +	/* offset of first page in pagelist is always 0 */
>  	*page_offset = cursor->offset & ~PAGE_MASK;
> -	if (cursor->last_piece) /* pagelist offset is always 0 */
> +	if (cursor->last_piece)
>  		*length = cursor->resid;
>  	else
>  		*length = PAGE_SIZE - *page_offset;
> @@ -961,7 +961,7 @@ static bool ceph_msg_data_pagelist_advance(struct
> ceph_msg_data *data,
> 
>  	cursor->resid -= bytes;
>  	cursor->offset += bytes;
> -	/* pagelist offset is always 0 */
> +	/* offset of first page in pagelist is always 0 */
>  	if (!bytes || cursor->offset & ~PAGE_MASK)
>  		return false;	/* more bytes to process in the current page */
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
