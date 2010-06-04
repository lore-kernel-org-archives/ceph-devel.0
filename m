From: Sage Weil <sage@newdream.net>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Fri, 4 Jun 2010 09:48:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006040944331.2384@cobra.newdream.net>
References: <20100531125156.GJ1211@skl-net.de> <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net>
 <20100602081044.GY1212@skl-net.de> <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net>
 <20100604084521.GO1211@skl-net.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33337 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0FDQsU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jun 2010 12:48:20 -0400
In-Reply-To: <20100604084521.GO1211@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: ceph-devel@vger.kernel.org

On Fri, 4 Jun 2010, Andre Noll wrote:
> On Wed, Jun 02, 11:19, Sage Weil Wrote
> > Okay, it looks like there is a corrupt PG log.  Can you tar up the 
> > $osd_data/current/meta directory, and then 'f 8' and 'p /x info.pgid' from 
> > gdb (to figure out which pg it's loading)?
> 
> It's in decode_nohead():
> 
> 	...
> 	Program received signal SIGABRT, Aborted.
> 	[Switching to Thread 0x7ff115b566f0 (LWP 5045)]
> 	0x00007ff1146e9095 in raise () from /lib/libc.so.6
> 	(gdb) f 8
> 	#8  0x0000000000540920 in PG::read_log (this=0x7ff1104b6460,
> 	store=<value optimized out>) at ./include/cstring.h:120
> 	120         _data = new char[_len + 1];
> 	(gdb) p /x info.pgid
> 	$1 = {v = {preferred = {v = 0xffff}, ps = {v = 0x1bf}, pool = {v = 0x0}}}

The pgid's format like $pool.$ps[p$preferred] (where the preferred bit 
only shows up if >= 0).  In hex.  So the pgid above is 0.1bf, and the 
corrupted log should be current/meta/pglog_0.1bf_0.  If you send me that 
file (off list) I can see what the corruption looks like.

If you want to try to bring the osd up without that pg, you can move that 
pglog file and current/0.1bf to some other temp directory and restart 
cosd.

Thanks!
sage

