From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Thu, 19 Jul 2012 20:16:02 +0930
Message-ID: <5007E56A.6030509@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:42001 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2GSKqR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 06:46:17 -0400
In-Reply-To: <5006D5FB.8030700@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org


> It's actually the sum of the latencies of all 3971 asynchronous reads,
> in seconds, so the average latency was ~200ms, which is still pretty
> high.
OK. I did realize it later that day when I've noticed that sum does go 
up only. So sum is number of seconds spent and divided by avgcount gives 
an idea of average latency. I guess same is used everywhere else.
>
> That's latency between KVM and the OSDs. The extra latency could be from
> the callback to qemu or an artifact of this workload on the osds.
> You can use the admin socket on the osds for 'perf dump' as well, and
> check the 'op_r_latency' values, which is the latency between receiving
> a request on the OSD and replying to it.
osd.0 latency 0.121423775
         "op_r_latency": {
             "avgcount": 25018,
             "sum": 3037.78
         },
osd.3 latency 0.075055975
          "op_r_latency": {
             "avgcount": 3597595,
             "sum": 270021
         },

osd.0 was restarted recently, osd.3 runs for few days.
>
> It may still sit in some network queues before being sent, so you may
> want to enable debug_ms=1 for rbd. This will show each osd_op and the
> corresponding osd_op_reply with a leading timestamp. You can tell
> which ones go together by their transaction id, i.e.:
>
> 2012-07-17 17:39:21.813009 7f9174a30760  1 -- 
> 192.168.106.222:0/1009333 --> 192.168.106.222:6800/9134 -- 
> osd_op(client.4104.0:20  [write 4096~512] 3.bd49d10d) v4 -- ?+0 
> 0x235ac90 con 0x234e530
> 2012-07-17 17:39:21.869671 7f9171093710  1 -- 
> 192.168.106.222:0/1009333 <== osd.0 192.168.106.222:6800/9134 20 ==== 
> osd_op_reply(20  [write 4096~512] ondisk = 0) v4 ==== 99+0+0 
> (1120882424 0 0) 0x235ac90 con 0x23
> 4e530
>
> The transaction id is 20 here (seen in 'osd_op(client.4104.0:20' and 
> 'osd_op_reply(20'.
>
Done that... Log excerpt below. Appears to be in line with what rados 
bench says: latency is in millisecond range. Manual glance over roughly 
4000 requests at random spots just confirms that latency is low on OSD.

To run this test I have:
1. Migrated out all VMs from the host except one which I am testing
2. Put debug_ms=1 in ceph.conf and restarted ceph (mon, mds, osd - all 
running on this host).

I am not sure that ceph-osd.0.log cointains information we looking for: 
ie it appears in reverse to your example. May be I need to look 
somewhere else? My thinking is that osd log is done by osd and thus does 
not include any network latency.

ceph-osd.0.log:2012-07-19 19:09:52.899706 7fb261ffb700  1 -- 
172.16.64.200:6802/17408 <== client.159051 172.16.64.200:0/1021101 376 
==== osd_op(client.159051.0:1427 rb.0.7.000000000000 [read 1282048~4096] 
2.c8eaa480) v4 ==== 158+0+0 (4291909772 0 0) 0x7fb16c001000 con 
0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.899912 7fb25e7f4700  1 -- 
172.16.64.200:6802/17408 --> 172.16.64.200:0/1021101 -- 
osd_op_reply(1427 rb.0.7.000000000000 [read 1282048~4096] = 0) v4 -- ?+0 
0x7fb2408e2000 con 0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.900254 7fb261ffb700  1 -- 
172.16.64.200:6802/17408 <== client.159051 172.16.64.200:0/1021101 377 
==== osd_op(client.159051.0:1428 rb.0.7.000000000000 [read 1286144~4096] 
2.c8eaa480) v4 ==== 158+0+0 (1278691322 0 0) 0x7fb16c001400 con 
0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.900451 7fb25eff5700  1 -- 
172.16.64.200:6802/17408 --> 172.16.64.200:0/1021101 -- 
osd_op_reply(1428 rb.0.7.000000000000 [read 1286144~4096] = 0) v4 -- ?+0 
0x7fb24dbd9570 con 0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.900815 7fb261ffb700  1 -- 
172.16.64.200:6802/17408 <== client.159051 172.16.64.200:0/1021101 378 
==== osd_op(client.159051.0:1429 rb.0.7.000000000000 [read 1290240~4096] 
2.c8eaa480) v4 ==== 158+0+0 (3727777927 0 0) 0x7fb16c001000 con 
0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.901016 7fb25e7f4700  1 -- 
172.16.64.200:6802/17408 --> 172.16.64.200:0/1021101 -- 
osd_op_reply(1429 rb.0.7.000000000000 [read 1290240~4096] = 0) v4 -- ?+0 
0x7fb2403d14e0 con 0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.901359 7fb261ffb700  1 -- 
172.16.64.200:6802/17408 <== client.159051 172.16.64.200:0/1021101 379 
==== osd_op(client.159051.0:1430 rb.0.7.000000000000 [read 1294336~4096] 
2.c8eaa480) v4 ==== 158+0+0 (773263335 0 0) 0x7fb16c001400 con 
0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.901557 7fb25eff5700  1 -- 
172.16.64.200:6802/17408 --> 172.16.64.200:0/1021101 -- 
osd_op_reply(1430 rb.0.7.000000000000 [read 1294336~4096] = 0) v4 -- ?+0 
0x7fb24e311050 con 0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.901917 7fb261ffb700  1 -- 
172.16.64.200:6802/17408 <== client.159051 172.16.64.200:0/1021101 380 
==== osd_op(client.159051.0:1431 rb.0.7.000000000000 [read 1298432~4096] 
2.c8eaa480) v4 ==== 158+0+0 (3155241114 0 0) 0x7fb16c001000 con 
0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.902120 7fb25e7f4700  1 -- 
172.16.64.200:6802/17408 --> 172.16.64.200:0/1021101 -- 
osd_op_reply(1431 rb.0.7.000000000000 [read 1298432~4096] = 0) v4 -- ?+0 
0x7fb2414137d0 con 0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.902462 7fb261ffb700  1 -- 
172.16.64.200:6802/17408 <== client.159051 172.16.64.200:0/1021101 381 
==== osd_op(client.159051.0:1432 rb.0.7.000000000000 [read 1302528~4096] 
2.c8eaa480) v4 ==== 158+0+0 (267859948 0 0) 0x7fb16c001400 con 
0x7fb22c004b10
ceph-osd.0.log:2012-07-19 19:09:52.902685 7fb25eff5700  1 -- 
172.16.64.200:6802/17408 --> 172.16.64.200:0/1021101 -- 
osd_op_reply(1432 rb.0.7.000000000000 [read 1302528~4096] = 0) v4 -- ?+0 
0x7fb24e393960 con 0x7fb22c004b10


----------------------------

10 minutes later

Same setup but this time I checking ceph-osd.1.log and here funny things 
start:

ceph-osd.1.log:2012-07-19 20:08:55.711596 7f395f7fe700  1 -- 
172.16.64.201:6801/10316 <== client.159124 172.16.64.200:0/1023686 1082 
==== osd_op(client.159124.0:3617 rb.0.7.0000000006a0 [read 2699264~4096] 
2.8a53450e) v4 ==== 158+0+0 (2262544758 0 0) 0x7f385c0047f0 con 
0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:08:55.840296 7f395f7fe700  1 -- 
172.16.64.201:6801/10316 <== client.159124 172.16.64.200:0/1023686 1083 
==== osd_op(client.159124.0:3623 rb.0.7.00000000069e [read 2162688~4096] 
2.5a790d97) v4 ==== 158+0+0 (592881250 0 0) 0x7f385c004c80 con 
0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:08:55.847014 7f394f7fe700  1 -- 
172.16.64.201:6801/10316 --> 172.16.64.200:0/1023686 -- 
osd_op_reply(3623 rb.0.7.00000000069e [read 2162688~4096] = 0) v4 -- ?+0 
0x7f39385f9420 con 0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:08:55.847936 7f395f7fe700  1 -- 
172.16.64.201:6801/10316 <== client.159124 172.16.64.200:0/1023686 1084 
==== osd_op(client.159124.0:3624 rb.0.7.00000000069e [read 2166784~4096] 
2.5a790d97) v4 ==== 158+0+0 (2974843167 0 0) 0x7f385c005110 con 
0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:08:55.874587 7f394f7fe700  1 -- 
172.16.64.201:6801/10316 --> 172.16.64.200:0/1023686 -- 
osd_op_reply(3624 rb.0.7.00000000069e [read 2166784~4096] = 0) v4 -- ?+0 
0x7f39385f9420 con 0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:08:56.082832 7f394ffff700  1 -- 
172.16.64.201:6801/10316 --> 172.16.64.200:0/1023686 -- 
osd_op_reply(3617 rb.0.7.0000000006a0 [read 2699264~4096] = 0) v4 -- ?+0 
0x7f3945abc050 con 0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:08:56.165947 7f395f7fe700  1 -- 
172.16.64.201:6801/10316 <== client.159124 172.16.64.200:0/1023686 1085 
==== osd_op(client.159124.0:3635 rb.0.7.0000000004a4 [read 20480~4096] 
2.90c38a47) v4 ==== 158+0+0 (3621913351 0 0) 0x7f385c0055a0 con 
0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:08:56.222705 7f394f7fe700  1 -- 
172.16.64.201:6801/10316 --> 172.16.64.200:0/1023686 -- 
osd_op_reply(3635 rb.0.7.0000000004a4 [read 20480~4096] = 0) v4 -- ?+0 
0x7f39385f9420 con 0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:09:14.899024 7f395f7fe700  1 -- 
172.16.64.201:6801/10316 <== client.159124 172.16.64.200:0/1023686 1093 
==== osd_op(client.159124.0:3670 rb.0.7.000000000cb4 [read 
2367488~16384] 2.75848b4b) v4 ==== 158+0+0 (276134829 0 0) 
0x7f385c0008c0 con 0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:09:22.507585 7f394f7fe700  1 -- 
172.16.64.201:6801/10316 --> 172.16.64.200:0/1023686 -- 
osd_op_reply(3670 rb.0.7.000000000cb4 [read 2367488~16384] = 0) v4 -- 
?+0 0x7f39382c84c0 con 0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:09:43.314805 7f395f7fe700  1 -- 
172.16.64.201:6801/10316 <== client.159124 172.16.64.200:0/1023686 1094 
==== osd_op(client.159124.0:3677 rb.0.7.000000000cb4 [read 
2383872~20480] 2.75848b4b) v4 ==== 158+0+0 (3028592063 0 0) 
0x7f385c001000 con 0x7f390c0040f0
ceph-osd.1.log:2012-07-19 20:09:43.717755 7f394ffff700  1 -- 
172.16.64.201:6801/10316 --> 172.16.64.200:0/1023686 -- 
osd_op_reply(3677 rb.0.7.000000000cb4 [read 2383872~20480] = 0) v4 -- 
?+0 0x7f394460f050 con 0x7f390c0040f0

Check out 3670: response took 7.608561 seconds! And other requests have 
fairly high latency. So I guess it is where the issue stems from.
> Getting latency from these debug logs will get you the time between the
> client messenger layer sending the request to the osd and receiving the
> osd's response, which includes the network queuing at both ends, but
> does not include the qemu block driver callback like the 'perf dump'
> does.
>
>
>> And good question: where to from here?
>
> Try to determine how much of the 200ms avg latency comes from osds vs
> the qemu block driver.
>
> Once the latency is under control, you might look into changing guest 
> settings to send larger requests and readahead more.
>
> Josh


