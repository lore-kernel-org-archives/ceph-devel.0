From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/3] ceph: fixes for directory fragment
Date: Sat, 21 Sep 2013 21:01:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309212100010.19555@cobra.newdream.net>
References: <1379717080-15626-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43982 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab3IVEBG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Sep 2013 00:01:06 -0400
In-Reply-To: <1379717080-15626-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

These look good.

I would *really* like to get some tests into ceph-qa-suite that cover 
multi-mds, multi-mds thrashing, and mds frag = true.  Eventulaly also 'mds 
thrash frags = true' (is this what you're testing with?).

sage


On Sat, 21 Sep 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> This patch series is also in:
>   https://github.com/ceph/ceph-client.git wip-dirfrag
> 
> The MDS counterpart is in:
>   https://github.com/ceph/ceph.git wip-dirfrag
> 
> Regards
> Yan, Zheng
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
