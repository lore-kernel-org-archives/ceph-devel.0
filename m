From: Sage Weil <sweil@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 13:00:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55267 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbbJTUA0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Oct 2015 16:00:26 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 3B74EC0C18AF
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2015 20:00:26 +0000 (UTC)
In-Reply-To: <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 20 Oct 2015, John Spray wrote:
> On Mon, Oct 19, 2015 at 8:49 PM, Sage Weil <sweil@redhat.com> wrote:
> >  - We have to size the kv backend storage (probably still an XFS
> > partition) vs the block storage.  Maybe we do this anyway (put metadata on
> > SSD!) so it won't matter.  But what happens when we are storing gobs of
> > rgw index data or cephfs metadata?  Suddenly we are pulling storage out of
> > a different pool and those aren't currently fungible.
> 
> This is the concerning bit for me -- the other parts one "just" has to
> get the code right, but this problem could linger and be something we
> have to keep explaining to users indefinitely.  It reminds me of cases
> in other systems where users had to make an educated guess about inode
> size up front, depending on whether you're expecting to efficiently
> store a lot of xattrs.
> 
> In practice it's rare for users to make these kinds of decisions well
> up-front: it really needs to be adjustable later, ideally
> automatically.  That could be pretty straightforward if the KV part
> was stored directly on block storage, instead of having XFS in the
> mix.  I'm not quite up with the state of the art in this area: are
> there any reasonable alternatives for the KV part that would consume
> some defined range of a block device from userspace, instead of
> sitting on top of a filesystem?

I agree: this is my primary concern with the raw block approach.

There are some KV alternatives that could consume block, but the problem 
would be similar: we need to dynamically size up or down the kv portion of 
the device.

I see two basic options:

1) Wire into the Env abstraction in rocksdb to provide something just 
smart enough to let rocksdb work.  It isn't much: named files (not that 
many--we could easily keep the file table in ram), always written 
sequentially, to be read later with random access. All of the code is 
written around abstractions of SequentialFileWriter so that everything 
posix is neatly hidden in env_posix (and there are various other env 
implementations for in-memory mock tests etc.).

2) Use something like dm-thin to sit between the raw block device and XFS 
(for rocksdb) and the block device consumed by newstore.  As long as XFS 
doesn't fragment horrifically (it shouldn't, given we *always* write ~4mb 
files in their entirety) we can fstrim and size down the fs portion.  If 
we similarly make newstores allocator stick to large blocks only we would 
be able to size down the block portion as well.  Typical dm-thin block 
sizes seem to range from 64KB to 512KB, which seems reasonable enough to 
me.  In fact, we could likely just size the fs volume at something 
conservatively large (like 90%) and rely on -o discard or periodic fstrim 
to keep its actual utilization in check.

sage
