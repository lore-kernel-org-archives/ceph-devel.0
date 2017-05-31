From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [ceph-users] Lumionous: bluestore 'tp_osd_tp thread tp_osd_tp'
 had timed out after 60
Date: Wed, 31 May 2017 07:13:05 -0500
Message-ID: <ca2ed1de-9f51-2dbe-8339-276af89be1ce@redhat.com>
References: <dddebe78eb377ab91786b73f9c390617.squirrel@mail.mrc-lmb.cam.ac.uk>
 <12d74514-7018-afd6-0130-a46017faf6e9@redhat.com>
 <CALWuvY-6MOajWEsNWUjEHnoe8nEFhE5f0mcAZ=RBQ+JgRRFS-Q@mail.gmail.com>
 <224407a4-18d2-e7cd-5b2f-582fd4afaf8e@redhat.com>
 <CALWuvY8QjeV=+E7vKL1v0sj8==MFM2Ks+PzMn584GXFj8Uix2A@mail.gmail.com>
 <CALWuvY9JXGhyGY5cYRN=rLiawQxBQn_1=40sMmyS1aQRy9UQvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdEaMNH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 May 2017 08:13:07 -0400
In-Reply-To: <CALWuvY9JXGhyGY5cYRN=rLiawQxBQn_1=40sMmyS1aQRy9UQvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nokia ceph <nokiacephusers@gmail.com>
Cc: Ceph Users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 05/31/2017 05:21 AM, nokia ceph wrote:
> + ceph-devel ..
>
> $ps -ef | grep 294
> ceph     3539720       1 14 08:04 ?        00:16:35 /usr/bin/ceph-osd -f
> --cluster ceph --id 294 --setuser ceph --setgroup ceph
>
> $gcore -o coredump-osd  3539720
>
>
> $(gdb) bt
> #0  0x00007f5ef68f56d5 in pthread_cond_wait@@GLIBC_2.3.2 () from
> /lib64/libpthread.so.0
> #1  0x00007f5ef9cc45ab in ceph::logging::Log::entry() ()
> #2  0x00007f5ef68f1dc5 in start_thread () from /lib64/libpthread.so.0
> #3  0x00007f5ef57e173d in clone () from /lib64/libc.so.6

Can you do a thread apply all bt instead so we can see what the 
tp_osd_tp threads were doing?  That might be the bigger clue.

Mark

>
>
> *2017-05-31 10:11:51.064495 7f5ef383b700  1 heartbeat_map is_healthy
> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
> *2017-05-31 10:11:51.064496 7f5ef383b700  1 heartbeat_map is_healthy
> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
> *2017-05-31 10:11:51.064497 7f5ef383b700  1 heartbeat_map is_healthy
> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
> *2017-05-31 10:11:51.064497 7f5ef383b700  1 heartbeat_map is_healthy
> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
> *2017-05-31 10:11:51.064498 7f5ef383b700  1 heartbeat_map is_healthy
> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
> 2017-05-31 10:11:51.957092 7f5eef88a700 -1 osd.294 1004 heartbeat_check:
> no reply from 10.50.62.154:6858 <http://10.50.62.154:6858> osd.64 since
> back 2017-05-31 09:58:53.016145 front 2017-05-31 09:58:53.016145 (cutoff
> 2017-05-31 10:11:31.957089)
> 2017-05-31 10:11:51.957114 7f5eef88a700 -1 osd.294 1004 heartbeat_check:
> no reply from 10.50.62.154:6931 <http://10.50.62.154:6931> osd.82 since
> back 2017-05-31 10:04:48.204500 front 2017-05-31 10:04:48.204500 (cutoff
> 2017-05-31 10:11:31.957089)
> 2017-05-31 10:11:51.957121 7f5eef88a700 -1 osd.294 1004 heartbeat_check:
> no reply from 10.50.62.152:6929 <http://10.50.62.152:6929> osd.162 since
> back 2017-05-31 09:57:37.451595 front 2017-05-31 09:57:37.451595 (cutoff
> 2017-05-31 10:11:31.957089)
>
>
>
> Thanks
> Jayaram
>
> On Tue, May 30, 2017 at 7:33 PM, nokia ceph <nokiacephusers@gmail.com
> <mailto:nokiacephusers@gmail.com>> wrote:
>
>     Hello Mark,
>
>     Yes this issue happens once the test/write started after 60 secs
>     which correspond config value -- "threadpool_default_timeout = 60 "
>     . Do you require the down OSD coredump to analyse tp_osd_tp state. .
>     Please be specify which process dump you would require to analyse.
>
>     Like ,
>     #gcore <PID of down OSD>
>
>     or using wallclock profiler, I'm not much aware how to use this tool.
>
>     Thanks
>     Jayaram
>
>     On Tue, May 30, 2017 at 6:57 PM, Mark Nelson <mnelson@redhat.com
>     <mailto:mnelson@redhat.com>> wrote:
>
>         On 05/30/2017 05:07 AM, nokia ceph wrote:
>
>             Hello Mark,
>
>             I can able to reproduce this problem everytime.
>
>
>         Ok, next question, does it happen 60s after starting the 200MB/s
>         load, or does it take a while?  Sounds like it's pretty random
>         across OSDs? I'm thinking we want to figure out what state the
>         tp_osd_tp threads are in when this is happening (maybe via a gdb
>         bt or using the wallclock profiler to gather several samples)
>         and then figure out via the logs what lead to the chain of
>         events that put it in that state.
>
>         Mark
>
>
>             Env:-- 5 node, v12.0.3, EC 4+1 bluestore , RHEL 7.3 -
>             3.10.0-514.el7.x86_64
>
>             Tested with debug bluestore = 20...
>
>             From ceph watch
>             ===========
>
>             2017-05-30 08:57:33.510794 mon.0 [INF] pgmap v15649: 8192
>             pgs: 8192
>             active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB
>             avail; 35167
>             B/s rd, 77279 kB/s wr, 726 op/s
>             2017-05-30 08:57:35.134604 mon.0 [INF] pgmap v15650: 8192
>             pgs: 8192
>             active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB
>             avail; 19206
>             B/s rd, 63835 kB/s wr, 579 op/s
>             2017-05-30 08:57:36.295086 mon.0 [INF] pgmap v15651: 8192
>             pgs: 8192
>             active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB
>             avail; 10999
>             B/s rd, 44093 kB/s wr, 379 op/s
>             2017-05-30 08:57:37.228422 mon.0 [INF] osd.243
>             10.50.62.154:6895/1842853 <http://10.50.62.154:6895/1842853>
>             <http://10.50.62.154:6895/1842853
>             <http://10.50.62.154:6895/1842853>> failed (4 reporters from
>             different
>             host after 20.062159 >= grace 20.000000)
>             2017-05-30 08:57:37.234308 mon.0 [INF] osd.19
>             10.50.62.152:6856/1940715 <http://10.50.62.152:6856/1940715>
>             <http://10.50.62.152:6856/1940715
>             <http://10.50.62.152:6856/1940715>> failed (4 reporters from
>             different
>
>             host after 20.000234 >= grace 20.000000)
>             2017-05-30 08:57:37.368342 mon.0 [INF] pgmap v15652: 8192
>             pgs: 8192
>             active+clean; 774 GB data, 1360 GB used, 1854 TB / 1855 TB
>             avail; 12628
>             B/s rd, 50471 kB/s wr, 444 op/s
>             2017-05-30 08:57:37.506743 mon.0 [INF] osdmap e848: 340
>             osds: 338 up, 340 in
>
>
>             From failed osd.19 log
>             =========
>
>             ===
>             2017-05-30 08:57:04.155836 7f9d6c723700 10
>             bluestore(/var/lib/ceph/osd/ceph-19) _omap_setkeys 1.1e85s4_head
>             4#1:a1780000::::head# = 0
>             2017-05-30 08:57:04.155840 7f9d6c723700 10
>             bluestore(/var/lib/ceph/osd/ceph-19) _txc_calc_cost
>             0x7f9da2d1f180 cost
>             3542664 (2 ios * 1500000 + 542664 bytes)
>             2017-05-30 08:57:04.155841 7f9d6c723700 20
>             bluestore(/var/lib/ceph/osd/ceph-19) _txc_write_nodes txc
>             0x7f9da2d1f180
>             onodes 0x7f9da6651840 shared_blobs
>             2017-05-30 08:57:04.155843 7f9d6c723700 20
>             bluestore.extentmap(0x7f9da6651930) update
>             4#1:a179feb3:::%2fc20%2fvx0000033%2fpot%2fchannel1%2fhls%2fvar2660000%2f00000%2fseg0015.ts:head#
>             2017-05-30 08:57:04.155852 7f9d6c723700 20
>             bluestore.extentmap(0x7f9da6651930) update  inline shard 607
>             bytes from
>             2 extents
>             2017-05-30 08:57:04.155858 7f9d6c723700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)   onode
>             4#1:a179feb3:::%2fc20%2fvx0000033%2fpot%2fchannel1%2fhls%2fvar2660000%2f00000%2fseg0015.ts:head#
>             is 1348 (735 bytes onode + 2 bytes spanning blobs + 611
>             bytes inline
>             extents)
>             2017-05-30 08:57:04.155876 7f9d6c723700 20
>             bluestore(/var/lib/ceph/osd/ceph-19) _txc_finalize_kv txc
>             0x7f9da2d1f180
>             allocated 0x[388af10000~90000] released 0x[]
>             2017-05-30 08:57:04.155880 7f9d6c723700 10 freelist allocate
>             0x388af10000~90000
>             2017-05-30 08:57:04.155882 7f9d6c723700 20 freelist _xor
>             first_key
>             0x388af00000 last_key 0x388af80000
>             2017-05-30 08:57:07.698556 7f9d6a71f700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)
>             statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>             0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>             2017-05-30 08:57:08.201089 7f9d6a71f700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)
>             statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>             0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>             2017-05-30 08:57:09.903290 7f9d6a71f700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)
>             statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>             0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>             2017-05-30 08:57:11.605590 7f9d6a71f700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)
>             statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>             0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>             2017-05-30 08:57:15.707908 7f9d6a71f700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)
>             statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>             0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>             2017-05-30 08:57:17.410365 7f9d6a71f700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)
>             statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>             0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>             2017-05-30 08:57:18.512773 7f9d6a71f700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)
>             statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>             0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>             *2017-05-30 08:57:20.005812 7f9d8f712700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>             *2017-05-30 08:57:20.006648 7f9d8ff13700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>             *2017-05-30 08:57:20.015585 7f9d8f712700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>             *2017-05-30 08:57:20.015677 7f9d8f712700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>             *
>             *
>             *..<snip>..*
>
>
>             2017-05-30 08:57:37.506457 7f9d875fd700 20
>             bluestore(/var/lib/ceph/osd/ceph-19) _do_write perform garbage
>             collection, expected benefit = 0 AUs
>             2017-05-30 08:57:37.506459 7f9d875fd700 20
>             bluestore.extentmap(0x7f9da0ed50b0) dirty_range mark inline
>             shard dirty
>             2017-05-30 08:57:37.506461 7f9d875fd700 10
>             bluestore(/var/lib/ceph/osd/ceph-19) _write meta
>             #-1:7b3f43c4:::osd_superblock:0# 0x0~1f8 = 0
>             2017-05-30 08:57:37.506463 7f9d875fd700 10
>             bluestore(/var/lib/ceph/osd/ceph-19) _txc_calc_cost
>             0x7f9da2d22680 cost
>             3104677 (2 ios * 1500000 + 104677 bytes)
>             2017-05-30 08:57:37.506479 7f9d875fd700 20
>             bluestore(/var/lib/ceph/osd/ceph-19) _txc_write_nodes txc
>             0x7f9da2d22680
>             onodes 0x7f9da0ed4fc0,0x7f9da5bd8000,0x7f9da72dad80 shared_blobs
>             2017-05-30 08:57:37.506482 7f9d875fd700 20
>             bluestore.extentmap(0x7f9da0ed50b0) update
>             #-1:7b3f43c4:::osd_superblock:0#
>             2017-05-30 08:57:37.506485 7f9d875fd700 20
>             bluestore.extentmap(0x7f9da0ed50b0) update  inline shard 81
>             bytes from 1
>             extents
>             2017-05-30 08:57:37.506491 7f9d875fd700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)   onode
>             #-1:7b3f43c4:::osd_superblock:0# is 108 (21 bytes onode + 2
>             bytes
>             spanning blobs + 85 bytes inline extents)
>             2017-05-30 08:57:37.506495 7f9d875fd700 20
>             bluestore.extentmap(0x7f9da5bd80f0) update
>             #-1:a51ca935:::osdmap.848:0#
>             2017-05-30 08:57:37.506497 7f9d875fd700 20
>             bluestore.extentmap(0x7f9da5bd80f0) update  inline shard 235
>             bytes from
>             2 extents
>             2017-05-30 08:57:37.506499 7f9d875fd700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)   onode
>             #-1:a51ca935:::osdmap.848:0# is 264 (23 bytes onode + 2
>             bytes spanning
>             blobs + 239 bytes inline extents)
>             2017-05-30 08:57:37.506502 7f9d875fd700 20
>             bluestore.extentmap(0x7f9da72dae70) update
>             #-1:48acce63:::inc_osdmap.848:0#
>             2017-05-30 08:57:37.506504 7f9d875fd700 20
>             bluestore.extentmap(0x7f9da72dae70) update  inline shard 82
>             bytes from 1
>             extents
>             2017-05-30 08:57:37.506506 7f9d875fd700 20
>             bluestore(/var/lib/ceph/osd/ceph-19)   onode
>             #-1:48acce63:::inc_osdmap.848:0# is 110 (22 bytes onode + 2
>             bytes
>             spanning blobs + 86 bytes inline extents)
>             2017-05-30 08:57:37.506558 7f9d875fd700 20
>             bluestore(/var/lib/ceph/osd/ceph-19) _txc_finalize_kv txc
>             0x7f9da2d22680
>             allocated 0x[388afa0000~30000] released 0x[]
>             2017-05-30 08:57:37.506562 7f9d875fd700 10 freelist allocate
>             0x388afa0000~30000
>             2017-05-30 08:57:37.506563 7f9d875fd700 20 freelist _xor
>             first_key
>             0x388af80000 last_key 0x388af80000
>             2017-05-30 08:57:37.510446 7f9d8ff13700  0 --
>             10.50.63.152:6857/1940715 <http://10.50.63.152:6857/1940715>
>             <http://10.50.63.152:6857/1940715
>             <http://10.50.63.152:6857/1940715>> >>
>             10.50.63.153:6869/1572972 <http://10.50.63.153:6869/1572972>
>             <http://10.50.63.153:6869/1572972
>             <http://10.50.63.153:6869/1572972>> conn(0x7f9da698a800 :6857
>             s=STATE_OPEN pgs=243 cs=1 l=0).fault with nothing to send,
>             going to standby
>             2017-05-30 08:57:37.514366 7f9d8ff13700  0 --
>             10.50.63.152:6857/1940715 <http://10.50.63.152:6857/1940715>
>             <http://10.50.63.152:6857/1940715
>             <http://10.50.63.152:6857/1940715>> >>
>             10.50.63.153:6863/1572982 <http://10.50.63.153:6863/1572982>
>             <http://10.50.63.153:6863/1572982
>             <http://10.50.63.153:6863/1572982>> conn(0x7f9da620f800 :6857
>             s=STATE_OPEN pgs=149 cs=1 l=0).fault with nothing to send,
>             going to standby
>             2017-05-30 08:57:37.517351 7f9d8ef11700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 60
>             2017-05-30 08:57:37.517354 7f9d8ef11700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 60
>             ====
>
>
>              config value --> threadpool_default_timeout = 60
>
>             // default timeout while caling WaitInterval on an empty queue
>             OPTION(threadpool_default_timeout, OPT_INT, 60)
>
>             I altered the above value to 300, then it serve for some time
>
>             2017-05-30 09:44:32.027168 7efc1f2b9700 20
>             bluestore(/var/lib/ceph/osd/ceph-41)
>             statfsstore_statfs(0x574f2860000/0x5753b990000, stored
>             0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)
>             2017-05-30 09:44:35.529164 7efc1f2b9700 20
>             bluestore(/var/lib/ceph/osd/ceph-41)
>             statfsstore_statfs(0x574f2860000/0x5753b990000, stored
>             0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)
>             2017-05-30 09:44:40.831130 7efc1f2b9700 20
>             bluestore(/var/lib/ceph/osd/ceph-41)
>             statfsstore_statfs(0x574f2860000/0x5753b990000, stored
>             0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)
>             2017-05-30 09:44:41.634056 7efc3fafa700 -1 osd.41 878
>             heartbeat_check:
>             no reply from 10.50.62.152:6853 <http://10.50.62.152:6853>
>             <http://10.50.62.152:6853> osd.30 since
>             back 2017-05-30 09:44:21.521517 front 2017-05-30
>             09:44:21.521517 (cutoff
>             2017-05-30 09:44:21.634053)
>             *2017-05-30 09:44:42.128280 7efc442ac700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 300*
>             *2017-05-30 09:44:42.128282 7efc442ac700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 300*
>             *2017-05-30 09:44:42.128284 7efc442ac700  1 heartbeat_map
>             is_healthy
>             'tp_osd_tp thread tp_osd_tp' had timed out after 300*
>
>             Do you require any logs from my end? Shall I open tracker
>             for this issue?
>
>             Thanks
>             Jayaram
>
>
>             On Mon, May 29, 2017 at 4:58 AM, Mark Nelson
>             <mnelson@redhat.com <mailto:mnelson@redhat.com>
>             <mailto:mnelson@redhat.com <mailto:mnelson@redhat.com>>> wrote:
>
>                 Hi Jake,
>
>                 200MB/s is pretty low load across 5 servers.  I wouldn't
>             expect the
>                 tp_osd_tp threads to be that heavily loaded that it's
>             not responding
>                 for 60s.  Sounds like a bug.  Can you reproduce it?  It
>             might be
>                 worth trying it with debug bluestore = 20.
>
>                 Mark
>
>
>                 On 05/27/2017 05:02 AM, Jake Grimmett wrote:
>
>                     Dear All,
>
>                     I wonder if anyone can give advice regarding
>             bluestore OSD's
>                     going down on
>                     Luminous 12.0.3 when the cluster is under moderate
>             (200MB/s) load,
>
>                     OSD's seem to do down randomly across the 5 OSD
>             servers. When
>                     one OSD is
>                     down, load decreases, so no further OSD's drop,
>             until I restart
>                     the OSD,
>                     then another fails.
>
>                     There are no obvious disk errors seen in
>             /var/log/messages.
>
>                     Here though is part of a ceph-osd.46.log...
>
>                     2017-05-27 10:42:28.781821 7f7c503b4700  0
>             log_channel(cluster)
>                     log [WRN]
>                     : slow request 120.247733 seconds old, received at
>             2017-05-27
>                     10:40:28.534048: osd_op(osd.52.1251:8732 1.3ffs0
>             1.a8ec73ff
>                     (undecoded)
>
>             ondisk+read+rwordered+ignore_cache+ignore_overlay+map_snap_clone+known_if_redirected
>                     e1342) currently queued_for_pg
>                     2017-05-27 10:42:33.748109 7f7c52bf1700  1
>             heartbeat_map is_healthy
>                     'tp_osd_tp thread tp_osd_tp' had timed out after 60
>
>                     - these two errors repeat, with more of the
>             'tp_osd_tp thread
>                     tp_osd_tp'
>                     errors.
>
>                     Hopefully this is not due to the highpoint rocket
>             r750 cards in
>                     my OSD
>                     servers (the OSD servers are all 45drive.com
>             <http://45drive.com>
>                     <http://45drive.com> storinators)
>
>                     Other info - each node has 64GB ram, 10 x 8TB
>             Ironwolf drive,
>                     10Gb Intel
>                     nic, single E5-2620 v4
>
>                     Any advice gratefully received!
>
>                     thanks,
>
>                     Jake
>
>                 _______________________________________________
>                 ceph-users mailing list
>                 ceph-users@lists.ceph.com
>             <mailto:ceph-users@lists.ceph.com>
>             <mailto:ceph-users@lists.ceph.com
>             <mailto:ceph-users@lists.ceph.com>>
>                 http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>             <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>
>                 <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>             <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>>
>
>
>
>
