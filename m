From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] README: Add missing "install"
Date: Fri, 21 Mar 2014 10:49:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403211047310.5823@cobra.newdream.net>
References: <1395422784-13443-1-git-send-email-jon.mason@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49284 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbaCURt0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Mar 2014 13:49:26 -0400
In-Reply-To: <1395422784-13443-1-git-send-email-jon.mason@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jon Mason <jon.mason@intel.com>
Cc: ceph-devel@vger.kernel.org

This appears to have already been fixed recently in 
	a4b3b786ff6d176c7aa62f7af2056d00c0bc57de

Thanks!
sage


On Fri, 21 Mar 2014, Jon Mason wrote:

> In the section describing how to build packages for Debian, the command
> given to install dpkg-dev is incomplete.  "install" is needed for the
> command to execute as desired.
> 
> Signed-off-by: Jon Mason <jon.mason@intel.com>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 197a7bf..825e932 100644
> --- a/README
> +++ b/README
> @@ -58,7 +58,7 @@ Building packages
>  You can build packages for Debian or Debian-derived (e.g., Ubuntu)
>  systems with
>  
> -$ sudo apt-get dpkg-dev
> +$ sudo apt-get install dpkg-dev
>  $ dpkg-checkbuilddeps        # make sure we have all dependencies
>  $ dpkg-buildpackage
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
