From: David Zafman <dzafman@redhat.com>
Subject: Re: trying to get osd-scrub-repair to work on my jenkins builder
Date: Fri, 4 Nov 2016 12:39:22 -0700
Message-ID: <b25d133d-8505-0ba4-c203-467b77104abb@redhat.com>
References: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754066AbcKDTjY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 15:39:24 -0400
In-Reply-To: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>


I'm working a similar problem with the test-erasure-eio.sh test which 
only fails on Jenkins.  I have a pg that is active+degraded and then 
active+recovery_wait+degraded.  In this case the hinfo is missing after 
osds are brought up and down in order to use the ceph-objectstore-tool 
to implement the test cases.  On Jenkins the osd restarting causes 
different pg mappings then on my build machine and recovery can't make 
progress.

See if you see these message in the osd log of the primary of the pg (in 
your example below that would be osd.3:

handle_sub_read_reply shard=1(1) error=-5

_failed_push: canceling recovery op for obj ...

David


On 11/4/16 10:09 AM, Willem Jan Withagen wrote:
> Hi,
>
> On my workstation if have this tst completing just fine. But on my
> Jenkins-builder it keeps running into this state where it does not make
> any progress.
> Any particulars I should look for? I can let this run for an hour, but
> pg 2.0 stays active+degrades, and the script requires it to be clean.
> and the pgmap version is steadily incrementing.
>
> What should be in the log files that points me to the problem?
>
> Thanx,
> --WjW
>
>
>      cluster 667960a1-a2ae-11e6-a834-69c386980813
>       health HEALTH_WARN
>              1 pgs degraded
>              1 pgs stuck degraded
>              1 pgs stuck unclean
>              recovery 2/6 objects degraded (33.333%)
>              too few PGs per OSD (1 < min 30)
>             
> noscrub,nodeep-scrub,sortbitwise,require_jewel_osds,require_kraken_osds
> flag(s) set
>       monmap e1: 1 mons at {a=127.0.0.1:7107/0}
>              election epoch 3, quorum 0 a
>          mgr no daemons active
>       osdmap e117: 10 osds: 10 up, 10 in
>              flags
> noscrub,nodeep-scrub,sortbitwise,require_jewel_osds,require_kraken_osds
>        pgmap v674: 5 pgs, 2 pools, 7 bytes data, 1 objects
>              60710 MB used, 2314 GB / 2374 GB avail
>              2/6 objects degraded (33.333%)
>                     4 active+clean
>                     1 active+degraded
>
> PG_STAT OBJECTS MISSING_ON_PRIMARY DEGRADED MISPLACED UNFOUND BYTES LOG
> DISK_LOG STATE           STATE_STAMP                VERSION REPORTED
> UP            UP_PRIMARY ACTING        ACTING_PRIMARY LAST_SCRUB
> SCRUB_STAMP                LAST_DEEP_SCRUB DEEP_SCRUB_STAMP
> 122: 2.0           1                  0        2         0       0
> 7   1        1 active+degraded 2016-11-04 17:55:00.190833    72'1
> 117:139 [3,1,9,0,6,2]          3 [3,1,9,0,6,2]              3       72'1
> 2016-11-04 17:54:37.943943            72'1 2016-11-04 17:54:37.943943
> 122: 1.3           0                  0        0         0       0
> 0   0        0    active+clean 2016-11-04 17:55:00.321568     0'0
> 117:139       [4,1,5]          4       [4,1,5]              4        0'0
> 2016-11-04 17:52:24.704377             0'0 2016-11-04 17:52:24.704377
> 122: 1.2           0                  0        0         0       0
> 0   0        0    active+clean 2016-11-04 17:55:00.249497     0'0
> 117:188       [0,5,9]          0       [0,5,9]              0        0'0
> 2016-11-04 17:52:24.704324             0'0 2016-11-04 17:52:24.704324
> 122: 1.1           0                  0        0         0       0
> 0   0        0    active+clean 2016-11-04 17:55:00.133525     0'0
> 116:7       [7,3,8]          7       [7,3,8]              7        0'0
> 2016-11-04 17:52:24.704269             0'0 2016-11-04 17:52:24.704269
> 122: 1.0           0                  0        0         0       0
> 0   0        0    active+clean 2016-11-04 17:53:18.409300     0'0
> 60:7       [8,0,2]          8       [8,0,2]              8        0'0
> 2016-11-04 17:52:24.704159             0'0 2016-11-04 17:52:24.704159
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

