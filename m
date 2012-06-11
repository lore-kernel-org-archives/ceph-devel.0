From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] mon: fix pg state logging
Date: Mon, 11 Jun 2012 09:52:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206110952160.10557@cobra.newdream.net>
References: <1339381980-11571-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46238 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab2FKQwd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 12:52:33 -0400
In-Reply-To: <1339381980-11571-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 11 Jun 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> PGMap->num_pg_by_state is a PG state to number of PG in the state
> mapping. PGMonitor::update_logger wrongly interprets the mapping.

Thanks, applied!
sage


> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mon/PGMonitor.cc |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/src/mon/PGMonitor.cc b/src/mon/PGMonitor.cc
> index 97fbb1b..1b0a210 100644
> --- a/src/mon/PGMonitor.cc
> +++ b/src/mon/PGMonitor.cc
> @@ -96,13 +96,13 @@ void PGMonitor::update_logger()
>    for (hash_map<int,int>::iterator p = pg_map.num_pg_by_state.begin();
>         p != pg_map.num_pg_by_state.end();
>         ++p) {
> -    if (p->second & PG_STATE_ACTIVE) {
> -      active++;
> -      if (p->second & PG_STATE_CLEAN)
> -	active_clean++;
> +    if (p->first & PG_STATE_ACTIVE) {
> +      active += p->second;
> +      if (p->first & PG_STATE_CLEAN)
> +	active_clean += p->second;
>      }
> -    if (p->second & PG_STATE_PEERING)
> -      peering++;
> +    if (p->first & PG_STATE_PEERING)
> +      peering += p->second;
>    }
>    mon->cluster_logger->set(l_cluster_num_pg_active_clean, active_clean);
>    mon->cluster_logger->set(l_cluster_num_pg_active, active);
> -- 
> 1.7.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
