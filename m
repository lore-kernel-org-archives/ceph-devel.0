From: Teodor Yantchev <teodor.yantchev@gmail.com>
Subject: Fwd: OSD crashing unexpectedly within ~1 minute of being up
Date: Mon, 13 Jun 2011 17:52:26 +0300
Message-ID: <BANLkTiktR4+aWjv41vPhmvwLnpmjceiwGQ@mail.gmail.com>
References: <BANLkTi=GPtNQM1TLOGsqAZ+rqONWCr2cxg@mail.gmail.com>
	<BANLkTi=GFbDZFg0tZRyDcOQsPDA1T1Hxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34918 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab1FMOw1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 10:52:27 -0400
Received: by iwn34 with SMTP id 34so3855537iwn.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jun 2011 07:52:26 -0700 (PDT)
In-Reply-To: <BANLkTi=GFbDZFg0tZRyDcOQsPDA1T1Hxvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,
We are trying to setup a ceph cluster of 4 machines set-up as follows:
osd.0/mon.0/mds.0:

root@cs-pc-1:/mnt# uname -a
Linux cs-pc-1 2.6.35-28-generic #50-Ubuntu SMP Fri Mar 18 19:00:26 UTC
2011 i686 GNU/Linux

osd.1 :

root@nikola-pc:~# uname -a
Linux nikola-pc 2.6.35-28-generic #49-Ubuntu SMP Tue Mar 1 14:40:58
UTC 2011 i686 GNU/Linux

osd.2

root@work:/var/log/ceph# uname -a
Linux work 2.6.38-8-generic #42-Ubuntu SMP Mon Apr 11 03:31:24 UTC
2011 x86_64 x86_64 x86_64 GNU/Linux

[osd.0/mon.0/mds.0] and [osd.1] are P4s with 3G of RAM and [osd.2] is
a Core2Duo=A0G6950 with 4G RAM.
All disks are setup on loopback devices (/dev/loop0) with osd.1 and
osd.2 using 1 Gig files (partitions) and osd.0 using 2 Gig FS. All
formatted with btrfs.
ceph version (identical on all hosts):

ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)

/etc/ceph/ceph.conf (same on all hosts):

[global]
=A0 =A0 =A0 =A0pid file =3D /var/run/ceph/$name.pid
=A0 =A0 =A0 =A0debug ms =3D 10
=A0 =A0 =A0 =A0debug filestore =3D 20
[mon]
=A0 =A0 =A0 =A0mon data =3D /data/mon.$id
[mon.0]
=A0 =A0 =A0 =A0host =3D cs-pc-1.local
=A0 =A0 =A0 =A0mon addr =3D=A010.10.10.99:6789
[mds]
=A0 =A0 =A0 keyring =3D /data/keyring.$name
[mds.0]
=A0 =A0 =A0 =A0host =3D cs-pc-1.local
[osd]
=A0 =A0 =A0 =A0sudo =3D true
[osd.0]
=A0 =A0 =A0 =A0host =3D cs-pc-1.local
=A0 =A0 =A0 =A0brtfs devs =3D /dev/loop0
=A0 =A0 =A0 =A0osd data =3D /mnt/osd.0
; =A0 =A0 =A0 osd journal =3D /dev/loop2
; =A0 =A0 =A0 osd journal size =3D 16384000
=A0 =A0 =A0 =A0keyring =3D /mnt/osd.0/keyring
[osd.1]
=A0 =A0 =A0 =A0host =3D nikola-pc.local
=A0 =A0 =A0 =A0brtfs devs =3D /dev/loop0
=A0 =A0 =A0 =A0osd data =3D /mnt/osd.1
=A0 =A0 =A0 =A0keyring =3D /mnt/osd.1/keyring
[osd.2]
=A0 =A0 =A0 =A0host =3D work.local ; Alex
=A0 =A0 =A0 =A0brtfs devs =3D /dev/loop0
=A0 =A0 =A0 =A0osd data =3D /mnt/osd.2
=A0 =A0 =A0 =A0keyring =3D /mnt/osd.2/keyring

CRUSH maps as follows :

root@cs-pc-1:/mnt# cat /tmp/crush.txt
# begin crush map
# devices
device 0 device0
device 1 device1
device 2 device2
# types
type 0 osd
type 1 domain
type 2 pool
# buckets
domain root {
id -1 # do not change unnecessarily
# weight 3.000
alg straw
hash 0 # rjenkins1
item device0 weight 1.000
item device1 weight 1.000
item device2 weight 1.000
}
# rules
rule data {
ruleset 0
type replicated
min_size 1
max_size 10
step take root
step choose firstn 0 type osd
step emit
}
rule metadata {
ruleset 1
type replicated
min_size 1
max_size 10
step take root
step choose firstn 0 type osd
step emit
}
rule rbd {
ruleset 2
type replicated
min_size 1
max_size 10
step take root
step choose firstn 0 type osd
step emit
}
# end crush map

ceph is setup and starts properly, the filesystem is mountable and
files can be read from and written to it.
The problem is that both osd.1 and osd.2 drop out of the cluster
within 1-2 minutes (not simultaneously though) of being started and we
have no idea why. osd.0 seems to work ok all the time and never
crashes.
This is what we have in the crashing OSDs logs :
osd.1.log :

2011-06-13 12:41:14.789775 a91feb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
reader
wants 165 from dispatch throttler 3158098/104857600
2011-06-13 12:41:14.789821 a8ffcb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
writer:
state =3D 2 policy.server=3D0
2011-06-13 12:41:14.789861 a91feb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
aborted =3D
0
2011-06-13 12:41:14.789912 a91feb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
reader
got message 2902 0xa8a16b60 osd_sub_op_reply(unknown0.0:0 0.20
1000000002e.00000001/head [push] ack =3D 0) v1
2011-06-13 12:41:14.789974 a8ffcb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
writer:
state =3D 2 policy.server=3D0
2011-06-13 12:41:14.790013 a8ffcb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
write_ack
2902
2011-06-13 12:41:14.790053 a91feb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
reader
wants 165 from dispatch throttler 3158263/104857600
2011-06-13 12:41:14.790099 a8ffcb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
writer:
state =3D 2 policy.server=3D0
2011-06-13 12:41:14.790138 a91feb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
aborted =3D
0
2011-06-13 12:41:14.790191 a91feb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
reader
got message 2903 0xa8a18160 osd_sub_op_reply(unknown0.0:0 0.21
10000000039.00000017/head [push] ack =3D 0) v1
2011-06-13 12:41:14.790269 a8ffcb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
writer:
state =3D 2 policy.server=3D0
2011-06-13 12:41:14.790314 a8ffcb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
write_ack
2903
2011-06-13 12:41:14.790358 a8ffcb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
writer:
state =3D 2 policy.server=3D0
2011-06-13 12:41:14.921092 a9cf3b70 --=A00.0.0.0:6802/6566=A0-->
10.10.10.99:6803/5672=A0-- osd_ping(e272 as_of 272 heartbeat) v1 -- ?+0
0xa89002e8 con 0x9663698
2011-06-13 12:41:14.921210 a90fdb70 --=A00.0.0.0:6802/6566=A0>>
10.10.10.99:6803/5672=A0pipe(0x96634e0 sd=3D12 pgs=3D222 cs=3D1 l=3D0).=
writer:
state =3D 2 policy.server=3D0
2011-06-13 12:41:14.921344 a90fdb70 --=A00.0.0.0:6802/6566=A0>>
10.10.10.99:6803/5672=A0pipe(0x96634e0 sd=3D12 pgs=3D222 cs=3D1 l=3D0).=
writer:
state =3D 2 policy.server=3D0
2011-06-13 12:41:14.965400 a91feb70 --=A00.0.0.0:6801/6566=A0>>
10.10.10.99:6802/5672=A0pipe(0x9663870 sd=3D13 pgs=3D545 cs=3D1 l=3D0).=
reader
wants 898211 from dispatch throttler 3158428/104857600
2011-06-13 12:41:14.983377 abcf7b70 filestore(/mnt/osd.1)
queue_flusher ep 10 fd 14 2097152~1048576 qlen 1
2011-06-13 12:41:14.983458 abcf7b70 filestore(/mnt/osd.1) write
temp/1000000003b.00000007/head 2097152~1048576 =3D -28
2011-06-13 12:41:14.983542 b0f03b70 filestore(/mnt/osd.1) flusher_entry=
 awoke
*** Caught signal (Aborted) **
=A0in thread 0xabcf7b70
2011-06-13 12:41:14.983584 b0f03b70 filestore(/mnt/osd.1)
flusher_entry flushing+closing 14 ep 10
2011-06-13 12:41:14.983627 b0f03b70 filestore(/mnt/osd.1) flusher_entry=
 sleeping
=A0ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
=A01: cosd() [0x828dbff]
=A02: [0x79d400]
=A03: [0x79d416]
=A04: (gsignal()+0x51) [0x7c8941]
=A05: (abort()+0x182) [0x7cbe42]
=A06: (__assert_fail()+0xf8) [0x7c18e8]
=A07: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x3f6b) [0=
x821403b]
=A08: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, unsigned long
long)+0x9d) [0x821445d]
=A09: (FileStore::queue_transactions(ObjectStore::Sequencer*,
std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, Context*, Context*,
Context*)+0x38a) [0x81f88aa]
=A010: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction*, Context*, Context*, Context*)+0x60)
[0x82194a0]
=A011: (ReplicatedPG::sub_op_push(MOSDSubOp*)+0x1a79) [0x80fb3e9]
=A012: (OSD::dequeue_op(PG*)+0x402) [0x8152622]
=A013: (ThreadPool::worker()+0x2a7) [0x8254ee7]
=A014: (ThreadPool::WorkThread::entry()+0x14) [0x816ea94]
=A015: (()+0x5cc9) [0xe72cc9]
=A016: (clone()+0x5e) [0x86e69e]

and in osd.2.log:

2011-06-13 17:32:28.259790 7f2d9d326700 -- 0.0.0.0:6801/6975 <=3D=3D os=
d0
10.10.10.99:6802/5672 2913 =3D=3D=3D=3D osd_sub_op(unknown0.0:0 0.2
10000000040.00000001/head [push] first v 25'1 snapset=3D0=3D[]:[]
snapc=3D0=3D[] subset [0~1048576]) v3 =3D=3D=3D=3D 702+0+1048576 (23282=
57847 0
1809860682) 0x7f2d940d23a0 con 0x1f4f8b0
2011-06-13 17:32:28.259898 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).re=
ader
wants 1049278 from dispatch throttler 1049278/104857600
2011-06-13 17:32:28.259987 7f2d9d326700 -- 0.0.0.0:6801/6975
dispatch_throttle_release 1049278 to dispatch throttler
2098556/104857600
2011-06-13 17:32:28.260023 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
iter:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.260051 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
ite_ack
2913
2011-06-13 17:32:28.260075 7f2d9b221700 filestore(/mnt/osd.2)
queue_transactions existing osr 0x7f2d940e4eb0/0x7f2d94107790
2011-06-13 17:32:28.260094 7f2d9b221700 filestore(/mnt/osd.2)
queue_transactions (trailing journal) 37123 0x1fab630
2011-06-13 17:32:28.260105 7f2d9b221700 filestore(/mnt/osd.2)
_do_transaction on 0x1fab630
2011-06-13 17:32:28.260118 7f2d9b221700 filestore(/mnt/osd.2) remove
temp/10000000040.00000001/head
2011-06-13 17:32:28.260138 7f2d9b221700 filestore(/mnt/osd.2) lfn_get
cid=3Dtemp oid=3D10000000040.00000001/head
pathname=3D/mnt/osd.2/current/temp/10000000040.00000001_head
lfn=3D10000000040.00000001_head is_lfn=3D0
2011-06-13 17:32:28.260222 7f2d9b221700 filestore(/mnt/osd.2) remove
temp/10000000040.00000001/head =3D -1
2011-06-13 17:32:28.260241 7f2d9b221700 filestore(/mnt/osd.2) write
temp/10000000040.00000001/head 0~1048576
2011-06-13 17:32:28.260254 7f2d9b221700 filestore(/mnt/osd.2) lfn_get
cid=3Dtemp oid=3D10000000040.00000001/head
pathname=3D/mnt/osd.2/current/temp/10000000040.00000001_head
lfn=3D10000000040.00000001_head is_lfn=3D0
2011-06-13 17:32:28.263061 7f2d9b221700 filestore(/mnt/osd.2)
queue_flusher ep 10 fd 14 0~1048576 qlen 1
2011-06-13 17:32:28.263100 7f2d9b221700 filestore(/mnt/osd.2) write
temp/10000000040.00000001/head 0~1048576 =3D 1048576
2011-06-13 17:32:28.263140 7f2da0b2d700 filestore(/mnt/osd.2)
flusher_entry awoke
2011-06-13 17:32:28.263180 7f2da0b2d700 filestore(/mnt/osd.2)
flusher_entry flushing+closing 14 ep 10
2011-06-13 17:32:28.263312 7f2d9b221700 -- 0.0.0.0:6801/6975 -->
10.10.10.99:6802/5672 -- osd_sub_op_reply(unknown0.0:0 0.2
10000000040.00000001/head [push] ack =3D 0) v1 -- ?+0 0x208fcd0 con
0x1f4f8b0
2011-06-13 17:32:28.263642 7f2da0b2d700 filestore(/mnt/osd.2)
flusher_entry sleeping
2011-06-13 17:32:28.264521 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
iter:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.347002 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).ab=
orted =3D
0
2011-06-13 17:32:28.348874 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).re=
ader
got message 2914 0x7f2d940d23a0 osd_sub_op(unknown0.0:0 0.2
10000000042.00000008/head [push] first v 25'2 snapset=3D0=3D[]:[]
snapc=3D0=3D[] subset [0~1048576]) v3
2011-06-13 17:32:28.348934 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
iter:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.348971 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
ite_ack
2914
2011-06-13 17:32:28.349028 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).re=
ader
wants 1049278 from dispatch throttler 1049278/104857600
2011-06-13 17:32:28.349076 7f2d9d326700 -- 0.0.0.0:6801/6975 <=3D=3D os=
d0
10.10.10.99:6802/5672 2914 =3D=3D=3D=3D osd_sub_op(unknown0.0:0 0.2
10000000042.00000008/head [push] first v 25'2 snapset=3D0=3D[]:[]
snapc=3D0=3D[] subset [0~1048576]) v3 =3D=3D=3D=3D 702+0+1048576 (19908=
0187 0
4236989312) 0x7f2d940d23a0 con 0x1f4f8b0
2011-06-13 17:32:28.349116 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
iter:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.349249 7f2d9d326700 -- 0.0.0.0:6801/6975
dispatch_throttle_release 1049278 to dispatch throttler
2098556/104857600
2011-06-13 17:32:28.349291 7f2d9ba22700 filestore(/mnt/osd.2)
queue_transactions existing osr 0x7f2d940e4eb0/0x7f2d94107790
2011-06-13 17:32:28.349313 7f2d9ba22700 filestore(/mnt/osd.2)
queue_transactions (trailing journal) 37124 0x1f3d750
2011-06-13 17:32:28.349327 7f2d9ba22700 filestore(/mnt/osd.2)
_do_transaction on 0x1f3d750
2011-06-13 17:32:28.349344 7f2d9ba22700 filestore(/mnt/osd.2) remove
temp/10000000042.00000008/head
2011-06-13 17:32:28.349363 7f2d9ba22700 filestore(/mnt/osd.2) lfn_get
cid=3Dtemp oid=3D10000000042.00000008/head
pathname=3D/mnt/osd.2/current/temp/10000000042.00000008_head
lfn=3D10000000042.00000008_head is_lfn=3D0
2011-06-13 17:32:28.349471 7f2d9ba22700 filestore(/mnt/osd.2) remove
temp/10000000042.00000008/head =3D -1
2011-06-13 17:32:28.349493 7f2d9ba22700 filestore(/mnt/osd.2) write
temp/10000000042.00000008/head 0~1048576
2011-06-13 17:32:28.349510 7f2d9ba22700 filestore(/mnt/osd.2) lfn_get
cid=3Dtemp oid=3D10000000042.00000008/head
pathname=3D/mnt/osd.2/current/temp/10000000042.00000008_head
lfn=3D10000000042.00000008_head is_lfn=3D0
2011-06-13 17:32:28.373229 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
10.10.10.99:6789/0 pipe(0x18b08e0 sd=3D11 pgs=3D1980 cs=3D1 l=3D1).writ=
er:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.373279 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
10.10.10.99:6789/0 pipe(0x18b08e0 sd=3D11 pgs=3D1980 cs=3D1
l=3D1).write_keepalive
2011-06-13 17:32:28.373323 7f2d9c324700 -- 10.10.10.112:6800/6975 -->
10.10.10.99:6789/0 -- log(1 entries) v1 -- ?+0 0x1fabbe0 con 0x18b0b50
2011-06-13 17:32:28.373395 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
10.10.10.99:6789/0 pipe(0x18b08e0 sd=3D11 pgs=3D1980 cs=3D1 l=3D1).writ=
er:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.373439 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
10.10.10.99:6789/0 pipe(0x18b08e0 sd=3D11 pgs=3D1980 cs=3D1 l=3D1).writ=
er:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.373506 7f2da8b7d700 -- 10.10.10.112:6800/6975 >>
10.10.10.99:6789/0 pipe(0x18b08e0 sd=3D11 pgs=3D1980 cs=3D1 l=3D1).writ=
er:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.436348 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).ab=
orted =3D
0
2011-06-13 17:32:28.437221 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).re=
ader
got message 2915 0x7f2d940ce9a0 osd_sub_op(unknown0.0:0 0.3
1000000000a.00000008/head [push] first v 25'1 snapset=3D0=3D[]:[]
snapc=3D0=3D[] subset [0~1048576]) v3
2011-06-13 17:32:28.437256 7f2d9d326700 -- 0.0.0.0:6801/6975 <=3D=3D os=
d0
10.10.10.99:6802/5672 2915 =3D=3D=3D=3D osd_sub_op(unknown0.0:0 0.3
1000000000a.00000008/head [push] first v 25'1 snapset=3D0=3D[]:[]
snapc=3D0=3D[] subset [0~1048576]) v3 =3D=3D=3D=3D 702+0+1048576 (25388=
18211 0
2577587947) 0x7f2d940ce9a0 con 0x1f4f8b0
2011-06-13 17:32:28.437284 7f2d9921d700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).re=
ader
wants 1049278 from dispatch throttler 1049278/104857600
2011-06-13 17:32:28.437358 7f2d9d326700 -- 0.0.0.0:6801/6975
dispatch_throttle_release 1049278 to dispatch throttler
2098556/104857600
2011-06-13 17:32:28.437390 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
iter:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.437403 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
ite_ack
2915
2011-06-13 17:32:28.437414 7f2d9901b700 -- 0.0.0.0:6801/6975 >>
10.10.10.99:6802/5672 pipe(0x1f4f640 sd=3D12 pgs=3D561 cs=3D1 l=3D0).wr=
iter:
state =3D 2 policy.server=3D0
2011-06-13 17:32:28.437421 7f2d9b221700 filestore(/mnt/osd.2)
queue_transactions existing osr 0x2026df0/0x1f0cb70
2011-06-13 17:32:28.496529 7f2d9ba22700 filestore(/mnt/osd.2)
queue_flusher ep 10 fd 14 0~1048576 qlen 1
2011-06-13 17:32:28.496563 7f2d9ba22700 filestore(/mnt/osd.2) write
temp/10000000042.00000008/head 0~1048576 =3D -28
2011-06-13 17:32:28.496594 7f2da0b2d700 filestore(/mnt/osd.2)
flusher_entry awoke
2011-06-13 17:32:28.496616 7f2da0b2d700 filestore(/mnt/osd.2)
flusher_entry flushing+closing 14 ep 10
2011-06-13 17:32:28.496637 7f2da0b2d700 filestore(/mnt/osd.2)
flusher_entry sleeping
*** Caught signal (Aborted) **
=A0in thread 0x7f2d9ba22700
=A0ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
=A01: cosd() [0x62b4ce]
=A02: (()+0xfc60) [0x7f2da8577c60]
=A03: (gsignal()+0x35) [0x7f2da736ed05]
=A04: (abort()+0x186) [0x7f2da7372ab6]
=A05: (__assert_fail()+0xf5) [0x7f2da73677c5]
=A06: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x39df) [0=
x5b8e6f]
=A07: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x75)
[0x5b9675]
=A08: (FileStore::queue_transactions(ObjectStore::Sequencer*,
std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, Context*, Context*,
Context*)+0x2d7) [0x5a1bd7]
=A09: (ObjectStore::queue_transaction(ObjectStore::Sequencer*,
ObjectStore::Transaction*, Context*, Context*, Context*)+0x6b)
[0x5bebbb]
=A010: (ReplicatedPG::sub_op_push(MOSDSubOp*)+0x15d9) [0x4a9569]
=A011: (OSD::dequeue_op(PG*)+0x3b5) [0x50ae45]
=A012: (ThreadPool::worker()+0x50f) [0x5f69bf]
=A013: (ThreadPool::WorkThread::entry()+0xd) [0x5235ad]
=A014: (()+0x6d8c) [0x7f2da856ed8c]
=A015: (clone()+0x6d) [0x7f2da742104d]

Please advice and thanks in advance :)
--
Teodor Yantchev
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
