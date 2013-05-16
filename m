From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: must hold mutex for reset_changed_osds()
Date: Thu, 16 May 2013 09:11:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305160911040.25295@cobra.newdream.net>
References: <5193FF8D.2070403@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab3EPQLW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 12:11:22 -0400
In-Reply-To: <5193FF8D.2070403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 15 May 2013, Alex Elder wrote:
> An osd client has a red-black tree describing its osds, and
> occasionally we would get crashes due to one of these trees tree
> becoming corrupt somehow.
> 
> The problem turned out to be that reset_changed_osds() was being
> called without protection of the osd client request mutex.  That
> function would call __reset_osd() for any osd that had changed, and
> __reset_osd() would call __remove_osd() for any osd with no
> outstanding requests, and finally __remove_osd() would remove the
> corresponding entry from the red-black tree.  Thus, the tree was
> getting modified without having any lock protection, and was
> vulnerable to problems due to concurrent updates.
> 
> This appears to be the only osd tree updating path that has this
> problem.  It can be fairly easily fixed by moving the call up
> a few lines, to just before the request mutex gets dropped
> in kick_requests().
> 
> This resolves:
>     http://tracker.ceph.com/issues/5043
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Sage Weil <sage@inktank.com>


> ---
>  net/ceph/osd_client.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index d5953b8..3a246a6 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1675,13 +1675,13 @@ static void kick_requests(struct ceph_osd_client
> *osdc, int force_resend)
>  		__register_request(osdc, req);
>  		__unregister_linger_request(osdc, req);
>  	}
> +	reset_changed_osds(osdc);
>  	mutex_unlock(&osdc->request_mutex);
> 
>  	if (needmap) {
>  		dout("%d requests for down osds, need new map\n", needmap);
>  		ceph_monc_request_next_osdmap(&osdc->client->monc);
>  	}
> -	reset_changed_osds(osdc);
>  }
> 
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
