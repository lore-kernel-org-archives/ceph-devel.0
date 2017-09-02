From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: Rados bench with a failed node
Date: Sat, 2 Sep 2017 15:46:52 +0300
Message-ID: <CAODUPsEfsO4t3b-EXm0btYzDiN_aDQpTmuC0zsGNu3vbQ6DJ8A@mail.gmail.com>
References: <CAODUPsHkC153vq5O7TKjt+ZTgMofsyR7m7hdKdi2ASbKTMWpRg@mail.gmail.com>
 <alpine.DEB.2.11.1708011319590.20435@piezo.novalocal> <CAODUPsGuq4o7PtH4JuHBPPLk70NkzHRNGpvEQwZYraZwmPT3Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34161 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbdIBMqy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Sep 2017 08:46:54 -0400
Received: by mail-oi0-f45.google.com with SMTP id w10so18842574oie.1
        for <ceph-devel@vger.kernel.org>; Sat, 02 Sep 2017 05:46:53 -0700 (PDT)
In-Reply-To: <CAODUPsGuq4o7PtH4JuHBPPLk70NkzHRNGpvEQwZYraZwmPT3Cg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
I've rebuilt my code to fix the issues I had with rados bench and to
match CRUSH rule (so shards are placed as in lrc).
I'm running 'rados bench' and while reading I kill an osd and measure
cluster recovery.
The experiment runs well on the vstart.sh virtual cluster however I
have a failure in the real cluster running with 40 osds.
I've tested the reconstruction of my code, writing an object and
reading it while one of the osds is down (in noout) - that has also
worked.

I've seen the following error in the log:

 osd.37 634 enqueue_op 0x7fbe2261c520 prio 127 cost 0 latency 0.303431
epoch 634 MOSDECSubOpReadReply(17.13bs0 634/632
ECSubReadReply(tid=182, attrs_read=0)) v2
 osd.37 op_wq(0) _enqueue 17.13bs0 PGQueueable(0x7fbe2261c520 prio 127
cost 0 e634)
 osd.37 op_wq(0) _process 17.13bs0 item PGQueueable(0x7fbe2261c520
prio 127 cost 0 e634) queued
 osd.37 op_wq(0) _process 17.13bs0 item PGQueueable(0x7fbe2261c520
prio 127 cost 0 e634) pg 0x7fbe2040d000
 osd.37 634 dequeue_op 0x7fbe2261c520 prio 127 cost 0 latency 0.303503
MOSDECSubOpReadReply(17.13bs0 634/632 ECSubReadReply(tid=182,
attrs_read=0)) v2 pg pg[17.13bs0( v 628'1 (0'0,628'1] local-li
 osd.37 634 share_map osd.2 172.31.20.174:6805/1908 634
 osd.37 634 should_share_map osd.2 172.31.20.174:6805/1908 634
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 634 dequeue_op 0x7fbe2261c520 finish
 osd.37 op_wq(0) _process empty q, waiting
 osd.37 634 enqueue_op 0x7fbe203f2ec0 prio 127 cost 0 latency 0.329054
epoch 634 MOSDECSubOpReadReply(17.13bs0 634/632
ECSubReadReply(tid=182, attrs_read=0)) v2
 osd.37 op_wq(0) _enqueue 17.13bs0 PGQueueable(0x7fbe203f2ec0 prio 127
cost 0 e634)
 osd.37 op_wq(0) _process 17.13bs0 item PGQueueable(0x7fbe203f2ec0
prio 127 cost 0 e634) queued
 osd.37 op_wq(0) _process 17.13bs0 item PGQueueable(0x7fbe203f2ec0
prio 127 cost 0 e634) pg 0x7fbe2040d000
 osd.37 634 dequeue_op 0x7fbe203f2ec0 prio 127 cost 0 latency 0.329081
MOSDECSubOpReadReply(17.13bs0 634/632 ECSubReadReply(tid=182,
attrs_read=0)) v2 pg pg[17.13bs0( v 628'1 (0'0,628'1] local-li
 osd.37 634 share_map osd.14 172.31.89.11:6805/1033 634
 osd.37 634 should_share_map osd.14 172.31.89.11:6805/1033 634
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 log_channel(cluster) log [ERR] : handle_sub_read_reply: Error(s)
ignored for 17:dcd09fc8:::benchmark_data_adm-1_14964_object2:head
enough copies available
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0
 osd.37 pg_epoch: 634 pg[17.13bs0( v 628'1 (0'0,628'1]
local-lis/les=632/633 n=1 ec=625/625 lis/c 632/632 les/c/f 633/633/0
632/632/625) [37,14,32,39,2,23,35,30,27] r=0 lpr=632 crt=628'1 lcod
0'0



I've brought down osd.1 and it was replaced by osd.39. But when trying
to read the object osd.39 causes a problem for some reason (data
shards are 0,1,3,4. osd.39 contains shard 3).  I should also mention
that the cluster recovers successfully in this experiment (reaches
HEALTH_OK).
I would think that something is wrong with my code, but as I've
mentioned both virtual cluster and specific object read are working.

Thanks,
Oleg

On Wed, Aug 2, 2017 at 11:54 AM, Oleg Kolosov <olekol@gmail.com> wrote:
> Hi Sage,
> You are correct! The problem is indeed only for my erasure code,
> however I'm not sure what it is.
> I've reproduced the issue in the virtual cluster created by vstart.sh
>  (logging enabled)
> I've compared the logs of all OSDs with my erasure code versus a
> similar implementation of lrc - however there were no visible
> differences.
> Any tips on what should I look for?
> What might affect this in erasure code source code?
>
> Another iteresting thing I'm seeing is that even cleanup fails:
>
>>  bin/rados -p optlrcpool cleanup
> error during cleanup: -5
> error 5: (5) Input/output error
>
> This only occurs when I set 'noout' & stop and osd and then write and
> read with the benchmark.
>
>
> I should mentioned that my erasure code works properly besides this
> experiment. It manages to recover from a failed node during normal
> mode of operation.
>
> Thanks,
> Oleg
>
> On Tue, Aug 1, 2017 at 4:21 PM, Sage Weil <sage@newdream.net> wrote:
>> On Tue, 1 Aug 2017, Oleg Kolosov wrote:
>>> Hi
>>> I'm developing my own erasure code and I'm trying to run rados
>>> benchmark on it. My experiment consists of writing objects, then while
>>> reading them I stop an OSD and see how it affects latency.
>>> While running this experiment with 'rados bench' I get an error after
>>> stopping the osd:
>>>
>>> benchmark_data_adm-1_3806_object8 is not correct!
>>> read got -5
>>> error during benchmark: -5
>>> error 5: (5) Input/output error
>>>
>>> Is it expected to fail like this?
>>
>> It's hard to say what's happening without logs, but my guess would be that
>> your erasure code isn't correctly reconstructing the stripe when a
>> shard is missing.
>>
>>> Is there a way to bypass it or somehow perform my experiment?
>>
>> If it's what I'm guessing, not really... nor would you want to.  I would
>> enable osd logging to see where the EIO is coming from.
>>
>> sage
