From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/3] ceph: fix cap revoke race
Date: Tue, 2 Jul 2013 09:18:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307020918320.1067@cobra.newdream.net>
References: <1372740021-7980-1-git-send-email-zheng.z.yan@intel.com> <1372740021-7980-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50966 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3GBQSk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 12:18:40 -0400
In-Reply-To: <1372740021-7980-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Tue, 2 Jul 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> If caps are been revoking by the auth MDS, don't consider them as
> issued even they are still issued by non-auth MDS. The non-auth
> MDS should also be revoking/exporting these caps, the client just
> hasn't received the cap revoke/export message.
> 
> The race I encountered is: When caps are exporting to new MDS, the
> client receives cap import message and cap revoke message from the
> new MDS, then receives cap export message from the old MDS. When
> the client receives cap revoke message from the new MDS, the revoking
> caps are still issued by the old MDS, so the client does nothing.
> Later when the cap export message is received, the client removes
> the caps issued by the old MDS. (Another way to fix the race is
> calling ceph_check_caps() in handle_cap_export())
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 16266f3..7045a8d 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -690,6 +690,15 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
>  		if (implemented)
>  			*implemented |= cap->implemented;
>  	}
> +	/*
> +	 * exclude caps issued by non-auth MDS, but are been revoking
> +	 * by the auth MDS. The non-auth MDS should be revoking/exporting
> +	 * these caps, but the message is delayed.
> +	 */
> +	if (ci->i_auth_cap) {
> +		cap = ci->i_auth_cap;
> +		have &= ~cap->implemented | cap->issued;
> +	}
>  	return have;
>  }
>  
> -- 
> 1.8.1.4
> 
> 
