From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: [ceph-users] Troubleshooting incomplete PG's
Date: Sun, 2 Apr 2017 10:11:14 +1000
Message-ID: <CAF-wwdFB5mXhh2UzEiz7JQKhr1m8Cb=D_6eSNB5-XLuN4dRwAw@mail.gmail.com>
References: <CALWuvY9pPr6FumF-d65pLrhbj1=HPNUEH74tKEOsfs=fAn_fbA@mail.gmail.com>
 <CAF-wwdGXduVn8a5xYPxo2BBtHQnAFVijPG_EvDjojyL_7f0cxQ@mail.gmail.com> <CALWuvY-053dt8w8Aj5n-icf--v_TZ2dkEBrE8T7nTR8Hb3SeDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38428 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdDBALP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Apr 2017 20:11:15 -0400
Received: by mail-it0-f48.google.com with SMTP id y18so28007748itc.1
        for <ceph-devel@vger.kernel.org>; Sat, 01 Apr 2017 17:11:15 -0700 (PDT)
In-Reply-To: <CALWuvY-053dt8w8Aj5n-icf--v_TZ2dkEBrE8T7nTR8Hb3SeDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nokia ceph <nokiacephusers@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Ceph Users <ceph-users@lists.ceph.com>

On Fri, Mar 31, 2017 at 5:19 AM, nokia ceph <nokiacephusers@gmail.com> wrote:
> Hello Brad,
>
> Many thanks of the info :)
>
> ENV:-- Kracken - bluestore - EC 4+1 - 5 node cluster : RHEL7
>
> What is the status of the down+out osd? Only one osd osd.6 down and out from
> cluster.
> What role did/does it play? Mostimportantly, is it osd.6? Yes, due to
> underlying I/O error issue we removed this device from the cluster.
>
> I put this parameter " osd_find_best_info_ignore_history_les = true" in
> ceph.conf, and find those 22 PG's were changed to "down+remapped" . Now all
> are reverted to "remapped+incomplete" state.
>
> #ceph pg stat 2> /dev/null
> v2731828: 4096 pgs: 1 incomplete, 21 remapped+incomplete, 4074 active+clean;
> 268 TB data, 371 TB used, 267 TB / 638 TB avail
>
> ## ceph -s
> 2017-03-30 19:02:14.350242 7f8b0415f700 -1 WARNING: the following dangerous
> and experimental features are enabled: bluestore,rocksdb
> 2017-03-30 19:02:14.366545 7f8b0415f700 -1 WARNING: the following dangerous
> and experimental features are enabled: bluestore,rocksdb
>     cluster bd8adcd0-c36d-4367-9efe-f48f5ab5f108
>      health HEALTH_ERR
>             22 pgs are stuck inactive for more than 300 seconds
>             22 pgs incomplete
>             22 pgs stuck inactive
>             22 pgs stuck unclean
>      monmap e2: 5 mons at
> {au-adelaide=10.50.21.24:6789/0,au-brisbane=10.50.21.22:6789/0,au-canberra=10.50.21.23:6789/0,au-melbourne=10.50.21.21:6789/0,au-sydney=10.50.21.20:6789/0}
>             election epoch 180, quorum 0,1,2,3,4

Are you *actually* trying to create a cluster that is as
geographically dispersed as these machine names indicate?

> au-sydney,au-melbourne,au-brisbane,au-canberra,au-adelaide
>         mgr active: au-adelaide
>      osdmap e6506: 117 osds: 117 up, 117 in; 21 remapped pgs
>             flags sortbitwise,require_jewel_osds,require_kraken_osds
>       pgmap v2731828: 4096 pgs, 1 pools, 268 TB data, 197 Mobjects
>             371 TB used, 267 TB / 638 TB avail
>                 4074 active+clean
>                   21 remapped+incomplete
>                    1 incomplete
>
>
> ## ceph osd dump 2>/dev/null | grep cdvr
> pool 1 'cdvr_ec' erasure size 5 min_size 4 crush_ruleset 1 object_hash
> rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags
> hashpspool,nodeep-scrub stripe_width 65536
>
> Inspecting affected PG 1.e4b
>
> # ceph pg dump 2> /dev/null | grep 1.e4b
> 1.e4b     50832                  0        0         0       0 73013340821
> 10006    10006 remapped+incomplete 2017-03-30 14:14:26.297098 3844'161662
> 6506:325748 [113,66,15,73,103]        113  [NONE,NONE,NONE,73,NONE]
> 73 1643'139486 2017-03-21 04:56:16.683953             0'0 2017-02-21
> 10:33:50.012922
>
> When I trigger below command.
>
> #ceph pg force_create_pg 1.e4b
> pg 1.e4b now creating, ok
>
> As it went to creating state, no change after that. Can you explain why this
> PG showing null values after triggering "force_create_pg",?
>
> ]# ceph pg dump 2> /dev/null | grep 1.e4b
> 1.e4b         0                  0        0         0       0           0
> 0        0            creating 2017-03-30 19:07:00.982178         0'0
> 0:0                 []         -1                        []             -1
> 0'0                   0.000000             0'0                   0.000000
>
> Then I triggered below command
>
> # ceph pg  repair 1.e4b
> Error EAGAIN: pg 1.e4b has no primary osd  --<<
>
> Could you please provide answer for below queries.
>
> 1. How to fix this "incomplete+remapped" PG issue, here all OSD's were up
> and running and affected OSD marked out and removed from the cluster.
> 2. Will reduce min_size helps? currently it set to 4. Could you please
> explain what is the impact if we reduce min_size for the current config EC
> 4+1
> 3. Is there any procedure to safely remove an affected PG? As per my
> understanding I'm aware about this command.
>
> ===
> #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph --pgid 1.e4b --op
> remove
> ===
>
> Awaiting for your suggestions to proceed.
>
> Thanks
>
>
>
>
>
>
> On Thu, Mar 30, 2017 at 7:32 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>
>>
>>
>> On Thu, Mar 30, 2017 at 4:53 AM, nokia ceph <nokiacephusers@gmail.com>
>> wrote:
>> > Hello,
>> >
>> > Env:-
>> > 5 node, EC 4+1 bluestore kraken v11.2.0 , RHEL7.2
>> >
>> > As part of our resillency testing with kraken bluestore, we face more
>> > PG's
>> > were in incomplete+remapped state. We tried to repair each PG using
>> > "ceph pg
>> > repair <pgid>" still no luck. Then we planned to remove incomplete PG's
>> > using below procedure.
>> >
>> >
>> > #ceph health detail | grep  1.e4b
>> > pg 1.e4b is remapped+incomplete, acting [2147483647,66,15,73,2147483647]
>> > (reducing pool cdvr_ec min_size from 4 may help; search ceph.com/docs
>> > for
>> > 'incomplete')
>>
>> "Incomplete Ceph detects that a placement group is missing information
>> about
>> writes that may have occurred, or does not have any healthy copies. If you
>> see
>> this state, try to start any failed OSDs that may contain the needed
>> information."
>>
>> >
>> > Here we shutdown the OSD's 66,15 and 73 then proceeded with below
>> > operation.
>> >
>> > #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135 --op
>> > list-pgs
>> > #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135 --pgid
>> > 1.e4b
>> > --op remove
>> >
>> > Please confirm that we are following the correct procedure to removal of
>> > PG's
>>
>> There are multiple threads about that on this very list "pgs stuck
>> inactive"
>> recently for example.
>>
>> >
>> > #ceph pg stat
>> > v2724830: 4096 pgs: 1 active+clean+scrubbing+deep+repair, 1
>> > down+remapped,
>> > 21 remapped+incomplete, 4073 active+clean; 268 TB data, 371 TB used, 267
>> > TB
>> > / 638 TB avail
>> >
>> > # ceph -s
>> > 2017-03-29 18:23:44.288508 7f8c2b8e5700 -1 WARNING: the following
>> > dangerous
>> > and experimental features are enabled: bluestore,rocksdb
>> > 2017-03-29 18:23:44.304692 7f8c2b8e5700 -1 WARNING: the following
>> > dangerous
>> > and experimental features are enabled: bluestore,rocksdb
>> >     cluster bd8adcd0-c36d-4367-9efe-f48f5ab5f108
>> >      health HEALTH_ERR
>> >             22 pgs are stuck inactive for more than 300 seconds
>> >             1 pgs down
>> >             21 pgs incomplete
>> >             1 pgs repair
>> >             22 pgs stuck inactive
>> >             22 pgs stuck unclean
>> >      monmap e2: 5 mons at
>> >
>> > {au-adelaide=10.50.21.24:6789/0,au-brisbane=10.50.21.22:6789/0,au-canberra=10.50.21.23:6789/0,au-melbourne=10.50.21.21:6789/0,au-sydney=10.50.21.20:6789/0}
>> >             election epoch 172, quorum 0,1,2,3,4
>> > au-sydney,au-melbourne,au-brisbane,au-canberra,au-adelaide
>> >         mgr active: au-brisbane
>> >      osdmap e6284: 118 osds: 117 up, 117 in; 22 remapped pgs
>>
>> What is the status of the down+out osd? What role did/does it play? Most
>> importantly, is it osd.6?
>>
>> >             flags sortbitwise,require_jewel_osds,require_kraken_osds
>> >       pgmap v2724830: 4096 pgs, 1 pools, 268 TB data, 197 Mobjects
>> >             371 TB used, 267 TB / 638 TB avail
>> >                 4073 active+clean
>> >                   21 remapped+incomplete
>> >                    1 down+remapped
>> >                    1 active+clean+scrubbing+deep+repair
>> >
>> >
>> > #ceph osd dump | grep pool
>> > pool 1 'cdvr_ec' erasure size 5 min_size 4 crush_ruleset 1 object_hash
>> > rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags
>> > hashpspool,nodeep-scrub stripe_width 65536
>> >
>> >
>> >
>> > Can you please suggest is there any way to wipe out these incomplete
>> > PG's.
>>
>> See the thread previously mentioned. Take note of the force_create_pg
>> step.
>>
>> > Why ceph pg repair failed in this scenerio?
>> > How to recover incomplete PG's to active state.
>> >
>> > pg query for the affected PG ended with this error. Can you please
>> > explain
>> > what is meant by this ?
>> > ---
>> >                 "15(2)",
>> >                 "66(1)",
>> >                 "73(3)",
>> >                 "103(4)",
>> >                 "113(0)"
>> >             ],
>> >             "down_osds_we_would_probe": [
>> >                 6
>> >             ],
>> >             "peering_blocked_by": [],
>> >             "peering_blocked_by_detail": [
>> >                 {
>> >                     "detail": "peering_blocked_by_history_les_bound"
>> >                 }
>> > ----
>>
>> During multiple intervals osd 6 was in the up/acting set, for example;
>>
>>                 {
>>                     "first": 1608,
>>                     "last": 1645,
>>                     "maybe_went_rw": 1,
>>                     "up": [
>>                         113,
>>                         6,
>>                         15,
>>                         73,
>>                         103
>>                     ],
>>                     "acting": [
>>                         113,
>>                         6,
>>                         15,
>>                         73,
>>                         103
>>                     ],
>>                     "primary": 113,
>>                     "up_primary": 113
>>                 },
>>
>> Because we may have gone rw during that interval we need to query it and
>> it is blocking progress.
>>
>>             "blocked_by": [
>>                 6
>>             ],
>>
>> Setting osd_find_best_info_ignore_history_les to true may help but then
>> you may
>> need to mark the missing OSD lost or perform some other trickery (and this
>> . I
>> suspect your min_size is too low, especially for a cluster of this size,
>> but EC
>> is not an area I know extensively so I can't say definitively. Some of
>> your
>> questions may be better suited to the ceph-devel mailing list by the way.
>>
>> >
>> > Attaching "ceph pg 1.e4b query > /tmp/1.e4b-pg.txt" file with this mail.
>> >
>> > Thanks
>> >
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >
>>
>>
>>
>> --
>> Cheers,
>> Brad
>
>



-- 
Cheers,
Brad
