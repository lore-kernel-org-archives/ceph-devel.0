From: Sage Weil <sage@inktank.com>
Subject: Re: v0.58 released
Date: Tue, 5 Mar 2013 13:01:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303051300220.1162@cobra.newdream.net>
References: <alpine.DEB.2.00.1303051106370.28558@cobra.newdream.net> <513654BC.1030904@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37199 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab3CEVB0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 16:01:26 -0500
In-Reply-To: <513654BC.1030904@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

[Re-adding ceph-devel]

On Tue, 5 Mar 2013, Stefan Priebe wrote:
> Hi Sage,
> 
> thanks for the great new features. Are there any plans for incremental rbd
> exports? Or export of just the changed rados objects between two snapshots?

The librados bits just landed in master today (thanks to David Zafman).  
The next step is to build an export and import function into the rbd (or 
another) command line tool.

sage


> 
> Greets,
> Stefan
> 
> Am 05.03.2013 20:07, schrieb Sage Weil:
> > It's been two weeks and v0.58 is baked. Notable changes since v0.57
> > include:
> > 
> >   * mon: rearchitected to utilize single instance of paxos and a key/value
> >     store (Joao Luis)
> >   * librbd: fixed some locking issues with flatten (Josh Durgin)
> >   * rbd: udevadm settle on map/unmap to avoid various races (Dan Mick)
> >   * osd: move pg info, log into leveldb (== better performance) (David
> >     Zafman)
> >   * osd: fix pg log trimming (avoids memory bloat on degraded clusters)
> >   * osd: fixed bug in journal checksums (Sam Just)
> >   * osd: verify snap collections on startup (Sam Just)
> >   * ceph-disk-prepare/activate: support for dm-crypt (Alexandre Marangone)
> >   * ceph-disk-prepare/activate: support for sysvinit, directories or
> >     partitions (not full disks)
> >   * msgr: fixed race in connection reset
> >   * msgr: fix comparison of IPv6 addresses (fixes monitor bringup via
> >     ceph-deploy, chef)
> >   * radosgw: fix object copy onto self (Yehuda Sadeh)
> >   * radosgw: ACL grants in headers (Caleb Miles)
> >   * radosgw: ability to listen to fastcgi via a port (Guilhem Lettron)
> >   * mds: new encoding for all data types (to allow forward/backward
> >     compatbility) (Greg Farnum)
> >   * mds: fast failover between MDSs (enforce unique mds names)
> >   * crush: ability to create, remove rules via CLI
> >   * many many cleanups (Danny Al-Gaaf)
> >   * buffer unit testing (Loic Dachary)
> >   * fixed log rotation (Gary Lowell)
> > 
> > Also, although it is not part of the ceph packages, I'd also like to call
> > out recent work on ceph-deploy, our new easy to use deployment tool:
> > 
> >   * ceph-deploy: support for Debian systems
> >   * ceph-deploy: new safety checks
> >   * ceph-deploy: support for dm-crypt on OSDs
> > 
> > There has also been a lot of work by Joe Buck and Noah Watkins on the
> > Hadoop integration. The libcephfs-java package is in good shape, and
> > they are very close to having a single .jar file to drop into a Hadoop
> > installation to run on top of CephFS.
> > 
> > With the release of v0.58 we've also frozen v0.59, which will get two
> > weeks of QA before it is released.
> > 
> > You can get v0.58 from the usual locations:
> > 
> >   * Git at git://github.com/ceph/ceph.git
> >   * Tarball at http://ceph.com/download/ceph-0.58.tar.gz
> >   * For Debian/Ubuntu packages, see
> > http://ceph.com/docs/master/install/debian
> >   * For RPMs, see http://ceph.com/docs/master/install/rpm
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
