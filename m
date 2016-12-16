From: =?UTF-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass@univ-lorraine.fr>
Subject: Re: Re : Performance issues on Jewel 10.2.2
Date: Fri, 16 Dec 2016 10:37:44 +0100
Message-ID: <33981ae8-4c7a-b053-39ca-a9f2324486b1@univ-lorraine.fr>
References: <CAL2-6bJ9RkB5rdSzauxtLZWwv5_hv9=7LKEAiiR1KTbRZ9tcFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta-outslow2.mel.univ-lorraine.fr ([193.54.32.12]:38000 "EHLO
        mta-outslow2.mel.univ-lorraine.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754990AbcLPJhs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Dec 2016 04:37:48 -0500
In-Reply-To: <CAL2-6bJ9RkB5rdSzauxtLZWwv5_hv9=7LKEAiiR1KTbRZ9tcFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent Godin <vince.mlist@gmail.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Devel <ceph-devel@vger.kernel.org>

Hi,

1 - rados or rbd bug ? We're using rados bench.

2 - This is not bandwith related. If it was, it should happen almost 
instantly and not 15 minutes after I start to write to the pool.
Once it has happened on the pool, I can then reproduce with a fewer 
--concurrent-ios, like 12 or even 1.

This happens with :
OSDs journals on SSDs with the SAS drives in Raid0 writeback with XFS 
and split/merge threshold 10/2 (default)
OSDs journals on SSDs with the SAS drives in Raid0 writeback with XFS 
and split/merge threshold 40/8
OSDs journals on SSDs with the SAS drives in Raid0 writeback with btrfs 
and split/merge threshold 10/2 (default)
OSDs journals on SAS drives (not using the SSDs) in Raid0 writeback with 
XFS and split/merge threshold 10/2 (default)
OSDs journals on SAS drives (not using the SSDs) in Raid0 write-through 
with XFS and split/merge threshold 10/2 (default). PERC H730p mini is 
not the culprit apparently.

I tried with bluestore but OSDs wouldn't launch (even with an 
experimental ... = * set. I suppose its disabled within RHCS 2.0) so I 
couldn't tell if this is filestore related.

When the rados bench stops writing, we can see slow requests, and one or 
more SAS drives hitting 100% iostat usage, even with --concurrent-ios=1. 
With full debug on this particular OSD, we don't see any filestore 
operation anymore.
Just some recurring sched_scrub task and then some :

    -25> 2016-12-16 10:08:41.891756 7f8855051700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7f8865903700' had timed out after 60
    -24> 2016-12-16 10:08:41.891758 7f8855051700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7f8866104700' had timed out after 60
    -23> 2016-12-16 10:08:41.891759 7f8855051700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7f885f0f6700' had timed out after 60
    -22> 2016-12-16 10:08:41.891772 7f8856b57700  1 heartbeat_map 
is_healthy 'OSD::osd_op_tp thread 0x7f8842f10700' had timed out after 15
    -21> 2016-12-16 10:08:41.891775 7f8856b57700  1 heartbeat_map 
is_healthy 'OSD::osd_op_tp thread 0x7f884641b700' had timed out after 15
    -20> 2016-12-16 10:08:41.891777 7f8856b57700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7f885f8f7700' had timed out after 60
    -19> 2016-12-16 10:08:41.891779 7f8856b57700  1 heartbeat_map 
is_healthy 'FileStore::op_tp thread 0x7f88600f8700' had timed out after 60

then the OSD hit the suicide timeout :

      0> 2016-12-16 10:08:42.031740 7f8856b57700 -1 
common/HeartbeatMap.cc: In function 'bool 
ceph::HeartbeatMap::_check(const ceph::heartbeat_handle_d*, const char*, 
time_t)' thread 7f8856b57700 time 2016-12-16 10:08:42.029391
common/HeartbeatMap.cc: 86: FAILED assert(0 == "hit suicide timeout")

  ceph version 10.2.2-41.el7cp (1ac1c364ca12fa985072174e75339bfb1f50e9ee)
  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x85) [0x7f887873be25]
  2: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d const*, char 
const*, long)+0x2e1) [0x7f88786783a1]
  3: (ceph::HeartbeatMap::is_healthy()+0xde) [0x7f8878678bfe]
  4: (OSD::handle_osd_ping(MOSDPing*)+0x93f) [0x7f88780b206f]
  5: (OSD::heartbeat_dispatch(Message*)+0x3cb) [0x7f88780b329b]
  6: (DispatchQueue::entry()+0x78a) [0x7f88787fcd0a]
  7: (DispatchQueue::DispatchThread::entry()+0xd) [0x7f887871761d]
  8: (()+0x7dc5) [0x7f887666adc5]
  9: (clone()+0x6d) [0x7f8874cf673d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- logging levels ---
    0/ 5 none
    0/ 1 lockdep
    0/ 1 context
    1/ 1 crush
    1/ 5 mds
    1/ 5 mds_balancer
    1/ 5 mds_locker
[...]
    1/ 5 kstore
    4/ 5 rocksdb
    4/ 5 leveldb
    1/ 5 kinetic
    1/ 5 fuse
   -2/-2 (syslog threshold)
   -1/-1 (stderr threshold)
   max_recent     10000
   max_new         1000
   log_file /var/log/ceph/ceph-osd.16.log
--- end dump of recent events ---

and comes back to life on its own 2'42" later.

We use ceph version 10.2.2-41.el7cp 
(1ac1c364ca12fa985072174e75339bfb1f50e9ee) (RHCS 2.0).

We're hitting something here.

Regards,

Frederic.


Le 15/12/2016 à 21:04, Vincent Godin a écrit :
> Hello,
>
> I didn't look at your video but i already can tell you some tracks :
>
> 1 - there is a bug in 10.2.2 which make the client cache not working. 
> The client cache works as it never recieved a flush so it will stay in 
> writethrough mode. This bug is clear in 10.2.3
>
> 2 - 2 SSDs in JBOD and 12 x 4TB NL SAS in RAID0 are not very well 
> optimized if your workload is based on write. You will perform in 
> write at the max speed of your two SSD only. I don't know the real 
> speed of your SSD nor your SAS disks but let's say:
>
> your SSD can reach a 400 MB/s in write throughput
> your SAS can reach a 130 MB/s in write throughput
>
> i suppose that you use 1 SSD to host the journals of 6 SAS
> Your max throughput in write will be 2 x 400 MB/s so 800 MB/s compare 
> to the 12 x 130 MB/s = 1560 MB/s of your SAS
>
> if you had 4 SSD for the journal, 1 SSD for 3 SAS
> Your max throughput would be 4 x 400 MB/s so 1600 MB/s very near of 
> the 1560 MB/s of your SAS
>
> Of course, you need to adjust that with the real throughput of your 
> SSD ans SAS disks
>
> Vincent

