From: Mark Nelson <mnelson@redhat.com>
Subject: Re: mempool update
Date: Tue, 11 Oct 2016 09:16:18 -0500
Message-ID: <c20fb3f3-7371-dab0-17fc-53335a1ef772@redhat.com>
References: <alpine.DEB.2.11.1610101848410.18626@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752892AbcJKOQX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Oct 2016 10:16:23 -0400
In-Reply-To: <alpine.DEB.2.11.1610101848410.18626@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org
Cc: allen.samuels@sandisk.com



On 10/10/2016 02:05 PM, Sage Weil wrote:
> Hi Allen, everyone,

<snip>

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

I ran some tests yesterday, sadly without 11394 until we've got a 
working version we can apply to wip-mempool.  I dumped the stats (this 
was with about 14GB of RSS per OSD!) and compared them against Sage's 
numbers:

https://drive.google.com/file/d/0B2gTBZrkrnpZdlNjNWkzbU4xMk0/view?usp=sharing

Looks like in my run some of the types are a bit smaller.  Not sure if 
that's due to fixes being applied to wip-mempool after sage's run.  The 
total amount of memory used by the cache is way smaller than the RSS of 
the OSD, but that's probably to be expected right now.

Mark
