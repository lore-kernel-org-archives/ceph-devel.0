From: Sage Weil <sage@newdream.net>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Thu, 29 Jun 2017 19:25:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42692 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdF2TZm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 15:25:42 -0400
In-Reply-To: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Mohamad,

Thanks for looking into this!

On Thu, 29 Jun 2017, Mohamad Gebai wrote:
> Hi,
> 
> The ticket http://tracker.ceph.com/issues/19198 says that Bluestore uses
> twice as much memory than it should, and the description talks about
> page alignment. By looking at the unit test in attachment (see
> Bugzilla), I came to the conclusion that it is neither a Bluestore nor a
> Ceph bug, but it's simply due to the allocation pattern. The unit test
> that reproduces the bug does page-aligned allocations of 4KB blocs (a
> page size) in a tight loop. What each allocation ends up doing is the
> following:
> 
> 1. Find the next page boundary because the user (caller of malloc) wants
> a page-aligned allocation
> 2. Allocate the memory requested by the user (a whole page)
> 3. Keep metadata about that chunk of memory
> 
> We can see in this case two pages have been touched: one for the user
> and, one for the metadata. Since this is in a tight loop, each iteration
> skips a page that is almost completely empty in order to do have the
> next allocation page-aligned. This is the worst case scenario, and makes
> it seem like Bluestore uses "twice" the memory it should.
> 
> If the unit test was doing page-aligned allocation of 40KB, it would
> seem like 10% more memory is used (10 pages for the data and one page
> for the metadata). What this suggests is that there isn't a direct
> solution for this "bug". Alternatively, if a the unit test did
> allocations of a page and a half, it would seem like Bluestore uses 33%
> more memory than it should.
> 
> If the page-aligned allocations are large, and if they are sparse (ie.
> there are random smaller non-page-aligned allocations in between), the
> heap is much less fragmented, and it won't seem like the memory is
> wasted. Does that seem like a reasonable hypothesis or did I completely
> misunderstand the bug report?

This all sounds right.

The problem is that it is common and expected for bluestore to ask for a 
4kb page-aligned buffer.  There is the 4kb aligned allocation for the 
buffer itself, and there is the small buffer::raw tracking struct 
with the ref count and so on.  This should end up consuming 4kb + a little 
bit, not 8kb.

First, it would be good to confirm the allocator actually does behave this 
way.  (Ick.)

Then, I think we need to figure out how to mitigate the problem.  I 
suspect what we need to do is create slab-like allocation pool for the 
buffer::raw structs so that they do not consume a full page as a 
side-effect of the allocation timing.

> How this affects Bluestore is in buffer::create_page_aligned(). The
> question is: what is the pattern that would cause bufferlist to create
> page-aligned buffers that are only a page in size? It doesn't seem like
> *any* usage of Bluestore causes this issue (played around with rados
> bench without seeing the problem).

IIRC Igor hit this by doing 4KB random writes via the fio ObjectStore 
driver.  I suspect we'd see a similar with the OSD and 4KB writes, but 
never confirmed.

sage
