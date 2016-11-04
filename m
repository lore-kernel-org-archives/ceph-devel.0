From: Willem Jan Withagen <wjw@digiware.nl>
Subject: trying to get osd-scrub-repair to work on my jenkins builder
Date: Fri, 4 Nov 2016 18:09:34 +0100
Message-ID: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:42347 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756399AbcKDRJk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 13:09:40 -0400
Received: from [192.168.101.51] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 5D65D27F24
        for <ceph-devel@vger.kernel.org>; Fri,  4 Nov 2016 18:09:36 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

On my workstation if have this tst completing just fine. But on my
Jenkins-builder it keeps running into this state where it does not make
any progress.
Any particulars I should look for? I can let this run for an hour, but
pg 2.0 stays active+degrades, and the script requires it to be clean.
and the pgmap version is steadily incrementing.

What should be in the log files that points me to the problem?

Thanx,
--WjW


    cluster 667960a1-a2ae-11e6-a834-69c386980813
     health HEALTH_WARN
            1 pgs degraded
            1 pgs stuck degraded
            1 pgs stuck unclean
            recovery 2/6 objects degraded (33.333%)
            too few PGs per OSD (1 < min 30)
           
noscrub,nodeep-scrub,sortbitwise,require_jewel_osds,require_kraken_osds
flag(s) set
     monmap e1: 1 mons at {a=127.0.0.1:7107/0}
            election epoch 3, quorum 0 a
        mgr no daemons active
     osdmap e117: 10 osds: 10 up, 10 in
            flags
noscrub,nodeep-scrub,sortbitwise,require_jewel_osds,require_kraken_osds
      pgmap v674: 5 pgs, 2 pools, 7 bytes data, 1 objects
            60710 MB used, 2314 GB / 2374 GB avail
            2/6 objects degraded (33.333%)
                   4 active+clean
                   1 active+degraded

PG_STAT OBJECTS MISSING_ON_PRIMARY DEGRADED MISPLACED UNFOUND BYTES LOG
DISK_LOG STATE           STATE_STAMP                VERSION REPORTED
UP            UP_PRIMARY ACTING        ACTING_PRIMARY LAST_SCRUB
SCRUB_STAMP                LAST_DEEP_SCRUB DEEP_SCRUB_STAMP
122: 2.0           1                  0        2         0       0    
7   1        1 active+degraded 2016-11-04 17:55:00.190833    72'1 
117:139 [3,1,9,0,6,2]          3 [3,1,9,0,6,2]              3       72'1
2016-11-04 17:54:37.943943            72'1 2016-11-04 17:54:37.943943
122: 1.3           0                  0        0         0       0    
0   0        0    active+clean 2016-11-04 17:55:00.321568     0'0 
117:139       [4,1,5]          4       [4,1,5]              4        0'0
2016-11-04 17:52:24.704377             0'0 2016-11-04 17:52:24.704377
122: 1.2           0                  0        0         0       0    
0   0        0    active+clean 2016-11-04 17:55:00.249497     0'0 
117:188       [0,5,9]          0       [0,5,9]              0        0'0
2016-11-04 17:52:24.704324             0'0 2016-11-04 17:52:24.704324
122: 1.1           0                  0        0         0       0    
0   0        0    active+clean 2016-11-04 17:55:00.133525     0'0   
116:7       [7,3,8]          7       [7,3,8]              7        0'0
2016-11-04 17:52:24.704269             0'0 2016-11-04 17:52:24.704269
122: 1.0           0                  0        0         0       0    
0   0        0    active+clean 2016-11-04 17:53:18.409300     0'0    
60:7       [8,0,2]          8       [8,0,2]              8        0'0
2016-11-04 17:52:24.704159             0'0 2016-11-04 17:52:24.704159


