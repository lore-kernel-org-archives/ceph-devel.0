From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 0/30] mds: lookup-by-ino & fixes
Date: Fri, 24 May 2013 16:44:27 +0800
Message-ID: <519F286B.2@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231118510.32642@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49201 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759970Ab3EXIob (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 May 2013 04:44:31 -0400
In-Reply-To: <alpine.DEB.2.00.1305231118510.32642@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On 05/24/2013 02:22 AM, Sage Weil wrote:
> On Thu, 23 May 2013, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> Patch 1~21 are random fixes for MDS cluster. Patch 22~28 rework
>> the backtrace handling. Patch 29 introduces lookup-by-ino helper.
>> Path 30 uses the lookup-by-ino helper to fix issue #4850.
>>
>> This patch series are also in:
>>   git://github.com/ukernel/ceph.git wip-mds
> 
> Awesome!  I pushed this to wip-mds in ceph.git for now.  Note that 
> gitbuilders are picking up a failure due to the encoding changes.  For the 
> types and messages that change, can you mark them in the 
> ceph-object-corpus.git tree?  Look for the forward_incompat/ dirs and 
> follow that example.
> 
Could you be more specific. Change in patch 14 should only affect MExportDir
and MExportCaps, object-corpus does not contain objects for these two messages.
Patch 27 looks suspicious, does the incompatible change you mentioned cause the
failure?


> I reviewed up until the backtrace patch before I ran out of time (catching 
> a plane).  If you can address the comments we can get at least that 
> much merged.  I'll defer to Greg for now on the backtrace changes, though, 
> as he is more familiar with that original code.
> 
> Can't wait to get the lookup-by-ino into tree... I think the ganesha guys 
> will be happy about that too.  Do you have any stress tests for that?  
> There is a wip-cephfs branch (incomplete and not quite ready yet, but..) 
> branch that adds a handle-based API to libcephfs.  Soon we should build 
> some tests for the ino lookup based on that (or something similar) so we 
> can hammer the mds cluster under various load/stress conditions.
> 
The only test case I have is patch 30. My environment has 3 active MDS and
2 clients running fsstress and blogbench. I restart random MDS every 2 minutes.
Each time MDS restarts, the lookup-by-ino function need open about 300 missing
inodes. I have run the restart test more than 1000 passes. No unsolved bug in
the lookup-by-ino function.

I have updated all patches you have comments, re-push them to:
  https://github.com/ukernel/ceph.git wip-mds

Regards
Yan, Zheng
