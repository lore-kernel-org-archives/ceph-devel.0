From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Write back mode Cach-tier behavior
Date: Tue, 6 Jun 2017 13:57:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706061345590.3646@piezo.novalocal>
References: <8841B22B-1A20-4D79-9EAB-32D0BBFB2DD9@gmail.com> <CAJ4mKGZR_VQi+8Poyq-zGXVev2Nh3EjC88tQ_5D1qmcmgkbPyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1681134672-1496757464=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56493 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbdFFN5p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 09:57:45 -0400
In-Reply-To: <CAJ4mKGZR_VQi+8Poyq-zGXVev2Nh3EjC88tQ_5D1qmcmgkbPyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, TYLin <wooertim@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1681134672-1496757464=:3646
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2017, Gregory Farnum wrote:
> [ Moving to ceph-devel ]
> 
> On Sun, Jun 4, 2017 at 9:25 PM, TYLin <wooertim@gmail.com> wrote:
> > Hi all,
> >
> > We’re using cache-tier with write-back mode but the write throughput is not
> > as good as we expect. We use CephFS and create a 20GB file in it. While data
> > is writing, we use iostat to get the disk statistics. From iostat, we saw
> > that ssd (cache-tier) is idle most of the time and hdd (storage-tier) is
> > busy all the time. From the document
> >
> > “When admins configure tiers with writeback mode, Ceph clients write data to
> > the cache tier and receive an ACK from the cache tier. In time, the data
> > written to the cache tier migrates to the storage tier and gets flushed from
> > the cache tier.”
> >
> > So the data is write to cache-tier and then flush to storage tier when dirty
> > ratio is more than 0.4? The word “in time” in the document confused me.
> >
> > We found that the throughput of creating a new file is slower than overwrite
> > an existing file, and ssd has more write when doing overwrite. We then look
> > into the source code and log. A newly created file goes to proxy_write,
> > which is followed by a promote_object. Does this means that the object
> > actually goes to storage pool directly and then be promoted to the
> > cache-tier when creating a new file?
> 
> So I skimmed this thread and thought it was very wrong, since we don't
> need to proxy when we're doing fresh writes. But looking at current
> master, that does indeed appear to be the case when creating new
> objects: they always get proxied (I didn't follow the whole chain, but
> PrimaryLogPG::maybe_handle_cache_detail unconditionally calls
> do_proxy_write() if the OSD cluster supports proxying and we aren't
> must_promote!).
> 
> Was this intentional? I know we've flipped around a bit on ideal
> tiering behavior but it seems like at the very least it should be
> configurable — proxying then promoting is a very inefficient pattern
> for workloads that involve generating lots of data, modifying it, and
> then never reading it again.

I think we just didn't optimize for this pattern. In general, we decided 
it was faster to proxy the write and then promote async.  If the object 
exists, it's faster when there is 1 write, and about the same when there 
are 2+ writes.  If the object doesn't exist, though, you lose.

I think there are two options:

  uint32_t min_read_recency_for_promote;   ///< minimum number of HitSet to check before promote on read
  uint32_t min_write_recency_for_promote;  ///< minimum number of HitSet to check before promote on write

are the pg_pool_t properties that currently control this. 

Option 1:

Right now "0" means we have to existing in no hitsets prior to this op, so 
we'll promote immediately (but still async).  We can make a "-1" value 
that also means promote immediately, but do it synchronously instead of 
async.

Option 2:

Make the sync/async promote decision orthogonal to these options.  I'm not 
sure it makes as much sense to promote sync if the object is in 1 or more 
hitsets, though.  It can happen that has been a delete so it's in the 
hitset but doesn't exist, but in general it's probably safe to assume that 
if its in the hitset then the object also exists, and the sync promotion 
is going to be a bad idea in that case.

1 is awkward; 2 is somewhat uselessly expanding the possible 
combinations...

sage
--8323329-1681134672-1496757464=:3646--
