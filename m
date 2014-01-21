From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 00/11] Fixes for mds cluster
Date: Mon, 20 Jan 2014 21:25:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401202124360.28801@cobra.newdream.net>
References: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38061 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaAUFZu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 00:25:50 -0500
In-Reply-To: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

It seems that 1 is missing?

I reviewed 2-9 and 11; ran out of steam on 10.  If this is holding up to 
your stress testing, though, I suggested pushing it to the testing branch 
so the nightly can run against it.

Thanks!
sage


On Tue, 21 Jan 2014, Yan, Zheng wrote:

> The last 5 patches are client part of protocol change that handles
> corner cases of capability import/export. The mds counterpart is at
>   https://github.com/ceph/ceph.git wip-mds-cluster2
> 
> The rest patches fix -ESTALE and other misc issues with mds cluster
> 
> These patches are also at:
>   https://github.com/ceph/ceph-client.git wip-mds-cluster
> 
> Regards
> Yan, Zheng
> 
> 
