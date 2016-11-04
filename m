From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: trying to get osd-scrub-repair to work on my jenkins builder
Date: Fri, 4 Nov 2016 21:09:07 +0100
Message-ID: <69f67e0d-b9bf-a0ed-0eb2-200e2aaeba69@digiware.nl>
References: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
 <b25d133d-8505-0ba4-c203-467b77104abb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:44564 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756178AbcKDUYe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 16:24:34 -0400
In-Reply-To: <b25d133d-8505-0ba4-c203-467b77104abb@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 4-11-2016 20:39, David Zafman wrote:
> 
> I'm working a similar problem with the test-erasure-eio.sh test which
> only fails on Jenkins.  I have a pg that is active+degraded and then
> active+recovery_wait+degraded.  In this case the hinfo is missing after
> osds are brought up and down in order to use the ceph-objectstore-tool
> to implement the test cases.  On Jenkins the osd restarting causes
> different pg mappings then on my build machine and recovery can't make
> progress.
> 
> See if you see these message in the osd log of the primary of the pg (in
> your example below that would be osd.3:
> 
> handle_sub_read_reply shard=1(1) error=-5
> 
> _failed_push: canceling recovery op for obj ...

I have something like 250.000 !!! lines looking like:

2016-11-04 18:09:52.769091 ba9c480 10 osd.3 pg_epoch: 117 pg[2.0s0( v
72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
[3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
0'0 active+recovering+degraded] _failed_push: canceling recovery op for
obj 2:eb822e21:::SOMETHING:head

And another fragment is:
2016-11-04 17:55:00.233049 ba6ad00 10 osd.3 pg_epoch: 117 pg[2.0s0( v
72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
[3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
0'0 active+recovering+degraded] handle_message:
MOSDECSubOpReadReply(2.0s0 117 ECSubReadReply(tid=14, attrs_read=0)) v1
2016-11-04 17:55:00.233099 ba6ad00 10 osd.3 pg_epoch: 117 pg[2.0s0( v
72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
[3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
0'0 active+recovering+degraded] handle_sub_read_reply: reply
ECSubReadReply(tid=14, attrs_read=0)
2016-11-04 17:55:00.233150 ba6ad00 20 osd.3 pg_epoch: 117 pg[2.0s0( v
72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
[3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
0'0 active+recovering+degraded] handle_sub_read_reply shard=9(2) error=-2
2016-11-04 17:55:00.233200 ba6ad00 10 osd.3 pg_epoch: 117 pg[2.0s0( v
72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
[3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
0'0 active+recovering+degraded] handle_sub_read_reply readop not
complete: ReadOp(tid=14,
to_read={2:eb822e21:::SOMETHING:head=read_request_t(to_read=[0,8388608,0],
need=0(3),3(0),6(4),9(2), want_attrs=1)},
complete={2:eb822e21:::SOMETHING:head=read_result_t(r=0,
errors={9(2)=-2}, noattrs, returned=(0, 8388608, [3(0),1024]))},
priority=3,
obj_to_source={2:eb822e21:::SOMETHING:head=0(3),3(0),6(4),9(2)},
source_to_obj={0(3)=2:eb822e21:::SOMETHING:head,3(0)=2:eb822e21:::SOMETHING:head,6(4)=2:eb822e21:::SOMETHING:head,9(2)=2:eb822e21:::SOMETHING:head},
in_progress=0(3),6(4))

I can post (a part of) the 7Gb logfile for you to have a look at.

--WjW

> On 11/4/16 10:09 AM, Willem Jan Withagen wrote:
>> Hi,
>>
>> On my workstation if have this tst completing just fine. But on my
>> Jenkins-builder it keeps running into this state where it does not make
>> any progress.
>> Any particulars I should look for? I can let this run for an hour, but
>> pg 2.0 stays active+degrades, and the script requires it to be clean.
>> and the pgmap version is steadily incrementing.
>>
>> What should be in the log files that points me to the problem?
>>
>> Thanx,
>> --WjW
>>
>>
>>      cluster 667960a1-a2ae-11e6-a834-69c386980813
>>       health HEALTH_WARN
>>              1 pgs degraded
>>              1 pgs stuck degraded
>>              1 pgs stuck unclean
>>              recovery 2/6 objects degraded (33.333%)
>>              too few PGs per OSD (1 < min 30)
>>            
>> noscrub,nodeep-scrub,sortbitwise,require_jewel_osds,require_kraken_osds
>> flag(s) set
>>       monmap e1: 1 mons at {a=127.0.0.1:7107/0}
>>              election epoch 3, quorum 0 a
>>          mgr no daemons active
>>       osdmap e117: 10 osds: 10 up, 10 in
>>              flags
>> noscrub,nodeep-scrub,sortbitwise,require_jewel_osds,require_kraken_osds
>>        pgmap v674: 5 pgs, 2 pools, 7 bytes data, 1 objects
>>              60710 MB used, 2314 GB / 2374 GB avail
>>              2/6 objects degraded (33.333%)
>>                     4 active+clean
>>                     1 active+degraded
>>
>> PG_STAT OBJECTS MISSING_ON_PRIMARY DEGRADED MISPLACED UNFOUND BYTES LOG
>> DISK_LOG STATE           STATE_STAMP                VERSION REPORTED
>> UP            UP_PRIMARY ACTING        ACTING_PRIMARY LAST_SCRUB
>> SCRUB_STAMP                LAST_DEEP_SCRUB DEEP_SCRUB_STAMP
>> 122: 2.0           1                  0        2         0       0
>> 7   1        1 active+degraded 2016-11-04 17:55:00.190833    72'1
>> 117:139 [3,1,9,0,6,2]          3 [3,1,9,0,6,2]              3       72'1
>> 2016-11-04 17:54:37.943943            72'1 2016-11-04 17:54:37.943943
>> 122: 1.3           0                  0        0         0       0
>> 0   0        0    active+clean 2016-11-04 17:55:00.321568     0'0
>> 117:139       [4,1,5]          4       [4,1,5]              4        0'0
>> 2016-11-04 17:52:24.704377             0'0 2016-11-04 17:52:24.704377
>> 122: 1.2           0                  0        0         0       0
>> 0   0        0    active+clean 2016-11-04 17:55:00.249497     0'0
>> 117:188       [0,5,9]          0       [0,5,9]              0        0'0
>> 2016-11-04 17:52:24.704324             0'0 2016-11-04 17:52:24.704324
>> 122: 1.1           0                  0        0         0       0
>> 0   0        0    active+clean 2016-11-04 17:55:00.133525     0'0
>> 116:7       [7,3,8]          7       [7,3,8]              7        0'0
>> 2016-11-04 17:52:24.704269             0'0 2016-11-04 17:52:24.704269
>> 122: 1.0           0                  0        0         0       0
>> 0   0        0    active+clean 2016-11-04 17:53:18.409300     0'0
>> 60:7       [8,0,2]          8       [8,0,2]              8        0'0
>> 2016-11-04 17:52:24.704159             0'0 2016-11-04 17:52:24.704159
>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

