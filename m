From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: fix ceph_msg_new error path
Date: Tue, 3 May 2011 09:08:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105030908160.20944@cobra.newdream.net>
References: <1304389796-11363-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35186 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1ECQHt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 12:07:49 -0400
In-Reply-To: <1304389796-11363-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org, Henry C Chang <henry_c_chang@tcloudcomputing.com>

Applied, thanks!

On Tue, 3 May 2011, Henry C Chang wrote:

> If memory allocation failed, calling ceph_msg_put() will cause GPF
> since some of ceph_msg variables are not initialized first.
> 
> Fix Bug #970.
> 
> Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
> ---
>  net/ceph/messenger.c |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 05f3578..e15a82c 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2267,6 +2267,19 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags)
>  	m->more_to_follow = false;
>  	m->pool = NULL;
>  
> +	/* middle */
> +	m->middle = NULL;
> +
> +	/* data */
> +	m->nr_pages = 0;
> +	m->page_alignment = 0;
> +	m->pages = NULL;
> +	m->pagelist = NULL;
> +	m->bio = NULL;
> +	m->bio_iter = NULL;
> +	m->bio_seg = 0;
> +	m->trail = NULL;
> +
>  	/* front */
>  	if (front_len) {
>  		if (front_len > PAGE_CACHE_SIZE) {
> @@ -2286,19 +2299,6 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags)
>  	}
>  	m->front.iov_len = front_len;
>  
> -	/* middle */
> -	m->middle = NULL;
> -
> -	/* data */
> -	m->nr_pages = 0;
> -	m->page_alignment = 0;
> -	m->pages = NULL;
> -	m->pagelist = NULL;
> -	m->bio = NULL;
> -	m->bio_iter = NULL;
> -	m->bio_seg = 0;
> -	m->trail = NULL;
> -
>  	dout("ceph_msg_new %p front %d\n", m, front_len);
>  	return m;
>  
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
