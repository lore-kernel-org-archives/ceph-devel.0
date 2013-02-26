From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 3/3] ceph: fix vmtruncate deadlock
Date: Mon, 25 Feb 2013 21:00:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302252051300.6167@cobra.newdream.net>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com> <1361498899-15831-4-git-send-email-zheng.z.yan@intel.com> <CAPYLRziAgfT0F2cdNe+sMbiphBMz20Sm3oSgqkdwNcJL-K--DQ@mail.gmail.com> <51284624.9050007@intel.com>
 <CAPYLRzinxnLg9+c-2Bh2f=S6vjqdTi+WjGsf02FTkj1sJK0iSQ@mail.gmail.com> <512C1AB1.1090307@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45677 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3BZFAW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 00:00:22 -0500
In-Reply-To: <512C1AB1.1090307@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 26 Feb 2013, Yan, Zheng wrote:
> > It looks to me like truncates can get queued for later, so that's not the case?
> > And how could the client receive a truncate while in the middle of
> > writing? Either it's got the write caps (in which case nobody else can
> > truncate), or it shouldn't be writing...I suppose if somebody enables
> > lazyIO that would do it, but again in that case I imagine we'd rather
> > do the truncate before writing:
> 
> Commit 22cddde104 make buffered write get/put caps for individual page. So the MDS can
> revoke the write caps in the middle of write.
> 
> > 
> >> I think it's better to do vmtruncate after write finishes.
> > What if you're writing past the truncate point? Then your written data
> > would be truncated off even though it should have been a file
> > extension.
> >
> I was wrong, I thought the order of write and truncate is not important. 
> Now I'm worry about the correctness of commit 22cddde104, we probably 
> should revert that commit.

I'm sorry I haven't had time to dig into this thread.  Do you think we 
should revert that commit for this merge window?

My gut feeling is that the whole locking scheme here needs to be reworked.  
I suspect where we'll end up is something more like XFS, where there is an 
explicit truncate (or other) mutex that is separate from i_mutex.  The 
fact that we were relying on i_mutex serialization from the VFS was 
fragile and (as we can see) ultimately a flawed approach.  And the locking 
and races between writes, mmap, and truncation in the page cache code are 
fragile and annoying.  The only good thing going for us is that fsx is 
pretty good at stress testing the code.  :)

> > Oh, you're right about the locking (I think, anyway?). However, i_size 
> > doesn't protect us ? we might for instance have truncated to zero and 
> > then back up to the original file size. :( But that doesn't look like 
> > it's handled correctly anyway (racy) ? am I misreading that badly or 
> > is the infrastructure in fact broken in that case?
> 
> You are right. probably we can fix the race by disallowing both read and 
> write when there is pending truncate.

FWIW, I think the high-level strategy before should still be basically 
sound: we can queue a truncation without blocking, and any write path will 
apply a pending truncation under the appropriate lock.  But I think it's 
going to mean carefully documenting the locking requirements for the 
various paths and working out a new locking structure.

Yan, is this something you are able to put some time into?  I would like 
to work on it, but it's going to be hard for me to find the time in the 
next several weeks to get to it.

sage
