From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: Fix local messages and lost wake-up in SimpleMessenger
Date: Tue, 14 Aug 2012 23:28:41 -0300
Message-ID: <or8vdgx50m.fsf@livre.localdomain>
References: <or7gt2ypox.fsf@livre.localdomain>
	<orsjbpxq8i.fsf@livre.localdomain>
	<alpine.DEB.2.00.1208141534040.18862@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:39010 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755656Ab2HOC2v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Aug 2012 22:28:51 -0400
In-Reply-To: <alpine.DEB.2.00.1208141534040.18862@cobra.newdream.net> (Sage
	Weil's message of "Tue, 14 Aug 2012 15:49:36 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Aug 14, 2012, Sage Weil <sage@inktank.com> wrote:

> Do you mind trying to reproduce this on the current master?

Tried, but couldn't.  It looks like it is indeed fixed in master, but
not in 0.50.

> BTW, if you have a script or anything you were using to test, that'd be 
> great to add to our test suite.

It occurred occasionally while rsyncing (with -aH) trees containing
hardlinks into the ceph filesystem, but it became a real problem when I
decided to stop using snapshots and use hardlink farms instead.
Creating a hardlink farm of a tree containing hardlinks (like
/usr/share/zoneinfo) presumably compounds the problem, but I've hit it
most often after creating linkfarms of a few backups of my phone's root
directory, some old SHR GNU/Linux release, probably just because those
have enough directories and files to get stuff kicked out of the mds
cache.

You could probably trigger it with something like this:

rsync -aH /usr/share/zoneinfo/ /mnt/ceph/sub1/
rsync -aH /usr/share/zoneinfo/ /mnt/ceph/sub2/ --link-dest=/mnt/ceph/sub1/

umount /mnt/ceph
# ceph-fuse survives the umount, so wait
# till it flushes everything to the mds:
while killall -0 ceph-fuse; do sleep 1; done 
restart mds # maybe not needed
mount /mnt/ceph

# kick all of sub1/ and sub2/ out of the cache somehow, and then:

ls -lR /mnt/ceph/sub2 # freezes

# restarting mds at this point may get it stuck at rejoin

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
