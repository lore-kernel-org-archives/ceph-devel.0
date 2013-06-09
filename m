From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/9] fixes for kclient
Date: Sat, 8 Jun 2013 23:23:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306082322010.18155@cobra.newdream.net>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48492 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIGXb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Jun 2013 02:23:31 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, elder@inktank.com

I pulled these into the testing branch, with the exception of #2, which 
needs a closer look.

We should really be checking the userspace client for these same issues 
(the logic ones at least) to avoid fixing the same or similar bugs later..

Thanks!
sage

On Tue, 4 Jun 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> this patch series are also in:
>   git://github.com/ukernel/linux.git wip-ceph
> 
> Regards
> Yan, Zheng
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
