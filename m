From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] libceph: ceph_pagelist_append might sleep while
 atomic
Date: Tue, 14 May 2013 11:44:22 -0600
Message-ID: <519277F6.4060808@sandia.gov>
References: <1368110565-125922-1-git-send-email-jaschut@sandia.gov>
 <519269F2.1000907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:60779 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab3ENRom (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 13:44:42 -0400
In-Reply-To: <519269F2.1000907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/14/2013 10:44 AM, Alex Elder wrote:
> On 05/09/2013 09:42 AM, Jim Schutt wrote:
>> Ceph's encode_caps_cb() worked hard to not call __page_cache_alloc while
>> holding a lock, but it's spoiled because ceph_pagelist_addpage() always
>> calls kmap(), which might sleep.  Here's the result:
> 
> I finally took a close look at this today, Jim.  Sorry
> for the delay.
> 

No worries - thanks for taking a look.

> The issue is formatting the reconnect message--which will
> hold an arbitrary amount of data and therefore which we'll
> need to do some allocation (and kmap) for--in the face of
> having to hold the flock spinlock while doing so.
> 
> And as you found, ceph_pagelist_addpage(), which is called
> by ceph_pagelist_append(), calls kmap() even if it doesn't
> need to allocate anything.  This means that despite reserving
> the pages, those pages are in the free list and because they'll
> need to be the subject of kmap() their preallocation doesn't
> help.
> 
> Your solution was to pre-allocate a buffer, format the locks
> into that buffer while holding the lock, then append the
> buffer contents to a pagelist after releasing the lock.  You
> check for a changing (increasing) lock count while you format
> the locks, which is good.
> 
> So...  Given that, I think your change looks good.  It's a shame
> we can't format directly into the pagelist buffer but this won't
> happen much so it's not a big deal.  I have a few small suggestions,
> below.
> 
> I do find some byte order bugs though.   They aren't your doing,
> but I think they ought to be fixed first, as a separate patch
> that would precede this one.  The bug is that the lock counts
> that are put into the buffer (num_fcntl_locks and num_flock_locks)
> are not properly byte-swapped.  I'll point it out inline
> in your code, below.
> 
> I'll say that what you have is OK.  Consider my suggestions, and
> if you choose not to fix the byte order bugs, please let me know.

I'll happily fix up a v2 series with your suggestions addressed.
Thanks for catching those issues.  Stay tuned...

Thanks -- Jim


