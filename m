From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 2 Mar 2011 13:54:55 -0700
Message-ID: <1299099295.4750.41.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:50102 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab1CBUzK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 15:55:10 -0500
In-Reply-To: <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-03-02 at 10:10 -0700, Sage Weil wrote:
> > I'll see if I see the same signature with master,
> > and post logs.
> 
> Thanks!  Keep us posted.

Hmmm, I'm not having much luck with master (commit 
0fb5ef2ce92 + extra debugging) on a 96-osd filesystem;
lots of dead OSDs during startup.

I used to use a global chdir option to redirect
my core files; my servers are readonly NFS-root, 
with /root on a ramdisk, so being able to point
those core files at persistent storage was useful.
That seems to have changed somewhat.

The backtraces all seem to look like this:

(gdb) bt
#0  0x00007f5d496d79dd in raise (sig=<value optimized out>) at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
#1  0x000000000089bd67 in handle_fatal_signal (signum=6) at common/signal.cc:78
#2  <signal handler called>
#3  0x00007f5d48542265 in raise (sig=<value optimized out>) at ../nptl/sysdeps/unix/sysv/linux/raise.c:64
#4  0x00007f5d48543d10 in abort () at abort.c:88
#5  0x00007f5d48db8cb4 in __gnu_cxx::__verbose_terminate_handler() () from /usr/lib64/libstdc++.so.6
#6  0x00007f5d48db6db6 in ?? () from /usr/lib64/libstdc++.so.6
#7  0x00007f5d48db6de3 in std::terminate() () from /usr/lib64/libstdc++.so.6
#8  0x00007f5d48db6eca in __cxa_throw () from /usr/lib64/libstdc++.so.6
#9  0x000000000066b1ac in ceph::buffer::list::iterator::copy (this=0x7f5d3f4fde40, len=2, dest=0x7f5d3f4fd77e "") at ./include/buffer.h:637
#10 0x00000000006d998c in decode_raw<__le16> (t=@0x7f5d3f4fd77e, p=...) at ./include/encoding.h:35
#11 0x0000000000769a27 in decode (v=@0x7f5d3f4fd7ae, p=...) at ./include/encoding.h:82
#12 0x000000000079c857 in OSDMap::Incremental::decode (this=0x7f5d3f4fd8a0, p=...) at osd/OSDMap.h:204
#13 0x0000000000731803 in OSD::handle_osd_map (this=0x2266af0, m=0x24b2c30) at osd/OSD.cc:2859
#14 0x0000000000733198 in OSD::_dispatch (this=0x2266af0, m=0x24b2c30) at osd/OSD.cc:2428
#15 0x00000000007344e0 in OSD::ms_dispatch (this=0x2266af0, m=0x24b2c30) at osd/OSD.cc:2301
#16 0x000000000068ab9d in Messenger::ms_deliver_dispatch (this=0x220aa30, m=0x24b2c30) at msg/Messenger.h:97
#17 0x0000000000677894 in SimpleMessenger::dispatch_entry (this=0x220aa30) at msg/SimpleMessenger.cc:357
#18 0x000000000066eb2d in SimpleMessenger::DispatchThread::entry (this=0x220aed0) at msg/SimpleMessenger.h:534
#19 0x000000000068b258 in Thread::_entry_func (arg=0x220aed0) at ./common/Thread.h:47
#20 0x00007f5d496cf73d in start_thread (arg=<value optimized out>) at pthread_create.c:301
#21 0x00007f5d485e5f6d in clone () from /lib64/libc.so.6

-- Jim

> sage
> 


