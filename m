From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: stuck recovery for many days, help needed
Date: Fri, 22 Sep 2017 10:04:25 +0800
Message-ID: <CAEYCsVLQOrPtfkM7tgMpzgsvdTsDWmu27VPAV-NDXgfhu_o-3Q@mail.gmail.com>
References: <CAGbvivL+rMz439OZV2R1UGAaN2A5uOMiMe1ykd88nOJ=MqnFcQ@mail.gmail.com>
 <CAFehDbC=VUc8rQXgxRoo78G-WoSiLoOx4+6bVwi7HbyC4zVrsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:56359 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdIVCE0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Sep 2017 22:04:26 -0400
Received: by mail-it0-f51.google.com with SMTP id g18so11449itg.5
        for <ceph-devel@vger.kernel.org>; Thu, 21 Sep 2017 19:04:26 -0700 (PDT)
In-Reply-To: <CAFehDbC=VUc8rQXgxRoo78G-WoSiLoOx4+6bVwi7HbyC4zVrsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafa1024m@gmail.com>
Cc: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

Luminous recovery also eat up lots of memory,  I consistently seeing
5GB+ RSS for my OSDs during recovery.

mempool stat showing pglog eat up most of the memory

>     "osd_pglog": {
>         "items": 7834058,
>         "bytes": 3025235100
>     },


>     "total": {
>         "items": 23999967,
>         "bytes": 3820337626
>     }


Also the huge gap on memory consumption, between mempool stat and heap
stat are unknown:

[19:02:15 pts/0]root@slx03c-6rqx:~# ceph daemon osd.428 --cluster
pre-prod  heap stats
osd.428 tcmalloc heap stats:------------------------------------------------
MALLOC:     6418067864 ( 6120.7 MiB) Bytes in use by application
MALLOC: +     20635648 (   19.7 MiB) Bytes in page heap freelist
MALLOC: +    806292256 (  768.9 MiB) Bytes in central cache freelist
MALLOC: +     26934096 (   25.7 MiB) Bytes in transfer cache freelist
MALLOC: +     86640632 (   82.6 MiB) Bytes in thread cache freelists
MALLOC: +     33353880 (   31.8 MiB) Bytes in malloc metadata
MALLOC:   ------------
MALLOC: =   7391924376 ( 7049.5 MiB) Actual memory used (physical + swap)
MALLOC: +    907812864 (  865.8 MiB) Bytes released to OS (aka unmapped)
MALLOC:   ------------
MALLOC: =   8299737240 ( 7915.2 MiB) Virtual address space used
MALLOC:
MALLOC:         399235              Spans in use
MALLOC:             34              Thread heaps in use
MALLOC:           8192              Tcmalloc page size
------------------------------------------------
Call ReleaseFreeMemory() to release freelist memory to the OS (via madvise()).
Bytes released to the OS take up virtual address space but no physical memory.
{
    "error": "(0) Success",
    "success": true
}

2017-09-22 5:27 GMT+08:00 Mustafa Muhammad <mustafa1024m@gmail.com>:
> Hello,
>
> We had similar issue 6 weeks ago, you can find some details in this thread:
> https://marc.info/?t=150297924500005&r=1&w=2
>
> There were multiple problems all together, mainly osdmap updates are
> very slow and peering takes huge amount of memory (in that version,
> fixed in 12.2)
> I think you should first set "pause" and "notieragent" flags.
> Also set noup, nodown so your osdmap doesn't change rapidly with every
> OSD down and up, and only unset them for maybe 10 seconds when you
> want started OSDs to go up.
>
> For us, the memory usage issue was fixed by upgrading to Luminous
> (12.2.0 is available), after that we could start the whole cluster
> with fraction of the memory (no more than 15G per node (12 OSD each)
> ).
>
> This should let the peering and recovery proceed, and hopefully you
> get your cluster healthy soon.
>
> We faced another bug in recovery, hope you don't face it too, my
> colleague made a patch for it and sent it to this ML, but I hope you
> don't need it.
>
> Feel free to ask for any more info
>
> Regards
> Mustafa Muhammad
>
>
> On Thu, Sep 21, 2017 at 5:08 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> I have a damaged cluster that has been recovering for over a week and
>> is still not getting healthy.  It will get to a point and then the
>> "degraded" recovery objects count stops going down and eventually the
>> "mispaced" object count also stops going down and recovery basically
>> stops.
>>
>> Problems noted:
>>
>>  - Memory exhaustion on storage servers. We have 192GB RAM and 64TB of
>> disks (though only 40TB of disks are marked "up/in" the cluster
>> currently to avoid crashing issues and some suspected bad disks).
>>
>> - OSD crashes.  We have a number of OSDs that repeatedly crash on or
>> shortly after starting up and joining back into the cluster (crash
>> logs already sent in to this list early this week).  Possibly due to
>> hard drive issues, but none of them are marked as failing by SMART
>> utilities.
>>
>> - Too many cephfs snapshots.  We have a cephfs with over 4800
>> snapshots.  cephfs is currently unavailable during the recovery, but
>> when it *was* available, deleting a single snapshot threw the system
>> into a bad state - thousands of requests would become blocked, cephfs
>> would become blocked and the entire cluster basically went to hell.  I
>> believe a bug has been filed for this, but I think the impact is more
>> severe and critical than originally suspected.
>>
>>
>> Fixes attempted:
>> - Upgraded everything to ceph 10.2.9 (was originally 10.2.7)
>> - Upgraded kernels on storage servers to 4.13.1 to get around XFS problems.
>> - disabled scrub and deep scrub
>> - attempting to bring more OSDs online, but its tricky because we end
>> up either running into memory exhaustion problems or the OSDs crash
>> shortly after starting making them essentially useless.
>>
>>
>> Currently our status looks like this (MDSs are disabled intentionally
>> for now, having them online makes no difference for recovery or cephfs
>> availability):
>>
>>      health HEALTH_ERR
>>             25 pgs are stuck inactive for more than 300 seconds
>>             1398 pgs backfill_wait
>>             72 pgs backfilling
>>             38 pgs degraded
>>             13 pgs down
>>             1 pgs incomplete
>>             2 pgs inconsistent
>>             13 pgs peering
>>             35 pgs recovering
>>             37 pgs stuck degraded
>>             25 pgs stuck inactive
>>             1519 pgs stuck unclean
>>             33 pgs stuck undersized
>>             34 pgs undersized
>>             81 requests are blocked > 32 sec
>>             recovery 351883/51815427 objects degraded (0.679%)
>>             recovery 4920116/51815427 objects misplaced (9.495%)
>>             recovery 152/17271809 unfound (0.001%)
>>             15 scrub errors
>>             mds rank 0 has failed
>>             mds cluster is degraded
>>             noscrub,nodeep-scrub flag(s) set
>>      monmap e1: 3 mons at
>> {mon01=10.16.51.21:6789/0,mon02=10.16.51.22:6789/0,mon03=10.16.51.23:6789/0}
>>             election epoch 192, quorum 0,1,2 mon01,mon02,mon03
>>       fsmap e18157: 0/1/1 up, 1 failed
>>      osdmap e254054: 93 osds: 77 up, 76 in; 1511 remapped pgs
>>             flags noscrub,nodeep-scrub,sortbitwise,require_jewel_osds
>>       pgmap v36166916: 16200 pgs, 13 pools, 25494 GB data, 16867 kobjects
>>             86259 GB used, 139 TB / 223 TB avail
>>
>>
>> Any suggestions as to what to look for or how to try and get this
>> cluster healthy soon would be much appreciated, its literally been
>> more than 2 weeks of battling with various issues and we are no closer
>> to a healthy usable cluster.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
