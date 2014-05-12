From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] crush: decode and initialize chooseleaf_vary_r
Date: Mon, 12 May 2014 05:28:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405120528030.12608@cobra.newdream.net>
References: <1399897059-4813-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53592 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367AbaELM2Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 May 2014 08:28:25 -0400
In-Reply-To: <1399897059-4813-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org, Dmitry Smirnov <onlyjob@member.fsf.org>

Reviewed-by: Sage Weil <sage@inktank.com>

On Mon, 12 May 2014, Ilya Dryomov wrote:

> Commit e2b149cc4ba0 ("crush: add chooseleaf_vary_r tunable") added the
> crush_map::chooseleaf_vary_r field but missed the decode part.  This
> lead to misdirected requests caused by incorrect raw crush mapping
> sets.
> 
> Fixes: http://tracker.ceph.com/issues/8226
> 
> Reported-and-Tested-by: Dmitry Smirnov <onlyjob@member.fsf.org>
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b8a5a24b223..c547e46084d3 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -329,6 +329,11 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>  	dout("crush decode tunable chooseleaf_descend_once = %d",
>  	     c->chooseleaf_descend_once);
>  
> +	ceph_decode_need(p, end, sizeof(u8), done);
> +	c->chooseleaf_vary_r = ceph_decode_8(p);
> +	dout("crush decode tunable chooseleaf_vary_r = %d",
> +	     c->chooseleaf_vary_r);
> +
>  done:
>  	dout("crush_decode success\n");
>  	return c;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
