From: Sage Weil <sage@newdream.net>
Subject: Re: rbd: null pointer dereferenced during osd_reset
Date: Tue, 29 Mar 2011 12:01:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103291200330.19819@cobra.newdream.net>
References: <AANLkTikr09GsB49N0dSOyvfY63CkTx9CBj4iSG460_BN@mail.gmail.com>
 <Pine.LNX.4.64.1103291103240.19819@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39413 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1C2S6M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 14:58:12 -0400
In-Reply-To: <Pine.LNX.4.64.1103291103240.19819@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 29 Mar 2011, Sage Weil wrote:
> On Tue, 29 Mar 2011, Henry Chang wrote:
> > Hi,
> > 
> > I got the NULL pointer dereference exception (see below) when I
> > restarted one of my osd during rbd testing. After digging into
> > osd_client.c, it seems that when osd_reset() is called, the req->r_osd
> > will be set to NULL in __unregister_linger_request(). Then, in
> > send_queued(), req->r_osd (NULL pointer) will be dereferenced in
> > __send_request().
> 
> The patch below (also pushed to ceph-client.git master) should fix this. 
> Can you give it a test?
> 
> Thanks!
> sage
> 
> 
> >From 83c52219ff0f4581f1affe577a34ea7d3ba7b59d Mon Sep 17 00:00:00 2001
> From: Sage Weil <sage@newdream.net>
> Date: Tue, 29 Mar 2011 10:14:26 -0700
> Subject: [PATCH] libceph: fix null dereference when unregistering linger requests
> 
> We should only clear r_osd if we are neither registered as a linger or a
> regular request.  We may unregister as a linger while still registered as
> a regular request (e.g., in reset_osd).  Incorrectly clearing r_osd there
> leads to a null pointer dereference in __send_request.
> 
> Also simplify the parallel check in __unregister_request() where we just
> removed r_osd_item and know it's empty.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  net/ceph/osd_client.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 03740e8..3f957a6 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -837,8 +837,7 @@ static void __unregister_request(struct ceph_osd_client *osdc,
>  			dout("moving osd to %p lru\n", req->r_osd);
>  			__move_osd_to_lru(osdc, req->r_osd);
>  		}
> -		if (list_empty(&req->r_osd_item) &&
> -		    list_empty(&req->r_linger_item))
> +		if (list_empty(&req->r_linger_item))
>  			req->r_osd = NULL;
>  	}
>  
> @@ -883,7 +882,8 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  			dout("moving osd to %p lru\n", req->r_osd);
>  			__move_osd_to_lru(osdc, req->r_osd);
>  		}
> -		req->r_osd = NULL;
> +		if (list_empty(&req->r_osd_item))
> +			req->r_osd == NULL;

...and I pushed an updated version that fixes the == no-op above.  :)

sage



>  	}
>  }
>  
> -- 
> 1.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
