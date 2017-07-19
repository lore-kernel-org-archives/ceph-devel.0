From: Mark Nelson <mnelson@redhat.com>
Subject: Re: osds have slow requests on Ceph luminous FileStore
Date: Wed, 19 Jul 2017 08:37:47 -0500
Message-ID: <7bcb1ea3-d416-b6c7-4c69-738832977a3b@redhat.com>
References: <694B98CBCEF42547AE4CD1A693225B5D08555F65@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751967AbdGSNhs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Jul 2017 09:37:48 -0400
In-Reply-To: <694B98CBCEF42547AE4CD1A693225B5D08555F65@CNMAILEX04.lenovo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junqin JQ7 Zhang <zhangjq7@lenovo.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Junqin,

Is this the same cluster where bluestore was previously performing 
slowly for you?  Your disks are definitely being hammered pretty hard. 
The throughput doesn't appear especially low for HDDs.  I did notice 
your using 8196 vs 8192 for slightly non-4k aligned IOs.  The latency is 
the biggest oddity.  Earlier you mentioned you are using a 20000Mb/s 
network.  Is that bonded 10GbE?  We've seen cases in the past on a 
customer cluster where the bonding configuration was causing some really 
nasty network latency on certain routes.

Mark

On 07/18/2017 05:42 AM, Junqin JQ7 Zhang wrote:
> Hi,
>
> I met "osds have slow requests" problem on Ceph luminous 12.1.0 FileStore on a newly installed cluster.
> We have tested 10.2.* version before, but didn't see such kind of issue.
> Could anyone help this?  Thanks in advance.
>
> The Ceph cluster is on 3 nodes.
> I have tried to restart all OSDs several times, but still same result.
>
> Here are the phenomenons.
> After, I did rbd bench with high --io-threads, then I can see following error.
>
> [root@ceph-1 ~]# rbd bench --io-type write --io-size 8196 --io-threads 8 --io-total 4G  --io-pattern rand  rbd/rbdtest
> bench  type write io_size 8196 io_threads 8 bytes 4294967296 pattern random
>   SEC       OPS   OPS/SEC   BYTES/SEC
>     1      7043   7051.57  57794684.13
>     2     15416   7712.12  63208574.94
> ......
>    62    508945   8271.42  67792552.91
>    63    517257   8274.47  67817535.56
> elapsed:    63  ops:   524033  ops/sec:  8211.96  bytes/sec: 67305203.40
> 2017-07-18 18:13:08.293445 7fb09ffff700 -1 librbd::ImageWatcher: 0x7fb090001ed0 image watch failed: 140396306931344, (107) Transport endpoint is not connected
> 2017-07-18 18:13:08.293483 7fb09ffff700 -1 librbd::Watcher: 0x7fb090001ed0 handle_error: handle=140396306931344: (107) Transport endpoint is not connected
>
> Then get " osds have slow requests "
> [root@ceph-1 osddebug]# ceph -s
>   cluster:
>     id:     1f1e3ab0-0e93-4e0e-8cda-fb5d67e072e0
>     health: HEALTH_WARN
>             34213 requests are blocked > 32 sec
>             8 osds have slow requests
>
> And I see very high apply_latency.
> [root@ceph-1 osddebug]# ceph osd perf
> osd commit_latency(ms) apply_latency(ms)
>  23                  0             28958
>  22                  0             30457
>   9                  0             35393
>   8                  0             43926
>   7                  0             45192
>   6                  0             39647
>   5                  0             52997
>   4                  0             45622
>   3                  0             36825
>   2                  0             33094
>   1                  0             49191
>   0                  0             40646
>  10                  0             29356
>  11                  0             36629
>  12                  0             28765
>  13                  0             39133
>  14                  0             38505
>  15                  0             37818
>  16                  0             30575
>  17                  0             43622
>  18                  0             41289
>  19                  0             39110
>  20                  0             39957
>  21                  0             38773
>
> Here is iostat in one node when perform bench.
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            7.31    0.00    4.73   42.98    0.00   44.98
>
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> sda               0.00     0.00    0.00 8094.00     0.00 49184.00    12.15     0.23    0.03    0.00    0.03   0.03  21.00
> sdb               0.00     0.00    0.00 8250.00     0.00 50144.00    12.16     0.26    0.03    0.00    0.03   0.03  23.50
> sde               0.00   327.00  114.00  468.00   456.00  6644.00    24.40    11.94   20.24   46.76   13.77   1.72 100.00
> sdg               0.00   399.00  145.00  492.00   580.00  5056.00    17.70     7.99   12.38   43.21    3.29   1.57 100.00
> sdk               0.00   422.00  143.00  534.00   572.00  5780.00    18.77     8.55   13.63   43.87    5.53   1.48 100.00
> sdi               0.00   322.00  115.00  581.00   460.00 12016.00    35.85    25.69   77.43   65.58   79.78   1.44 100.00
> sdh               0.00  1914.00   25.00  436.00   100.00 17796.00    77.64   145.97  317.56  257.60  321.00   2.17 100.00
> sdd               0.00   452.00  155.00  549.00   620.00  5756.00    18.11     8.32   11.85   41.14    3.58   1.42 100.00
> sdf               0.00     5.00   11.00  590.00    44.00  2792.00     9.44   146.84  243.25  465.55  239.11   1.66 100.00
> sdj               0.00   378.00  120.00  464.00   480.00  4824.00    18.16     7.84   13.23   50.51    3.59   1.71 100.00
> sdc               0.00     2.00    0.00    6.00     0.00    76.00    25.33     0.05    8.50    0.00    8.50   8.50   5.10
> dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
> dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
> dm-2              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
> dm-3              0.00     0.00    0.00    6.00     0.00    76.00    25.33     0.05    8.67    0.00    8.67   8.50   5.10
>
> log in ceph-osd
> 2017-07-18 18:13:22.104639 7fe34c270700  0 log_channel(cluster) log [WRN] : slow request 43.722246 seconds old, received at 2017-07-18 18:12:38.381955: osd_op(client.76896.0:509128 0.7b 0:de320fa8:::rbd_data.ba112ae8944a.00000000000028a6:head [write 3813028~8196 [fadvise_random]] snapc 0=[] ondisk+write+known_if_redirected e1119) currently commit_sent
> 2017-07-18 18:13:22.104644 7fe34c270700  0 log_channel(cluster) log [WRN] : slow request 43.714032 seconds old, received at 2017-07-18 18:12:38.390168: osd_repop(client.76896.0:509193 0.29d e1119/1116 0:b97947f6:::rbd_data.ba112ae8944a.0000000000004654:head v 1119'17412) currently commit_sent
> 2017-07-18 18:13:22.104648 7fe34c270700  0 log_channel(cluster) log [WRN] : slow request 43.653849 seconds old, received at 2017-07-18 18:12:38.450352: osd_repop(client.76896.0:509685 0.1e e1119/1117 0:781ecb04:::rbd_data.ba112ae8944a.0000000000003c5f:head v 1119'13702) currently commit_sent
> 2017-07-18 18:13:23.105083 7fe34c270700  0 log_channel(cluster) log [WRN] : 1471 slow requests, 5 included below; oldest blocked for > 44.206332 secs
> 2017-07-18 18:13:23.105098 7fe34c270700  0 log_channel(cluster) log [WRN] : slow request 44.206332 seconds old, received at 2017-07-18 18:12:38.898459: osd_repop(client.76896.0:513404 0.3a1 e1119/1117 0:85dab8cb:::rbd_data.ba112ae8944a.0000000000001fb4:head v 1119'15378) currently commit_sent
> 2017-07-18 18:13:23.105104 7fe34c270700  0 log_channel(cluster) log [WRN] : slow request 44.119205 seconds old, received at 2017-07-18 18:12:38.985585: osd_op(client.76896.0:514135 0.2e0 0:07575ed3:::rbd_data.ba112ae8944a.0000000000004782:head [write 2665884~8196 [fadvise_random]] snapc 0=[] ondisk+write+known_if_redirected e1119) currently commit_sent
> 2017-07-18 18:13:23.105109 7fe34c270700  0 log_channel(cluster) log [WRN] : slow request 44.098773 seconds old, received at 2017-07-18 18:12:39.006017: osd_op(client.76896.0:514296 0.306 0:60da6e83:::rbd_data.ba112ae8944a.0000000000002a78:head [write 2333184~8196 [fadvise_random]] snapc 0=[] ondisk+write+known_if_redirected e1119) currently commit_sent
> 2017-07-18 18:13:23.105125 7fe34c270700  0 log_channel(cluster) log [WRN] : slow request 44.063825 seconds old, received at 2017-07-18 18:12:39.040965: osd_repop(client.76896.0:514585 0.1e e1119/1117 0:783122c6:::rbd_data.ba112ae8944a.0000000000002292:head v 1119'13711) currently commit_sent
>
> I also checked dmesg, found following log, but seems not at this time.
> [22932.710120] INFO: task filestore_sync:5128 blocked for more than 120 seconds.
> [22932.710121] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [22932.710123] filestore_sync  D 00007f902b69c708     0  5128      1 0x00000080
> [22932.710126]  ffff885f8d78fd50 0000000000000086 ffff885fbe6f9f60 ffff885f8d78ffd8
> [22932.710130]  ffff885f8d78ffd8 ffff885f8d78ffd8 ffff885fbe6f9f60 ffff885f8d78fe80
> [22932.710133]  ffff885f8d78fe88 7fffffffffffffff ffff885fbe6f9f60 00007f902b69c708
>
> Here is my osd configure.
> [osd.0]
> host = ceph-1
> osd journal = /var/lib/ceph/osd/ceph-0-journal/journal  # a ssd partion
> osd data =  /var/lib/ceph/osd/ceph-0                                      # a HDD disk
>
> Could anyone help how to move on to debug this?
> Thanks a lot!
>
> B.R.
> Junqin Zhang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
