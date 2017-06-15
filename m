From: Jake Grimmett <jog@mrc-lmb.cam.ac.uk>
Subject: Re: ceph-mds crash v12.0.3
Date: Thu, 15 Jun 2017 12:32:31 +0100
Message-ID: <77dd0d48-6ff9-5c3d-f828-29824998e0d9@mrc-lmb.cam.ac.uk>
References: <fbb1a455-48c3-16c4-fbbf-2a46e720bb67@mrc-lmb.cam.ac.uk>
 <CAAM7YAmGGoFXpqUNOtJnEt1qvcW4dUeie8y+mrM=5RYuJyrbCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:46137 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdFOLcc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 07:32:32 -0400
In-Reply-To: <CAAM7YAmGGoFXpqUNOtJnEt1qvcW4dUeie8y+mrM=5RYuJyrbCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Jake Grimmett <jake.grimmett@gmail.com>

Hi Yan,

Many thanks for looking into this and providing a patch.

I've downloaded ceph 12.0.3-1661-g3ddbfcd, applied your patch, rebuilt
the rpms, and installed across my cluster.

Unfortunately, the MDS are still crashing, any ideas welcome :)

With "debug_mds = 10" the full Log is 140MB, a truncated version of the
log immediately preceding the crash follows:

best,

Jake

    -5> 2017-06-15 12:21:14.084373 7f77fe590700 10 mds.0.journal
EMetaBlob.replay added (full) [dentry
#1/isilon/sc/users/spc/JessComb_AB_230115/JessB_TO_190115_F6_1/n0/JessB_TO_190115_F6_1.peaks_int
[9f,head] auth NULL (dversion lock) v=3104 inode=0
state=1073741888|bottomlru 0x7f781a3f1860]
    -4> 2017-06-15 12:21:14.084375 7f77fe590700 10 mds.0.journal
EMetaBlob.replay added [inode 1000147f773 [9f,head]
/isilon/sc/users/spc/JessComb_AB_230115/JessB_TO_190115_F6_1/n0/JessB_TO_190115_F6_1.peaks_int
auth v3104 s=4 n(v0 b4 1=1+0) (iversion lock) cr={3554272=0-4194304@9e}
0x7f781a3f5800]
    -3> 2017-06-15 12:21:14.084379 7f77fe590700 10 mds.0.journal
EMetaBlob.replay added (full) [dentry
#1/isilon/sc/users/spc/JessComb_AB_230115/JessB_TO_190115_F6_1/n0/JessB_TO_190115_F6_1.peaks_maxt
[9f,head] auth NULL (dversion lock) v=3132 inode=0
state=1073741888|bottomlru 0x7f781a3f1d40]
    -2> 2017-06-15 12:21:14.084381 7f77fe590700 10 mds.0.journal
EMetaBlob.replay added [inode 1000147f775 [9f,head]
/isilon/sc/users/spc/JessComb_AB_230115/JessB_TO_190115_F6_1/n0/JessB_TO_190115_F6_1.peaks_maxt
auth v3132 s=4 n(v0 b4 1=1+0) (iversion lock) cr={3554272=0-4194304@9e}
0x7f781a3f5e00]
    -1> 2017-06-15 12:21:14.084406 7f77fe590700  0 mds.0.journal
EOpen.replay ino 1000147761b.9a not in metablob
     0> 2017-06-15 12:21:14.085348 7f77fe590700 -1
/root/rpmbuild/BUILD/ceph-12.0.3-1661-g3ddbfcd/src/mds/journal.cc: In
function 'virtual void EOpen::replay(MDSRank*)' thread 7f77fe590700 time
2017-06-15 12:21:14.084409
/root/rpmbuild/BUILD/ceph-12.0.3-1661-g3ddbfcd/src/mds/journal.cc: 2207:
FAILED assert(in)

 ceph version 12.0.3-1661-g3ddbfcd
(3ddbfcd4357ab3a3c2f17f86f88dc83172d4ce0d) luminous (dev)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x110) [0x7f780d290500]
 2: (EOpen::replay(MDSRank*)+0x3e5) [0x7f780d2397b5]
 3: (MDLog::_replay_thread()+0x5f2) [0x7f780d1efd12]
 4: (MDLog::ReplayThread::entry()+0xd) [0x7f780cf9b6ad]
 5: (()+0x7dc5) [0x7f780adb4dc5]
 6: (clone()+0x6d) [0x7f7809e9476d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
  10/10 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 rbd_mirror
   0/ 5 rbd_replay
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   1/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   1/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/10 civetweb
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
   0/ 0 refs
   1/ 5 xio
   1/ 5 compressor
   1/ 5 bluestore
   1/ 5 bluefs
   1/ 3 bdev
   1/ 5 kstore
   4/ 5 rocksdb
   4/ 5 leveldb
   4/ 5 memdb
   1/ 5 kinetic
   1/ 5 fuse
   1/ 5 mgr
   1/ 5 mgrc
   1/ 5 dpdk
   1/ 5 eventtrace
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-mds.cephfs1.log
--- end dump of recent events ---
2017-06-15 12:21:14.101761 7f77fe590700 -1 *** Caught signal (Aborted) **
 in thread 7f77fe590700 thread_name:md_log_replay

 ceph version 12.0.3-1661-g3ddbfcd
(3ddbfcd4357ab3a3c2f17f86f88dc83172d4ce0d) luminous (dev)
 1: (()+0x57d7ff) [0x7f780d2507ff]
 2: (()+0xf370) [0x7f780adbc370]
 3: (gsignal()+0x37) [0x7f7809dd21d7]
 4: (abort()+0x148) [0x7f7809dd38c8]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x284) [0x7f780d290674]
 6: (EOpen::replay(MDSRank*)+0x3e5) [0x7f780d2397b5]
 7: (MDLog::_replay_thread()+0x5f2) [0x7f780d1efd12]
 8: (MDLog::ReplayThread::entry()+0xd) [0x7f780cf9b6ad]
 9: (()+0x7dc5) [0x7f780adb4dc5]
 10: (clone()+0x6d) [0x7f7809e9476d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
     0> 2017-06-15 12:21:14.101761 7f77fe590700 -1 *** Caught signal
(Aborted) **
 in thread 7f77fe590700 thread_name:md_log_replay

 ceph version 12.0.3-1661-g3ddbfcd
(3ddbfcd4357ab3a3c2f17f86f88dc83172d4ce0d) luminous (dev)
 1: (()+0x57d7ff) [0x7f780d2507ff]
 2: (()+0xf370) [0x7f780adbc370]
 3: (gsignal()+0x37) [0x7f7809dd21d7]
 4: (abort()+0x148) [0x7f7809dd38c8]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x284) [0x7f780d290674]
 6: (EOpen::replay(MDSRank*)+0x3e5) [0x7f780d2397b5]
 7: (MDLog::_replay_thread()+0x5f2) [0x7f780d1efd12]
 8: (MDLog::ReplayThread::entry()+0xd) [0x7f780cf9b6ad]
 9: (()+0x7dc5) [0x7f780adb4dc5]
 10: (clone()+0x6d) [0x7f7809e9476d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
  10/10 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 rbd_mirror
   0/ 5 rbd_replay
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   1/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   1/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/10 civetweb
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
   0/ 0 refs
   1/ 5 xio
   1/ 5 compressor
   1/ 5 bluestore
   1/ 5 bluefs
   1/ 3 bdev
   1/ 5 kstore
   4/ 5 rocksdb
   4/ 5 leveldb
   4/ 5 memdb
   1/ 5 kinetic
   1/ 5 fuse
   1/ 5 mgr
   1/ 5 mgrc
   1/ 5 dpdk
   1/ 5 eventtrace
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-mds.cephfs1.log
--- end dump of recent events ---


On 15/06/17 08:10, Yan, Zheng wrote:
> On Wed, Jun 14, 2017 at 11:49 PM, Jake Grimmett <jog@mrc-lmb.cam.ac.uk> wrote:
>> Dear All,
>>
>> Sorry, but I need to add +1 to the mds crash reports with ceph
>> 12.0.3-1507-g52f0deb
>>
>> This happened to me after updating from 12.0.2
>> All was fairly OK for a few hours, I/O  around 500MB/s, then both MDS
>> servers crashed, and have not worked since.
>>
>> The two MDS servers, are active:standby, both now crash immediately
>> after being started.
>>
>> This cluster has been upgraded from Kraken, through several Luminous
>> versions, so I did a clean install of SL7.3 on one MDS server, and still
>> have crashes on this machine.
>>
>> Cluster has 40 x 8TB drives (EC 4+1), with dual replicated NVME
>> providing a hotpool to drive the Cephfs layer. df -h /cephfs is/was
>> 200TB. All OSD's are bluestore, and were generated on Luminous.
>>
>> I enabled snapshots a few days ago, and keep 144 snapshots (one taken
>> every 10 minutes, each is kept for 24 hours only) about 30TB is copied
>> into the fs each day. If snapshots caused the crash, I can regenerate
>> the data, but they are very useful.
>>
>> One MDS gave this log...
>>
>> <http://www.mrc-lmb.cam.ac.uk/jog/ceph-mds.cephfs1.log>
> 
> It is a snapshot related bug. The Attached patch should prevent mds
> from crashing.
> Next time you restart mds, please set debug_mds=10 and upload the log.
> 
> Regards
> Yan, Zheng
> 
>>
>> many thanks for any suggestions, and it's great to see the experimental
>> flag removed from bluestore!
>>
>> Jake
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Dr Jake Grimmett
Head Of Scientific Computing
MRC Laboratory of Molecular Biology
Francis Crick Avenue,
Cambridge CB2 0QH, UK.
Phone 01223 267019
Mobile 0776 9886539
