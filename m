From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: Assign different global_id for each
 ceph_auth_client.
Date: Fri, 17 Aug 2012 09:40:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208170938290.26904@cobra.newdream.net>
References: <1345022611-14080-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47022 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758481Ab2HQQkc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 12:40:32 -0400
In-Reply-To: <1345022611-14080-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 15 Aug 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> The global_id for ceph_auth_client is always zero. It prevents the
> kernel from creating more than one ceph_clients that are connected
> to the same cluster. (ceph_debugfs_client_init() fails to create
> debugfs directory)
> 
> Without this patch, I can't using rbd and cephfs on the same machine.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

This one is a bit more complicated.  The global_id is a cluster-wide 
unique id assigned by the monitor.  We can't set up the debugfs dir until 
we have that and the fsid.  The check was in handle_monmap, I suspect 
because long ago the fsid was learned after the global_id, whereas now it 
is normally fsid and then global_id.

I just sent two patches that restructure this so that we will initialize 
debugfs only after getting both values, regardless of which order. Let me 
know if that resolves things on your end; it's working for me :)

Thanks!
sage


> ---
>  net/ceph/auth.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> index b4bf4ac..2b00d3a 100644
> --- a/net/ceph/auth.c
> +++ b/net/ceph/auth.c
> @@ -12,6 +12,8 @@
>  #include "auth_x.h"
>  
>  
> +static u64 auth_global_id;
> +
>  /*
>   * get protocol handler
>   */
> @@ -54,6 +56,7 @@ struct ceph_auth_client *ceph_auth_init(const char *name, const struct ceph_cryp
>  		ac->name = CEPH_AUTH_NAME_DEFAULT;
>  	dout("auth_init name %s\n", ac->name);
>  	ac->key = key;
> +	ac->global_id = ++auth_global_id;
>  	return ac;
>  
>  out:
> -- 
> 1.7.11.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
