From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Lumionous: bluestore 'tp_osd_tp thread tp_osd_tp'
 had timed out after 60
Date: Wed, 31 May 2017 15:51:13 +0530
Message-ID: <CALWuvY9JXGhyGY5cYRN=rLiawQxBQn_1=40sMmyS1aQRy9UQvQ@mail.gmail.com>
References: <dddebe78eb377ab91786b73f9c390617.squirrel@mail.mrc-lmb.cam.ac.uk>
	<12d74514-7018-afd6-0130-a46017faf6e9@redhat.com>
	<CALWuvY-6MOajWEsNWUjEHnoe8nEFhE5f0mcAZ=RBQ+JgRRFS-Q@mail.gmail.com>
	<224407a4-18d2-e7cd-5b2f-582fd4afaf8e@redhat.com>
	<CALWuvY8QjeV=+E7vKL1v0sj8==MFM2Ks+PzMn584GXFj8Uix2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1696598181=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALWuvY8QjeV=+E7vKL1v0sj8==MFM2Ks+PzMn584GXFj8Uix2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1696598181==
Content-Type: multipart/alternative; boundary="001a113e2420a1b5550550cf4768"

--001a113e2420a1b5550550cf4768
Content-Type: text/plain; charset="UTF-8"

+ ceph-devel ..

$ps -ef | grep 294
ceph     3539720       1 14 08:04 ?        00:16:35 /usr/bin/ceph-osd -f
--cluster ceph --id 294 --setuser ceph --setgroup ceph

$gcore -o coredump-osd  3539720


$(gdb) bt
#0  0x00007f5ef68f56d5 in pthread_cond_wait@@GLIBC_2.3.2 () from
/lib64/libpthread.so.0
#1  0x00007f5ef9cc45ab in ceph::logging::Log::entry() ()
#2  0x00007f5ef68f1dc5 in start_thread () from /lib64/libpthread.so.0
#3  0x00007f5ef57e173d in clone () from /lib64/libc.so.6


*2017-05-31 10:11:51.064495 7f5ef383b700  1 heartbeat_map is_healthy
'tp_osd_tp thread tp_osd_tp' had timed out after 60*
*2017-05-31 10:11:51.064496 7f5ef383b700  1 heartbeat_map is_healthy
'tp_osd_tp thread tp_osd_tp' had timed out after 60*
*2017-05-31 10:11:51.064497 7f5ef383b700  1 heartbeat_map is_healthy
'tp_osd_tp thread tp_osd_tp' had timed out after 60*
*2017-05-31 10:11:51.064497 7f5ef383b700  1 heartbeat_map is_healthy
'tp_osd_tp thread tp_osd_tp' had timed out after 60*
*2017-05-31 10:11:51.064498 7f5ef383b700  1 heartbeat_map is_healthy
'tp_osd_tp thread tp_osd_tp' had timed out after 60*
2017-05-31 10:11:51.957092 7f5eef88a700 -1 osd.294 1004 heartbeat_check: no
reply from 10.50.62.154:6858 osd.64 since back 2017-05-31 09:58:53.016145
front 2017-05-31 09:58:53.016145 (cutoff 2017-05-31 10:11:31.957089)
2017-05-31 10:11:51.957114 7f5eef88a700 -1 osd.294 1004 heartbeat_check: no
reply from 10.50.62.154:6931 osd.82 since back 2017-05-31 10:04:48.204500
front 2017-05-31 10:04:48.204500 (cutoff 2017-05-31 10:11:31.957089)
2017-05-31 10:11:51.957121 7f5eef88a700 -1 osd.294 1004 heartbeat_check: no
reply from 10.50.62.152:6929 osd.162 since back 2017-05-31 09:57:37.451595
front 2017-05-31 09:57:37.451595 (cutoff 2017-05-31 10:11:31.957089)



Thanks
Jayaram

On Tue, May 30, 2017 at 7:33 PM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hello Mark,
>
> Yes this issue happens once the test/write started after 60 secs which
> correspond config value -- "threadpool_default_timeout = 60 " . Do you
> require the down OSD coredump to analyse tp_osd_tp state. . Please be
> specify which process dump you would require to analyse.
>
> Like ,
> #gcore <PID of down OSD>
>
> or using wallclock profiler, I'm not much aware how to use this tool.
>
> Thanks
> Jayaram
>
> On Tue, May 30, 2017 at 6:57 PM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>> On 05/30/2017 05:07 AM, nokia ceph wrote:
>>
>>> Hello Mark,
>>>
>>> I can able to reproduce this problem everytime.
>>>
>>
>> Ok, next question, does it happen 60s after starting the 200MB/s load, or
>> does it take a while?  Sounds like it's pretty random across OSDs? I'm
>> thinking we want to figure out what state the tp_osd_tp threads are in when
>> this is happening (maybe via a gdb bt or using the wallclock profiler to
>> gather several samples) and then figure out via the logs what lead to the
>> chain of events that put it in that state.
>>
>> Mark
>>
>>
>>> Env:-- 5 node, v12.0.3, EC 4+1 bluestore , RHEL 7.3 -
>>> 3.10.0-514.el7.x86_64
>>>
>>> Tested with debug bluestore = 20...
>>>
>>> From ceph watch
>>> ===========
>>>
>>> 2017-05-30 08:57:33.510794 mon.0 [INF] pgmap v15649: 8192 pgs: 8192
>>> active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB avail; 35167
>>> B/s rd, 77279 kB/s wr, 726 op/s
>>> 2017-05-30 08:57:35.134604 mon.0 [INF] pgmap v15650: 8192 pgs: 8192
>>> active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB avail; 19206
>>> B/s rd, 63835 kB/s wr, 579 op/s
>>> 2017-05-30 08:57:36.295086 mon.0 [INF] pgmap v15651: 8192 pgs: 8192
>>> active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB avail; 10999
>>> B/s rd, 44093 kB/s wr, 379 op/s
>>> 2017-05-30 08:57:37.228422 mon.0 [INF] osd.243 10.50.62.154:6895/1842853
>>> <http://10.50.62.154:6895/1842853> failed (4 reporters from different
>>> host after 20.062159 >= grace 20.000000)
>>> 2017-05-30 08:57:37.234308 mon.0 [INF] osd.19 10.50.62.152:6856/1940715
>>> <http://10.50.62.152:6856/1940715> failed (4 reporters from different
>>>
>>> host after 20.000234 >= grace 20.000000)
>>> 2017-05-30 08:57:37.368342 mon.0 [INF] pgmap v15652: 8192 pgs: 8192
>>> active+clean; 774 GB data, 1360 GB used, 1854 TB / 1855 TB avail; 12628
>>> B/s rd, 50471 kB/s wr, 444 op/s
>>> 2017-05-30 08:57:37.506743 mon.0 [INF] osdmap e848: 340 osds: 338 up,
>>> 340 in
>>>
>>>
>>> From failed osd.19 log
>>> =========
>>>
>>> ===
>>> 2017-05-30 08:57:04.155836 7f9d6c723700 10
>>> bluestore(/var/lib/ceph/osd/ceph-19) _omap_setkeys 1.1e85s4_head
>>> 4#1:a1780000::::head# = 0
>>> 2017-05-30 08:57:04.155840 7f9d6c723700 10
>>> bluestore(/var/lib/ceph/osd/ceph-19) _txc_calc_cost 0x7f9da2d1f180 cost
>>> 3542664 (2 ios * 1500000 + 542664 bytes)
>>> 2017-05-30 08:57:04.155841 7f9d6c723700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19) _txc_write_nodes txc 0x7f9da2d1f180
>>> onodes 0x7f9da6651840 shared_blobs
>>> 2017-05-30 08:57:04.155843 7f9d6c723700 20
>>> bluestore.extentmap(0x7f9da6651930) update
>>> 4#1:a179feb3:::%2fc20%2fvx0000033%2fpot%2fchannel1%2fhls%2fv
>>> ar2660000%2f00000%2fseg0015.ts:head#
>>> 2017-05-30 08:57:04.155852 7f9d6c723700 20
>>> bluestore.extentmap(0x7f9da6651930) update  inline shard 607 bytes from
>>> 2 extents
>>> 2017-05-30 08:57:04.155858 7f9d6c723700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)   onode
>>> 4#1:a179feb3:::%2fc20%2fvx0000033%2fpot%2fchannel1%2fhls%2fv
>>> ar2660000%2f00000%2fseg0015.ts:head#
>>> is 1348 (735 bytes onode + 2 bytes spanning blobs + 611 bytes inline
>>> extents)
>>> 2017-05-30 08:57:04.155876 7f9d6c723700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19) _txc_finalize_kv txc 0x7f9da2d1f180
>>> allocated 0x[388af10000~90000] released 0x[]
>>> 2017-05-30 08:57:04.155880 7f9d6c723700 10 freelist allocate
>>> 0x388af10000~90000
>>> 2017-05-30 08:57:04.155882 7f9d6c723700 20 freelist _xor first_key
>>> 0x388af00000 last_key 0x388af80000
>>> 2017-05-30 08:57:07.698556 7f9d6a71f700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)
>>> statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>>> 0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>>> 2017-05-30 08:57:08.201089 7f9d6a71f700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)
>>> statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>>> 0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>>> 2017-05-30 08:57:09.903290 7f9d6a71f700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)
>>> statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>>> 0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>>> 2017-05-30 08:57:11.605590 7f9d6a71f700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)
>>> statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>>> 0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>>> 2017-05-30 08:57:15.707908 7f9d6a71f700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)
>>> statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>>> 0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>>> 2017-05-30 08:57:17.410365 7f9d6a71f700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)
>>> statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>>> 0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>>> 2017-05-30 08:57:18.512773 7f9d6a71f700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)
>>> statfsstore_statfs(0x574506f0000/0x5753b990000, stored
>>> 0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)
>>> *2017-05-30 08:57:20.005812 7f9d8f712700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>>> *2017-05-30 08:57:20.006648 7f9d8ff13700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>>> *2017-05-30 08:57:20.015585 7f9d8f712700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>>> *2017-05-30 08:57:20.015677 7f9d8f712700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 60*
>>> *
>>> *
>>> *..<snip>..*
>>>
>>>
>>> 2017-05-30 08:57:37.506457 7f9d875fd700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19) _do_write perform garbage
>>> collection, expected benefit = 0 AUs
>>> 2017-05-30 08:57:37.506459 7f9d875fd700 20
>>> bluestore.extentmap(0x7f9da0ed50b0) dirty_range mark inline shard dirty
>>> 2017-05-30 08:57:37.506461 7f9d875fd700 10
>>> bluestore(/var/lib/ceph/osd/ceph-19) _write meta
>>> #-1:7b3f43c4:::osd_superblock:0# 0x0~1f8 = 0
>>> 2017-05-30 08:57:37.506463 7f9d875fd700 10
>>> bluestore(/var/lib/ceph/osd/ceph-19) _txc_calc_cost 0x7f9da2d22680 cost
>>> 3104677 (2 ios * 1500000 + 104677 bytes)
>>> 2017-05-30 08:57:37.506479 7f9d875fd700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19) _txc_write_nodes txc 0x7f9da2d22680
>>> onodes 0x7f9da0ed4fc0,0x7f9da5bd8000,0x7f9da72dad80 shared_blobs
>>> 2017-05-30 08:57:37.506482 7f9d875fd700 20
>>> bluestore.extentmap(0x7f9da0ed50b0) update
>>> #-1:7b3f43c4:::osd_superblock:0#
>>> 2017-05-30 08:57:37.506485 7f9d875fd700 20
>>> bluestore.extentmap(0x7f9da0ed50b0) update  inline shard 81 bytes from 1
>>> extents
>>> 2017-05-30 08:57:37.506491 7f9d875fd700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)   onode
>>> #-1:7b3f43c4:::osd_superblock:0# is 108 (21 bytes onode + 2 bytes
>>> spanning blobs + 85 bytes inline extents)
>>> 2017-05-30 08:57:37.506495 7f9d875fd700 20
>>> bluestore.extentmap(0x7f9da5bd80f0) update #-1:a51ca935:::osdmap.848:0#
>>> 2017-05-30 08:57:37.506497 7f9d875fd700 20
>>> bluestore.extentmap(0x7f9da5bd80f0) update  inline shard 235 bytes from
>>> 2 extents
>>> 2017-05-30 08:57:37.506499 7f9d875fd700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)   onode
>>> #-1:a51ca935:::osdmap.848:0# is 264 (23 bytes onode + 2 bytes spanning
>>> blobs + 239 bytes inline extents)
>>> 2017-05-30 08:57:37.506502 7f9d875fd700 20
>>> bluestore.extentmap(0x7f9da72dae70) update
>>> #-1:48acce63:::inc_osdmap.848:0#
>>> 2017-05-30 08:57:37.506504 7f9d875fd700 20
>>> bluestore.extentmap(0x7f9da72dae70) update  inline shard 82 bytes from 1
>>> extents
>>> 2017-05-30 08:57:37.506506 7f9d875fd700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19)   onode
>>> #-1:48acce63:::inc_osdmap.848:0# is 110 (22 bytes onode + 2 bytes
>>> spanning blobs + 86 bytes inline extents)
>>> 2017-05-30 08:57:37.506558 7f9d875fd700 20
>>> bluestore(/var/lib/ceph/osd/ceph-19) _txc_finalize_kv txc 0x7f9da2d22680
>>> allocated 0x[388afa0000~30000] released 0x[]
>>> 2017-05-30 08:57:37.506562 7f9d875fd700 10 freelist allocate
>>> 0x388afa0000~30000
>>> 2017-05-30 08:57:37.506563 7f9d875fd700 20 freelist _xor first_key
>>> 0x388af80000 last_key 0x388af80000
>>> 2017-05-30 08:57:37.510446 7f9d8ff13700  0 -- 10.50.63.152:6857/1940715
>>> <http://10.50.63.152:6857/1940715> >> 10.50.63.153:6869/1572972
>>> <http://10.50.63.153:6869/1572972> conn(0x7f9da698a800 :6857
>>> s=STATE_OPEN pgs=243 cs=1 l=0).fault with nothing to send, going to
>>> standby
>>> 2017-05-30 08:57:37.514366 7f9d8ff13700  0 -- 10.50.63.152:6857/1940715
>>> <http://10.50.63.152:6857/1940715> >> 10.50.63.153:6863/1572982
>>> <http://10.50.63.153:6863/1572982> conn(0x7f9da620f800 :6857
>>> s=STATE_OPEN pgs=149 cs=1 l=0).fault with nothing to send, going to
>>> standby
>>> 2017-05-30 08:57:37.517351 7f9d8ef11700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 60
>>> 2017-05-30 08:57:37.517354 7f9d8ef11700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 60
>>> ====
>>>
>>>
>>>  config value --> threadpool_default_timeout = 60
>>>
>>> // default timeout while caling WaitInterval on an empty queue
>>> OPTION(threadpool_default_timeout, OPT_INT, 60)
>>>
>>> I altered the above value to 300, then it serve for some time
>>>
>>> 2017-05-30 09:44:32.027168 7efc1f2b9700 20
>>> bluestore(/var/lib/ceph/osd/ceph-41)
>>> statfsstore_statfs(0x574f2860000/0x5753b990000, stored
>>> 0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)
>>> 2017-05-30 09:44:35.529164 7efc1f2b9700 20
>>> bluestore(/var/lib/ceph/osd/ceph-41)
>>> statfsstore_statfs(0x574f2860000/0x5753b990000, stored
>>> 0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)
>>> 2017-05-30 09:44:40.831130 7efc1f2b9700 20
>>> bluestore(/var/lib/ceph/osd/ceph-41)
>>> statfsstore_statfs(0x574f2860000/0x5753b990000, stored
>>> 0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)
>>> 2017-05-30 09:44:41.634056 7efc3fafa700 -1 osd.41 878 heartbeat_check:
>>> no reply from 10.50.62.152:6853 <http://10.50.62.152:6853> osd.30 since
>>> back 2017-05-30 09:44:21.521517 front 2017-05-30 09:44:21.521517 (cutoff
>>> 2017-05-30 09:44:21.634053)
>>> *2017-05-30 09:44:42.128280 7efc442ac700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 300*
>>> *2017-05-30 09:44:42.128282 7efc442ac700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 300*
>>> *2017-05-30 09:44:42.128284 7efc442ac700  1 heartbeat_map is_healthy
>>> 'tp_osd_tp thread tp_osd_tp' had timed out after 300*
>>>
>>> Do you require any logs from my end? Shall I open tracker for this issue?
>>>
>>> Thanks
>>> Jayaram
>>>
>>>
>>> On Mon, May 29, 2017 at 4:58 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>>> <mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
>>>
>>>     Hi Jake,
>>>
>>>     200MB/s is pretty low load across 5 servers.  I wouldn't expect the
>>>     tp_osd_tp threads to be that heavily loaded that it's not responding
>>>     for 60s.  Sounds like a bug.  Can you reproduce it?  It might be
>>>     worth trying it with debug bluestore = 20.
>>>
>>>     Mark
>>>
>>>
>>>     On 05/27/2017 05:02 AM, Jake Grimmett wrote:
>>>
>>>         Dear All,
>>>
>>>         I wonder if anyone can give advice regarding bluestore OSD's
>>>         going down on
>>>         Luminous 12.0.3 when the cluster is under moderate (200MB/s)
>>> load,
>>>
>>>         OSD's seem to do down randomly across the 5 OSD servers. When
>>>         one OSD is
>>>         down, load decreases, so no further OSD's drop, until I restart
>>>         the OSD,
>>>         then another fails.
>>>
>>>         There are no obvious disk errors seen in /var/log/messages.
>>>
>>>         Here though is part of a ceph-osd.46.log...
>>>
>>>         2017-05-27 10:42:28.781821 7f7c503b4700  0 log_channel(cluster)
>>>         log [WRN]
>>>         : slow request 120.247733 seconds old, received at 2017-05-27
>>>         10:40:28.534048: osd_op(osd.52.1251:8732 1.3ffs0 1.a8ec73ff
>>>         (undecoded)
>>>         ondisk+read+rwordered+ignore_cache+ignore_overlay+map_snap_c
>>> lone+known_if_redirected
>>>         e1342) currently queued_for_pg
>>>         2017-05-27 10:42:33.748109 7f7c52bf1700  1 heartbeat_map
>>> is_healthy
>>>         'tp_osd_tp thread tp_osd_tp' had timed out after 60
>>>
>>>         - these two errors repeat, with more of the 'tp_osd_tp thread
>>>         tp_osd_tp'
>>>         errors.
>>>
>>>         Hopefully this is not due to the highpoint rocket r750 cards in
>>>         my OSD
>>>         servers (the OSD servers are all 45drive.com
>>>         <http://45drive.com> storinators)
>>>
>>>         Other info - each node has 64GB ram, 10 x 8TB Ironwolf drive,
>>>         10Gb Intel
>>>         nic, single E5-2620 v4
>>>
>>>         Any advice gratefully received!
>>>
>>>         thanks,
>>>
>>>         Jake
>>>
>>>     _______________________________________________
>>>     ceph-users mailing list
>>>     ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>     <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>
>>>
>>>
>>>
>

--001a113e2420a1b5550550cf4768
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+ ceph-devel ..<div><br></div><div><div>$ps -ef | grep 294=
</div><div>ceph =C2=A0 =C2=A0 3539720 =C2=A0 =C2=A0 =C2=A0 1 14 08:04 ? =C2=
=A0 =C2=A0 =C2=A0 =C2=A000:16:35 /usr/bin/ceph-osd -f --cluster ceph --id 2=
94 --setuser ceph --setgroup ceph</div></div><div><br></div><div>$gcore -o =
coredump-osd =C2=A03539720</div><div><br></div><div><br></div><div><div>$(g=
db) bt</div><div>#0 =C2=A00x00007f5ef68f56d5 in pthread_cond_wait@@GLIBC_2.=
3.2 () from /lib64/libpthread.so.0</div><div>#1 =C2=A00x00007f5ef9cc45ab in=
 ceph::logging::Log::entry() ()</div><div>#2 =C2=A00x00007f5ef68f1dc5 in st=
art_thread () from /lib64/libpthread.so.0</div><div>#3 =C2=A00x00007f5ef57e=
173d in clone () from /lib64/libc.so.6</div></div><div><br></div><div><br><=
/div><div><div><b>2017-05-31 10:11:51.064495 7f5ef383b700 =C2=A01 heartbeat=
_map is_healthy &#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60=
</b></div><div><b>2017-05-31 10:11:51.064496 7f5ef383b700 =C2=A01 heartbeat=
_map is_healthy &#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60=
</b></div><div><b>2017-05-31 10:11:51.064497 7f5ef383b700 =C2=A01 heartbeat=
_map is_healthy &#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60=
</b></div><div><b>2017-05-31 10:11:51.064497 7f5ef383b700 =C2=A01 heartbeat=
_map is_healthy &#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60=
</b></div><div><b>2017-05-31 10:11:51.064498 7f5ef383b700 =C2=A01 heartbeat=
_map is_healthy &#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60=
</b></div><div>2017-05-31 10:11:51.957092 7f5eef88a700 -1 osd.294 1004 hear=
tbeat_check: no reply from <a href=3D"http://10.50.62.154:6858">10.50.62.15=
4:6858</a> osd.64 since back 2017-05-31 09:58:53.016145 front 2017-05-31 09=
:58:53.016145 (cutoff 2017-05-31 10:11:31.957089)</div><div>2017-05-31 10:1=
1:51.957114 7f5eef88a700 -1 osd.294 1004 heartbeat_check: no reply from <a =
href=3D"http://10.50.62.154:6931">10.50.62.154:6931</a> osd.82 since back 2=
017-05-31 10:04:48.204500 front 2017-05-31 10:04:48.204500 (cutoff 2017-05-=
31 10:11:31.957089)</div><div>2017-05-31 10:11:51.957121 7f5eef88a700 -1 os=
d.294 1004 heartbeat_check: no reply from <a href=3D"http://10.50.62.152:69=
29">10.50.62.152:6929</a> osd.162 since back 2017-05-31 09:57:37.451595 fro=
nt 2017-05-31 09:57:37.451595 (cutoff 2017-05-31 10:11:31.957089)</div></di=
v><div><br></div><div><br></div><div><br></div><div>Thanks</div><div>Jayara=
m</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On T=
ue, May 30, 2017 at 7:33 PM, nokia ceph <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hel=
lo Mark,<div><br></div><div>Yes this issue happens once the test/write star=
ted after 60 secs which correspond config value -- &quot;<span style=3D"col=
or:rgb(80,0,80);font-size:12.8px">threadpool_default_timeout =3D 60 &quot; =
. Do you require the down OSD coredump to analyse=C2=A0</span><span style=
=3D"font-size:12.8px">tp_osd_tp state. . Please be specify which process du=
mp you would require to analyse.=C2=A0</span></div><div><span style=3D"font=
-size:12.8px"><br></span></div><div><span style=3D"font-size:12.8px">Like ,=
</span></div><div><span style=3D"font-size:12.8px">#gcore &lt;PID of down O=
SD&gt;=C2=A0</span></div><div><span style=3D"font-size:12.8px"><br></span><=
/div><div><span style=3D"font-size:12.8px">or using wallclock profiler, I&#=
39;m not much aware how to use this tool.=C2=A0</span></div><div><span styl=
e=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-size:12.8p=
x">Thanks</span></div><div><span style=3D"font-size:12.8px">Jayaram</span><=
/div></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Tue, May 30, 2017 at 6:57 PM, Mark Nel=
son <span dir=3D"ltr">&lt;<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_=
blank">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span>On 05/30/2017 05:07 AM, nokia ceph wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello Mark,<br>
<br>
I can able to reproduce this problem everytime.<br>
</blockquote>
<br></span>
Ok, next question, does it happen 60s after starting the 200MB/s load, or d=
oes it take a while?=C2=A0 Sounds like it&#39;s pretty random across OSDs? =
I&#39;m thinking we want to figure out what state the tp_osd_tp threads are=
 in when this is happening (maybe via a gdb bt or using the wallclock profi=
ler to gather several samples) and then figure out via the logs what lead t=
o the chain of events that put it in that state.<br>
<br>
Mark<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span>
<br>
Env:-- 5 node, v12.0.3, EC 4+1 bluestore , RHEL 7.3 - 3.10.0-514.el7.x86_64=
<br>
<br>
Tested with debug bluestore =3D 20...<br>
<br>
From ceph watch<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
2017-05-30 08:57:33.510794 mon.0 [INF] pgmap v15649: 8192 pgs: 8192<br>
active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB avail; 35167<br>
B/s rd, 77279 kB/s wr, 726 op/s<br>
2017-05-30 08:57:35.134604 mon.0 [INF] pgmap v15650: 8192 pgs: 8192<br>
active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB avail; 19206<br>
B/s rd, 63835 kB/s wr, 579 op/s<br>
2017-05-30 08:57:36.295086 mon.0 [INF] pgmap v15651: 8192 pgs: 8192<br>
active+clean; 774 GB data, 1359 GB used, 1854 TB / 1855 TB avail; 10999<br>
B/s rd, 44093 kB/s wr, 379 op/s<br>
2017-05-30 08:57:37.228422 mon.0 [INF] osd.243 <a href=3D"http://10.50.62.1=
54:6895/1842853" rel=3D"noreferrer" target=3D"_blank">10.50.62.154:6895/184=
2853</a><br></span>
&lt;<a href=3D"http://10.50.62.154:6895/1842853" rel=3D"noreferrer" target=
=3D"_blank">http://10.50.62.154:6895/1842<wbr>853</a>&gt; failed (4 reporte=
rs from different<span><br>
host after 20.062159 &gt;=3D grace 20.000000)<br>
2017-05-30 08:57:37.234308 mon.0 [INF] osd.19 <a href=3D"http://10.50.62.15=
2:6856/1940715" rel=3D"noreferrer" target=3D"_blank">10.50.62.152:6856/1940=
715</a><br></span>
&lt;<a href=3D"http://10.50.62.152:6856/1940715" rel=3D"noreferrer" target=
=3D"_blank">http://10.50.62.152:6856/1940<wbr>715</a>&gt; failed (4 reporte=
rs from different<div><div class=3D"m_-9026048169171084622h5"><br>
host after 20.000234 &gt;=3D grace 20.000000)<br>
2017-05-30 08:57:37.368342 mon.0 [INF] pgmap v15652: 8192 pgs: 8192<br>
active+clean; 774 GB data, 1360 GB used, 1854 TB / 1855 TB avail; 12628<br>
B/s rd, 50471 kB/s wr, 444 op/s<br>
2017-05-30 08:57:37.506743 mon.0 [INF] osdmap e848: 340 osds: 338 up, 340 i=
n<br>
<br>
<br>
From failed osd.19 log<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=3D=3D=3D<br>
2017-05-30 08:57:04.155836 7f9d6c723700 10<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _omap_setkeys 1.1e85s4_head<br>
4#1:a1780000::::head# =3D 0<br>
2017-05-30 08:57:04.155840 7f9d6c723700 10<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _txc_calc_cost 0x7f9da2d1f180 cos=
t<br>
3542664 (2 ios * 1500000 + 542664 bytes)<br>
2017-05-30 08:57:04.155841 7f9d6c723700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _txc_write_nodes txc 0x7f9da2d1f1=
80<br>
onodes 0x7f9da6651840 shared_blobs<br>
2017-05-30 08:57:04.155843 7f9d6c723700 20<br>
bluestore.extentmap(0x7f9da665<wbr>1930) update<br>
4#1:a179feb3:::%2fc20%2fvx0000<wbr>033%2fpot%2fchannel1%2fhls%2fv<wbr>ar266=
0000%2f00000%2fseg0015.<wbr>ts:head#<br>
2017-05-30 08:57:04.155852 7f9d6c723700 20<br>
bluestore.extentmap(0x7f9da665<wbr>1930) update=C2=A0 inline shard 607 byte=
s from<br>
2 extents<br>
2017-05-30 08:57:04.155858 7f9d6c723700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)=C2=A0 =C2=A0onode<br>
4#1:a179feb3:::%2fc20%2fvx0000<wbr>033%2fpot%2fchannel1%2fhls%2fv<wbr>ar266=
0000%2f00000%2fseg0015.<wbr>ts:head#<br>
is 1348 (735 bytes onode + 2 bytes spanning blobs + 611 bytes inline<br>
extents)<br>
2017-05-30 08:57:04.155876 7f9d6c723700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _txc_finalize_kv txc 0x7f9da2d1f1=
80<br>
allocated 0x[388af10000~90000] released 0x[]<br>
2017-05-30 08:57:04.155880 7f9d6c723700 10 freelist allocate<br>
0x388af10000~90000<br>
2017-05-30 08:57:04.155882 7f9d6c723700 20 freelist _xor first_key<br>
0x388af00000 last_key 0x388af80000<br>
2017-05-30 08:57:07.698556 7f9d6a71f700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)<br>
statfsstore_statfs(0x574506f00<wbr>00/0x5753b990000, stored<br>
0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)<br>
2017-05-30 08:57:08.201089 7f9d6a71f700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)<br>
statfsstore_statfs(0x574506f00<wbr>00/0x5753b990000, stored<br>
0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)<br>
2017-05-30 08:57:09.903290 7f9d6a71f700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)<br>
statfsstore_statfs(0x574506f00<wbr>00/0x5753b990000, stored<br>
0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)<br>
2017-05-30 08:57:11.605590 7f9d6a71f700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)<br>
statfsstore_statfs(0x574506f00<wbr>00/0x5753b990000, stored<br>
0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)<br>
2017-05-30 08:57:15.707908 7f9d6a71f700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)<br>
statfsstore_statfs(0x574506f00<wbr>00/0x5753b990000, stored<br>
0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)<br>
2017-05-30 08:57:17.410365 7f9d6a71f700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)<br>
statfsstore_statfs(0x574506f00<wbr>00/0x5753b990000, stored<br>
0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)<br>
2017-05-30 08:57:18.512773 7f9d6a71f700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)<br>
statfsstore_statfs(0x574506f00<wbr>00/0x5753b990000, stored<br>
0xa389a531/0xa70e0000, compress 0x0/0x0/0x0)<br></div></div>
*2017-05-30 08:57:20.005812 7f9d8f712700=C2=A0 1 heartbeat_map is_healthy<b=
r>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60*<br>
*2017-05-30 08:57:20.006648 7f9d8ff13700=C2=A0 1 heartbeat_map is_healthy<b=
r>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60*<br>
*2017-05-30 08:57:20.015585 7f9d8f712700=C2=A0 1 heartbeat_map is_healthy<b=
r>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60*<br>
*2017-05-30 08:57:20.015677 7f9d8f712700=C2=A0 1 heartbeat_map is_healthy<b=
r>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60*<br>
*<br>
*<br>
*..&lt;snip&gt;..*<div><div class=3D"m_-9026048169171084622h5"><br>
<br>
2017-05-30 08:57:37.506457 7f9d875fd700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _do_write perform garbage<br>
collection, expected benefit =3D 0 AUs<br>
2017-05-30 08:57:37.506459 7f9d875fd700 20<br>
bluestore.extentmap(0x7f9da0ed<wbr>50b0) dirty_range mark inline shard dirt=
y<br>
2017-05-30 08:57:37.506461 7f9d875fd700 10<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _write meta<br>
#-1:7b3f43c4:::osd_superblock:<wbr>0# 0x0~1f8 =3D 0<br>
2017-05-30 08:57:37.506463 7f9d875fd700 10<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _txc_calc_cost 0x7f9da2d22680 cos=
t<br>
3104677 (2 ios * 1500000 + 104677 bytes)<br>
2017-05-30 08:57:37.506479 7f9d875fd700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _txc_write_nodes txc 0x7f9da2d226=
80<br>
onodes 0x7f9da0ed4fc0,0x7f9da5bd8000,<wbr>0x7f9da72dad80 shared_blobs<br>
2017-05-30 08:57:37.506482 7f9d875fd700 20<br>
bluestore.extentmap(0x7f9da0ed<wbr>50b0) update #-1:7b3f43c4:::osd_superblo=
ck:<wbr>0#<br>
2017-05-30 08:57:37.506485 7f9d875fd700 20<br>
bluestore.extentmap(0x7f9da0ed<wbr>50b0) update=C2=A0 inline shard 81 bytes=
 from 1<br>
extents<br>
2017-05-30 08:57:37.506491 7f9d875fd700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)=C2=A0 =C2=A0onode<br>
#-1:7b3f43c4:::osd_superblock:<wbr>0# is 108 (21 bytes onode + 2 bytes<br>
spanning blobs + 85 bytes inline extents)<br>
2017-05-30 08:57:37.506495 7f9d875fd700 20<br>
bluestore.extentmap(0x7f9da5bd<wbr>80f0) update #-1:a51ca935:::osdmap.848:0=
#<br>
2017-05-30 08:57:37.506497 7f9d875fd700 20<br>
bluestore.extentmap(0x7f9da5bd<wbr>80f0) update=C2=A0 inline shard 235 byte=
s from<br>
2 extents<br>
2017-05-30 08:57:37.506499 7f9d875fd700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)=C2=A0 =C2=A0onode<br>
#-1:a51ca935:::osdmap.848:0# is 264 (23 bytes onode + 2 bytes spanning<br>
blobs + 239 bytes inline extents)<br>
2017-05-30 08:57:37.506502 7f9d875fd700 20<br>
bluestore.extentmap(0x7f9da72d<wbr>ae70) update #-1:48acce63:::inc_osdmap.8=
48:<wbr>0#<br>
2017-05-30 08:57:37.506504 7f9d875fd700 20<br>
bluestore.extentmap(0x7f9da72d<wbr>ae70) update=C2=A0 inline shard 82 bytes=
 from 1<br>
extents<br>
2017-05-30 08:57:37.506506 7f9d875fd700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19)=C2=A0 =C2=A0onode<br>
#-1:48acce63:::inc_osdmap.848:<wbr>0# is 110 (22 bytes onode + 2 bytes<br>
spanning blobs + 86 bytes inline extents)<br>
2017-05-30 08:57:37.506558 7f9d875fd700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-19) _txc_finalize_kv txc 0x7f9da2d226=
80<br>
allocated 0x[388afa0000~30000] released 0x[]<br>
2017-05-30 08:57:37.506562 7f9d875fd700 10 freelist allocate<br>
0x388afa0000~30000<br>
2017-05-30 08:57:37.506563 7f9d875fd700 20 freelist _xor first_key<br>
0x388af80000 last_key 0x388af80000<br>
2017-05-30 08:57:37.510446 7f9d8ff13700=C2=A0 0 -- <a href=3D"http://10.50.=
63.152:6857/1940715" rel=3D"noreferrer" target=3D"_blank">10.50.63.152:6857=
/1940715</a><br></div></div>
&lt;<a href=3D"http://10.50.63.152:6857/1940715" rel=3D"noreferrer" target=
=3D"_blank">http://10.50.63.152:6857/1940<wbr>715</a>&gt; &gt;&gt; <a href=
=3D"http://10.50.63.153:6869/1572972" rel=3D"noreferrer" target=3D"_blank">=
10.50.63.153:6869/1572972</a><br>
&lt;<a href=3D"http://10.50.63.153:6869/1572972" rel=3D"noreferrer" target=
=3D"_blank">http://10.50.63.153:6869/1572<wbr>972</a>&gt; conn(0x7f9da698a8=
00 :6857<span><br>
s=3DSTATE_OPEN pgs=3D243 cs=3D1 l=3D0).fault with nothing to send, going to=
 standby<br>
2017-05-30 08:57:37.514366 7f9d8ff13700=C2=A0 0 -- <a href=3D"http://10.50.=
63.152:6857/1940715" rel=3D"noreferrer" target=3D"_blank">10.50.63.152:6857=
/1940715</a><br></span>
&lt;<a href=3D"http://10.50.63.152:6857/1940715" rel=3D"noreferrer" target=
=3D"_blank">http://10.50.63.152:6857/1940<wbr>715</a>&gt; &gt;&gt; <a href=
=3D"http://10.50.63.153:6863/1572982" rel=3D"noreferrer" target=3D"_blank">=
10.50.63.153:6863/1572982</a><br>
&lt;<a href=3D"http://10.50.63.153:6863/1572982" rel=3D"noreferrer" target=
=3D"_blank">http://10.50.63.153:6863/1572<wbr>982</a>&gt; conn(0x7f9da620f8=
00 :6857<span><br>
s=3DSTATE_OPEN pgs=3D149 cs=3D1 l=3D0).fault with nothing to send, going to=
 standby<br>
2017-05-30 08:57:37.517351 7f9d8ef11700=C2=A0 1 heartbeat_map is_healthy<br=
>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60<br>
2017-05-30 08:57:37.517354 7f9d8ef11700=C2=A0 1 heartbeat_map is_healthy<br=
>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 60<br>
=3D=3D=3D=3D<br>
<br>
<br>
=C2=A0config value --&gt; threadpool_default_timeout =3D 60<br>
<br>
// default timeout while caling WaitInterval on an empty queue<br>
OPTION(threadpool_default_time<wbr>out, OPT_INT, 60)<br>
<br>
I altered the above value to 300, then it serve for some time<br>
<br>
2017-05-30 09:44:32.027168 7efc1f2b9700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-41)<br>
statfsstore_statfs(0x574f28600<wbr>00/0x5753b990000, stored<br>
0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)<br>
2017-05-30 09:44:35.529164 7efc1f2b9700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-41)<br>
statfsstore_statfs(0x574f28600<wbr>00/0x5753b990000, stored<br>
0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)<br>
2017-05-30 09:44:40.831130 7efc1f2b9700 20<br>
bluestore(/var/lib/ceph/osd/ce<wbr>ph-41)<br>
statfsstore_statfs(0x574f28600<wbr>00/0x5753b990000, stored<br>
0x2e65ed1/0x6730000, compress 0x0/0x0/0x0)<br>
2017-05-30 09:44:41.634056 7efc3fafa700 -1 osd.41 878 heartbeat_check:<br><=
/span>
no reply from <a href=3D"http://10.50.62.152:6853" rel=3D"noreferrer" targe=
t=3D"_blank">10.50.62.152:6853</a> &lt;<a href=3D"http://10.50.62.152:6853"=
 rel=3D"noreferrer" target=3D"_blank">http://10.50.62.152:6853</a>&gt; osd.=
30 since<span><br>
back 2017-05-30 09:44:21.521517 front 2017-05-30 09:44:21.521517 (cutoff<br=
>
2017-05-30 09:44:21.634053)<br></span>
*2017-05-30 09:44:42.128280 7efc442ac700=C2=A0 1 heartbeat_map is_healthy<b=
r>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 300*<br>
*2017-05-30 09:44:42.128282 7efc442ac700=C2=A0 1 heartbeat_map is_healthy<b=
r>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 300*<br>
*2017-05-30 09:44:42.128284 7efc442ac700=C2=A0 1 heartbeat_map is_healthy<b=
r>
&#39;tp_osd_tp thread tp_osd_tp&#39; had timed out after 300*<span><br>
<br>
Do you require any logs from my end? Shall I open tracker for this issue?<b=
r>
<br>
Thanks<br>
Jayaram<br>
<br>
<br>
On Mon, May 29, 2017 at 4:58 AM, Mark Nelson &lt;<a href=3D"mailto:mnelson@=
redhat.com" target=3D"_blank">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a><br></span><div><div cl=
ass=3D"m_-9026048169171084622h5">
&lt;mailto:<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">mnelson@=
redhat.com</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 Hi Jake,<br>
<br>
=C2=A0 =C2=A0 200MB/s is pretty low load across 5 servers.=C2=A0 I wouldn&#=
39;t expect the<br>
=C2=A0 =C2=A0 tp_osd_tp threads to be that heavily loaded that it&#39;s not=
 responding<br>
=C2=A0 =C2=A0 for 60s.=C2=A0 Sounds like a bug.=C2=A0 Can you reproduce it?=
=C2=A0 It might be<br>
=C2=A0 =C2=A0 worth trying it with debug bluestore =3D 20.<br>
<br>
=C2=A0 =C2=A0 Mark<br>
<br>
<br>
=C2=A0 =C2=A0 On 05/27/2017 05:02 AM, Jake Grimmett wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Dear All,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I wonder if anyone can give advice regarding bl=
uestore OSD&#39;s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 going down on<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Luminous 12.0.3 when the cluster is under moder=
ate (200MB/s) load,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OSD&#39;s seem to do down randomly across the 5=
 OSD servers. When<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 one OSD is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 down, load decreases, so no further OSD&#39;s d=
rop, until I restart<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the OSD,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 then another fails.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 There are no obvious disk errors seen in /var/l=
og/messages.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Here though is part of a ceph-osd.46.log...<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2017-05-27 10:42:28.781821 7f7c503b4700=C2=A0 0=
 log_channel(cluster)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 log [WRN]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 : slow request 120.247733 seconds old, received=
 at 2017-05-27<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 10:40:28.534048: osd_op(osd.52.1251:8732 1.3ffs=
0 1.a8ec73ff<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (undecoded)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ondisk+read+rwordered+ignore_c<wbr>ache+ignore_=
overlay+map_snap_c<wbr>lone+known_if_redirected<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 e1342) currently queued_for_pg<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2017-05-27 10:42:33.748109 7f7c52bf1700=C2=A0 1=
 heartbeat_map is_healthy<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;tp_osd_tp thread tp_osd_tp&#39; had timed =
out after 60<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - these two errors repeat, with more of the &#3=
9;tp_osd_tp thread<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tp_osd_tp&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 errors.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hopefully this is not due to the highpoint rock=
et r750 cards in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 my OSD<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 servers (the OSD servers are all <a href=3D"htt=
p://45drive.com" rel=3D"noreferrer" target=3D"_blank">45drive.com</a><br></=
div></div>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"http://45drive.com" rel=3D"noref=
errer" target=3D"_blank">http://45drive.com</a>&gt; storinators)<span><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Other info - each node has 64GB ram, 10 x 8TB I=
ronwolf drive,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 10Gb Intel<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nic, single E5-2620 v4<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Any advice gratefully received!<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Jake<br>
<br>
=C2=A0 =C2=A0 ______________________________<wbr>_________________<br>
=C2=A0 =C2=A0 ceph-users mailing list<br></span>
=C2=A0 =C2=A0 <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank=
">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:ceph-users@lis=
ts.ceph.com" target=3D"_blank">ceph-users-idqoXFIVOFKrVG3r5yU2QA@public.gmane.org<wbr>com</a>&gt;<br>
=C2=A0 =C2=A0 <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph=
.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<w=
br>.cgi/ceph-users-ceph.com</a><br>
=C2=A0 =C2=A0 &lt;<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listin=
f<wbr>o.cgi/ceph-users-ceph.com</a>&gt;<br>
<br>
<br>
</blockquote>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a113e2420a1b5550550cf4768--

--===============1696598181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1696598181==--
