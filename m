From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] ceph: Fix oops when mounting cephfs with non-existing
 path
Date: Mon, 20 Aug 2012 10:47:15 +0800
Message-ID: <5031A533.8070603@intel.com>
References: <1345182959-6486-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1208170850380.26904@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11517 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab2HTCrR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 19 Aug 2012 22:47:17 -0400
In-Reply-To: <alpine.DEB.2.00.1208170850380.26904@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/17/2012 11:54 PM, Sage Weil wrote:
> Hi Yan,
> 
> On Fri, 17 Aug 2012, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> req->r_locked_dir is NULL if the request was created by
>> open_root_dentry(). ceph_fill_trace() lacks check for this case.
>> It causes oops when mounting cephfs with non-existing path.
> 
> This is actually an MDS bug.  The problem is that the client is issuing a 
> GETATTR request and isn't prepared to handle a dentry in the reply, but 
> the MDS sees that there is a relative path in the request and behaves like 
> this is a lookup.  We were distinguishing correctly between the two cases 
> on success, but not on error.  I've pushed branch bug-2969 to ceph.git 
> which fixes this for me.  Can you please test and verify it resolves 
> the problem?
It does resolve the problem.

> 
> We may want to have a check like the below, but it should probably be 
> accompanied by a pr_warning or WARN_ON() since it is a protocol error.  
> Generally speaking, the client isn't allowed to ignore state the MDS has 
> issued it (in this case, caps on the directory inode; lower down in 
> fill_trace possibly a dentry lease) without messing up the protocol.
> 

Thank you for your explanation. 

Yan, Zheng
