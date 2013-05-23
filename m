From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/30] mds: lookup-by-ino & fixes
Date: Thu, 23 May 2013 11:22:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305231118510.32642@cobra.newdream.net>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42349 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab3EWSW5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 14:22:57 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On Thu, 23 May 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Patch 1~21 are random fixes for MDS cluster. Patch 22~28 rework
> the backtrace handling. Patch 29 introduces lookup-by-ino helper.
> Path 30 uses the lookup-by-ino helper to fix issue #4850.
> 
> This patch series are also in:
>   git://github.com/ukernel/ceph.git wip-mds

Awesome!  I pushed this to wip-mds in ceph.git for now.  Note that 
gitbuilders are picking up a failure due to the encoding changes.  For the 
types and messages that change, can you mark them in the 
ceph-object-corpus.git tree?  Look for the forward_incompat/ dirs and 
follow that example.

I reviewed up until the backtrace patch before I ran out of time (catching 
a plane).  If you can address the comments we can get at least that 
much merged.  I'll defer to Greg for now on the backtrace changes, though, 
as he is more familiar with that original code.

Can't wait to get the lookup-by-ino into tree... I think the ganesha guys 
will be happy about that too.  Do you have any stress tests for that?  
There is a wip-cephfs branch (incomplete and not quite ready yet, but..) 
branch that adds a handle-based API to libcephfs.  Soon we should build 
some tests for the ino lookup based on that (or something similar) so we 
can hammer the mds cluster under various load/stress conditions.

Thanks!
sage
