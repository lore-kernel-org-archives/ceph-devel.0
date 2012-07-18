From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Poor read performance in KVM
Date: Wed, 18 Jul 2012 08:27:55 -0700
Message-ID: <5006D5FB.8030700@inktank.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49192 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab2GRP17 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 11:27:59 -0400
Received: by yhmm54 with SMTP id m54so1673191yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 08:27:58 -0700 (PDT)
In-Reply-To: <50064DCD.8040904@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On 07/17/2012 10:46 PM, Vladimir Bashkirtsev wrote:
> On 16/07/12 15:46, Josh Durgin wrote:
>> On 07/15/2012 06:13 AM, Vladimir Bashkirtsev wrote:
>>> Hello,
>>>
>>> Lately I was trying to get KVM to perform well on RBD. But it still
>>> appears elusive.
>>>
>>> [root@alpha etc]# rados -p rbd bench 120 seq -t 8
>>>
>>> Total time run:        16.873277
>>> Total reads made:     302
>>> Read size:            4194304
>>> Bandwidth (MB/sec):    71.592
>>>
>>> Average Latency:       0.437984
>>> Max latency:           3.26817
>>> Min latency:           0.015786
>>>
>>> Fairly good performance. But when I run in KVM:
>>>
>>> [root@mail ~]# hdparm -tT /dev/vda
>>>
>>> /dev/vda:
>>>   Timing cached reads:   8808 MB in  2.00 seconds = 4411.49 MB/sec
>>
>> This is just the guest page cache - it's reading the first two
>> megabytes of the device repeatedly.
> Just to make sure there no issue with VM itself.
>>
>>>   Timing buffered disk reads:  10 MB in 6.21 seconds =   1.61 MB/sec
>>
>> This is a sequential read, so readahead in the guest should help here.
> Should but obviously does not.
>>
>>> Not even close to what rados bench show! I even seen 900KB/sec
>>> performance. Such slow read performance of course affecting guests.
>>>
>>> Any ideas where to start to look for performance boost?
>>
>> Do you have rbd caching enabled?
> rbd_cache=true:rbd_cache_size=134217728:rbd_cache_max_dirty=125829120
>> It would also be interesting to see
>> how the guest reads are translating to rados reads. hdparm is doing
>> 2MiB sequential reads of the block device. If you add
>> admin_socket=/var/run/ceph/kvm.asok to the rbd device on the qemu
>> command line) you can see number of requests, latency, and
>> request size info while the guest is running via:
>>
>> ceph --admin-daemon /var/run/ceph/kvm.asok perf dump
> Done that. Waited for VM to fully boot then got perf dump. It would be
> nice to get output in human readable format instead of JSON - I remember
> some other part of ceph had relevant command line switch. Does it exist
> for perf dump?
>
> {"librbd-rbd/kvm1":{"rd":0,"rd_bytes":0,"rd_latency":{"avgcount":0,"sum":0},"wr":0,"wr_bytes":0,"wr_latency":{"avgcount":0,"sum":0},"discard":0,"discard_bytes":0,"discard_latency":{"avgcount":0,"sum":0},"flush":0,"aio_rd":3971,"aio_rd_bytes":64750592,"aio_rd_latency":{"avgcount":3971,"sum":803.656},"aio_wr":91,"aio_wr_bytes":652288,"aio_wr_latency":{"avgcount":91,"sum":0.002977},"aio_discard":0,"aio_discard_bytes":0,"aio_discard_latency":{"avgcount":0,"sum":0},"snap_create":0,"snap_remove":0,"snap_rollback":0,"notify":0,"resize":0},"objectcacher-librbd-rbd/kvm1":{"cache_ops_hit":786,"cache_ops_miss":3189,"cache_bytes_hit":72186880,"cache_bytes_miss":61276672,"data_read":64750592,"data_written":652288,"data_flushed":648192,"data_overwritten_while_flushing":8192,"write_ops_blocked":0,"writ
 e_bytes_blocked":0,"write_time_blocked":0},"objecter":{"op_active":0,"op_laggy":0,"op_send":3271,"op_send_bytes":0,"op_resend":0,"op_ack":3270,"op_commit":78,"op":3271,"op_r":3194,"op_w":77,"op_rmw":
0,"op_pg":0,"osdop_stat":1,"osdop_create":0,"osdop_read":3191,"osdop_write":77,"osdop_writefull":0,"osdop_append":0,"osdop_zero":0,"osdop_truncate":0,"osdop_delete":0,"osdop_mapext":0,"osdop_sparse_read":0,"osdop_clonerange":0,"osdop_getxattr":0,"osdop_setxattr":0,"osdop_cmpxattr":0,"osdop_rmxattr":0,"osdop_resetxattrs":0,"osdop_tmap_up":0,"osdop_tmap_put":0,"osdop_tmap_get":0,"osdop_call":1,"osdop_watch":1,"osdop_notify":0,"osdop_src_cmpxattr":0,"osdop_pgls":0,"osdop_pgls_filter":0,"osdop_other":0,"linger_active":1,"linger_send":1,"linger_resend":0,"poolop_active":0,"poolop_send":0,"poolop_resend":0,"poolstat_active":0,"poolstat_send":0,"poolstat_resend":0,"statfs_active":0,"statfs_send":0,"statfs_resend":0,"map_epoch":0,"map_full":0,"map_inc":0,"osd_sessions":10,"osd_session_open":4,"osd
 _session_close":0,"osd_laggy":1},"throttle-msgr_dispatch_throttler-radosclient":{"val":0,"max":104857600,"get":3292,"get_sum":61673502,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum"
:0,"put":3292,"put_sum":61673502,"wait":{"avgcount":0,"sum":0}},"throttle-objecter_bytes":{"val":0,"max":104857600,"get":3271,"get_sum":61928960,"get_or_fail_fail":0,"get_or_fail_success":3271,"take":0,"take_sum":0,"put":3268,"put_sum":61928960,"wait":{"avgcount":0,"sum":0}},"throttle-objecter_ops":{"val":0,"max":1024,"get":3271,"get_sum":3271,"get_or_fail_fail":0,"get_or_fail_success":3271,"take":0,"take_sum":0,"put":3271,"put_sum":3271,"wait":{"avgcount":0,"sum":0}}}
>
>
> If my understanding is correct aio_rd is asynchrous read, latency in
> millisecons? Average read latency of 800ms is quite high! I remember in
> 1991 my 80MB HDD had similar read times - surely we are in 2012! :)

It's actually the sum of the latencies of all 3971 asynchronous reads,
in seconds, so the average latency was ~200ms, which is still pretty
high.

> Write latency appears to be excellent. Latency measured between KVM and
> librbd or between librbd and OSDs or between KVM and OSDs? Something
> tells me it is latter and thus it does not sched any light on where the
> problem is. Notably rados has max latency of just over 3ms. Does it mean
> that latency of 800ms comes from qemu-rbd driver?!

That's latency between KVM and the OSDs. The extra latency could be from
the callback to qemu or an artifact of this workload on the osds.
You can use the admin socket on the osds for 'perf dump' as well, and
check the 'op_r_latency' values, which is the latency between receiving
a request on the OSD and replying to it.

It may still sit in some network queues before being sent, so you may
want to enable debug_ms=1 for rbd. This will show each osd_op and the
corresponding osd_op_reply with a leading timestamp. You can tell
which ones go together by their transaction id, i.e.:

2012-07-17 17:39:21.813009 7f9174a30760  1 -- 192.168.106.222:0/1009333 
--> 192.168.106.222:6800/9134 -- osd_op(client.4104.0:20  [write 
4096~512] 3.bd49d10d) v4 -- ?+0 0x235ac90 con 0x234e530
2012-07-17 17:39:21.869671 7f9171093710  1 -- 192.168.106.222:0/1009333 
<== osd.0 192.168.106.222:6800/9134 20 ==== osd_op_reply(20  [write 
4096~512] ondisk = 0) v4 ==== 99+0+0 (1120882424 0 0) 0x235ac90 con 0x23
4e530

The transaction id is 20 here (seen in 'osd_op(client.4104.0:20' and 
'osd_op_reply(20'.

Getting latency from these debug logs will get you the time between the
client messenger layer sending the request to the osd and receiving the
osd's response, which includes the network queuing at both ends, but
does not include the qemu block driver callback like the 'perf dump'
does.

>
> Cache shows that 61MB of read data was missing from cache. Given total
> read was 64MB cache was effectively useless. However why cache_byte_hit
> shows 72MB? Where it went to?

That was some faulty accounting, adding each miss to both
cache_byte_hit and cache_byte_miss.

> And good question: where to from here?

Try to determine how much of the 200ms avg latency comes from osds vs
the qemu block driver.

Once the latency is under control, you might look into changing guest 
settings to send larger requests and readahead more.

Josh
