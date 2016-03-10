From: Sage Weil <sweil@redhat.com>
Subject: RE: BlueStore Performance issue
Date: Thu, 10 Mar 2016 11:12:36 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603101110071.14377@cpach.fuggernut.com>
References: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603090842140.14377@cpach.fuggernut.com> <CY1PR0201MB1897981F391262D2CFEF7D06E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603091033200.14377@cpach.fuggernut.com> <CY1PR0201MB18972EAD3EAAC4CDC3BDC602E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603100839170.14377@cpach.fuggernut.com>
 <CY1PR0201MB1897D0D0D818B598F0EA85A6E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58628 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbcCJQM4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 11:12:56 -0500
In-Reply-To: <CY1PR0201MB1897D0D0D818B598F0EA85A6E8B40@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 10 Mar 2016, Allen Samuels wrote:
> > > Another important benefit of this is that the WAL code need only kick
> > > in for operations that are less than 4K rather than the current 64K.
> > > This is a big reduction in write-amplification for these operations
> > > which should translate directly into improved throughput, especially
> > > for such benchmark critical areas as random 4K writes...
> > >
> > > While not terribly useful on hybrid or HDD systems, the bitmap based
> > > code has MUCH shorter CPU paths than does the current code. On an all
> > > flash OSD system this will directly translate into more performance
> > > (quantity unknown of course).
> > >
> > > While the memory consumption reduction is nice, for me the significant
> > > performance improvement implied by virtual elimination of WAL is the
> > > compelling factor.
> >
> > I wouldn't conflate the allcoation size and freelist representation; we get the
> > same avoidance of the WAL path with the current code by changing
> > min_alloc_size to 4k.  Making the freelist represntation more efficient is
> > important for small block sizes, but *any* memory-efficient strategy is fine
> > (and even the current one is probably fine for most workloads).  For
> > example, we could keep an extent-based representation and page in regions
> > instead...
> 
> Perhaps I inartfully made my point. I just wanted to say that if you set 
> min_alloc_size to 4K you avoid the WAL stuff but you spend more memory, 
> in the worst case the memory consumption would be 16 * 320MB => 5GB per 
> TB of storage. While I agree that the true worst-case pattern requires a 
> pathological use-case, I am concerned that normal use-cases will still 
> consume unreasonably large amounts of memory -- leading to unreliable 
> systems.
> 
> I believe that we simply don't want to be using that much memory for 
> this part of the system. There are other tradeoffs (time, complexity, 
> latency, etc.) that could significantly reduce memory consumption. Let's 
> explore these.

Agreed.  :)

> > The other thing to keep in mind is that the freelist is representated
> > twice: once in memory in indexed form in StupidAllocator, and once in
> > FreelistManager just to ensure it's persisted properly.  In the second case, I
> > suspect we could leverage a custom rocksdb merge operator to avoid that
> > representation entirely so that adjacent extents are coalesced when the sst
> > is generated (when writing to l0 or during compaction).  I'm guessing that
> > functionality isn't present is ZS though?
> 
> Not at present. But since I control the developers, that is something 
> that could be added. Clearly it's possible to address the global 
> serialization of KV commits if a different mechanism was available for 
> representing the allocation lists in the KV store. Having some kind of 
> merging primitive allows that to be done. I was going to raise exactly 
> this issue yesterday, but tabled it. Let's continue this conversation.

I haven't really done my homework with the existing rocksdb merge 
operators to confirm that they would work in this way.  In particular, I 
think we want them to merge adjacent keys together (at least if we stick 
with the naive offset=length kv representation), and I'm afraid they might 
be intended to merge values with matching keys.  In any case, though, my 
hope would be that we'd settle on a single strategy that would work across 
both ZS and rocksdb as it'd simplify our life a bit.

sage

