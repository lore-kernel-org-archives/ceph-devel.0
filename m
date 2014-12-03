From: Sage Weil <sage@newdream.net>
Subject: Re: Performance variation across RBD clients on different pools in
 all SSD setup - tcmalloc issue
Date: Wed, 3 Dec 2014 07:59:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412030755410.25778@cobra.newdream.net>
References: <9E914F5BD7F48A4782456CEB550A42280A74C0F6@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39145 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaLCP7b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 10:59:31 -0500
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A74C0F6@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 3 Dec 2014, Chaitanya Huilgol wrote:
> (2)    TCmalloc - Client -2 (note significant increase in TCmalloc internal free to central list code paths)
> 
> 14.75%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::FetchFromSpans()
>   7.46%  libtcmalloc.so.4.1.2     [.] tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*, unsigned long, int)
>   6.71%  libtcmalloc.so.4.1.2     [.] tcmalloc::CentralFreeList::ReleaseToSpans(void*)
>   1.68%  libtcmalloc.so.4.1.2     [.] operator new(unsigned long)
>   1.57%  ceph-osd                 [.] crush_hash32_3

Yikes!

> IMHO, we should probably look at the following in general for better 
> performance with less variation
> 
> - Add jemalloc option for ceph builds

Definitely.

Several years ago we saw serious heap fragmetnation issues with glibc.  I 
suspect newer versions are less problematics.  It may also be that newer 
version of tcmalloc behave better (not sure if we're linking against the 
latest version?).  In any case, we should have build support for all 
options.  We'll need to be careful when making a change, though.  The best 
choice may also vary on a per-distro basis.

> - Look at ways to evenly distribute PGs across the shards - with larger 
> number of shards some shards do not get exercised at all while some are 
> overloaded

Ok

> - Look at decreasing heap activity in the I/O path (index Manager, Hash 
> Index, LFN index etc.)

Yes.  Unfortunately I think this is a long tail... lots of small changes 
needed before we'll see much impact.

sage
