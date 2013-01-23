From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 01/25] mds: fix end check in
 Server::handle_client_readdir()
Date: Wed, 23 Jan 2013 09:17:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301230916200.29291@cobra.newdream.net>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com> <1358910541-15535-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50855 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab3AWRRP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 12:17:15 -0500
In-Reply-To: <1358910541-15535-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan,

I pushed this one to next, thanks.  BTW what are you using to reproduce 
this?  We'd like to continue to improve the coverage of 
ceph-qa-suite.git/suites/fs.

Thanks!
sage

On Wed, 23 Jan 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> commit 1174dd3188 (don't retry readdir request after issuing caps)
> introduced an bug that wrongly marks 'end' in the the readdir reply.
> The code that touches existing dentries re-uses an iterator, and the
> iterator is used for checking if readdir is end.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Server.cc | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index b70445e..45eed81 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -2895,11 +2895,9 @@ void Server::handle_client_readdir(MDRequest *mdr)
>  	continue;
>        } else {
>  	// touch everything i _do_ have
> -	for (it = dir->begin(); 
> -	     it != dir->end(); 
> -	     it++) 
> -	  if (!it->second->get_linkage()->is_null())
> -	    mdcache->lru.lru_touch(it->second);
> +	for (CDir::map_t::iterator p = dir->begin(); p != dir->end(); p++)
> +	  if (!p->second->get_linkage()->is_null())
> +	    mdcache->lru.lru_touch(p->second);
>  
>  	// already issued caps and leases, reply immediately.
>  	if (dnbl.length() > 0) {
> -- 
> 1.7.11.7
> 
> 
