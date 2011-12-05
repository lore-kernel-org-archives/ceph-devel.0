From: Sage Weil <sage@newdream.net>
Subject: Re: os/FileJournal.cc: 1011: FAILED assert(seq >= last_committed_seq)
Date: Mon, 5 Dec 2011 09:44:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112050943260.16190@cobra.newdream.net>
References: <4ED4C68A.9060606@tuxadero.com> <4ED4C87F.6010505@grnet.gr>
 <4ED4CCAB.6040005@tuxadero.com> <4ED4E477.6060108@tuxadero.com>
 <Pine.LNX.4.64.1111290806450.32268@cobra.newdream.net> <4EDCB881.3060704@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39132 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799Ab1LERoL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 12:44:11 -0500
In-Reply-To: <4EDCB881.3060704@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

dc167bac7800c75df971bded4b54e0de48f7b18f (wip-journal branch) should fix 
this.  Can you give it a test before I push to stable?

Thanks!
sage


On Mon, 5 Dec 2011, Martin Mailand wrote:

> Hi Sage,
> it happened again, this time I have the log, it's attached.
> 
> (gdb) thread 1
> [Switching to thread 1 (Thread 24077)]#0  0x00007f7995b83b3b in raise () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> (gdb) frame 11
> #11 0x000000000072ee8d in FileJournal::committed_thru (this=0x1ebc000,
> seq=16833973) at os/FileJournal.cc:1011
> 1011    os/FileJournal.cc: No such file or directory.
>         in os/FileJournal.cc
> (gdb) p seq
> $1 = 16833973
> (gdb) p last_committed_seq
> $2 = 16834010
> (gdb)
> 
> Is this all info you need, or should I leave the osd in this state for further
> debugging?
> 
> -martin
> 
> Am 29.11.2011 17:07, schrieb Sage Weil:
> > On Tue, 29 Nov 2011, Martin Mailand wrote:
> > > Hi,
> > > with a build from today, I have the same prob.
> > > 
> > > os/FileJournal.cc: In function 'virtual void
> > > FileJournal::committed_thru(uint64_t)', in thread '7fc55c85f700'
> > > os/FileJournal.cc: 1011: FAILED assert(seq>= last_committed_seq)
> > >   ceph version 0.38-250-gc2889fe
> > > (commit:c2889fef420611df3dd0de4064c91f6aa9f86625)
> > 
> > Can you post a log of the failed ceph-osd restart with 'debug journal =
> > 20' and 'debug filestore = 20'?
> > 
> > Thanks!
> > sage
> > 
> > 
> 
