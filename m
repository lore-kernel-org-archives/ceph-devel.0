From: Sage Weil <sage@inktank.com>
Subject: Re: Strange behavior after upgrading to 0.48
Date: Thu, 5 Jul 2012 07:26:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207050725550.6931@cobra.newdream.net>
References: <4FF53706.7070003@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51702 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab2GEO06 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 10:26:58 -0400
In-Reply-To: <4FF53706.7070003@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Thu, 5 Jul 2012, Xiaopong Tran wrote:
> Hi,
> 
> I put up a small cluster with 3 osds, 2 mds, 3 mons, on 3 machines.
> They were running 0.47.2, and this is a test to do rolling upgrade to
> 0.48.
> 
> I shutdown, upgraded the software, then restarted. One node at a time.
> The first two seemed to be ok. The third one gave me some weird thing.
> While it was doing the conversion and recovering, the command ceph -s gives
> things like this:
> 
> 
> root@china:/tmp# ceph -s
> 2012-07-05 14:28:41.069470 7fa3c8443780  2 auth: KeyRing::load: loaded key
> file /etc/ceph/client.admin.keyring
> 2012-07-05 14:28:41.594229 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.596313 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.598949 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.601158 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.603069 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.605020 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.607436 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.609304 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.611047 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.667980 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.670283 7fa3c030e700  0 monclient: hunting for new mon
> 2012-07-05 14:28:41.672274 7fa3c030e700  0 monclient: hunting for new mon
> ....

The problem is that the ceph utility itself is pre-0.48, but the monitors 
are running 0.48.  You need to upgrade the utility as well.  (There was a 
note about this in the release announcement.)

This only affects the -s and -w commands.

sage


> 
> And it never stopped. I was thinking, maybe it just behaved like
> that during recovery. But after the recovery is done, it still
> get the same thing:
> 
> root@china:/tmp# ceph health
> 2012-07-05 14:28:55.077364 7f8306a0d780  2 auth: KeyRing::load: loaded key
> file /etc/ceph/client.admin.keyring
> HEALTH_OK
> root@china:/tmp# ceph -s
> 2012-07-05 14:30:49.688017 7feb6338e780  2 auth: KeyRing::load: loaded key
> file /etc/ceph/client.admin.keyring
> 2012-07-05 14:30:49.691690 7feb5b259700  0 monclient: hunting for new mon
> 2012-07-05 14:30:49.694295 7feb5b259700  0 monclient: hunting for new mon
> 2012-07-05 14:30:49.696487 7feb5b259700  0 monclient: hunting for new mon
> 2012-07-05 14:30:49.698953 7feb5b259700  0 monclient: hunting for new mon
> 2012-07-05 14:30:49.700833 7feb5b259700  0 monclient: hunting for new mon
> ....
> 
> Upgrading the first two nodes have no such problem. This first two
> nodes all run osd, mds, and mon. The third only runs osd and mon.
> 
> The mon log on the 3rd node shows this, not sure if this is helpful:
> 
> ....
> 925291 lease_expire=2012-07-05 02:38:14.149966 has v44 lc 44
> 2012-07-05 02:38:12.572107 7f7d9381a700  1 mon.a@0(leader).paxos(pgmap active
> c 29531..30031) is_readable now=2012-07-05 02:38:12.572114
> lease_expire=2012-07-05 02:38:15.889056 has v0 lc 30031
> 2012-07-05 02:38:12.572128 7f7d9381a700  1 mon.a@0(leader).paxos(pgmap active
> c 29531..30031) is_readable now=2012-07-05 02:38:12.572129
> lease_expire=2012-07-05 02:38:15.889056 has v0 lc 30031
> 2012-07-05 02:38:15.120439 7f7d9401b700  1 mon.a@0(leader).paxos(mdsmap active
> c 1..44) is_readable now=2012-07-05 02:38:15.120446 lease_expire=2012-07-05
> 02:38:17.149967 has v44 lc 44
> 2012-07-05 02:38:15.925349 7f7d9401b700  1 mon.a@0(leader).paxos(mdsmap active
> c 1..44) is_readable now=2012-07-05 02:38:15.925356 lease_expire=2012-07-05
> 02:38:20.149971 has v44 lc 44
> 2012-07-05 02:38:17.572181 7f7d9381a700  1 mon.a@0(leader).paxos(pgmap active
> c 29531..30031) is_readable now=2012-07-05 02:38:17.572189
> lease_expire=2012-07-05 02:38:21.889065 has v0 lc 30031
> 2012-07-05 02:38:17.572204 7f7d9381a700  1 mon.a@0(leader).paxos(pgmap active
> c 29531..30031) is_readable now=2012-07-05 02:38:17.572205
> lease_expire=2012-07-05 02:38:21.889065 has v0 lc 30031
> 2012-07-05 02:38:19.120463 7f7d9401b700  1 mon.a@0(leader).paxos(mdsmap active
> c 1..44) is_readable now=2012-07-05 02:38:19.120470 lease_expire=2012-07-05
> 02:38:23.149973 has v44 lc 44
> 2012-07-05 02:38:19.925323 7f7d9401b700  1 mon.a@0(leader).paxos(mdsmap active
> c 1..44) is_readable now=2012-07-05 02:38:19.925330 lease_expire=2012-07-05
> 02:38:23.149973 has v44 lc 44
> 
> Could someone give a hint on this?
> 
> Thanks
> 
> Xiaopong
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
