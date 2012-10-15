From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Ceph benchmark high wait on journal device
Date: Mon, 15 Oct 2012 17:03:16 -0400
Message-ID: <CACkq2mr5QEoim0GUem2ML8211NLkTuePPrCHxPiZcX2DiDf78g@mail.gmail.com>
References: <507C35DE.7000308@tuxadero.com> <507C68F1.9000501@inktank.com> <507C743A.6050302@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:63996 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab2JOVDh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 17:03:37 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so1677918qaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 14:03:37 -0700 (PDT)
In-Reply-To: <507C743A.6050302@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Martin,

> btw.
>
> Is there a nice way to format the output of ceph --admin-daemon
> ceph-osd.0.asok perf_dump?

I use:

ceph --admin-daemon /var/run/ceph/ceph-osd.3.asok perf dump | python -mjson.tool

 - Travis


On Mon, Oct 15, 2012 at 4:38 PM, Martin Mailand <martin@tuxadero.com> wrote:
> Hi Mark,
>
> I think there is no differences between the 9266-8i and the 9265-8i, except
> for the cache vault and the angel of the SAS connectors.
> In the last test, which I posted, the SSDs where connected to the onboard
> SATA ports. Further test showed if I reduce the the object size (the -b
> option) to 1M, 512k, 256k the latency almost vanished.
> With 256k the w_wait was around 1ms.
> So my observation shows almost the different of yours.
>
> I use a singel controller with a dual expander backplane.
>
> That's the baby.
>
> http://85.214.49.87/ceph/testlab/IMAG0018.jpg
>
> btw.
>
> Is there a nice way to format the output of ceph --admin-daemon
> ceph-osd.0.asok perf_dump?
>
>
> -martin
>
> Am 15.10.2012 21:50, schrieb Mark Nelson:
>>
>> Hi Martin,
>>
>> I haven't tested the 9266-8i specifically, but it may behave similarly
>> to the 9265-8i.  This is just a theory, but I get the impression that
>> the controller itself introduces some latency getting data to disk, and
>> that it may get worse as the more data is pushed across the controller.
>> That seems to be the case even of the data is not going to the disk in
>> question.  Are you using a single controller with expanders?  On some of
>> our nodes that use a single controller with lots of expanders, I've
>> noticed high IO wait times, especially when doing lots of small writes.
>>
>> Mark
>>
>> On 10/15/2012 11:12 AM, Martin Mailand wrote:
>>>
>>> Hi,
>>>
>>> inspired from the performance test Mark did, I tried to compile my own
>>> one.
>>> I have four OSD processes on one Node, each process has a Intel 710 SSD
>>> for its journal and 4 SAS Disk via an Lsi 9266-8i in Raid 0.
>>> If I test the SSD with fio they are quite fast and the w_wait time is
>>> quite low.
>>> But if I run rados bench on the cluster, the w_wait times for the
>>> journal devices are quite high (around 20-40ms).
>>> I thought the SSD would be better, any ideas what happend here?
>>>
>>> -martin
>>>
>>> Logs:
>>>
>>> /dev/sd{c,d,e,f}
>>> Intel SSD 710 200G
>>>
>>> /dev/sd{g,h,i,j}
>>> each 4 x SAS on LSI 9266-8i Raid 0
>>>
>>> fio -name iops -rw=write -size=10G -iodepth 1 -filename /dev/sdc2
>>> -ioengine libaio -direct 1 -bs 256k
>>>
>>> Device: rrqm/s wrqm/s r/s w/s rMB/s wMB/s avgrq-sz avgqu-sz await
>>> r_await w_await svctm %util
>>> <- snip ->
>>> sdc 0,00 0,00 0,00 809,20 0,00 202,30 512,00 0,96 1,19 0,00 1,19 1,18
>>> 95,84
>>> <- snap ->
>>>
>>>
>>>
>>> rados bench -p rbd 300 write -t 16
>>>
>>> 2012-10-15 17:53:17.058383min lat: 0.035382 max lat: 0.469604 avg lat:
>>> 0.189553
>>> sec Cur ops started finished avg MB/s cur MB/s last lat avg lat
>>> 300 16 25329 25313 337.443 324 0.274815 0.189553
>>> Total time run: 300.169843
>>> Total writes made: 25329
>>> Write size: 4194304
>>> Bandwidth (MB/sec): 337.529
>>>
>>> Stddev Bandwidth: 25.1568
>>> Max bandwidth (MB/sec): 372
>>> Min bandwidth (MB/sec): 0
>>> Average Latency: 0.189597
>>> Stddev Latency: 0.0641609
>>> Max latency: 0.469604
>>> Min latency: 0.035382
>>>
>>>
>>> during the rados bench test.
>>>
>>> avg-cpu: %user %nice %system %iowait %steal %idle
>>> 20,38 0,00 16,20 8,87 0,00 54,55
>>>
>>> Device: rrqm/s wrqm/s r/s w/s rMB/s wMB/s avgrq-sz avgqu-sz await
>>> r_await w_await svctm %util
>>> sda 0,00 41,20 0,00 12,40 0,00 0,35 57,42 0,00 0,31 0,00 0,31 0,31 0,38
>>> sdb 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00
>>> sdc 0,00 0,00 0,00 332,80 0,00 139,67 859,53 7,36 22,09 0,00 22,09 2,12
>>> 70,42
>>> sdd 0,00 0,00 0,00 391,60 0,00 175,84 919,62 15,59 39,62 0,00 39,62 2,40
>>> 93,80
>>> sde 0,00 0,00 0,00 342,00 0,00 147,39 882,59 8,54 24,89 0,00 24,89 2,18
>>> 74,58
>>> sdf 0,00 0,00 0,00 362,20 0,00 162,72 920,05 15,35 42,50 0,00 42,50 2,60
>>> 94,20
>>> sdg 0,00 0,00 0,00 522,00 0,00 139,20 546,13 0,28 0,54 0,00 0,54 0,10
>>> 5,26
>>> sdh 0,00 0,00 0,00 672,00 0,00 179,20 546,13 9,67 14,42 0,00 14,42 0,61
>>> 41,18
>>> sdi 0,00 0,00 0,00 555,00 0,00 148,00 546,13 0,32 0,57 0,00 0,57 0,10
>>> 5,46
>>> sdj 0,00 0,00 0,00 582,00 0,00 155,20 546,13 0,51 0,87 0,00 0,87 0,12
>>> 6,96
>>>
>>> 100 seconds later
>>>
>>> avg-cpu: %user %nice %system %iowait %steal %idle
>>> 22,92 0,00 19,57 9,25 0,00 48,25
>>>
>>> Device: rrqm/s wrqm/s r/s w/s rMB/s wMB/s avgrq-sz avgqu-sz await
>>> r_await w_await svctm %util
>>> sda 0,00 40,80 0,00 15,60 0,00 0,36 47,08 0,00 0,22 0,00 0,22 0,22 0,34
>>> sdb 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00
>>> sdc 0,00 0,00 0,00 386,60 0,00 168,33 891,70 12,11 31,08 0,00 31,08 2,25
>>> 86,86
>>> sdd 0,00 0,00 0,00 405,00 0,00 183,06 925,68 15,68 38,70 0,00 38,70 2,34
>>> 94,90
>>> sde 0,00 0,00 0,00 411,00 0,00 185,06 922,15 15,58 38,09 0,00 38,09 2,33
>>> 95,92
>>> sdf 0,00 0,00 0,00 387,00 0,00 168,33 890,79 12,19 31,48 0,00 31,48 2,26
>>> 87,48
>>> sdg 0,00 0,00 0,00 646,20 0,00 171,22 542,64 0,42 0,65 0,00 0,65 0,10
>>> 6,70
>>> sdh 0,00 85,60 0,40 797,00 0,01 192,97 495,65 10,95 13,73 32,50 13,72
>>> 0,55 44,22
>>> sdi 0,00 0,00 0,00 678,20 0,00 180,01 543,59 0,45 0,67 0,00 0,67 0,10
>>> 6,76
>>> sdj 0,00 0,00 0,00 639,00 0,00 169,61 543,61 0,36 0,57 0,00 0,57 0,10
>>> 6,32
>>>
>>> --admin-daemon /var/run/ceph/ceph-osd.1.asok perf dump
>>>
>>> {"filestore":{"journal_queue_max_ops":500,"journal_queue_ops":0,"journal_ops":34653,"journal_queue_max_bytes":104857600,"journal_queue_bytes":0,"journal_bytes":86821481160,"journal_latency":{"avgcount":34653,"sum":3458.68},"journal_wr":19372,"journal_wr_bytes":{"avgcount":19372,"sum":87026655232},"op_queue_max_ops":500,"op_queue_ops":126,"ops":34653,"op_queue_max_bytes":104857600,"op_queue_bytes":167023,"bytes":86821143225,"apply_latency":{"avgcount":34527,"sum":605.768},"committing":0,"commitcycle":19,"commitcycle_interval":{"avgcount":19,"sum":572.674},"commitcycle_latency":{"avgcount":19,"sum":2.62279},"journal_full":0},"osd":{"opq":0,"op_wip":4,"op":15199,"op_in_bytes":36140461079,"op_out_bytes":0,"op_latency":{"avgcount":15199,"sum":1811.57},"op_r":0,"op_r_out_bytes":0,"op_r_laten
 cy":{"avgcount":0,"sum":0},"op_w":15199,"op_w_in_bytes":36140461079,"op_w_rlat":{"avgcount":15199,"sum":177.327},"op_w_latency":{"avgcount":15199,"sum":1811.57},"op_rw":0,"op_rw_in_bytes":0,!
>
> "op!
>>>
>>>
>>>
>>> _rw_out_
>>>
>>> bytes":0,"op_rw_rlat":{"avgcount":0,"sum":0},"op_rw_latency":{"avgcount":0,"sum":0},"subop":19258,"subop_in_bytes":50617887978,"subop_latency":{"avgcount":19258,"sum":2110.84},"subop_w":0,"subop_w_in_bytes":50617887978,"subop_w_latency":{"avgcount":19258,"sum":2110.84},"subop_pull":0,"subop_pull_latency":{"avgcount":0,"sum":0},"subop_push":0,"subop_push_in_bytes":0,"subop_push_latency":{"avgcount":0,"sum":0},"pull":0,"push":0,"push_out_bytes":0,"push_in":0,"push_in_bytes":0,"recovery_ops":0,"loadavg":7.36,"buffer_bytes":0,"numpg":501,"numpg_primary":214,"numpg_replica":287,"numpg_stray":0,"heartbeat_to_peers":3,"heartbeat_from_peers":0,"map_messages":10,"map_message_epochs":34,"map_message_epoch_dups":28},"throttle-filestore_bytes":{"val":0,"max":104857600,"get":0,"get_sum":0,"get_or_f
 ail_fail":0,"get_or_fail_success":0,"take":34653,"take_sum":86821481160,"put":19377,"put_sum":86821481160,"wait":{"avgcount":0,"sum":0}},"throttle-filestore_ops":{"val":0,"max":500,"get":0,"!
>
> get!
>>>
>>>
>>>
>>> _sum":0,"
>>>
>>> get_or_fail_fail":0,"get_or_fail_success":0,"take":34653,"take_sum":34653,"put":19377,"put_sum":34653,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-client":{"val":0,"max":104857600,"get":13798,"get_sum":36132522860,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":13798,"put_sum":36132522860,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-cluster":{"val":0,"max":104857600,"get":43047,"get_sum":50644298035,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":43047,"put_sum":50644298035,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbclient":{"val":0,"max":104857600,"get":924,"get_sum":43428,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":924,"put_sum":43428,"wait":{
 "avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbserver":{"val":0,"max":104857600,"get":924,"get_sum":43428,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put"!
>
> :92!
>>>
>>>
>>>
>>> 4,"put_su
>>>
>>> m":43428,"wait":{"avgcount":0,"sum":0}},"throttle-osd_client_bytes":{"val":0,"max":524288000,"get":13676,"get_sum":36132351923,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":22290,"put_sum":36132351923,"wait":{"avgcount":0,"sum":0}}}
>>>
>>>
>>>
>>> ceph.conf
>>>
>>> [global]
>>> pid file = /var/run/$name.pid
>>> debug ms = 0
>>> [mon]
>>> mon data = /data/mon.$id
>>> mon lease wiggle room = 1.0
>>> debug mon = 1
>>> [mon.a]
>>> host = 01-00-25-90-79-cc-ba
>>> mon addr = 10.100.42.111:6789
>>> [osd]
>>> osd data = /data/osd.$id
>>> debug osd = 1
>>> debug filestore = 1
>>> filestore max sync interval = 30
>>> filestore btrfs snap = true
>>> journal aio = true
>>> [osd.0]
>>> host = 01-00-25-90-79-cc-ba
>>> osd journal = /dev/sdc1
>>> btrfs devs = /dev/sdg
>>> btrfs options = noatime,nodatacow,autodefrag
>>> [osd.1]
>>> host = 01-00-25-90-79-cc-ba
>>> osd journal = /dev/sdd1
>>> btrfs devs = /dev/sdh
>>> btrfs options = noatime,nodatacow,autodefrag
>>> [osd.2]
>>> host = 01-00-25-90-79-cc-ba
>>> osd journal = /dev/sde1
>>> btrfs devs = /dev/sdi
>>> btrfs options = noatime,nodatacow,autodefrag
>>> [osd.3]
>>> host = 01-00-25-90-79-cc-ba
>>> osd journal = /dev/sdf1
>>> btrfs devs = /dev/sdj
>>> btrfs options = noatime,nodatacow,autodefrag
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
