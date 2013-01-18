From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Hit suicide timeout after adding new osd
Date: Fri, 18 Jan 2013 22:36:17 +0100
Message-ID: <50F9C051.7070900@mermaidconsulting.dk>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.stofanet.dk ([212.10.10.11]:42270 "EHLO mx01.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119Ab3ARVgY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Jan 2013 16:36:24 -0500
In-Reply-To: <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

 > Getting closer.. it looks like someone is blocked with map_lock held=
, or
 > leaked the lock.  Can you do a 'thread apply all bt' with that same =
core
 > file/process?

Sure, here's the result:

(gdb) thread apply all bt

Thread 59 (Thread 0x7fd8ce7fc700 (LWP 981)):
#0  0x000000360d6e60b7 in unlink () from /lib64/libc.so.6
#1  0x00000000007fa741 in LFNIndex::lfn_unlink=20
(this=3Dthis@entry=3D0x7fd8c8000c50, path=3Dstd::vector of length 3, ca=
pacity=20
4 =3D {...}, hoid=3D...,=20
mangled_name=3D"rb.0.11b7.4a933baa.00000000a3c0__head_B9A6E309__0") at=20
os/LFNIndex.cc:758
#2  0x00000000007fb463 in LFNIndex::remove_object (this=3D0x7fd8c8000c5=
0,=20
from=3Dstd::vector of length 3, capacity 4 =3D {...}, hoid=3D...) at=20
os/LFNIndex.cc:293
#3  0x0000000000802dd1 in HashIndex::_remove (this=3D0x7fd8c8000c50,=20
path=3Dstd::vector of length 3, capacity 4 =3D {...}, hoid=3D...,=20
mangled_name=3D...) at os/HashIndex.cc:273
#4  0x00000000007fbc0e in LFNIndex::unlink (this=3D0x7fd8c8000c50,=20
hoid=3D...) at os/LFNIndex.cc:87
#5  0x00000000007b471f in FileStore::lfn_unlink=20
(this=3Dthis@entry=3D0x1c25130, cid=3D..., o=3D..., spos=3D...) at os/F=
ileStore.cc:361
#6  0x00000000007b4960 in FileStore::_remove (this=3Dthis@entry=3D0x1c2=
5130,=20
cid=3D..., oid=3D..., spos=3D...) at os/FileStore.cc:2841
#7  0x00000000007c967a in FileStore::_do_transaction=20
(this=3Dthis@entry=3D0x1c25130, t=3D..., op_seq=3Dop_seq@entry=3D137685=
42,=20
trans_num=3Dtrans_num@entry=3D0) at os/FileStore.cc:2405
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#8  0x00000000007cb47c in FileStore::do_transactions (this=3D0x1c25130,=
=20
tls=3Dstd::list, op_seq=3D13768542) at os/FileStore.cc:2122
#9  0x00000000007a0b68 in FileStore::_do_op (this=3D0x1c25130,=20
osr=3D<optimized out>) at os/FileStore.cc:1955
#10 0x00000000008cbefc in ThreadPool::worker (this=3D0x1c25b38,=20
wt=3D0x1c65630) at common/WorkQueue.cc:113
#11 0x00000000008cce70 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#12 0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#13 0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 58 (Thread 0x7fd8d41f2700 (LWP 1018)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd884001320) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd884001320, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8d41f1c8f "\377\001", len=3Dlen@entry=3D1) at msg/Pipe=
=2Ecc:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd884001320) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 57 (Thread 0x7fd8d42f3700 (LWP 1016)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd87c000fe8) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd87c000e10) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 56 (Thread 0x7fd8e46c5700 (LWP 1003)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x948a6b8) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x948a4e0) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 55 (Thread 0x7fd8d44f5700 (LWP 1015)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd884000fe8) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd884000e10) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 54 (Thread 0x7fd8e691d700 (LWP 32747)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000084daeb in ceph::log::Log::entry (this=3D0x1a82b80) at=20
log/Log.cc:323
#2  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#3  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 53 (Thread 0x7fd8e45c4700 (LWP 1006)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x948a4e0) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read (this=3Dthis@entry=3D0x948a4e0=
,=20
buf=3D<optimized out>, buf@entry=3D0x7fd8e45c3c8f "\377*", len=3Dlen@en=
try=3D1)=20
at msg/Pipe.cc:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x948a4e0) at msg/Pipe.c=
c:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 52 (Thread 0x7fd8baffd700 (LWP 1000)):
#0  0x000000360de0b902 in pthread_cond_timedwait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000006b5642 in WaitUntil (when=3D..., mutex=3D...,=20
this=3D0x1aa4fe8) at common/Cond.h:71
#2  WaitInterval (interval=3D..., mutex=3D..., cct=3D<optimized out>,=20
this=3D0x1aa4fe8) at common/Cond.h:79
#3  OSD::heartbeat_entry (this=3D0x1aa44f0) at osd/OSD.cc:2086
#4  0x00000000006f9f0d in OSD::T_Heartbeat::entry (this=3D<optimized ou=
t>)=20
at osd/OSD.h:548
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 51 (Thread 0x7fd8cc7f8700 (LWP 1019)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd8840014f8) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd884001320) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 50 (Thread 0x7fd8bbfff700 (LWP 998)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000007a0723 in Wait (mutex=3D..., this=3D0x1c25970) at=20
common/Cond.h:55
#2  FileStore::op_queue_reserve_throttle (this=3Dthis@entry=3D0x1c25130=
,=20
o=3Do@entry=3D0x7fd8b0066070) at os/FileStore.cc:1925
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#3  0x00000000007bde7a in FileStore::queue_transactions (this=3D0x1c251=
30,=20
posr=3D<optimized out>, tls=3Dempty std::list, onreadable=3D0x7fd8b006a=
430,=20
ondisk=3D0x7fd8b00329f0, onreadable_sync=3D<optimized out>,=20
osd_op=3Dstd::tr1::shared_ptr (empty) 0x0) at os/FileStore.cc:2030
#4  0x00000000007ce702 in ObjectStore::queue_transaction=20
(this=3D0x1c25130, osr=3Dosr@entry=3D0x3c24260, t=3Dt@entry=3D0x7fd8b01=
00340,=20
onreadable=3D0x7fd8b006a430, ondisk=3Dondisk@entry=3D0x7fd8b00329f0,=20
onreadable_sync=3Donreadable_sync@entry=3D0x0, op=3Dstd::tr1::shared_pt=
r=20
(empty) 0x0)
     at os/ObjectStore.h:645
#5  0x00000000006a9c22 in OSD::RemoveWQ::_process (this=3D0x1aa5a60,=20
item=3D0x7db97f0) at osd/OSD.cc:2316
#6  0x00000000008cbefc in ThreadPool::worker (this=3D0x1aa4c48,=20
wt=3D0x3c4d860) at common/WorkQueue.cc:113
#7  0x00000000008cce70 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#8  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#9  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 49 (Thread 0x7fd8e43c2700 (LWP 1008)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd88c000a98) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd88c0008c0) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 48 (Thread 0x7fd8cc2f3700 (LWP 1026)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd858000d90) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd858000d90, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8cc2f2c8f "\377]", len=3Dlen@entry=3D1) at msg/Pipe.cc=
:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd858000d90) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 47 (Thread 0x7fd8c17f2700 (LWP 996)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000007a0723 in Wait (mutex=3D..., this=3D0x1c25970) at=20
common/Cond.h:55
#2  FileStore::op_queue_reserve_throttle (this=3Dthis@entry=3D0x1c25130=
,=20
o=3Do@entry=3D0x7fd8bc47aae0) at os/FileStore.cc:1925
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#3  0x00000000007bde7a in FileStore::queue_transactions (this=3D0x1c251=
30,=20
posr=3D<optimized out>, tls=3Dempty std::list, onreadable=3D0x7fd8bc469=
fd0,=20
ondisk=3D0x7fd8bc9ff4c0, onreadable_sync=3D<optimized out>,=20
osd_op=3Dstd::tr1::shared_ptr (empty) 0x0) at os/FileStore.cc:2030
#4  0x00000000007ce702 in ObjectStore::queue_transaction=20
(this=3D0x1c25130, osr=3D0x26ea4c0, t=3D0x7fd8bc84abd0,=20
onreadable=3D0x7fd8bc469fd0, ondisk=3D0x7fd8bc9ff4c0, onreadable_sync=3D=
0x0,=20
op=3Dstd::tr1::shared_ptr (empty) 0x0) at os/ObjectStore.h:645
#5  0x00000000006a070c in OSD::dispatch_context_transaction=20
(this=3Dthis@entry=3D0x1aa44f0, ctx=3D..., pg=3Dpg@entry=3D0xb425ae0) a=
t=20
osd/OSD.cc:4895
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#6  0x00000000006cdf7d in OSD::process_peering_events (this=3D0x1aa44f0=
,=20
pgs=3Dstd::list) at osd/OSD.cc:6188
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#7  0x0000000000709617 in OSD::PeeringWQ::_process (this=3D<optimized=20
out>, pgs=3Dstd::list) at osd/OSD.h:718
#8  0x00000000008cbefc in ThreadPool::worker (this=3D0x1aa4938,=20
wt=3D0x3c4f310) at common/WorkQueue.cc:113
#9  0x00000000008cce70 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#10 0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#11 0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 46 (Thread 0x7fd8e42c1700 (LWP 1009)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd8840008c0) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd8840008c0, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8e42c0c8f "\377\002", len=3Dlen@entry=3D1) at msg/Pipe=
=2Ecc:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd8840008c0) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 45 (Thread 0x7fd8c1ff3700 (LWP 995)):
#0  0x000000360de0acb4 in pthread_rwlock_rdlock () from=20
/lib64/libpthread.so.0
#1  0x00000000006e34a9 in RWLock::get_read (this=3D0x1aa54c8) at=20
common/RWLock.h:51
#2  0x00000000006a0857 in OSD::queue_want_up_thru=20
(this=3Dthis@entry=3D0x1aa44f0, want=3Dwant@entry=3D460) at osd/OSD.cc:=
2585
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#3  0x00000000006ce175 in OSD::process_peering_events (this=3D0x1aa44f0=
,=20
pgs=3Dstd::list) at osd/OSD.cc:6193
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#4  0x0000000000709617 in OSD::PeeringWQ::_process (this=3D<optimized=20
out>, pgs=3Dstd::list) at osd/OSD.h:718
#5  0x00000000008cbefc in ThreadPool::worker (this=3D0x1aa4938,=20
wt=3D0x3c539a0) at common/WorkQueue.cc:113
#6  0x00000000008cce70 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#7  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#8  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 44 (Thread 0x7fd8cc1f2700 (LWP 1027)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd858001d10) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd858001d10, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8cc1f1c8f "\377]", len=3Dlen@entry=3D1) at msg/Pipe.cc=
:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd858001d10) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
---Type <return> to continue, or q <return> to quit---
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 43 (Thread 0x7fd8e41c0700 (LWP 1010)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd87c0008c0) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd87c0008c0, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8e41bfc8f "\377_", len=3Dlen@entry=3D1) at msg/Pipe.cc=
:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd87c0008c0) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 42 (Thread 0x7fd8c27f4700 (LWP 994)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000084091f in Wait (mutex=3D..., this=3D0x7fffed153d70) at=20
common/Cond.h:55
#2  Finisher::finisher_thread_entry (this=3D0x7fffed153d10) at=20
common/Finisher.cc:80
#3  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#4  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 41 (Thread 0x7fd8cc3f4700 (LWP 1028)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd858001470) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd858001470, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8cc3f3c8f "\377]", len=3Dlen@entry=3D1) at msg/Pipe.cc=
:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd858001470) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 40 (Thread 0x7fd8c2ff5700 (LWP 993)):
#0  0x000000360de0b902 in pthread_cond_timedwait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008c7ed8 in WaitUntil (when=3D..., mutex=3D...,=20
this=3D0x7fffed153c58) at common/Cond.h:71
#2  SafeTimer::timer_thread (this=3D0x7fffed153c48) at common/Timer.cc:=
115
#3  0x00000000008c8e0d in SafeTimerThread::entry (this=3D<optimized out=
>)=20
at common/Timer.cc:38
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 39 (Thread 0x7fd8e691e780 (LWP 32746)):
#0  0x000000360de08e60 in pthread_join () from /lib64/libpthread.so.0
#1  0x00000000008c3322 in Thread::join (this=3D0x1a86380, prval=3D<opti=
mized=20
out>) at common/Thread.cc:121
#2  0x00000000008bc028 in SimpleMessenger::wait (this=3D0x1a86180) at=20
msg/SimpleMessenger.cc:490
#3  0x0000000000611a31 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed=20
out>) at ceph_osd.cc:446

Thread 38 (Thread 0x7fd8d45f6700 (LWP 1013)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd87c000a98) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd87c0008c0) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 37 (Thread 0x7fd8c37f6700 (LWP 992)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x0000000000947c31 in Accepter::entry (this=3D0x1a88a40) at=20
msg/Accepter.cc:198
#2  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#3  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 36 (Thread 0x7fd8c0ff1700 (LWP 997)):
#0  0x000000360de0b902 in pthread_cond_timedwait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008cbbe0 in WaitUntil (when=3D..., mutex=3D...,=20
this=3D0x1aa4b38) at common/Cond.h:71
#2  WaitInterval (interval=3D..., mutex=3D..., cct=3D<optimized out>,=20
this=3D0x1aa4b38) at common/Cond.h:79
#3  ThreadPool::worker (this=3D0x1aa4ac0, wt=3D0x3c4fcb0) at=20
common/WorkQueue.cc:131
#4  0x00000000008cce70 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 35 (Thread 0x7fd8c3ff7700 (LWP 991)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000096345b in Wait (mutex=3D..., this=3D0x1a88ad0) at=20
common/Cond.h:55
#2  DispatchQueue::entry (this=3D0x1a88a68) at msg/DispatchQueue.cc:117
#3  0x00000000008c0a4d in DispatchQueue::DispatchThread::entry=20
(this=3D<optimized out>) at msg/DispatchQueue.h:85
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 34 (Thread 0x7fd8d46f7700 (LWP 1012)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd884000e10) at msg/Pipe.cc:1991
---Type <return> to continue, or q <return> to quit---
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd884000e10, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8d46f6c8f "\377", len=3Dlen@entry=3D1) at msg/Pipe.cc:=
1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd884000e10) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 33 (Thread 0x7fd8c57fa700 (LWP 988)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000007a0723 in Wait (mutex=3D..., this=3D0x1c25970) at=20
common/Cond.h:55
#2  FileStore::op_queue_reserve_throttle (this=3Dthis@entry=3D0x1c25130=
,=20
o=3Do@entry=3D0x7fd8681ab170) at os/FileStore.cc:1925
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#3  0x00000000007bde7a in FileStore::queue_transactions (this=3D0x1c251=
30,=20
posr=3D<optimized out>, tls=3Dempty std::list, onreadable=3D0x7fd8681b0=
010,=20
ondisk=3D0x0, onreadable_sync=3D<optimized out>, osd_op=3Dstd::tr1::sha=
red_ptr=20
(empty) 0x0) at os/FileStore.cc:2030
#4  0x00000000007ce702 in ObjectStore::queue_transaction=20
(this=3D0x1c25130, osr=3Dosr@entry=3D0x0, t=3Dt@entry=3D0x7fd8681a3770,=
=20
onreadable=3Donreadable@entry=3D0x7fd8681b0010, ondisk=3Dondisk@entry=3D=
0x0,=20
onreadable_sync=3Donreadable_sync@entry=3D0x7fd8681a2e00,
     op=3Dstd::tr1::shared_ptr (empty) 0x0) at os/ObjectStore.h:645
#5  0x00000000006dc1f1 in OSD::handle_osd_map=20
(this=3Dthis@entry=3D0x1aa44f0, m=3Dm@entry=3D0x7fd87802a8b0) at osd/OS=
D.cc:3951
#6  0x00000000006dd73b in OSD::_dispatch (this=3Dthis@entry=3D0x1aa44f0=
,=20
m=3Dm@entry=3D0x7fd87802a8b0) at osd/OSD.cc:3417
#7  0x00000000006dddff in OSD::ms_dispatch (this=3D0x1aa44f0,=20
m=3D0x7fd87802a8b0) at osd/OSD.cc:3220
#8  0x00000000009635f3 in ms_deliver_dispatch (m=3D0x7fd87802a8b0,=20
this=3D0x1a86c90) at msg/Messenger.h:549
#9  DispatchQueue::entry (this=3D0x1a86d78) at msg/DispatchQueue.cc:107
#10 0x00000000008c0a4d in DispatchQueue::DispatchThread::entry=20
(this=3D<optimized out>) at msg/DispatchQueue.h:85
#11 0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#12 0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 32 (Thread 0x7fd8e44c3700 (LWP 1007)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd88c0008c0) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd88c0008c0, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8e44c2c8f "\377", len=3Dlen@entry=3D1) at msg/Pipe.cc:=
1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd88c0008c0) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 31 (Thread 0x7fd8c5ffb700 (LWP 987)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x0000000000947c31 in Accepter::entry (this=3D0x1a86240) at=20
msg/Accepter.cc:198
#2  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#3  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 30 (Thread 0x7fd8cc4f5700 (LWP 1023)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd858001ee8) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd858001d10) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 29 (Thread 0x7fd8b9ffb700 (LWP 1002)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008c785a in Wait (mutex=3D..., this=3D0x1aa5f70) at=20
common/Cond.h:55
#2  SafeTimer::timer_thread (this=3D0x1aa5f60) at common/Timer.cc:113
#3  0x00000000008c8e0d in SafeTimerThread::entry (this=3D<optimized out=
>)=20
at common/Timer.cc:38
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 28 (Thread 0x7fd8c77fe700 (LWP 984)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000084091f in Wait (mutex=3D..., this=3D0x1c25638) at=20
common/Cond.h:55
#2  Finisher::finisher_thread_entry (this=3D0x1c255d8) at=20
common/Finisher.cc:80
#3  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#4  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 27 (Thread 0x7fd8cc5f6700 (LWP 1022)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd858001648) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd858001470) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 26 (Thread 0x7fd8cd7fa700 (LWP 983)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000084091f in Wait (mutex=3D..., this=3D0x1c25a68) at=20
common/Cond.h:55
#2  Finisher::finisher_thread_entry (this=3D0x1c25a08) at=20
common/Finisher.cc:80
#3  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#4  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 25 (Thread 0x7fd8ba7fc700 (LWP 1001)):
---Type <return> to continue, or q <return> to quit---
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000084091f in Wait (mutex=3D..., this=3D0x1aa6210) at=20
common/Cond.h:55
#2  Finisher::finisher_thread_entry (this=3D0x1aa61b0) at=20
common/Finisher.cc:80
#3  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#4  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 24 (Thread 0x7fd8cc6f7700 (LWP 1021)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd858000f68) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd858000d90) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 23 (Thread 0x7fd8cdffb700 (LWP 982)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000007b569c in Wait (mutex=3D..., this=3D0x1c25cf0) at=20
common/Cond.h:55
#2  FileStore::flusher_entry (this=3D0x1c25130) at os/FileStore.cc:3272
#3  0x00000000007cea0d in FileStore::FlusherThread::entry=20
(this=3D<optimized out>) at os/FileStore.h:262
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 22 (Thread 0x7fd8bb7fe700 (LWP 999)):
#0  0x000000360de0b902 in pthread_cond_timedwait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008cbbe0 in WaitUntil (when=3D..., mutex=3D...,=20
this=3D0x1aa4e48) at common/Cond.h:71
#2  WaitInterval (interval=3D..., mutex=3D..., cct=3D<optimized out>,=20
this=3D0x1aa4e48) at common/Cond.h:79
#3  ThreadPool::worker (this=3D0x1aa4dd0, wt=3D0x3c45700) at=20
common/WorkQueue.cc:131
#4  0x00000000008cce70 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 21 (Thread 0x7fd8d43f4700 (LWP 1014)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x000000000096fcbc in Pipe::tcp_read_wait=20
(this=3Dthis@entry=3D0x7fd87c000e10) at msg/Pipe.cc:1991
#2  0x000000000096ff80 in Pipe::tcp_read=20
(this=3Dthis@entry=3D0x7fd87c000e10, buf=3D<optimized out>,=20
buf@entry=3D0x7fd8d43f3c8f "\377`", len=3Dlen@entry=3D1) at msg/Pipe.cc=
:1964
#3  0x0000000000980384 in Pipe::reader (this=3D0x7fd87c000e10) at=20
msg/Pipe.cc:1222
#4  0x00000000009833bd in Pipe::Reader::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:47
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 20 (Thread 0x7fd8ceffd700 (LWP 980)):
#0  0x000000360de0ddcd in __lll_lock_wait () from /lib64/libpthread.so.=
0
#1  0x000000360de09c56 in _L_lock_840 () from /lib64/libpthread.so.0
#2  0x000000360de09b58 in pthread_mutex_lock () from /lib64/libpthread.=
so.0
#3  0x000000000089d85b in Mutex::Lock (this=3D0x7fd8b0000d58,=20
no_lockdep=3D<optimized out>) at common/Mutex.cc:90
#4  0x00000000007a0ae5 in FileStore::_do_op (this=3D0x1c25130,=20
osr=3D0x7fd8b0000c90) at os/FileStore.cc:1951
#5  0x00000000008cbefc in ThreadPool::worker (this=3D0x1c25b38,=20
wt=3D0x1aae360) at common/WorkQueue.cc:113
#6  0x00000000008cce70 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#7  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#8  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 19 (Thread 0x7fd8c47f8700 (LWP 990)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000096345b in Wait (mutex=3D..., this=3D0x1a87bb0) at=20
common/Cond.h:55
#2  DispatchQueue::entry (this=3D0x1a87b48) at msg/DispatchQueue.cc:117
#3  0x00000000008c0a4d in DispatchQueue::DispatchThread::entry=20
(this=3D<optimized out>) at msg/DispatchQueue.h:85
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 18 (Thread 0x7fd8cf7fe700 (LWP 979)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000084091f in Wait (mutex=3D..., this=3D0x1c251a8) at=20
common/Cond.h:55
#2  Finisher::finisher_thread_entry (this=3D0x1c25148) at=20
common/Finisher.cc:80
#3  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#4  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 17 (Thread 0x7fd8d47f8700 (LWP 1011)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000097a10e in Wait (mutex=3D..., this=3D0x7fd884000a98) at=20
common/Cond.h:55
#2  Pipe::writer (this=3D0x7fd8840008c0) at msg/Pipe.cc:1470
#3  0x000000000098329d in Pipe::Writer::entry (this=3D<optimized out>) =
at=20
msg/Pipe.h:59
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 16 (Thread 0x7fd8c6ffd700 (LWP 985)):
#0  0x000000360de0b902 in pthread_cond_timedwait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
#1  0x00000000008c7ed8 in WaitUntil (when=3D..., mutex=3D...,=20
this=3D0x1c25818) at common/Cond.h:71
#2  SafeTimer::timer_thread (this=3D0x1c25808) at common/Timer.cc:115
#3  0x00000000008c8e0d in SafeTimerThread::entry (this=3D<optimized out=
>)=20
at common/Timer.cc:38
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 15 (Thread 0x7fd8cffff700 (LWP 978)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000006e283a in Cond::Wait (this=3D0x1bbd920, mutex=3D...) at=
=20
common/Cond.h:55
#2  0x0000000000797a15 in FileJournal::write_finish_thread_entry=20
(this=3D0x1bbd5b0) at os/FileJournal.cc:1316
#3  0x00000000006dfa7d in FileJournal::WriteFinisher::entry=20
(this=3D<optimized out>) at os/FileJournal.h:303
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 14 (Thread 0x7fd8c4ff9700 (LWP 989)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x0000000000947c31 in Accepter::entry (this=3D0x1a86d50) at=20
msg/Accepter.cc:198
#2  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#3  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 13 (Thread 0x7fd8d57fa700 (LWP 977)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x000000000079a96e in Wait (mutex=3D..., this=3D0x1bbd6e8) at=20
common/Cond.h:55
#2  FileJournal::write_thread_entry (this=3D0x1bbd5b0) at=20
os/FileJournal.cc:1108
#3  0x00000000006dfa9d in FileJournal::Writer::entry (this=3D<optimized=
=20
out>) at os/FileJournal.h:293
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 12 (Thread 0x7fd8d67fc700 (LWP 969)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x0000000000829703 in BGThread (this=3D0x1aa3be0) at util/env_posix=
=2Ecc:522
#2  leveldb::(anonymous namespace)::PosixEnv::BGThreadWrapper=20
(arg=3D0x1aa3be0) at util/env_posix.cc:470
#3  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#4  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 11 (Thread 0x7fd8d77fe700 (LWP 965)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008bce60 in Wait (mutex=3D..., this=3D0x1a870f0) at=20
common/Cond.h:55
#2  SimpleMessenger::reaper_entry (this=3D0x1a86c90) at=20
msg/SimpleMessenger.cc:206
#3  0x00000000008c148d in SimpleMessenger::ReaperThread::entry=20
(this=3D<optimized out>) at msg/SimpleMessenger.h:411
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 10 (Thread 0x7fd8d6ffd700 (LWP 968)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008c785a in Wait (mutex=3D..., this=3D0x1aa6098) at=20
common/Cond.h:55
#2  SafeTimer::timer_thread (this=3D0x1aa6088) at common/Timer.cc:113
#3  0x00000000008c8e0d in SafeTimerThread::entry (this=3D<optimized out=
>)=20
at common/Timer.cc:38
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 9 (Thread 0x7fd8c67fc700 (LWP 986)):
#0  0x000000360de0ddcd in __lll_lock_wait () from /lib64/libpthread.so.=
0
#1  0x000000360de09c56 in _L_lock_840 () from /lib64/libpthread.so.0
#2  0x000000360de09b58 in pthread_mutex_lock () from /lib64/libpthread.=
so.0
#3  0x000000000089d85b in Mutex::Lock (this=3D0x1aa4500,=20
no_lockdep=3D<optimized out>) at common/Mutex.cc:90
#4  0x00000000006ddb37 in OSD::ms_dispatch (this=3D0x1aa44f0,=20
m=3D0x7fd880003930) at osd/OSD.cc:3211
#5  0x00000000009635f3 in ms_deliver_dispatch (m=3D0x7fd880003930,=20
this=3D0x1a86180) at msg/Messenger.h:549
#6  DispatchQueue::entry (this=3D0x1a86268) at msg/DispatchQueue.cc:107
#7  0x00000000008c0a4d in DispatchQueue::DispatchThread::entry=20
(this=3D<optimized out>) at msg/DispatchQueue.h:85
#8  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#9  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 8 (Thread 0x7fd8d7fff700 (LWP 967)):
#0  0x000000360de0ddcd in __lll_lock_wait () from /lib64/libpthread.so.=
0
#1  0x000000360de1043c in _L_cond_lock_848 () from /lib64/libpthread.so=
=2E0
#2  0x000000360de10318 in __pthread_mutex_cond_lock () from=20
/lib64/libpthread.so.0
#3  0x000000360de0b9b6 in pthread_cond_timedwait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#4  0x00000000008c7ed8 in WaitUntil (when=3D..., mutex=3D...,=20
this=3D0x1aa4568) at common/Cond.h:71
#5  SafeTimer::timer_thread (this=3D0x1aa4558) at common/Timer.cc:115
#6  0x00000000008c8e0d in SafeTimerThread::entry (this=3D<optimized out=
>)=20
at common/Timer.cc:38
#7  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#8  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 7 (Thread 0x7fd8ccff9700 (LWP 964)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
#1  0x00000000008bce60 in Wait (mutex=3D..., this=3D0x1a88de0) at=20
common/Cond.h:55
#2  SimpleMessenger::reaper_entry (this=3D0x1a88980) at=20
msg/SimpleMessenger.cc:206
#3  0x00000000008c148d in SimpleMessenger::ReaperThread::entry=20
(this=3D<optimized out>) at msg/SimpleMessenger.h:411
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 6 (Thread 0x7fd8d5ffb700 (LWP 976)):
#0  0x000000360de0b902 in pthread_cond_timedwait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000007cd471 in Cond::WaitUntil (this=3Dthis@entry=3D0x1c2576=
8,=20
mutex=3D..., when=3D...) at common/Cond.h:71
#2  0x00000000007cd58e in Cond::WaitInterval (this=3Dthis@entry=3D0x1c2=
5768,=20
cct=3D<optimized out>, mutex=3D..., interval=3D...) at common/Cond.h:79
#3  0x00000000007c3463 in FileStore::sync_entry (this=3D0x1c25130) at=20
os/FileStore.cc:3312
#4  0x00000000007cff6d in FileStore::SyncThread::entry (this=3D<optimiz=
ed=20
out>) at os/FileStore.h:115
#5  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#6  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 5 (Thread 0x7fd8d4ff9700 (LWP 963)):
#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008bce60 in Wait (mutex=3D..., this=3D0x1a87ec0) at=20
common/Cond.h:55
#2  SimpleMessenger::reaper_entry (this=3D0x1a87a60) at=20
msg/SimpleMessenger.cc:206
#3  0x00000000008c148d in SimpleMessenger::ReaperThread::entry=20
(this=3D<optimized out>) at msg/SimpleMessenger.h:411
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 4 (Thread 0x7fd8e4eda700 (LWP 966)):
#0  0x000000360d6ea9e3 in select () from /lib64/libc.so.6
#1  0x000000000082f6fa in SignalHandler::entry (this=3D0x1aa3410) at=20
global/signal_handler.cc:210
#2  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#3  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 3 (Thread 0x7fd8e56db700 (LWP 32750)):
#0  0x000000360d6e8bcf in poll () from /lib64/libc.so.6
#1  0x00000000008cefcd in AdminSocket::entry (this=3D0x1a830d0) at=20
common/admin_socket.cc:228
#2  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#3  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 2 (Thread 0x7fd8c7fff700 (LWP 962)):

#0  0x000000360de0b595 in pthread_cond_wait@@GLIBC_2.3.2 () from=20
/lib64/libpthread.so.0
#1  0x00000000008bce60 in Wait (mutex=3D..., this=3D0x1a865e0) at=20
common/Cond.h:55
#2  SimpleMessenger::reaper_entry (this=3D0x1a86180) at=20
msg/SimpleMessenger.cc:206
#3  0x00000000008c148d in SimpleMessenger::ReaperThread::entry=20
(this=3D<optimized out>) at msg/SimpleMessenger.h:411
#4  0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#5  0x000000360d6f167d in clone () from /lib64/libc.so.6

Thread 1 (Thread 0x7fd8e5edc700 (LWP 32749)):
#0  0x000000360de0eebb in raise () from /lib64/libpthread.so.0
#1  0x000000000082eb46 in reraise_fatal (signum=3D6) at=20
global/signal_handler.cc:58
#2  handle_fatal_signal (signum=3D6) at global/signal_handler.cc:104
#3  <signal handler called>
#4  0x000000360d635925 in raise () from /lib64/libc.so.6
#5  0x000000360d6370d8 in abort () from /lib64/libc.so.6
#6  0x0000003611660dad in __gnu_cxx::__verbose_terminate_handler() ()=20
from /lib64/libstdc++.so.6
#7  0x000000361165eea6 in ?? () from /lib64/libstdc++.so.6
#8  0x000000361165eed3 in std::terminate() () from /lib64/libstdc++.so.=
6
#9  0x000000361165f0fe in __cxa_throw () from /lib64/libstdc++.so.6
#10 0x00000000008d510d in ceph::__ceph_assert_fail (assertion=3D0x9edbf=
1=20
"0 =3D=3D \"hit suicide timeout\"", file=3D<optimized out>, line=3D78,=20
func=3D0x9edd40 "bool=20
ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,=20
time_t)") at common/assert.cc:77
#11 0x00000000008462bb in ceph::HeartbeatMap::_check=20
(this=3Dthis@entry=3D0x1a831d0, h=3D<optimized out>, who=3Dwho@entry=3D=
0x9edc66=20
"is_healthy", now=3Dnow@entry=3D1358454183) at common/HeartbeatMap.cc:7=
8
#12 0x0000000000846a9e in ceph::HeartbeatMap::is_healthy=20
(this=3Dthis@entry=3D0x1a831d0) at common/HeartbeatMap.cc:118
#13 0x0000000000846cc8 in ceph::HeartbeatMap::check_touch_file=20
(this=3D0x1a831d0) at common/HeartbeatMap.cc:129
#14 0x00000000008e01c5 in CephContextServiceThread::entry=20
(this=3D0x1aa02d0) at common/ceph_context.cc:68
#15 0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#16 0x000000360d6f167d in clone () from /lib64/libc.so.6


--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
