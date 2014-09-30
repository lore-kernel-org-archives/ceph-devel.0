From: Sage Weil <sweil@redhat.com>
Subject: Re: design a rados-based distributed kv store support scan op
Date: Tue, 30 Sep 2014 07:03:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409300701020.6593@cobra.newdream.net>
References: <CAJu7gM0T0nMjFtnPKh1ZT+BjV_-OOWmB6X0zQDUwGkmGfM0uPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53804 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaI3ODx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 10:03:53 -0400
In-Reply-To: <CAJu7gM0T0nMjFtnPKh1ZT+BjV_-OOWmB6X0zQDUwGkmGfM0uPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Plato Zhang <sangongs@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 30 Sep 2014, Plato Zhang wrote:
> Hi all,
> 
> We plan to develop a new distributed key-value storage engine, which
> would based on rados and supoort range-scan operation. Besides, it'll
> be open source.
> 
> We know rados is already a kv storage engine, and can do pretty well
> if we use KeyValueStore.
> However, it lacks the ability of scanning a key range, since keys are
> hashed into pgs.
> 
> In our scenarios, scanning is a common need. We considered the way of
> splitting our key space into fixed number of ranges, mapping each
> range to a rados object, and then storing key/value pairs in rados
> objects. However, there are two main disadvantages:
> 1. We can not adjust the number of ranges as the cluster scales.
> 2. For a good splitting, we must properly predict the distribution of
> keys, or we'll encounter serious load-balance problem.
> 
> So we decide to develop a new service based on rados (we want to use
> rados for unifying our storage infrastructure).
> 
> Before we start, we want to do some inquiries:
> 1. Is there already any similar system/module(scan-supported &&
> rados-based) existed?

Take a look at the ceph.git/src/key_value_store/ directory.  This is an 
implementation (mostly complete) of a distributed btree implemented on top 
of rados objects.  There is a blog and write-up about it here:

 http://ceph.com/community/summer-adventures-with-ceph-building-a-b-tree/
 http://ceph.com/papers/CawthonKeyValueStore.pdf

This work hasn't gotten any love since it was first written, but may make 
a good starting point!

sage


> 2. Except for the basic key-value functions, what features are you
> most interested in?
> 3. Other suggestions?
> 
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
