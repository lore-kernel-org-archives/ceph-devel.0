From: Sage Weil <sweil@redhat.com>
Subject: Re: Regarding bluestore release schedule
Date: Wed, 13 Jan 2016 08:45:26 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601130842560.26381@cpach.fuggernut.com>
References: <4EFB79CD-2601-4ABF-96DB-AAF6A90D0036@ict.ac.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472AbcAMNpW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jan 2016 08:45:22 -0500
In-Reply-To: <4EFB79CD-2601-4ABF-96DB-AAF6A90D0036@ict.ac.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Huan <zhanghuan@ict.ac.cn>
Cc: ceph-devel@vger.kernel.org

On Wed, 13 Jan 2016, Zhang Huan wrote:
> Hello Sage,
> 
> I have been watching the development of bluestore for a while. I am 
> interested in bluestore because I believe putting object store on top of 
> raw device is the right way. I would like to know if you have any 
> release schedule, and which version it will be merged into? I also 
> notice that there is big locks (Collection->lock and 
> StupidAllocator->lock, etc) in the write path, this might be an issue 
> for SSD. Do you have any plan to break it into finer locks?

It's in master now and it will be part of the jewel release.  It won't 
be the default choice yet, since it is still very new and unproven, but so 
far performance is looking better than FileStore on HDDs.

The collection->lock doesn't need to be broken up since it's hidden 
beneath the OSD's per-pg lock anyway.  The allocator lock could be 
sharded, though, by creating multiple allocation groups (ala XFS).  This 
is partly why the Allocator interface is abstract and the current 
implementation is called StupidAllocator :).  If you can demonstrate 
that the lock is affecting performance we should definitely improve that!

sage
