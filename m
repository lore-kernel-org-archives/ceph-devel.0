From: Sage Weil <sweil@redhat.com>
Subject: Re: mem use doubles due to buffer::create_page_aligned + bluestore
 obj content caching
Date: Mon, 13 Mar 2017 14:17:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703131413490.10776@piezo.novalocal>
References: <6b06369d-6b18-f4f0-b7ae-0c0114288e41@mirantis.com> <CAJ4mKGYnbTAXA16vsKkDoj8LaddtxDD7-yghqODsnBJ9qMz6_g@mail.gmail.com> <e746f38b-d870-49d3-7f37-722b03a01005@mirantis.com> <CAJ4mKGb0irpqukaEK4b7hufTfH-KJ4fp5260naKeQzHjnN4zNw@mail.gmail.com>
 <5d9e0423-0719-670d-ed26-6f0a33eb6073@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbdCMOR4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Mar 2017 10:17:56 -0400
In-Reply-To: <5d9e0423-0719-670d-ed26-6f0a33eb6073@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 13 Mar 2017, Igor Fedotov wrote:
> On 11.03.2017 0:24, Gregory Farnum wrote:
> > On Mon, Mar 6, 2017 at 1:47 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> > > On 3/6/2017 9:44 PM, Gregory Farnum wrote:
> > > > On Mon, Mar 6, 2017 at 9:35 AM, Igor Fedotov <ifedotov@mirantis.com>
> > > > wrote:
> > > > > Hi Cephers,
> > > > > 
> > > > > I've just created a ticket related to bluestore object content caching
> > > > > in
> > > > > particular and buffer::create_page_aligned in general.
> > > > > 
> > > > > But I'd like to additionally share this information here as well since
> > > > > the
> > > > > root cause seems to be pretty global.
> > > > > 
> > > > > Ticker URL:
> > > > > 
> > > > > http://tracker.ceph.com/issues/19198
> > > > > 
> > > > > Description:
> > > > > 
> > > > > When caching object content BlueStore uses twice as much memory than
> > > > > it
> > > > > really needs for that data amount.
> > > > > 
> > > > > The root cause seems to be in buffer::create_page_aligned
> > > > > implementation.
> > > > > Actually it results in
> > > > > new raw_posix_aligned()
> > > > > 
> > > > >     calling mempool::buffer_data::alloc_char.allocate_aligned(len,
> > > > > align);
> > > > > 
> > > > >         calling  posix_memalign((void**)(void*)&ptr, align, total);
> > > > > 
> > > > > sequence that in fact does 2 allocations:
> > > > > 
> > > > > 1) for raw_posix_aligned struct
> > > > > 2) for data itself (4096 bytes).
> > > > > 
> > > > > It looks like this sequence causes 2 * 4096 bytes allocation instead
> > > > > of
> > > > > sizeof(raw_posix_aligned) + alignment + 4096.
> > > > > The additional trick is that mempool stuff is unable to estimate such
> > > > > an
> > > > > overhead and hence BlueStore cache cleanup doesn't work properly.
> > > > > 
> > > > > It's not clear for me why allocator(s) behave that inefficiently for
> > > > > such
> > > > > a
> > > > > pattern though.
> > > > > 
> > > > > The issue is reproducible under Ubuntu 16.04.1 LTS for both jemalloc
> > > > > and
> > > > > tcmalloc builds.
> > > > > 
> > > > > 
> > > > > The ticket contains the patch to reproduce the issue and one can see
> > > > > that
> > > > > for 16Gb content system mem usage tend to be ~32Gb.
> > > > > 
> > > > > Patch firstly allocates 4K pages 0x400000 times using:
> > > > > 
> > > > > ...
> > > > > 
> > > > > +  size_t alloc_count = 0x400000; // allocate 16 Gb total
> > > > > +  allocs.resize(alloc_count);
> > > > > +  for( auto i = 0u; i < alloc_count; ++i) {
> > > > > +    bufferptr p = buffer::create_page_aligned(bsize);
> > > > > +    bufferlist* bl = new bufferlist;
> > > > > +    bl->append(p);
> > > > > +    *(bl->c_str()) = 0; // touch the page to increment system mem use
> > > > > 
> > > > > ...
> > > > > 
> > > > > then do the same reproducing  create_page_aligned() implementation:
> > > > > 
> > > > > +  struct fake_raw_posix_aligned{
> > > > > +    char stub[8];
> > > > > +    void* data;
> > > > > +    fake_raw_posix_aligned() {
> > > > > +      ::posix_memalign(&data, 0x1000, 0x1000);
> > > > > //mempool::buffer_data::alloc_char.allocate_aligned(0x1000, 0x1000);
> > > > > +      *((char*)data) = 0; // touch the page
> > > > > +    }
> > > > > +    ~fake_raw_posix_aligned() {
> > > > > +      ::free(data);
> > > > > +    }
> > > > > +  };
> > > > > +  vector <fake_raw_posix_aligned*> allocs2;
> > > > > 
> > > > > +  allocs2.resize(alloc_count);
> > > > > +  for( auto i = 0u; i < alloc_count; ++i) {
> > > > > +    allocs2[i] = new fake_raw_posix_aligned();
> > > > > ...
> > > > > 
> > > > > Output shows 32Gb usage in both cases.

This is really disconcerting.  If you take out the memalign in the 
fake_raw_posix_aligned ctor, does it use 16gb?  Or is really just that the 
order of the allocations (new then posix_memalign then new ...) 
makes the allocator consume a full page for each 
fake_raw_posix_aligned?  And/or, can you confirm that 
fake_raw_posix_aligned pointers are on page boundaries?

What if all the fake_raw_posix_aligned strutcs are allocated first, and 
*then* the data pages?

> > Do you have any proposed patches or fixes to deal with it? :)
> Just some thoughts, none of them seems ideal though...
> 1) Get rid of bluestore *content* cache. IMO object metadata caching is much
> more important and hence it's better to use memory for that. As a result no
> long-living aligned page allocations...
> 2) Do not use raw_posix_aligned in buffer::create_aligned and rollback to
> raw_combined::create(). For the latter mempool's mechanics can be fixed to
> measure alignment overhead properly and hence BlueStore cache will handle mem
> limits properly. Mem use for page aligned buffers is still ineffective
> though...

The simple heuristic that only does raw_combined for smaller buffers is 
based on the assumption that the allocator isn't stupid and can consume 
less than a full page of overhead for the buffer::raw stuff.  If that's 
truly not the case, then I think there's no reason not to unconditionally 
use raw_combined.  That doesn't seem right, though!

sage
