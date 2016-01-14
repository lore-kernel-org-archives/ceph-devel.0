From: Zhang Huan <zhanghuan@ict.ac.cn>
Subject: Re: Regarding bluestore release schedule
Date: Thu, 14 Jan 2016 14:37:14 +0800
Message-ID: <84CAA53B-B2B6-4F2A-B199-32534733068F@ict.ac.cn>
References: <4EFB79CD-2601-4ABF-96DB-AAF6A90D0036@ict.ac.cn> <alpine.DEB.2.11.1601130842560.26381@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp23.cstnet.cn ([159.226.251.23]:43805 "EHLO cstnet.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750816AbcANGnK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Jan 2016 01:43:10 -0500
In-Reply-To: <alpine.DEB.2.11.1601130842560.26381@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

> On Jan 13, 2016, at 9:45 PM, Sage Weil <sweil@redhat.com> wrote:
> 
> On Wed, 13 Jan 2016, Zhang Huan wrote:
>> Hello Sage,
>> 
>> I have been watching the development of bluestore for a while. I am 
>> interested in bluestore because I believe putting object store on top of 
>> raw device is the right way. I would like to know if you have any 
>> release schedule, and which version it will be merged into? I also 
>> notice that there is big locks (Collection->lock and 
>> StupidAllocator->lock, etc) in the write path, this might be an issue 
>> for SSD. Do you have any plan to break it into finer locks?
> 
> It's in master now and it will be part of the jewel release.  It won't 
> be the default choice yet, since it is still very new and unproven, but so 
> far performance is looking better than FileStore on HDDs.
I know it is early, but do we have any chance to know your test result? and
how about the result on SSD?

> 
> The collection->lock doesn't need to be broken up since it's hidden 
> beneath the OSD's per-pg lock anyway.  
Thanks, I found the per-pg lock. If there exist per-pg locks, the
per-collection locks are actually not needed?

> The allocator lock could be 
> sharded, though, by creating multiple allocation groups (ala XFS).  This 
> is partly why the Allocator interface is abstract and the current 
> implementation is called StupidAllocator :).  If you can demonstrate 
> that the lock is affecting performance we should definitely improve that!
It would be an interesting to look into:-)

> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


