From: Sage Weil <sage@newdream.net>
Subject: Re: How to understand Collection in Bluestore, is it a folder?
Date: Tue, 11 Apr 2017 13:36:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704111332280.2999@piezo.novalocal>
References: <CAN=xyVWyju7wrjvwf+pU6+atWOh2smiujATwLNx+C2n1GT-xrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34202 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdDKNgk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Apr 2017 09:36:40 -0400
In-Reply-To: <CAN=xyVWyju7wrjvwf+pU6+atWOh2smiujATwLNx+C2n1GT-xrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 11 Apr 2017, qi Shi wrote:
>   struct Collection : public CollectionImpl {
>     BlueStore *store;
>     Cache *cache;       ///< our cache shard
>     coll_t cid;
>     bluestore_cnode_t cnode;
>     RWLock lock;
> 
>     bool exists;
> 
>     SharedBlobSet shared_blob_set;      ///< open SharedBlobs
> 
>     // cache onodes on a per-collection basis to avoid lock
>     // contention.
>     OnodeSpace onode_map;
> 
>     //pool options
>     pool_opts_t pool_opts;

Mostly.  Most of the time you can think of it that way.  In reality, 
though, it is a range of the ghobject_t namespace, as specified by the 
<shardid,poolid,seed> in coll_t's spg_t and the bits value in 
bluestore_cnode_t, which ultimately specify a [begin,end) range of 
ghobject_t that the collection covers.

The collection "split" operation (see _split_collection()) allows a 
collection range to be split by some number of bits into smaller 
collections, without actually touching any of the object metadata, 
because the onode keys are already sorted in the same way.  See the 
get_coll_key_range() call in _collection_list to see how the 
collection range is calculated for the purposes of listing objects.

sage

