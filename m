From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Wed, 18 Jul 2012 15:16:53 +0930
Message-ID: <50064DCD.8040904@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:58885 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab2GRFwL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 01:52:11 -0400
In-Reply-To: <5003B1CC.4060909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 16/07/12 15:46, Josh Durgin wrote:
> On 07/15/2012 06:13 AM, Vladimir Bashkirtsev wrote:
>> Hello,
>>
>> Lately I was trying to get KVM to perform well on RBD. But it still
>> appears elusive.
>>
>> [root@alpha etc]# rados -p rbd bench 120 seq -t 8
>>
>> Total time run:        16.873277
>> Total reads made:     302
>> Read size:            4194304
>> Bandwidth (MB/sec):    71.592
>>
>> Average Latency:       0.437984
>> Max latency:           3.26817
>> Min latency:           0.015786
>>
>> Fairly good performance. But when I run in KVM:
>>
>> [root@mail ~]# hdparm -tT /dev/vda
>>
>> /dev/vda:
>>   Timing cached reads:   8808 MB in  2.00 seconds = 4411.49 MB/sec
>
> This is just the guest page cache - it's reading the first two
> megabytes of the device repeatedly.
Just to make sure there no issue with VM itself.
>
>>   Timing buffered disk reads:  10 MB in 6.21 seconds =   1.61 MB/sec
>
> This is a sequential read, so readahead in the guest should help here.
Should but obviously does not.
>
>> Not even close to what rados bench show! I even seen 900KB/sec
>> performance. Such slow read performance of course affecting guests.
>>
>> Any ideas where to start to look for performance boost?
>
> Do you have rbd caching enabled?
rbd_cache=true:rbd_cache_size=134217728:rbd_cache_max_dirty=125829120
> It would also be interesting to see
> how the guest reads are translating to rados reads. hdparm is doing
> 2MiB sequential reads of the block device. If you add
> admin_socket=/var/run/ceph/kvm.asok to the rbd device on the qemu
> command line) you can see number of requests, latency, and
> request size info while the guest is running via:
>
> ceph --admin-daemon /var/run/ceph/kvm.asok perf dump
Done that. Waited for VM to fully boot then got perf dump. It would be 
nice to get output in human readable format instead of JSON - I remember 
some other part of ceph had relevant command line switch. Does it exist 
for perf dump?

{"librbd-rbd/kvm1":{"rd":0,"rd_bytes":0,"rd_latency":{"avgcount":0,"sum":0},"wr":0,"wr_bytes":0,"wr_latency":{"avgcount":0,"sum":0},"discard":0,"discard_bytes":0,"discard_latency":{"avgcount":0,"sum":0},"flush":0,"aio_rd":3971,"aio_rd_bytes":64750592,"aio_rd_latency":{"avgcount":3971,"sum":803.656},"aio_wr":91,"aio_wr_bytes":652288,"aio_wr_latency":{"avgcount":91,"sum":0.002977},"aio_discard":0,"aio_discard_bytes":0,"aio_discard_latency":{"avgcount":0,"sum":0},"snap_create":0,"snap_remove":0,"snap_rollback":0,"notify":0,"resize":0},"objectcacher-librbd-rbd/kvm1":{"cache_ops_hit":786,"cache_ops_miss":3189,"cache_bytes_hit":72186880,"cache_bytes_miss":61276672,"data_read":64750592,"data_written":652288,"data_flushed":648192,"data_overwritten_while_flushing":8192,"write_ops_blocked":0,"write_
 bytes_blocked":0,"write_time_blocked":0},"objecter":{"op_active":0,"op_laggy":0,"op_send":3271,"op_send_bytes":0,"op_resend":0,"op_ack":3270,"op_commit":78,"op":3271,"op_r":3194,"op_w":77,"op_rmw":0,"op_pg":0,"osdop_stat":1,"osdop_create":0,"osdop_read":3191,"osdop_write":77,"osdop_writefull":0,"osdop_append":0,"osdop_zero":0,"osdop_truncate":0,"osdop_delete":0,"osdop_mapext":0,"osdop_sparse_read":0,"osdop_clonerange":0,"osdop_getxattr":0,"osdop_setxattr":0,"osdop_cmpxattr":0,"osdop_rmxattr":0,"osdop_resetxattrs":0,"osdop_tmap_up":0,"osdop_tmap_put":0,"osdop_tmap_get":0,"osdop_call":1,"osdop_watch":1,"osdop_notify":0,"osdop_src_cmpxattr":0,"osdop_pgls":0,"osdop_pgls_filter":0,"osdop_other":0,"linger_active":1,"linger_send":1,"linger_resend":0,"poolop_active":0,"poolop_send":0,"poolop_res
 end":0,"poolstat_active":0,"poolstat_send":0,"poolstat_resend":0,"statfs_active":0,"statfs_send":0,"statfs_resend":0,"map_epoch":0,"map_full":0,"map_inc":0,"osd_sessions":10,"osd_session_open":4,"osd_session_close":0,"osd_laggy":1},"throttle-msgr_dispatch_throttler-radosclient":{"val":0,"max":104857600,"get":3292,"get_sum":61673502,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":3292,"put_sum":61673502,"wait":{"avgcount":0,"sum":0}},"throttle-objecter_bytes":{"val":0,"max":104857600,"get":3271,"get_sum":61928960,"get_or_fail_fail":0,"get_or_fail_success":3271,"take":0,"take_sum":0,"put":3268,"put_sum":61928960,"wait":{"avgcount":0,"sum":0}},"throttle-objecter_ops":{"val":0,"max":1024,"get":3271,"get_sum":3271,"get_or_fail_fail":0,"get_or_fail_success":3271,"take"
 :0,"take_sum":0,"put":3271,"put_sum":3271,"wait":{"avgcount":0,"sum":0}}}

If my understanding is correct aio_rd is asynchrous read, latency in 
millisecons? Average read latency of 800ms is quite high! I remember in 
1991 my 80MB HDD had similar read times - surely we are in 2012! :) 
Write latency appears to be excellent. Latency measured between KVM and 
librbd or between librbd and OSDs or between KVM and OSDs? Something 
tells me it is latter and thus it does not sched any light on where the 
problem is. Notably rados has max latency of just over 3ms. Does it mean 
that latency of 800ms comes from qemu-rbd driver?!

Cache shows that 61MB of read data was missing from cache. Given total 
read was 64MB cache was effectively useless. However why cache_byte_hit 
shows 72MB? Where it went to?

And good question: where to from here?
>
> Josh



