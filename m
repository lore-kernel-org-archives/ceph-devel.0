From: Steve Barber <steve.barber@nist.gov>
Subject: Using locally replicated OSDs to reduce Ceph replication
Date: Wed, 17 Apr 2013 18:02:51 -0400
Message-ID: <20130417220251.GZ4565@nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wsget2.nist.gov ([129.6.13.151]:58300 "EHLO wsget2.nist.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966869Ab3DQWIF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 18:08:05 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 17, 2013 at 04:49:53PM -0400, Jeff Mitchell wrote in
another thread:
> ... If you
> set up the OSDs such that each OSD is based off of a ZFS mirror, you
> get these benefits locally. For some people, especially when heavy on
> reads (due to the intelligent caching), a solution that knocks the
> remote replication level down by one but uses local mirrors for OSDs
> may provide good functionality and safety compromises.

Funny that you mention this today; that's exactly an idea I was thinking
about pursuing yesterday, so that I don't have to do repl=4 for data
protection both between two sites and within each site (i.e. 2 copies of
data at each site).

If anybody is actively doing/trying this (whether via RAID or ZFS or
whatever, although I'm particularly interested in a ZFS/ZoL solution) I'd
love to see some discussion about it.

In particular, has anyone tried making a big RAID set (of any type) and
carving out space (logical volumes, zvols, etc.) to become virtual OSDs?
Any architectural gotchas with this idea?

I'm trying to set up a cluster spread across two server rooms in separate
buildings that can survive an outage of one building and still have
replicated (safe) data in the event of e.g. a disk failure during the
outage.  It seems like some local data protection would be much more
efficient than having Ceph manage the extra replicas - subject to testing
of course!

As a side note I do like the thought of ZFS ensuring data integrity, and
in the long run it might allow some of the same optimizations with Ceph that
btrfs is used for now (re: snapshots, compression, etc.) and as Jeff
mentioned, ZFS gives you a lot of performance tuning options.  I'm
thrilled to see that it's getting some attention.

Steve
