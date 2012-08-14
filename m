From: Sage Weil <sage@inktank.com>
Subject: Re: v0.48.1 argonaut stable update released
Date: Tue, 14 Aug 2012 12:29:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208141225220.18862@cobra.newdream.net>
References: <alpine.DEB.2.00.1208141116420.18862@cobra.newdream.net> <440738CF-7DDB-44D2-A35B-782D289D5B28@filoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56372 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab2HNT3N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 15:29:13 -0400
In-Reply-To: <440738CF-7DDB-44D2-A35B-782D289D5B28@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 14 Aug 2012, Oliver Francke wrote:
> Hi Sage,
> 
> I just updated to debian-testing/0.50 this afternoon, after some hint:
> 
> * osd: better tracking of recent slow operations

This is actually about the admin socket command to dump operations in 
flight (more useful information is reported for diagnosis/debugging).

> and it is hereby confirmed to be better in my testing environment. 
> Before I had requests, which could be there for >480 seconds? not any 
> more.

That great news!  That is probably Sam's refactor of the OSD threading at 
work.  There were also a few bugs fixed in 0.48.1 that were causing 
somewhat similar symptoms (ops blocked indefinitely) due to peering 
problems, but that doesn't sound like it's the same thing.

> How's about this fix in 0.48.X?

It's a huge set of changes, and definitely won't go into the 0.48 series, 
sorry!  (In fact, the pending change was one motivation for doing 0.48 
when we did.)  It will be in bobtail, though, which is probably about a 
month away from freeze.

Please let us know what your experience is like with 0.50 (and beyond).

Thanks!
sage


> 
> Thnx in @vance,
> 
> Oliver - Thus being too lazy to read all change logs - Francke.
> 
> Am 14.08.2012 um 20:18 schrieb Sage Weil <sage@inktank.com>:
> 
> > We've built and pushed the first update to the argonaut stable release.  
> > This branch has a range of small fixes for stability, compatibility, and 
> > performance, but no major changes in functionality.  The stability fixes 
> > are particularly important for large clusters with many OSDs, and for 
> > network environments where intermittent network failures are more common.
> > 
> > The highlights include:
> > 
> > * mkcephfs: use default `keyring', `osd data', `osd journal' paths when 
> >   not specified in conf
> > * msgr: various fixes to socket error handling
> > * osd: reduce scrub overhead
> > * osd: misc peering fixes (past_interval sharing, pgs stuck in `peering' 
> >   states)
> > * osd: fail on EIO in read path (do not silently ignore read errors from 
> >   failing disks)
> > * osd: avoid internal heartbeat errors by breaking some large 
> >   transactions into pieces
> > * osd: fix osdmap catch-up during startup (catch up and then add daemon 
> >   to osdmap)
> > * osd: fix spurious `misdirected op' messages
> > * osd: report scrub status via `pg # query'
> > * rbd: fix race when watch registrations are resent
> > * rbd: fix rbd image id assignment scheme (new image data objects have 
> >   slightly different names)
> > * rbd: fix perf stats for cache hit rate
> > * rbd tool: fix off-by-one in key name (crash when empty key specified)
> > * rbd: more robust udev rules
> > * rados tool: copy object, pool commands
> > * radosgw: fix in usage stats trimming
> > * radosgw: misc compatibility fixes (date strings, ETag quoting, swift 
> >   headers, etc.)
> > * ceph-fuse: fix locking in read/write paths
> > * mon: fix rare race corrupting on-disk data
> > * config: fix admin socket `config set' command
> > * log: fix in-memory log event gathering
> > * debian: remove crush headers, include librados-config
> > * rpm: add ceph-disk-{activate, prepare}
> > 
> > The fix for the radosgw usage trimming is incompatible with v0.48 (which 
> > was effectively broken).  You now need to use the v0.48.1 version of 
> > radosgw-admin to initiate usage stats trimming.
> > 
> > There are a range of smaller bug fixes as well.  For a complete list of 
> > what went into this release, please see the release notes and changelog.
> > 
> > You can get this stable update from the usual locations:
> > 
> > * Git at git://github.com/ceph/ceph.git
> > * Tarball at http://ceph.newdream.net/download/ceph-0.48.1.tar.gz
> > * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/master/install/debian
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
