From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Toying with a FreeBSD cluster results in a crash
Date: Fri, 7 Apr 2017 16:34:44 +0200
Message-ID: <f94f1932-ae99-eb6a-7fc6-e2fb6afee051@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25501 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755318AbdDGOet (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 7 Apr 2017 10:34:49 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 451613DA79
        for <ceph-devel@vger.kernel.org>; Fri,  7 Apr 2017 16:34:46 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm playing with my/a FreeBSD test cluster.
It is full with different types of disks, and sometimes they are not
very new.

The deepscrub on it showed things like:
 filestore(/var/lib/ceph/osd/osd.7) error creating
#-1:4962ce63:::inc_osdmap.705:0#
(/var/lib/ceph/osd/osd.7/current/meta/inc\uosdmap
.705__0_C6734692__none) in index: (87) Attribute not found


I've build the cluster with:
	osd pool default size      = 1

Created some pools, and then increased
	osd pool default size      = 3

Restarted the pools, but 1 pool does not want to reboot, so now I wonder
if the restarting problem is due to issue like quoted above?

And how do I cleanup this mess, without wiping the cluster and
restarting. :) Note that it is just practice for me doing somewhat more
tricky work.

Thanx,
--WjW


    -6> 2017-04-07 16:04:57.530301 806e16000  0 osd.7 733 crush map has
features 2200130813952, adjusting msgr requires for clients
    -5> 2017-04-07 16:04:57.530314 806e16000  0 osd.7 733 crush map has
features 2200130813952 was 8705, adjusting msgr requires for mons
    -4> 2017-04-07 16:04:57.530321 806e16000  0 osd.7 733 crush map has
features 2200130813952, adjusting msgr requires for osds
    -3> 2017-04-07 16:04:57.552968 806e16000  0 osd.7 733 load_pgs
    -2> 2017-04-07 16:04:57.553479 806e16000 -1 osd.7 0 failed to load
OSD map for epoch 714, got 0 bytes
    -1> 2017-04-07 16:04:57.553493 806e16000 -1 osd.7 733 load_pgs: have
pgid 8.e9 at epoch 714, but missing map.  Crashing.
     0> 2017-04-07 16:04:57.554157 806e16000 -1
/usr/ports/net/ceph/work/ceph-wip.FreeBSD/src/osd/OSD.cc: In function
'void OSD::load_pgs()' thread 806e16000 time 2017-04-0
7 16:04:57.553497
/usr/ports/net/ceph/work/ceph-wip.FreeBSD/src/osd/OSD.cc: 3360: FAILED
assert(0 == "Missing map in load_pgs")

Most of the pools are in "oke" state:
[/var/log/ceph] wjw@cephtest> ceph -s
    cluster 746e196d-e344-11e6-b4b7-0025903744dc
     health HEALTH_ERR
            45 pgs are stuck inactive for more than 300 seconds
            7 pgs down
            38 pgs stale
            7 pgs stuck inactive
            38 pgs stuck stale
            7 pgs stuck unclean
            pool cephfsdata has many more objects per pg than average
(too few pgs?)
     monmap e5: 3 mons at
{a=192.168.10.70:6789/0,b=192.168.9.79:6789/0,c=192.168.8.79:6789/0}
            election epoch 114, quorum 0,1,2 c,b,a
      fsmap e755: 1/1/1 up {0=alpha=up:active}
        mgr active: admin
     osdmap e877: 8 osds: 7 up, 7 in; 6 remapped pgs
            flags sortbitwise,require_jewel_osds,require_kraken_osds
      pgmap v681735: 1864 pgs, 7 pools, 12416 MB data, 354 kobjects
            79963 MB used, 7837 GB / 7915 GB avail
                1819 active+clean
                  38 stale+active+clean
                   6 down
                   1 down+remapped

Just the ones that were only on the OSD that doesn't want to come up.
