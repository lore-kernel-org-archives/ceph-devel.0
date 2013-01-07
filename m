From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 5/6] ceph: check mds_wanted for imported cap
Date: Sun, 6 Jan 2013 21:11:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301062110260.15430@cobra.newdream.net>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-6-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301052216330.15430@cobra.newdream.net> <50E93BDC.6050104@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60325 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab3AGFLu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 00:11:50 -0500
In-Reply-To: <50E93BDC.6050104@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 6 Jan 2013, Yan, Zheng wrote:
> how about below patch, also updated git://github.com/ukernel/ceph-client.git wip-ceph

The branch looks good.  Once Alex sorts out testing-next tomorrow we can 
pull these in.  If you don't mind adding the Reviewed-by tags, that'd be 
helpful, otherwise I'll do it tomorrow.

Thanks!
sage


> 
> Reagrds
> Yan, Zheng
> ---
> >From 6fdcf8d71239dac7b26f50623ee5986f39552b4a Mon Sep 17 00:00:00 2001
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> Date: Fri, 4 Jan 2013 15:30:10 +0800
> Subject: [PATCH 5/5] ceph: check mds_wanted for imported cap
> 
> The MDS may have incorrect wanted caps after importing caps. So the
> client should check the value mds has and send cap update if necessary.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 40b5bbe..1e1e020 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2429,7 +2429,9 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
>  		dout("mds wanted %s -> %s\n",
>  		     ceph_cap_string(le32_to_cpu(grant->wanted)),
>  		     ceph_cap_string(wanted));
> -		grant->wanted = cpu_to_le32(wanted);
> +		/* imported cap may not have correct mds_wanted */
> +		if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT)
> +			check_caps = 1;
>  	}
>  
>  	cap->seq = seq;
> -- 
> 1.7.11.7
> 
> 
