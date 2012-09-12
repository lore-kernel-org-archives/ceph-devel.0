From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] osd/OSD.cc: Fix typo in OSD::heartbeat_check()
Date: Wed, 12 Sep 2012 14:28:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209121428290.19850@cobra.newdream.net>
References: <1346996967-6380-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51267 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab2ILV2q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 17:28:46 -0400
In-Reply-To: <1346996967-6380-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Applied.  Nice catch!

Thanks-
sage


On Fri, 7 Sep 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> The check 'p->second.last_tx > cutoff' should always be false
> since last_tx is periodically updated by OSD::heartbeat()
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/osd/OSD.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
> index 5add675..562fd25 100644
> --- a/src/osd/OSD.cc
> +++ b/src/osd/OSD.cc
> @@ -1946,13 +1946,13 @@ void OSD::heartbeat_check()
>         p != heartbeat_peers.end();
>         p++) {
>      dout(25) << "heartbeat_check osd." << p->first
> -	     << " first_rx " << p->second.first_tx
> +	     << " first_tx " << p->second.first_tx
>  	     << " last_tx " << p->second.last_tx
>  	     << " last_rx " << p->second.last_rx
>  	     << dendl;
>      if (p->second.last_rx == utime_t()) {
>        if (p->second.last_tx == utime_t() ||
> -	  p->second.last_tx > cutoff)
> +	  p->second.first_tx > cutoff)
>  	continue;  // just started sending recently
>        derr << "heartbeat_check: no reply from osd." << p->first
>  	   << " ever, first ping sent " << p->second.first_tx
> -- 
> 1.7.11.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
