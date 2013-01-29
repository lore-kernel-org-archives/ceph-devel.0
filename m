From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 07/25] mds: don't early reply rename
Date: Tue, 29 Jan 2013 10:56:19 +0800
Message-ID: <51073A53.5090705@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com> <1358910541-15535-8-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301281342130.2055@cobra.newdream.net> <51072969.1040705@intel.com> <alpine.DEB.2.00.1301281821310.16431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26779 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab3A2C4V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jan 2013 21:56:21 -0500
In-Reply-To: <alpine.DEB.2.00.1301281821310.16431@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 01/29/2013 10:23 AM, Sage Weil wrote:
> On Tue, 29 Jan 2013, Yan, Zheng wrote:
>> On 01/29/2013 05:44 AM, Sage Weil wrote:
>>> On Wed, 23 Jan 2013, Yan, Zheng wrote:
>>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>>
>>>> _rename_finish() does not send dentry link/unlink message to replicas.
>>>> We should prevent dentries that are modified by the rename operation
>>>> from getting new replicas when the rename operation is committing. So
>>>> don't mark xlocks "done" and early reply for rename
>>>
>>> Can we change this to only skip early reply if there are replicas?  Or 
>>> change things so we do send thos messages (or something isilar) early?  As 
>>> is this will kill workloads like rsync that rename every file.
>>>
>>
>> How about not mark xlocks on dentries done.
> 
> Yeah, I like that if we do that just in the rename case.
> 
> The other patches look okay to me (from a quick review).  With that change 
> I'd like to pull the whole branch in.  I assume your current wip-mds 
> branch include sthe fix or squashes the problem from the previous series?
> 

Just force update my wip-mds branch. That patch is renamed to "mds: don't set
xlocks on dentries done when early reply rename". 

I also updated "mds: preserve non-auth/unlinked objects until slave commit" and
"mds: fix slave rename rollback". The new patches trim non-auth subtrees more
actively.

Regards
Yan, Zheng
