From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH V2 1/2] mds: Fix SessionMap::is_any_state()
Date: Mon, 24 Sep 2012 09:40:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209240940090.8973@cobra.newdream.net>
References: <1348486029-1125-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40316 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846Ab2IXQkN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 12:40:13 -0400
In-Reply-To: <1348486029-1125-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Mon, 24 Sep 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> is_any_state() should return false when the by_state list is empty.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/SessionMap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/mds/SessionMap.h b/src/mds/SessionMap.h
> index fcd0b47..6bca361 100644
> --- a/src/mds/SessionMap.h
> +++ b/src/mds/SessionMap.h
> @@ -248,7 +248,7 @@ public:
>  
>    bool is_any_state(int state) {
>      map<int,xlist<Session*>* >::iterator p = by_state.find(state);
> -    if (p == by_state.end())
> +    if (p == by_state.end() || p->second->empty())
>        return false;
>      return true;
>    }
> -- 
> 1.7.11.4
> 
> 
