From: Sage Weil <sage@inktank.com>
Subject: Re: Radosgw - bucket index
Date: Sun, 18 May 2014 16:05:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405181601030.1689@cobra.newdream.net>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net> <BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl> <alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net> <CABBk=J_p9dDQBhvhbXrDmUonsY_TW5ZFDWuQqw3DGukVSRJeKg@mail.gmail.com>
 <BLU436-SMTP15995ECEE2C5FA8E935D70EDF330@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45550 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbaERXFM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 May 2014 19:05:12 -0400
In-Reply-To: <BLU436-SMTP15995ECEE2C5FA8E935D70EDF330@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang <yguang11@outlook.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, haomaiwang@gmail.com, Ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 18 May 2014, Guang wrote:
> >> radosgw is using the omap key/value API for objects, which is more or less
> >> equivalent to what swift is doing with sqlite.  This data passes straight
> >> into leveldb on the backend (or whatever other backend you are using).
> >> Using something like rocksdb in its place is pretty simple and ther are
> >> unmerged patches to do that; the user would just need to adjust their
> >> crush map so that the rgw index pool is mapped to a different set of OSDs
> >> with the better k/v backend.
> Not sure if I miss anything, but the key difference with SWIFT?s 
> implementation is that they are using a table for bucket index and it 
> actually can be updated in parallel which makes more scalable for write, 
> though at certain point the sql table would result in performance 
> degradation as well.

As I understand it the same limitation is present there too: the index is 
in a single sqlite table.

> > My more well-formed opinion is that we need to come up with a good
> > design. It needs to be flexible enough to be able to grow (and maybe
> > shrink), and I assume there would be some kind of background operation
> > that will enable that. I also believe that making it hash based is the
> > way to go. It looks like that the more complicated issue is here is
> > how to handle the transition in which we shard buckets.
> Yeah I agree. I think the conflicting goals here are, we want a sorted 
> list (so that it enable prefix scan for listing purpose) and we want to 
> shard at the very beginning (the problem we are facing is parallel 
> writes updating the same bucket index object will need to be 
> serialized).

Given how infrequent container listings are, pre-sharding containers 
across several objects makes some sense.  Paying the cost of doing 
listings in parallel across N (where N is not too big) is not a big price 
to pay. However, there will always need to be a way to re-shard further 
when containers/buckets get extremely big.  Perhaps a starting point would 
be support for static sharding where the number of shards is specified at 
container/bucket creation time...

sage
