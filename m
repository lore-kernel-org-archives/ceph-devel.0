From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/2] libceph:  For nofail == false, if __map_request
 failed, it should unregister.
Date: Tue, 16 Jul 2013 17:43:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307161743430.21178@cobra.newdream.net>
References: <201307161545461466089@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45856 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab3GQAnr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 20:43:47 -0400
In-Reply-To: <201307161545461466089@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Applied, thanks!

On Tue, 16 Jul 2013, majianpeng wrote:

> For nofail == false  request, if __map_request failed, the caller do
> cleanup work,like release the relative pages.It doesn't make any sense
> to retry this request.So only give up it.
> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  net/ceph/osd_client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index dd47889..7d40a61 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2129,7 +2129,8 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>  			dout("osdc_start_request failed map, "
>  				" will retry %lld\n", req->r_tid);
>  			rc = 0;
> -		}
> +		} else
> +			__unregister_request(osdc, req);
>  		goto out_unlock;
>  	}
>  	if (req->r_osd == NULL) {
> -- 
> 1.8.1.2
> 
