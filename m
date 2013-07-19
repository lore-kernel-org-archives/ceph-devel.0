From: Sage Weil <sage@inktank.com>
Subject: Re: v0.61.5 Cuttlefish update released
Date: Thu, 18 Jul 2013 22:59:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307182254010.28090@cobra.newdream.net>
References: <alpine.DEB.2.00.1307180944270.7945@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49067 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3GSF7p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 01:59:45 -0400
In-Reply-To: <alpine.DEB.2.00.1307180944270.7945@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

A note on upgrading:

One of the fixes in 0.61.5 is with a 32bit vs 64bit bug with the feature 
bits.  We did not realize it before, but the fix will prevent 0.61.4 (or 
earlier) from forming a quorum with 0.61.5. This is similar to the upgrade 
from bobtail (and the future upgrade to dumpling). As such, we recommend 
you upgrade all monitors at once to avoid the potential for discruption in 
service.

I'm adding a note to the release notes.

Thanks!
sage


On Thu, 18 Jul 2013, Sage Weil wrote:

> We've prepared another update for the Cuttlefish v0.61.x series. This 
> release primarily contains monitor stability improvements, although there 
> are also some important fixes for ceph-osd for large clusters and a few 
> important CephFS fixes. We recommend that all v0.61.x users upgrade.
> 
>  * mon: misc sync improvements (faster, more reliable, better tuning)
>  * mon: enable leveldb cache by default (big performance improvement)
>  * mon: new scrub feature (primarily for diagnostic, testing purposes)
>  * mon: fix occasional leveldb assertion on startup
>  * mon: prevent reads until initial state is committed
>  * mon: improved logic for trimming old osdmaps
>  * mon: fix pick_addresses bug when expanding mon cluster
>  * mon: several small paxos fixes, improvements
>  * mon: fix bug osdmap trim behavior
>  * osd: fix several bugs with PG stat reporting
>  * osd: limit number of maps shared with peers (which could cause domino failures)
>  * rgw: fix radosgw-admin buckets list (for all buckets)
>  * mds: fix occasional client failure to reconnect
>  * mds: fix bad list traversal after unlink
>  * mds: fix underwater dentry cleanup (occasional crash after mds restart)
>  * libcephfs, ceph-fuse: fix occasional hangs on umount
>  * libcephfs, ceph-fuse: fix old bug with O_LAZY vs O_NOATIME confusion
>  * ceph-disk: more robust journal device detection on RHEL/CentOS
>  * ceph-disk: better, simpler locking
>  * ceph-disk: do not inadvertantely mount over existing osd mounts
>  * ceph-disk: better handling for unusual device names
>  * sysvinit, upstart: handle symlinks in /var/lib/ceph/*
> 
> Please also refer to the complete release notes:
> 
>    http://ceph.com/docs/master/release-notes/#v0-61-5-cuttlefish
> 
> You can get v0.61.5 from the usual locations:
> 
>  * Git at git://github.com/ceph/ceph.git
>  * Tarball at http://ceph.com/download/ceph-0.61.5.tar.gz
>  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>  * For RPMs, see http://ceph.com/docs/master/install/rpm
> 
