From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: fix non-default values check in
 apply_primary_affinity()
Date: Thu, 10 Apr 2014 10:11:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404101011010.27526@cobra.newdream.net>
References: <1397139185-5492-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35820 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758712AbaDJRLU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Apr 2014 13:11:20 -0400
In-Reply-To: <1397139185-5492-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Thu, 10 Apr 2014, Ilya Dryomov wrote:

> osd_primary_affinity array is indexed into incorrectly when checking
> for non-default primary-affinity values.  This nullifies the impact of
> the rest of the apply_primary_affinity() and results in misdirected
> requests.
> 
>                 if (osds[i] != CRUSH_ITEM_NONE &&
>                     osdmap->osd_primary_affinity[i] !=
>                                                 ^^^
>                                         CEPH_OSD_DEFAULT_PRIMARY_AFFINITY) {
> 
> For a pool with size 2, this always ends up checking osd0 and osd1
> primary_affinity values, instead of the values that correspond to the
> osds in question.  E.g., given a [2,3] up set and a [max,max,0,max]
> primary affinity vector, requests are still sent to osd2, because both
> osd0 and osd1 happen to have max primary_affinity values and therefore
> we return from apply_primary_affinity() early on the premise that all
> osds in the given set have max (default) values.  Fix it.
> 
> Fixes: http://tracker.ceph.com/issues/7954
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index e632b5a52f5b..8b8a5a24b223 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1548,8 +1548,10 @@ static void apply_primary_affinity(struct ceph_osdmap *osdmap, u32 pps,
>  		return;
>  
>  	for (i = 0; i < len; i++) {
> -		if (osds[i] != CRUSH_ITEM_NONE &&
> -		    osdmap->osd_primary_affinity[i] !=
> +		int osd = osds[i];
> +
> +		if (osd != CRUSH_ITEM_NONE &&
> +		    osdmap->osd_primary_affinity[osd] !=
>  					CEPH_OSD_DEFAULT_PRIMARY_AFFINITY) {
>  			break;
>  		}
> @@ -1563,10 +1565,9 @@ static void apply_primary_affinity(struct ceph_osdmap *osdmap, u32 pps,
>  	 * osd's pgs get rejected as primary.
>  	 */
>  	for (i = 0; i < len; i++) {
> -		int osd;
> +		int osd = osds[i];
>  		u32 aff;
>  
> -		osd = osds[i];
>  		if (osd == CRUSH_ITEM_NONE)
>  			continue;
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
