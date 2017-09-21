From: Vincent Godin <vince.mlist@gmail.com>
Subject: Re: stuck recovery for many days, help needed
Date: Thu, 21 Sep 2017 19:47:42 +0200
Message-ID: <CAL2-6bKympq8dTCtae3VMZBTWwX3TEE5YkfDtvUueJkePYjQMA@mail.gmail.com>
References: <CAGbvivL+rMz439OZV2R1UGAaN2A5uOMiMe1ykd88nOJ=MqnFcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:45717 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdIURrn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Sep 2017 13:47:43 -0400
Received: by mail-qk0-f182.google.com with SMTP id r141so6538148qke.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 Sep 2017 10:47:43 -0700 (PDT)
In-Reply-To: <CAGbvivL+rMz439OZV2R1UGAaN2A5uOMiMe1ykd88nOJ=MqnFcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hello,

You should first investigate on the 13 pgs which refuse to peer. They
probably refuse to peer because they're waiting for some OSDs with
more up-to-date datas. Try to focus on one pg and restart the OSD the
pg is waiting for

I don't understand very well your memory problem : my hosts have 64GB
of RAM and (20 x 6 TB SATA + 5 x 400GB SSD) and i have encountered no
memory problems (i'm on 10.2.7). An OSD consumes about 1GB of RAM. How
many OSD process are running on one of your host and how much RAM are
used by OSD process ? It may be your main problem

2017-09-21 16:08 GMT+02:00 Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>:
> I have a damaged cluster that has been recovering for over a week and
> is still not getting healthy.  It will get to a point and then the
> "degraded" recovery objects count stops going down and eventually the
> "mispaced" object count also stops going down and recovery basically
> stops.
>
> Problems noted:
>
>  - Memory exhaustion on storage servers. We have 192GB RAM and 64TB of
> disks (though only 40TB of disks are marked "up/in" the cluster
> currently to avoid crashing issues and some suspected bad disks).
>
> - OSD crashes.  We have a number of OSDs that repeatedly crash on or
> shortly after starting up and joining back into the cluster (crash
> logs already sent in to this list early this week).  Possibly due to
> hard drive issues, but none of them are marked as failing by SMART
> utilities.
>
> - Too many cephfs snapshots.  We have a cephfs with over 4800
> snapshots.  cephfs is currently unavailable during the recovery, but
> when it *was* available, deleting a single snapshot threw the system
> into a bad state - thousands of requests would become blocked, cephfs
> would become blocked and the entire cluster basically went to hell.  I
> believe a bug has been filed for this, but I think the impact is more
> severe and critical than originally suspected.
>
>
> Fixes attempted:
> - Upgraded everything to ceph 10.2.9 (was originally 10.2.7)
> - Upgraded kernels on storage servers to 4.13.1 to get around XFS problems.
> - disabled scrub and deep scrub
> - attempting to bring more OSDs online, but its tricky because we end
> up either running into memory exhaustion problems or the OSDs crash
> shortly after starting making them essentially useless.
>
>
> Currently our status looks like this (MDSs are disabled intentionally
> for now, having them online makes no difference for recovery or cephfs
> availability):
>
>      health HEALTH_ERR
>             25 pgs are stuck inactive for more than 300 seconds
>             1398 pgs backfill_wait
>             72 pgs backfilling
>             38 pgs degraded
>             13 pgs down
>             1 pgs incomplete
>             2 pgs inconsistent
>             13 pgs peering
>             35 pgs recovering
>             37 pgs stuck degraded
>             25 pgs stuck inactive
>             1519 pgs stuck unclean
>             33 pgs stuck undersized
>             34 pgs undersized
>             81 requests are blocked > 32 sec
>             recovery 351883/51815427 objects degraded (0.679%)
>             recovery 4920116/51815427 objects misplaced (9.495%)
>             recovery 152/17271809 unfound (0.001%)
>             15 scrub errors
>             mds rank 0 has failed
>             mds cluster is degraded
>             noscrub,nodeep-scrub flag(s) set
>      monmap e1: 3 mons at
> {mon01=10.16.51.21:6789/0,mon02=10.16.51.22:6789/0,mon03=10.16.51.23:6789/0}
>             election epoch 192, quorum 0,1,2 mon01,mon02,mon03
>       fsmap e18157: 0/1/1 up, 1 failed
>      osdmap e254054: 93 osds: 77 up, 76 in; 1511 remapped pgs
>             flags noscrub,nodeep-scrub,sortbitwise,require_jewel_osds
>       pgmap v36166916: 16200 pgs, 13 pools, 25494 GB data, 16867 kobjects
>             86259 GB used, 139 TB / 223 TB avail
>
>
> Any suggestions as to what to look for or how to try and get this
> cluster healthy soon would be much appreciated, its literally been
> more than 2 weeks of battling with various issues and we are no closer
> to a healthy usable cluster.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
