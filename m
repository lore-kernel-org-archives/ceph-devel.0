From: Sage Weil <sage@newdream.net>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Wed, 2 Jun 2010 11:19:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net>
References: <20100531125156.GJ1211@skl-net.de> <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net>
 <20100602081044.GY1212@skl-net.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38715 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab0FBSSs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jun 2010 14:18:48 -0400
In-Reply-To: <20100602081044.GY1212@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: ceph-devel@vger.kernel.org

Hi Andre,

On Wed, 2 Jun 2010, Andre Noll wrote:
> On 10:28, Sage Weil wrote:
> 
> > So, the mmap code in buffer.h is actually never called, so my guess is 
> > that posix_memalign() or some other library implementation is doing it.  
> > Can you get a stack trace?  Either look at the core file with gdb or run 
> > cosd via gdb?
> 
> Sure. Here we go:

Okay, it looks like there is a corrupt PG log.  Can you tar up the 
$osd_data/current/meta directory, and then 'f 8' and 'p /x info.pgid' from 
gdb (to figure out which pg it's loading)?

There is an open bug for pglog corruption, but I haven't been able to 
identify where it's actually happening.

Generally speaking, once you identify the bad pg, you can just delete the 
offending pglog and data directory from the osd, restart, and it will 
recover.  Provided you haven't corrupted both copies of the same pg on 
different osds.  Or more often than not, there is more than one corrupted 
log, and you have to repeat the process a few times.

This is probably the sort of corruption that we should log but not crash 
on, so that the osd can continue to start up (and just skip the offending 
pg).  I'll open an issue for that in the tracker.

Thanks-
sage



 > 
> 	root@node142:~# gdb /usr/local/bin/cosd
> 	GNU gdb 6.8-debian
> 	Copyright (C) 2008 Free Software Foundation, Inc.
> 	License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> 	This is free software: you are free to change and redistribute it.
> 	There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> 	and "show warranty" for details.
> 	This GDB was configured as "x86_64-linux-gnu"...
> 	(gdb) run -f -i 6 -c /etc/ceph/ceph.conf
> 	Starting program: /usr/local/bin/cosd -f -i 6 -c /etc/ceph/ceph.conf
> 	[Thread debugging using libthread_db enabled]
> 	 ** WARNING: Ceph is still under heavy development, and is only suitable for **
> 	 **          testing and review.  Do not trust it with important data.       **
> 	starting osd6 at 0.0.0.0:6800/3869 osd_data /var/ceph/osd6 /var/ceph/osd6/journal
> 	[New Thread 0x7f995df606f0 (LWP 3869)]
> 	[New Thread 0x4227e950 (LWP 3872)]
> 	[New Thread 0x41896950 (LWP 3873)]
> 	[New Thread 0x42a7f950 (LWP 3874)]
> 	[New Thread 0x43280950 (LWP 3875)]
> 	[New Thread 0x43a81950 (LWP 3876)]
> 	[New Thread 0x40dd1950 (LWP 3877)]
> 	[New Thread 0x44282950 (LWP 3878)]
> 	[New Thread 0x44a83950 (LWP 3879)]
> 	[New Thread 0x45284950 (LWP 3880)]
> 	[New Thread 0x45a85950 (LWP 3881)]
> 	terminate called after throwing an instance of 'std::bad_alloc'
> 	  what():  std::bad_alloc
> 
> 	Program received signal SIGABRT, Aborted.
> 	[Switching to Thread 0x7f995df606f0 (LWP 3869)]
> 	0x00007f995caf3095 in raise () from /lib/libc.so.6
> 	(gdb)  bt
> 	#0  0x00007f995caf3095 in raise () from /lib/libc.so.6
> 	#1  0x00007f995caf4af0 in abort () from /lib/libc.so.6
> 	#2  0x00007f995d3780e4 in __gnu_cxx::__verbose_terminate_handler () from /usr/lib/libstdc++.so.6
> 	#3  0x00007f995d376076 in ?? () from /usr/lib/libstdc++.so.6
> 	#4  0x00007f995d3760a3 in std::terminate () from /usr/lib/libstdc++.so.6
> 	#5  0x00007f995d37618a in __cxa_throw () from /usr/lib/libstdc++.so.6
> 	#6  0x00007f995d376649 in operator new () from /usr/lib/libstdc++.so.6
> 	#7  0x00007f995d376709 in operator new[] () from /usr/lib/libstdc++.so.6
> 	#8  0x0000000000540920 in PG::read_log (this=0x7f995845be60, store=<value optimized out>) at ./include/cstring.h:120
> 	#9  0x0000000000543187 in PG::read_state (this=0x7f995845be60, store=0x8a4840) at osd/PG.cc:2294
> 	#10 0x00000000004ec1f9 in OSD::load_pgs (this=0x8a04b0) at osd/OSD.cc:884
> 	#11 0x00000000004ecb00 in OSD::init (this=0x8a04b0) at osd/OSD.cc:462
> 	#12 0x000000000045f2cc in main (argc=<value optimized out>, argv=<value optimized out>) at cosd.cc:171
> 
> Thanks for looking into this.
> Andre
> -- 
> The only person who always got his work done by Friday was Robinson Crusoe
> 
