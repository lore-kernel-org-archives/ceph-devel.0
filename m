From: Mark Nelson <mnelson@redhat.com>
Subject: Re: mempool update
Date: Mon, 10 Oct 2016 14:13:23 -0500
Message-ID: <10c38cc8-3892-0100-a4c4-271c9527a916@redhat.com>
References: <alpine.DEB.2.11.1610101848410.18626@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbcJJTN0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Oct 2016 15:13:26 -0400
In-Reply-To: <alpine.DEB.2.11.1610101848410.18626@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org
Cc: allen.samuels@sandisk.com

On 10/10/2016 02:05 PM, Sage Weil wrote:
> Hi Allen, everyone,
>
> I spent the end of last week and today messing around some more with the
> mempool framework.  My primary complaints were that the debug mode with
> containers wasn't stable (because containers would come and go and race
> with an enumeration of the list) and (more importantly) that the
> per-container tracking wasn't actually what I wanted to see.  I wanted to
> know "how much memory is consume in the entire pool by container
> declaration x," and not how many items/bytes are in each individual
> container instance.
>
> This led me to restructure the way the containers are handled by defining
> a template allocator *type* for the contained type (or
> container-specific wrapper, like std::_Rb_tree_node) that had a static
> member containing the actual allocator instance.  That mean that for
> each type we declare to be in a container there has to be matching .cc
> definition of the allocator structure (slightly more awkward) but it
> totally eliminated the per-container-instance allocator state and made the
> debug mode very light-weight (we enumerate the *types*, not instances).
>
> The new version works something like so:
>
>  struct obj {
>    MEMBER_OF_MEMPOOL();
>    int a;
>    int b;
>    obj() : a(1), b(1) {}
>    obj(int _a) : a(_a), b(2) {}
>    obj(int _a,int _b) : a(_a), b(_b) {}
>    friend inline bool operator<(const obj& l, const obj& r) {
>      return l.a < r.a;
>    }
>  };
>
>  // and in a .cc file,
>  MEMPOOL_DEFINE_OBJECT_FACTORY(obj, obj, unittest_2);
>
> (That duplicate obj arg is just because scoped types like BlueStore::Foo
> can't be used to name the _factory_* static instance variable, so the user
> has to pass in a second variable-nameable name.  Not sure if there is some
> preprocessor magic that can automate that or not...)
>
> If I want to make containers, I can do this:
>
>  unittest_1::vector<int> v;
>
>  // and in a .cc file,
>  MEMPOOL_DEFINE_FACTORY(int, int, unittest_1);
>
> Vector works out of the box because it doesn't have a container-internal
> wrapper, but for set and map and list you have to do
>
>  unittest_1::set<int> s;
>  unittest_1::map<int,obj> m;
>  unittest_1::list<int> l;
>
>  MEMPOOL_DEFINE_SET_FACTORY(int, int, unittest_1);
>  MEMPOOL_DEFINE_MAP_FACTORY(int, obj, int_obj, unittest_1);
>  MEMPOOL_DEFINE_LIST_FACTORY(int, int, unittest_1);
>
> for the st::_List_node etc allocator instances.  Now, when you do debug
> mode and dump the stats, you can see information like this (for
> bluestore):
>
>     "bluestore_meta_onode": {
>         "total_bytes": 174760,
>         "total_items": 257,
>         "by_type": [
>             {
>                 "type": "BlueStore::Onode",
>                 "bytes": 174760,
>                 "items": 257
>             }
>         ]
>     },
>     "bluestore_meta_other": {
>         "total_bytes": 7969096,
>         "total_items": 76899,
>         "by_type": [
>             {
>                 "type": "std::_Rb_tree_node<std::pair<unsigned long const, bluestore_extent_ref_m
> ap_t::record_t> >",
>                 "bytes": 1146048,
>                 "items": 23876
>             },
>             {
>                 "type": "BlueStore::ExtentMap::Shard",
>                 "bytes": 111384,
>                 "items": 1989
>             },
>             {
>                 "type": "BlueStore::SharedBlob",
>                 "bytes": 2494848,
>                 "items": 12994
>             },
>             {
>                 "type": "std::_Rb_tree_node<std::pair<int const, boost::intrusive_ptr<BlueStore::
> Blob> > >",
>                 "bytes": 55056,
>                 "items": 1147
>             },
>             {
>                 "type": "BlueStore::Blob",
>                 "bytes": 3014608,
>                 "items": 12994
>             },
>             {
>                 "type": "BlueStore::Extent",
>                 "bytes": 1147152,
>                 "items": 23899
>             },
>             {
>                 "type": "std::_Rb_tree_node<std::pair<unsigned long const, std::unique_ptr<BlueSt
> ore::Buffer, std::default_delete<BlueStore::Buffer> > > >",
>                 "bytes": 0,
>                 "items": 0
>             },
>             {
>                 "type": "BlueStore::Buffer",
>                 "bytes": 0,
>                 "items": 0
>             }
>         ]
>     }
>

Beautiful!  Let me see if I can gather some more information with this 
verison.

> which tells pretty much the full story about where the memory is going and
> doesn't have the per-instance uglyness.  Notably, the container types in
> the mempool namespace are just convenient names for std::map<>
> etc--there's no longer a need to define the container types.
>
> Here's the latest iteration:
>
> 	https://github.com/liewegas/ceph/blob/wip-mempool/src/include/mempool.h
>
> Note that this version also removes all of the slab allocator logic--it's
> just the accounting infrastructure.  Mark's most recent run shows that the
> bluestore mempool is set at 1 GB and the RSS is almost 4 GB, so either
> there are lots of allocations we're not capturing yet or the heap is
> fragmenting heavily.  I suspect we'll want to add the slab behavior back
> in soon so that we have memory that is nicely packed, but I'd prefer to
> keep that change orthogonal so that we understand the full behavior!

FWIW, there has been some discrepancy in the massif heap results vs RSS 
too, though perhaps less of one than what we are seeing here.  I would 
hazzard a guess that it's a bit of both.

>
> Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
