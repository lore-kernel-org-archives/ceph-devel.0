From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: SimpleMessenger dispatching: cause of performance problems?
Date: Fri, 17 Aug 2012 14:01:59 +0200
Message-ID: <502E32B7.7070502@itxperts.de>
References: <502D1B07.3030101@itxperts.de> <CAC-hyiFgdD8EcF1uonkdbAwshDh87aP3NjXBvCPv3gbW7XpazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:41147 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2HQMCH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 08:02:07 -0400
In-Reply-To: <CAC-hyiFgdD8EcF1uonkdbAwshDh87aP3NjXBvCPv3gbW7XpazQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Yehuda,

I don't think throttling is the issue here.
The default thottle count is 100 MByte (100 << 20), it I read the source 
correctly.

My simple sequential write writes 40 MBytes in total.
Spread over 4 OSDs with 2 replicas this should amount to roughly 20 
MBytes per OSD.

Also I encounter the described behaviour already at the very beginning 
of the test.

Currently I am trying to use perf (as Sage suggested). However, this is 
causing some
funny effect, too: I run

   perf record -g -- /usr/bin/ceph-osd -f -i 2 --pid-file 
/var/run/ceph/osd.2.pid -c /tmp/ceph.conf.7278

on one the OSDs (osd.2). When I start the test, then the client system 
panics within the
kernel client - but the client is on a physically different system than 
osd.2.

[  405.139931] Call Trace:
[  405.145497]  [<ffffffffa05be3c3>] __send_request+0xb3/0x100 [libceph]
[  405.159848]  [<ffffffffa05be463>] send_queued+0x53/0x90 [libceph]
[  405.173429]  [<ffffffffa05c0730>] ceph_osdc_handle_map+0x290/0x530 
[libceph]
[  405.189133]  [<ffffffffa05bcdef>] dispatch+0xdf/0x120 [libceph]
[  405.202332]  [<ffffffffa05b6fd9>] process_message+0x89/0x1a0 [libceph]
[  405.216886]  [<ffffffffa05b9d68>] try_read+0x478/0x680 [libceph]
[  405.230273]  [<ffffffffa05bab1e>] con_work+0x6e/0x240 [libceph]
[  405.244876]  [<ffffffff81073f2c>] process_one_work+0x16c/0x350
[  405.257897]  [<ffffffff81076aba>] worker_thread+0x17a/0x410
[  405.270346]  [<ffffffff8107ade6>] kthread+0x96/0xa0
[  405.281248]  [<ffffffff8144a4c4>] kernel_thread_helper+0x4/0x10
[  405.295035] DWARF2 unwinder stuck at kernel_thread_helper+0x4/0x10

I don't see this panic when I start the osd without perf. This looks as 
if perf affects
the osd performance such that this causes some different code on the 
client side to
be executed.

The kernel modules on the client side report:
CIBDB1:~ # modinfo ceph
filename:       
/lib/modules/3.0.34-0.7-default/weak-updates/updates/ceph-kmp/fs/ceph/ceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     104662BE3ADB1ED236E1E83
depends:        libceph
supported:      yes
vermagic:       3.0.13-0.27-default SMP mod_unload modversions
CIBDB1:~ # modinfo rbd
filename:       
/lib/modules/3.0.34-0.7-default/weak-updates/updates/ceph-kmp/rbd.ko
license:        GPL
author:         Jeff Garzik <jeff@garzik.org>
description:    rados block device
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     0A1B0E7CE75C7F733B74137
depends:        libceph
supported:      yes
vermagic:       3.0.13-0.27-default SMP mod_unload modversions
CIBDB1:~ # modinfo libceph
filename:       
/lib/modules/3.0.34-0.7-default/weak-updates/updates/ceph-kmp/net/ceph/libceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     B31E02E58425C6E7487CA22
depends:        libcrc32c
supported:      yes
vermagic:       3.0.13-0.27-default SMP mod_unload modversions


Best Regards

Andreas

Yehuda Sadeh wrote:
> On Thu, Aug 16, 2012 at 9:08 AM, Andreas Bluemle
> <andreas.bluemle@itxperts.de> wrote:
>   
>> Hi,
>>
>> I have been trying to migrate a ceph cluster (ceph-0.48argonaut)
>> to a high speed cluster network and encounter scalability problems:
>> the overall performance of the ceph cluster does not scale well
>> with an increase in the underlying networking speed.
>>
>> In short:
>>
>> I believe that the dispatching from SimpleMessenger to
>> OSD worker queues causes that scalability issue.
>>
>> Question: is it possible that this dispatching is causing performance
>> problems?
>>
>>
>> In detail:
>>
>> In order to find out more about this problem, I have added profiling to
>> the ceph code in various place; for write operations to the primary or the
>> secondary, timestamps are recorded for OSD object, offset and length of
>> the such a write request.
>>
>> Timestamps record:
>>  - receipt time at SimpleMessenger
>>  - processing time at osd
>>  - for primary write operations: wait time until replication operation
>>    is acknowledged.
>>     
>
> Did you make any code changes? We'd love to see those.
>
>   
>> What I believe is happening: dispatching requests from SimpleMessenger to
>> OSD worker threads seems to consume a fair amount of time. This ends
>> up in a widening gap between subsequent receipts of requests and the start
>> of OSD processing them.
>>
>> A primary write suffers twice from this problem: first because
>> the delay happens on the primary OSD and second because the replicating
>> OSD also suffers from the same problem - and hence causes additional
>> delays
>> at the primary OSD when it waits for the commit from the replicating OSD.
>>
>> In the attached graphics, the x-axis shows the time (in seconds)
>> The y-axis shows the offset where a request to write happened.
>>
>> The red bar represents the SimpleMessenger receive, i.e. from reading
>> the message header until enqueuing the completely decoded message into
>> the SImpleMessenger dispatch queue.
>>     
>
> Could it be that messages were throttled here?
> There's a configurable that can be set (ms dispatch throttle bytes), might
> affect that.
>
>   
>> The green bar represents the time required for local processing, i.e.
>> dispatching the the OSD worker, writing to filesystem and journal, send
>> out the replication operation to the replicating OSD. It right
>> end of the green bar is the time when locally everything has finished
>> and a commit could happen.
>>
>> The blue bar represents the time until the replicating OSD has sent a
>> commit
>> back to the primary OSD and the original write request can be committed to
>> the client.
>>
>> The green bar is interrupted by a black bar: the left end represents
>> the time when the request has been enqueued on the OSD worker queue. The
>> right end gives the time when the request is taken off the OSD worker
>> queue and actual OSD processing starts.
>>
>> The test was a simple sequential write to a rados block device.
>>
>> Receiption of the write requests at the OSD is also sequential in the
>> graphics: the bar to the bottom of the graphics shows an earlier write
>> request.
>>
>> Note that the dispatching of a later request in all cases relates to the
>> enqueue time at the OSD worker queue of the previous write request: the
>> left
>> end of a black bar relates nicely to the beginning of a green bar above
>> it.
>>
>>
>>     
>
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   


-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm

