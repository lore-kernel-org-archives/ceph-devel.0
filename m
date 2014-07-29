From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] ceph: use the OSD time as the object mtime instead of
 the client time
Date: Tue, 29 Jul 2014 08:46:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407290844430.27871@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C534891D8CB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51861 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaG2Pqr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 11:46:47 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C534891D8CB@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 29 Jul 2014, Wang, Zhiqiang wrote:
> This fixes a bug when the time of the OSDs and clients are not synchronized
> (especially when client is ahead of OSD), and the cache tier dirty ratio
> reaches the threshold, the agent skips the flush work because it thinks
> the object is too young.
> 
> The skipping flush code is as following:
> 
>   if (obc->obs.oi.mtime + utime_t(pool.info.cache_min_flush_age, 0) > now) {
>     dout(20) << __func__ << " skip (too young) " << obc->obs.oi << dendl;
>     osd->logger->inc(l_osd_agent_skip);
>     return false;
>   }

Hmm, I think the use of the client mtime is an important property we want 
to maintain for the benefit of the rest of the system.  Two other 
possibilities:

1) If cache_min_flush_age is 0, skip the check, so we avoid mtimes in the 
future in that case.

2) Add an additional field to object_info_t that is an mtime based on the 
OSD's clock, and use that for these checks.

What do you think?
sage


> 
> Signed-off-by: Zhiqiang Wang <wonzhq@hotmail.com>
> ---
>  src/osd/ReplicatedPG.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
> index 5d822c1..1c7c527 100644
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -1805,7 +1805,7 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)
> 
>      // version
>      ctx->at_version = get_next_version();
> -    ctx->mtime = m->get_mtime();
> +    ctx->mtime = ceph_clock_now(cct);
> 
>      dout(10) << "do_op " << soid << " " << ctx->ops
>              << " ov " << obc->obs.oi.version << " av " << ctx->at_version
> --
> 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
