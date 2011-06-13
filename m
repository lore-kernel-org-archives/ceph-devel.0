From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: OSD crashing unexpectedly within ~1 minute of being up
Date: Mon, 13 Jun 2011 12:42:04 -0700
Message-ID: <D813E087-470F-4783-9EAD-CFAF705260EC@dreamhost.com>
References: <BANLkTi=GPtNQM1TLOGsqAZ+rqONWCr2cxg@mail.gmail.com> <BANLkTi=GFbDZFg0tZRyDcOQsPDA1T1Hxvw@mail.gmail.com> <BANLkTiktR4+aWjv41vPhmvwLnpmjceiwGQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33960 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab1FMTmF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 15:42:05 -0400
In-Reply-To: <BANLkTiktR4+aWjv41vPhmvwLnpmjceiwGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Teodor Yantchev <teodor.yantchev@gmail.com>
Cc: ceph-devel@vger.kernel.org

Looks like you're running your OSDs out of disk space and they're crashing:
> 2011-06-13 12:41:14.983458 abcf7b70 filestore(/mnt/osd.1) write
> temp/1000000003b.00000007/head 2097152~1048576 = -28


It could probably handle this more elegantly and print out a nice error message before shutting down, but the effect won't be too much different: you're out of disk space, and that scenario isn't handled well.
-Greg

On Jun 13, 2011, at 7:52 AM, Teodor Yantchev wrote:

> Hi All,
> We are trying to setup a ceph cluster of 4 machines set-up as follows:
> osd.0/mon.0/mds.0:
> 
> root@cs-pc-1:/mnt# uname -a
> Linux cs-pc-1 2.6.35-28-generic #50-Ubuntu SMP Fri Mar 18 19:00:26 UTC
> 2011 i686 GNU/Linux
> 
> osd.1 :
> 
> root@nikola-pc:~# uname -a
> Linux nikola-pc 2.6.35-28-generic #49-Ubuntu SMP Tue Mar 1 14:40:58
> UTC 2011 i686 GNU/Linux
> 
> osd.2
> 
> root@work:/var/log/ceph# uname -a
> Linux work 2.6.38-8-generic #42-Ubuntu SMP Mon Apr 11 03:31:24 UTC
> 2011 x86_64 x86_64 x86_64 GNU/Linux
> 
> [osd.0/mon.0/mds.0] and [osd.1] are P4s with 3G of RAM and [osd.2] is
> a Core2Duo G6950 with 4G RAM.
> All disks are setup on loopback devices (/dev/loop0) with osd.1 and
> osd.2 using 1 Gig files (partitions) and osd.0 using 2 Gig FS. All
> formatted with btrfs.
> ceph version (identical on all hosts):
> 
> ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
> 
> /etc/ceph/ceph.conf (same on all hosts):
> 
> [global]
>        pid file = /var/run/ceph/$name.pid
>        debug ms = 10
>        debug filestore = 20
> [mon]
>        mon data = /data/mon.$id
> [mon.0]
>        host = cs-pc-1.local
>        mon addr = 10.10.10.99:6789
> [mds]
>       keyring = /data/keyring.$name
> [mds.0]
>        host = cs-pc-1.local
> [osd]
>        sudo = true
> [osd.0]
>        host = cs-pc-1.local
>        brtfs devs = /dev/loop0
>        osd data = /mnt/osd.0
> ;       osd journal = /dev/loop2
> ;       osd journal size = 16384000
>        keyring = /mnt/osd.0/keyring
> [osd.1]
>        host = nikola-pc.local
>        brtfs devs = /dev/loop0
>        osd data = /mnt/osd.1
>        keyring = /mnt/osd.1/keyring
> [osd.2]
>        host = work.local ; Alex
>        brtfs devs = /dev/loop0
>        osd data = /mnt/osd.2
>        keyring = /mnt/osd.2/keyring
> 
> CRUSH maps as follows :
> 
> root@cs-pc-1:/mnt# cat /tmp/crush.txt
> # begin crush map
> # devices
> device 0 device0
> device 1 device1
> device 2 device2
> # types
> type 0 osd
> type 1 domain
> type 2 pool
> # buckets
> domain root {
> id -1 # do not change unnecessarily
> # weight 3.000
> alg straw
> hash 0 # rjenkins1
> item device0 weight 1.000
> item device1 weight 1.000
> item device2 weight 1.000
> }
> # rules
> rule data {
> ruleset 0
> type replicated
> min_size 1
> max_size 10
> step take root
> step choose firstn 0 type osd
> step emit
> }
> rule metadata {
> ruleset 1
> type replicated
> min_size 1
> max_size 10
> step take root
> step choose firstn 0 type osd
> step emit
> }
> rule rbd {
> ruleset 2
> type replicated
> min_size 1
> max_size 10
> step take root
> step choose firstn 0 type osd
> step emit
> }
> # end crush map
> 
> ceph is setup and starts properly, the filesystem is mountable and
> files can be read from and written to it.
> The problem is that both osd.1 and osd.2 drop out of the cluster
> within 1-2 minutes (not simultaneously though) of being started and we
> have no idea why. osd.0 seems to work ok all the time and never
> crashes.
> This is what we have in the crashing OSDs logs :
> osd.1.log :
> 
> 2011-06-13 12:41:14.789775 a91feb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).reader
> wants 165 from dispatch throttler 3158098/104857600
> 2011-06-13 12:41:14.789821 a8ffcb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 12:41:14.789861 a91feb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).aborted =
> 0
> 2011-06-13 12:41:14.789912 a91feb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).reader
> got message 2902 0xa8a16b60 osd_sub_op_reply(unknown0.0:0 0.20
> 1000000002e.00000001/head [push] ack = 0) v1
> 2011-06-13 12:41:14.789974 a8ffcb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 12:41:14.790013 a8ffcb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).write_ack
> 2902
> 2011-06-13 12:41:14.790053 a91feb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).reader
> wants 165 from dispatch throttler 3158263/104857600
> 2011-06-13 12:41:14.790099 a8ffcb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 12:41:14.790138 a91feb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).aborted =
> 0
> 2011-06-13 12:41:14.790191 a91feb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).reader
> got message 2903 0xa8a18160 osd_sub_op_reply(unknown0.0:0 0.21
> 10000000039.00000017/head [push] ack = 0) v1
> 2011-06-13 12:41:14.790269 a8ffcb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 12:41:14.790314 a8ffcb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).write_ack
> 2903
> 2011-06-13 12:41:14.790358 a8ffcb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 12:41:14.921092 a9cf3b70 -- 0.0.0.0:6802/6566 -->
> 10.10.10.99:6803/5672 -- osd_ping(e272 as_of 272 heartbeat) v1 -- ?+0
> 0xa89002e8 con 0x9663698
> 2011-06-13 12:41:14.921210 a90fdb70 -- 0.0.0.0:6802/6566 >>
> 10.10.10.99:6803/5672 pipe(0x96634e0 sd=12 pgs=222 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 12:41:14.921344 a90fdb70 -- 0.0.0.0:6802/6566 >>
> 10.10.10.99:6803/5672 pipe(0x96634e0 sd=12 pgs=222 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 12:41:14.965400 a91feb70 -- 0.0.0.0:6801/6566 >>
> 10.10.10.99:6802/5672 pipe(0x9663870 sd=13 pgs=545 cs=1 l=0).reader
> wants 898211 from dispatch throttler 3158428/104857600
> 2011-06-13 12:41:14.983377 abcf7b70 filestore(/mnt/osd.1)
> queue_flusher ep 10 fd 14 2097152~1048576 qlen 1
> 2011-06-13 12:41:14.983458 abcf7b70 filestore(/mnt/osd.1) write
> temp/1000000003b.00000007/head 2097152~1048576 = -28
> 2011-06-13 12:41:14.983542 b0f03b70 filestore(/mnt/osd.1) flusher_entry awoke
> *** Caught signal (Aborted) **
>  in thread 0xabcf7b70
> 2011-06-13 12:41:14.983584 b0f03b70 filestore(/mnt/osd.1)
> flusher_entry flushing+closing 14 ep 10
> 2011-06-13 12:41:14.983627 b0f03b70 filestore(/mnt/osd.1) flusher_entry sleeping
>  ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
>  1: cosd() [0x828dbff]
>  2: [0x79d400]
>  3: [0x79d416]
>  4: (gsignal()+0x51) [0x7c8941]
>  5: (abort()+0x182) [0x7cbe42]
>  6: (__assert_fail()+0xf8) [0x7c18e8]
>  7: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x3f6b) [0x821403b]
>  8: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
> std::allocator<ObjectStore::Transaction*> >&, unsigned long
> long)+0x9d) [0x821445d]
>  9: (FileStore::queue_transactions(ObjectStore::Sequencer*,
> std::list<ObjectStore::Transaction*,
> std::allocator<ObjectStore::Transaction*> >&, Context*, Context*,
> Context*)+0x38a) [0x81f88aa]
>  10: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
> ObjectStore::Transaction*, Context*, Context*, Context*)+0x60)
> [0x82194a0]
>  11: (ReplicatedPG::sub_op_push(MOSDSubOp*)+0x1a79) [0x80fb3e9]
>  12: (OSD::dequeue_op(PG*)+0x402) [0x8152622]
>  13: (ThreadPool::worker()+0x2a7) [0x8254ee7]
>  14: (ThreadPool::WorkThread::entry()+0x14) [0x816ea94]
>  15: (()+0x5cc9) [0xe72cc9]
>  16: (clone()+0x5e) [0x86e69e]
> 
> and in osd.2.log:
> 
> 2011-06-13 17:32:28.259790 7f2d9d326700 -- 0.0.0.0:6801/6975 <== osd0
> 10.10.10.99:6802/5672 2913 ==== osd_sub_op(unknown0.0:0 0.2
> 10000000040.00000001/head [push] first v 25'1 snapset=0=[]:[]
> snapc=0=[] subset [0~1048576]) v3 ==== 702+0+1048576 (2328257847 0
> 1809860682) 0x7f2d940d23a0 con 0x1f4f8b0
> 2011-06-13 17:32:28.259898 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).reader
> wants 1049278 from dispatch throttler 1049278/104857600
> 2011-06-13 17:32:28.259987 7f2d9d326700 -- 0.0.0.0:6801/6975
> dispatch_throttle_release 1049278 to dispatch throttler
> 2098556/104857600
> 2011-06-13 17:32:28.260023 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.260051 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).write_ack
> 2913
> 2011-06-13 17:32:28.260075 7f2d9b221700 filestore(/mnt/osd.2)
> queue_transactions existing osr 0x7f2d940e4eb0/0x7f2d94107790
> 2011-06-13 17:32:28.260094 7f2d9b221700 filestore(/mnt/osd.2)
> queue_transactions (trailing journal) 37123 0x1fab630
> 2011-06-13 17:32:28.260105 7f2d9b221700 filestore(/mnt/osd.2)
> _do_transaction on 0x1fab630
> 2011-06-13 17:32:28.260118 7f2d9b221700 filestore(/mnt/osd.2) remove
> temp/10000000040.00000001/head
> 2011-06-13 17:32:28.260138 7f2d9b221700 filestore(/mnt/osd.2) lfn_get
> cid=temp oid=10000000040.00000001/head
> pathname=/mnt/osd.2/current/temp/10000000040.00000001_head
> lfn=10000000040.00000001_head is_lfn=0
> 2011-06-13 17:32:28.260222 7f2d9b221700 filestore(/mnt/osd.2) remove
> temp/10000000040.00000001/head = -1
> 2011-06-13 17:32:28.260241 7f2d9b221700 filestore(/mnt/osd.2) write
> temp/10000000040.00000001/head 0~1048576
> 2011-06-13 17:32:28.260254 7f2d9b221700 filestore(/mnt/osd.2) lfn_get
> cid=temp oid=10000000040.00000001/head
> pathname=/mnt/osd.2/current/temp/10000000040.00000001_head
> lfn=10000000040.00000001_head is_lfn=0
> 2011-06-13 17:32:28.263061 7f2d9b221700 filestore(/mnt/osd.2)
> queue_flusher ep 10 fd 14 0~1048576 qlen 1
> 2011-06-13 17:32:28.263100 7f2d9b221700 filestore(/mnt/osd.2) write
> temp/10000000040.00000001/head 0~1048576 = 1048576
> 2011-06-13 17:32:28.263140 7f2da0b2d700 filestore(/mnt/osd.2)
> flusher_entry awoke
> 2011-06-13 17:32:28.263180 7f2da0b2d700 filestore(/mnt/osd.2)
> flusher_entry flushing+closing 14 ep 10
> 2011-06-13 17:32:28.263312 7f2d9b221700 -- 0.0.0.0:6801/6975 -->
> 10.10.10.99:6802/5672 -- osd_sub_op_reply(unknown0.0:0 0.2
> 10000000040.00000001/head [push] ack = 0) v1 -- ?+0 0x208fcd0 con
> 0x1f4f8b0
> 2011-06-13 17:32:28.263642 7f2da0b2d700 filestore(/mnt/osd.2)
> flusher_entry sleeping
> 2011-06-13 17:32:28.264521 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.347002 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).aborted =
> 0
> 2011-06-13 17:32:28.348874 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).reader
> got message 2914 0x7f2d940d23a0 osd_sub_op(unknown0.0:0 0.2
> 10000000042.00000008/head [push] first v 25'2 snapset=0=[]:[]
> snapc=0=[] subset [0~1048576]) v3
> 2011-06-13 17:32:28.348934 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.348971 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).write_ack
> 2914
> 2011-06-13 17:32:28.349028 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).reader
> wants 1049278 from dispatch throttler 1049278/104857600
> 2011-06-13 17:32:28.349076 7f2d9d326700 -- 0.0.0.0:6801/6975 <== osd0
> 10.10.10.99:6802/5672 2914 ==== osd_sub_op(unknown0.0:0 0.2
> 10000000042.00000008/head [push] first v 25'2 snapset=0=[]:[]
> snapc=0=[] subset [0~1048576]) v3 ==== 702+0+1048576 (199080187 0
> 4236989312) 0x7f2d940d23a0 con 0x1f4f8b0
> 2011-06-13 17:32:28.349116 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.349249 7f2d9d326700 -- 0.0.0.0:6801/6975
> dispatch_throttle_release 1049278 to dispatch throttler
> 2098556/104857600
> 2011-06-13 17:32:28.349291 7f2d9ba22700 filestore(/mnt/osd.2)
> queue_transactions existing osr 0x7f2d940e4eb0/0x7f2d94107790
> 2011-06-13 17:32:28.349313 7f2d9ba22700 filestore(/mnt/osd.2)
> queue_transactions (trailing journal) 37124 0x1f3d750
> 2011-06-13 17:32:28.349327 7f2d9ba22700 filestore(/mnt/osd.2)
> _do_transaction on 0x1f3d750
> 2011-06-13 17:32:28.349344 7f2d9ba22700 filestore(/mnt/osd.2) remove
> temp/10000000042.00000008/head
> 2011-06-13 17:32:28.349363 7f2d9ba22700 filestore(/mnt/osd.2) lfn_get
> cid=temp oid=10000000042.00000008/head
> pathname=/mnt/osd.2/current/temp/10000000042.00000008_head
> lfn=10000000042.00000008_head is_lfn=0
> 2011-06-13 17:32:28.349471 7f2d9ba22700 filestore(/mnt/osd.2) remove
> temp/10000000042.00000008/head = -1
> 2011-06-13 17:32:28.349493 7f2d9ba22700 filestore(/mnt/osd.2) write
> temp/10000000042.00000008/head 0~1048576
> 2011-06-13 17:32:28.349510 7f2d9ba22700 filestore(/mnt/osd.2) lfn_get
> cid=temp oid=10000000042.00000008/head
> pathname=/mnt/osd.2/current/temp/10000000042.00000008_head
> lfn=10000000042.00000008_head is_lfn=0
> 2011-06-13 17:32:28.373229 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
> 10.10.10.99:6789/0 pipe(0x18b08e0 sd=11 pgs=1980 cs=1 l=1).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.373279 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
> 10.10.10.99:6789/0 pipe(0x18b08e0 sd=11 pgs=1980 cs=1
> l=1).write_keepalive
> 2011-06-13 17:32:28.373323 7f2d9c324700 -- 10.10.10.112:6800/6975 -->
> 10.10.10.99:6789/0 -- log(1 entries) v1 -- ?+0 0x1fabbe0 con 0x18b0b50
> 2011-06-13 17:32:28.373395 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
> 10.10.10.99:6789/0 pipe(0x18b08e0 sd=11 pgs=1980 cs=1 l=1).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.373439 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
> 10.10.10.99:6789/0 pipe(0x18b08e0 sd=11 pgs=1980 cs=1 l=1).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.373506 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
> 10.10.10.99:6789/0 pipe(0x18b08e0 sd=11 pgs=1980 cs=1 l=1).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.436348 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).aborted =
> 0
> 2011-06-13 17:32:28.437221 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).reader
> got message 2915 0x7f2d940ce9a0 osd_sub_op(unknown0.0:0 0.3
> 1000000000a.00000008/head [push] first v 25'1 snapset=0=[]:[]
> snapc=0=[] subset [0~1048576]) v3
> 2011-06-13 17:32:28.437256 7f2d9d326700 -- 0.0.0.0:6801/6975 <== osd0
> 10.10.10.99:6802/5672 2915 ==== osd_sub_op(unknown0.0:0 0.3
> 1000000000a.00000008/head [push] first v 25'1 snapset=0=[]:[]
> snapc=0=[] subset [0~1048576]) v3 ==== 702+0+1048576 (2538818211 0
> 2577587947) 0x7f2d940ce9a0 con 0x1f4f8b0
> 2011-06-13 17:32:28.437284 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).reader
> wants 1049278 from dispatch throttler 1049278/104857600
> 2011-06-13 17:32:28.437358 7f2d9d326700 -- 0.0.0.0:6801/6975
> dispatch_throttle_release 1049278 to dispatch throttler
> 2098556/104857600
> 2011-06-13 17:32:28.437390 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.437403 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).write_ack
> 2915
> 2011-06-13 17:32:28.437414 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
> 10.10.10.99:6802/5672 pipe(0x1f4f640 sd=12 pgs=561 cs=1 l=0).writer:
> state = 2 policy.server=0
> 2011-06-13 17:32:28.437421 7f2d9b221700 filestore(/mnt/osd.2)
> queue_transactions existing osr 0x2026df0/0x1f0cb70
> 2011-06-13 17:32:28.496529 7f2d9ba22700 filestore(/mnt/osd.2)
> queue_flusher ep 10 fd 14 0~1048576 qlen 1
> 2011-06-13 17:32:28.496563 7f2d9ba22700 filestore(/mnt/osd.2) write
> temp/10000000042.00000008/head 0~1048576 = -28
> 2011-06-13 17:32:28.496594 7f2da0b2d700 filestore(/mnt/osd.2)
> flusher_entry awoke
> 2011-06-13 17:32:28.496616 7f2da0b2d700 filestore(/mnt/osd.2)
> flusher_entry flushing+closing 14 ep 10
> 2011-06-13 17:32:28.496637 7f2da0b2d700 filestore(/mnt/osd.2)
> flusher_entry sleeping
> *** Caught signal (Aborted) **
>  in thread 0x7f2d9ba22700
>  ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
>  1: cosd() [0x62b4ce]
>  2: (()+0xfc60) [0x7f2da8577c60]
>  3: (gsignal()+0x35) [0x7f2da736ed05]
>  4: (abort()+0x186) [0x7f2da7372ab6]
>  5: (__assert_fail()+0xf5) [0x7f2da73677c5]
>  6: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x39df) [0x5b8e6f]
>  7: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x75)
> [0x5b9675]
>  8: (FileStore::queue_transactions(ObjectStore::Sequencer*,
> std::list<ObjectStore::Transaction*,
> std::allocator<ObjectStore::Transaction*> >&, Context*, Context*,
> Context*)+0x2d7) [0x5a1bd7]
>  9: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
> ObjectStore::Transaction*, Context*, Context*, Context*)+0x6b)
> [0x5bebbb]
>  10: (ReplicatedPG::sub_op_push(MOSDSubOp*)+0x15d9) [0x4a9569]
>  11: (OSD::dequeue_op(PG*)+0x3b5) [0x50ae45]
>  12: (ThreadPool::worker()+0x50f) [0x5f69bf]
>  13: (ThreadPool::WorkThread::entry()+0xd) [0x5235ad]
>  14: (()+0x6d8c) [0x7f2da856ed8c]
>  15: (clone()+0x6d) [0x7f2da742104d]
> 
> Please advice and thanks in advance :)
> --
> Teodor Yantchev
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

