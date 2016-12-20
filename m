From: Sage Weil <sage@newdream.net>
Subject: Re: Bug in mempool::map?
Date: Tue, 20 Dec 2016 20:15:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612202010280.10615@piezo.novalocal>
References: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com> <alpine.DEB.2.11.1612201524400.10615@piezo.novalocal> <3117e8a5-e8dd-f323-25ef-dc6756ebb8f0@mirantis.com> <alpine.DEB.2.11.1612201824140.10615@piezo.novalocal>
 <aa0fa487-ffed-cc4a-eae0-226ef038f1d4@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58534 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbcLTUPj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 15:15:39 -0500
In-Reply-To: <aa0fa487-ffed-cc4a-eae0-226ef038f1d4@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 20 Dec 2016, Igor Fedotov wrote:
> I think I have a better idea.
> 
> We can simply track amount of bytes referenced in the blob. E.g. some extent
> has length 100 - this increments the counter by 100 accordingly.
> Removing/punching an extent  decrements the counter.
>
> If we want tp be able to deallocate specific unused pextent within a blob as
> we currently do then we just need to track that amount on per-pextent basis.
> Hence just a few ints per blob... And no need for map lookups.

For small blobs, a counter is probably sufficient since we're a single 
min_alloc_size unit anyway.  That's actually more like a vector of size 
(min_alloc_size count), with 1 being the degenerate case.  Is that what 
you're thinking?

It seems like we have a few common cases...

1) big blob, single ref (e.g., immutable large object, and then the entire 
thing is referenced, modulo the last block).

2) tiny blob, single alloc unit.  a counter is sufficient.

3) everything else in between...

We could probably get away with special-case efficient representations of 
just 1 and 2?

sage


> 
> If that's OK I can start implementing it tomorrow.
> 
> 
> Thanks,
> 
> Igor
> 
> 
> The same idea can be probably applied to SharedBlob too.
> 
> On 12/20/2016 9:26 PM, Sage Weil wrote:
> > On Tue, 20 Dec 2016, Igor Fedotov wrote:
> > > Some update on map<uint64_t, uint32_t> mem usage.
> > > 
> > > It looks like single entry map takes 48 bytes. And 40 bytes for
> > > map<uint32_t,uint32_t>.
> > > 
> > > Hence 1024 trivial ref_maps for 1024 blobs takes >48K!
> > > 
> > > These are my results taken from mempools. And they look pretty similar to
> > > what's been said in the following article:
> > > 
> > > http://lemire.me/blog/2016/09/15/the-memory-usage-of-stl-containers-can-be-surprising/
> > > 
> > > 
> > > Sage, you mentioned that you're planning to do something with ref maps
> > > during
> > > the standup but I missed the details. Is that something about their mem
> > > use or
> > > anything else?
> > I mentioned btree_map<> and flat_map<> (new in boost).  Probably the thing
> > to do here is to make extent_ref_map_t handle the common case of 1 (or
> > maybe 2?) extents done inline, and when we go beyond that allocate another
> > structure on the heap.  That other structure could be std::map<>, but I
> > think one of the other choices would be better: one larger allocation and
> > better performance in general for small maps.  This structure will
> > only get big for very big blobs, which shouldn't be terribly common, I
> > think.
> > 
> > sage
> > 
> > 
> > > 
> > > Thanks,
> > > 
> > > Igor
> > > 
> > > 
> > > 
> > > On 20.12.2016 18:25, Sage Weil wrote:
> > > > On Tue, 20 Dec 2016, Igor Fedotov wrote:
> > > > > Hi Allen,
> > > > > 
> > > > > It looks like mempools don't measure maps allocations properly.
> > > > > 
> > > > > I extended unittest_mempool in the following way but corresponding
> > > > > output
> > > > > is
> > > > > always 0 for both 'before' and 'after' values:
> > > > > 
> > > > > 
> > > > > diff --git a/src/test/test_mempool.cc b/src/test/test_mempool.cc
> > > > > index 4113c53..b38a356 100644
> > > > > --- a/src/test/test_mempool.cc
> > > > > +++ b/src/test/test_mempool.cc
> > > > > @@ -232,9 +232,19 @@ TEST(mempool, set)
> > > > >    TEST(mempool, map)
> > > > >    {
> > > > >      {
> > > > > -    mempool::unittest_1::map<int,int> v;
> > > > > -    v[1] = 2;
> > > > > -    v[3] = 4;
> > > > > +    size_t before = mempool::buffer_data::allocated_bytes();
> > > > I think it's just that you're measuring the buffer_data pool...
> > > > 
> > > > > +    mempool::unittest_1::map<int,int>* v = new
> > > > > mempool::unittest_1::map<int,int>;
> > > > but the map is in the unittest_1 pool?
> > > > 
> > > > > +    (*v)[1] = 2;
> > > > > +    (*v)[3] = 4;
> > > > > +    size_t after = mempool::buffer_data::allocated_bytes();
> > > > > +    cout << "before " << before << " after " << after << std::endl;
> > > > > +    delete v;
> > > > > +    before = after;
> > > > > +    mempool::unittest_1::map<int64_t,int64_t> v2;
> > > > > +    v2[1] = 2;
> > > > > +    v2[3] = 4;
> > > > > +    after = mempool::buffer_data::allocated_bytes();
> > > > > +    cout << " before " << before << " after " << after << std::endl;
> > > > >      }
> > > > >      {
> > > > >        mempool::unittest_2::map<int,obj> v;
> > > > > 
> > > > > 
> > > > > Output:
> > > > > 
> > > > > [ RUN      ] mempool.map
> > > > > before 0 after 0
> > > > >    before 0 after 0
> > > > > [       OK ] mempool.map (0 ms)
> > > > > 
> > > > > It looks like we do not measure ref_map for BlueStore Blob and
> > > > > SharedBlob
> > > > > classes too.
> > > > > 
> > > > > Any ideas?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Igor
> > > > > 
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > > in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > 
> > > > > 
> > > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
