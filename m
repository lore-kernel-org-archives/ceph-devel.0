From: Sage Weil <sage@redhat.com>
Subject: kraken status
Date: Fri, 30 Dec 2016 21:44:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612302128020.19993@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33434 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753631AbcL3Vo5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Dec 2016 16:44:57 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
        by cobra.newdream.net (Postfix) with ESMTP id A93FD813C8
        for <ceph-devel@vger.kernel.org>; Fri, 30 Dec 2016 13:44:56 -0800 (PST)
Received: from localhost.localdomain (unknown [64.111.99.127])
        by cobra.newdream.net (Postfix) with ESMTPSA id 791E081398
        for <ceph-devel@vger.kernel.org>; Fri, 30 Dec 2016 13:44:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rest, hadoop, knfs, kcephfs all green!

Most of the failures below have 'immediate' tickets open. I didn't open 
new tickets for the rbd or cephfs failures, though.  I'm not sure which 
ones are blockers.

	http://tracker.ceph.com/projects/ceph/issues?query_id=27

I'm on vacation next week (Jan 1 - Jan 8).


ceph-disk:

- fails to install ceph-radosgw on centos

	http://tracker.ceph.com/issues/18374


rados:

I think these are blockers:

- bluestore reclaim broken

	http://tracker.ceph.com/issues/18368
	https://github.com/ceph/ceph/pull/12725

- ceph-disk bug seen on xenial

	http://tracker.ceph.com/issues/18371

- bluestore + one failure injection test generates a core

	http://tracker.ceph.com/issues/18372
	https://github.com/ceph/ceph/pull/12726

These are either old or environmental noise:

- several failures with time skew. usually this is environmental but it's 
weird that we haven't seen until recently.  maybe ntp isn't configured on 
the new nodes properly?

	http://tracker.ceph.com/issues/18370

- ENOENT on clone suggests bug.  This pops up infrequently but I think I 
have a root cause this time!

	http://tracker.ceph.com/issues/18373

- still seeing deadlocks from gperftools vs dlopen on xenial (lead to dead 
runs)

There are also 2 issues that came up on the lab cluster.  These are 
probably related to old corruptions, but they lead to OSD crashes, so we 
should fix that much at least:

- failed_push does not update missing set, breaking mark_unfound_lost

	http://tracker.ceph.com/issues/18365

- scrub is still disabled as it lead to a crash last week.  we should make 
sure it can complete fully..


rgw:

http://pulpito.ceph.com/teuthology-2016-12-29_11:05:01-rgw-kraken-distro-basic-smithi

All valgrind failures:

- invalid read of size 4

	http://tracker.ceph.com/issues/18071

- leaks

	http://tracker.ceph.com/issues/18300


rbd:

http://pulpito.ceph.com/teuthology-2016-12-29_11:00:03-rbd-kraken-distro-basic-smithi
http://pulpito.ceph.com/teuthology-2016-12-29_11:00:03-rbd-kraken-distro-basic-smithi/

3 failures across those runs,

- test_lock_fence.sh (both)
- rbd_mirror.sh
- fsx nbd


fs:

http://pulpito.ceph.com/teuthology-2016-12-29_11:10:01-fs-kraken---basic-smithi

- TestVolumeClient
- TestSessionMap 


samba:

http://pulpito.ceph.com/teuthology-2016-12-29_11:35:02-samba-kraken---basic-mira/

many failures.. gitbuilder vs shaman issue?

