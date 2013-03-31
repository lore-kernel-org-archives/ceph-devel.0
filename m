From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: fix broken data length assertions
Date: Sat, 30 Mar 2013 18:00:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303301800440.12367@cobra.newdream.net>
References: <51573E2E.5090406@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44242 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab3CaBAw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Mar 2013 21:00:52 -0400
In-Reply-To: <51573E2E.5090406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Sage Weil <sage@inktank.com>

On Sat, 30 Mar 2013, Alex Elder wrote:

> It's OK for the result of a read to come back with fewer bytes than
> were requested.  So don't trigger a BUG() in that case when
> initializing the data cursor.
> 
> This resolves:
>     http://tracker.ceph.com/issues/4598
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index d4e46d8..24f3aba 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -833,7 +833,7 @@ static void ceph_msg_data_pages_cursor_init(struct
> ceph_msg_data *data,
> 
>  	BUG_ON(!data->pages);
>  	BUG_ON(!data->length);
> -	BUG_ON(length != data->length);
> +	BUG_ON(length > data->length);	/* short reads are OK */
> 
>  	cursor->resid = length;
>  	page_count = calc_pages_for(data->alignment, (u64)data->length);
> @@ -905,7 +905,7 @@ static void
> ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data,
> 
>  	pagelist = data->pagelist;
>  	BUG_ON(!pagelist);
> -	BUG_ON(length != pagelist->length);
> +	BUG_ON(length > pagelist->length);	/* short reads are OK */
> 
>  	if (!length)
>  		return;		/* pagelist can be assigned but empty */
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
