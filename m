From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Hit suicide timeout after adding new osd
Date: Fri, 18 Jan 2013 12:24:30 +0100
Message-ID: <50F930EE.9070201@mermaidconsulting.dk>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx06.stofanet.dk ([212.10.10.58]:42112 "EHLO mx06.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649Ab3ARLYg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Jan 2013 06:24:36 -0500
In-Reply-To: <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

> Unfortunately I can't see what the thread gets stuck doing after it s=
tops=20
> doing work (at an apparently normal point).  Is there any chance you =
can=20
> attach to it with gdb as soon as the log slows down and the initial=20
> timeout messages appear?  Or check the core file and see what thread=20
> 7fd8c1ff3700 is up to?

Here's the info from the core file:

(gdb) thread 45
[Switching to thread 45 (Thread 0x7fd8c1ff3700 (LWP 995))]
#0  0x000000360de0acb4 in pthread_rwlock_rdlock () from=20
/lib64/libpthread.so.0

(gdb) bt
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


Does this help?

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
