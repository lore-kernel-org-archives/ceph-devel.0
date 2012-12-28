From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/3] libceph: always reset osds when kicking
Date: Thu, 27 Dec 2012 16:55:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212271655020.22449@cobra.newdream.net>
References: <50DCD544.8000602@inktank.com> <50DCD70B.9020008@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44538 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab2L1AzM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 19:55:12 -0500
In-Reply-To: <50DCD70B.9020008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 27 Dec 2012, Alex Elder wrote:
> When ceph_osdc_handle_map() is called to process a new osd map,
> kick_requests() is called to ensure all affected requests are
> updated if necessary to reflect changes in the osd map.  This
> happens in two cases:  whenever an incremental map update is
> processed; and when a full map update (or the last one if there is
> more than one) gets processed.
> 
> In the former case, the kick_requests() call is followed immediately
> by a call to reset_changed_osds() to ensure any connections to osds
> affected by the map change are reset.  But for full map updates
> this isn't done.
> 
> Both cases should be doint this osd reset.
> 
> Rather than duplicating the reset_changed_osds() call, move it into
> the end of kick_requests().
> 
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Sage Weil <sage@inktank.com>

> ---
>  net/ceph/osd_client.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 616c6cf..0be8f0d 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1270,7 +1270,7 @@ static void reset_changed_osds(struct
> ceph_osd_client *osdc)
>   * Requeue requests whose mapping to an OSD has changed.  If requests
> map to
>   * no osd, request a new map.
>   *
> - * Caller should hold map_sem for read and request_mutex.
> + * Caller should hold map_sem for read.
>   */
>  static void kick_requests(struct ceph_osd_client *osdc, int force_resend)
>  {
> @@ -1346,6 +1346,7 @@ static void kick_requests(struct ceph_osd_client
> *osdc, int force_resend)
>  		dout("%d requests for down osds, need new map\n", needmap);
>  		ceph_monc_request_next_osdmap(&osdc->client->monc);
>  	}
> +	reset_changed_osds(osdc);
>  }
> 
> 
> @@ -1402,7 +1403,6 @@ void ceph_osdc_handle_map(struct ceph_osd_client
> *osdc, struct ceph_msg *msg)
>  				osdc->osdmap = newmap;
>  			}
>  			kick_requests(osdc, 0);
> -			reset_changed_osds(osdc);
>  		} else {
>  			dout("ignoring incremental map %u len %d\n",
>  			     epoch, maplen);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
