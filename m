From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Available space shrinks to zero after upgrading cluster
Date: Mon, 09 Jan 2012 12:23:53 +0100
Message-ID: <2223940.SkCGeMiCNa@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:56049 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab2AILX7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Jan 2012 06:23:59 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id C9BF910C866
	for <ceph-devel@vger.kernel.org>; Mon,  9 Jan 2012 12:23:57 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I just upgraded my cluster to the current git version (from 0.39, using 
https://github.com/NewDreamNetwork/ceph.git), and now ceph -s reports the 
total available space in the the cluster as 0 and all of the clients using the 
cluster are blocking:

# ceph -s
2012-01-09 12:12:39.433576    pg v313084: 396 pgs: 396 active+clean; 79166 MB 
data, 0 KB used, 0 KB / 0 KB avail
2012-01-09 12:12:39.434269   mds e11: 1/1/1 up {0=alpha=up:replay}
2012-01-09 12:12:39.434289   osd e293: 6 osds: 6 up, 6 in
2012-01-09 12:12:39.434338   log 2012-01-09 12:12:26.600575 mon.0 
10.3.1.33:6789/0 6 : [INF] osd.1 10.3.1.33:6804/22161 boot
2012-01-09 12:12:39.434389   mon e5: 3 mons at 
{ceph1=10.3.1.33:6789/0,ceph2=10.3.1.34:6789/0,ceph3=10.3.1.35:6789/0}

I have a cluster with three machines, each with two OSDs and one mon. 
Additionally, the first one also has a single mds.

I did the upgrade by cloning the latest git sources onto each machine, doing 
the usual ./autgen.sh, ./configure, make && make install and then restarting 
ceph on one machine after the other using /etc/init.d/ceph restart, starting 
with the last one.

So... what's happening here and how do I get my cluster working again?

	Guido
