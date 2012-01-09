From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Available space shrinks to zero after upgrading cluster
Date: Mon, 09 Jan 2012 12:28:57 +0100
Message-ID: <2860646.9ynkoJcyEE@pc10>
References: <2223940.SkCGeMiCNa@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:55415 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab2AIL3A (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Jan 2012 06:29:00 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id F30D610C866
	for <ceph-devel@vger.kernel.org>; Mon,  9 Jan 2012 12:28:58 +0100 (CET)
In-Reply-To: <2223940.SkCGeMiCNa@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Montag, 9. Januar 2012, 12:23:53 schrieb Guido Winkelmann:
> Hi,
> 
> I just upgraded my cluster to the current git version (from 0.39, using
> https://github.com/NewDreamNetwork/ceph.git), and now ceph -s reports the
> total available space in the the cluster as 0 and all of the clients using
> the cluster are blocking:
> 
> # ceph -s
> 2012-01-09 12:12:39.433576    pg v313084: 396 pgs: 396 active+clean; 79166
> MB data, 0 KB used, 0 KB / 0 KB avail
> 2012-01-09 12:12:39.434269   mds e11: 1/1/1 up {0=alpha=up:replay}
> 2012-01-09 12:12:39.434289   osd e293: 6 osds: 6 up, 6 in
> 2012-01-09 12:12:39.434338   log 2012-01-09 12:12:26.600575 mon.0
> 10.3.1.33:6789/0 6 : [INF] osd.1 10.3.1.33:6804/22161 boot
> 2012-01-09 12:12:39.434389   mon e5: 3 mons at
> {ceph1=10.3.1.33:6789/0,ceph2=10.3.1.34:6789/0,ceph3=10.3.1.35:6789/0}
> 
> I have a cluster with three machines, each with two OSDs and one mon.
> Additionally, the first one also has a single mds.
> 
> I did the upgrade by cloning the latest git sources onto each machine, doing
> the usual ./autgen.sh, ./configure, make && make install and then
> restarting ceph on one machine after the other using /etc/init.d/ceph
> restart, starting with the last one.
> 
> So... what's happening here and how do I get my cluster working again?

Oh, hey, it just changed to this:

# ceph -s
2012-01-09 12:28:07.745570    pg v313092: 396 pgs: 232 active+clean, 106 
active+clean+degraded, 13 active+clean+replay+degraded, 45 
down+degraded+peering; 79166 MB data, 33829 MB used, 825 GB / 876 GB avail; 
8792/42838 degraded (20.524%)
2012-01-09 12:28:07.746310   mds e11: 1/1/1 up {0=alpha=up:replay}
2012-01-09 12:28:07.746330   osd e296: 6 osds: 1 up, 6 in
2012-01-09 12:28:07.746379   log 2012-01-09 12:27:24.965150 mon.0 
10.3.1.33:6789/0 7 : [INF] osd.4 10.3.1.35:6806/3705 boot
2012-01-09 12:28:07.746422   mon e1: 1 mons at {ceph1=10.3.1.33:6789/0}
2012-01-09 12:28:07.746431   mon e2: 2 mons at 
{ceph1=10.3.1.33:6789/0,ceph2=10.3.1.34:6789/0}
2012-01-09 12:28:07.746440   mon e3: 1 mons at {ceph1=10.3.1.33:6789/0}
2012-01-09 12:28:07.746446   mon e4: 2 mons at 
{ceph1=10.3.1.33:6789/0,ceph2=10.3.1.34:6789/0}
2012-01-09 12:28:07.746453   mon e5: 3 mons at 
{ceph1=10.3.1.33:6789/0,ceph2=10.3.1.34:6789/0,ceph3=10.3.1.35:6789/0}

	Guido
