From: Sage Weil <sage@newdream.net>
Subject: Re: 0.31
Date: Sun, 10 Jul 2011 14:12:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107101411040.10951@cobra.newdream.net>
References: <4E19837D.7030702@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58499 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120Ab1GJVJd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Jul 2011 17:09:33 -0400
In-Reply-To: <4E19837D.7030702@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hmm, yeah the 'loaded dup inode' messages should never happen.  They 
appear to be just files, though, not directories, so you can safely ignore 
them.  The namespace repair will need to clean that up at some point. The 
recursive rstat errors you saw are probably just fallout from that, and 
can also be ignored.

I'm curious how you got into that state, though.  Are you running a single 
or clustered mds?  Is the workload purely amanda?

sage


On Sun, 10 Jul 2011, Fyodor Ustinov wrote:

> Hi!
> 
> I upgraded my cluster and  got these messages after upgrade mon/mds:
> 
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:40.891614 mds0
> 10.5.51.230:6801/23511 1 : [DBG] reconnect by client4705 10.5.51.242:0/8975
> after 0.005341
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:40.929079 mds0
> 10.5.51.230:6801/23511 2 : [DBG] reconnect by client4605 10.5.51.240:0/1543
> after 0.042807
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.008309 mds0
> 10.5.51.230:6801/23511 3 : [DBG] reconnect by client4710
> 10.5.51.241:0/1492286317 after 0.122038
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.273756 mds0
> 10.5.51.230:6801/23511 4 : [DBG] reconnect by client4525
> 10.5.51.188:0/263432158 after 0.387484
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.586636 mds0
> 10.5.51.230:6801/23511 5 : [ERR] loaded dup inode 1000000a5e9 [2,head] v244 at
> /dcvolia/amanda/state/servers/index/ticket.dcv/_/20110708000502_7.gz, but
> inode 1000000a5e9.head v238 already exists at
> /dcvolia/amanda/state/servers/index/ticket.dcv/_/20110708000502_7.gz.tmp
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.587066 mds0
> 10.5.51.230:6801/23511 6 : [ERR] loaded dup inode 1000000a5e6 [2,head] v429 at
> /dcvolia/amanda/state/servers/index/mail.naperehresti.info/_usr/20110708000502_0.gz,
> but inode 1000000a5e6.head v421 already exists at
> /dcvolia/amanda/state/servers/index/mail.naperehresti.info/_usr/20110708000502_0.gz.tmp
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.587313 mds0
> 10.5.51.230:6801/23511 7 : [ERR] loaded dup inode 1000000a5ec [2,head] v244 at
> /dcvolia/amanda/state/servers/index/iprit.dcv/_/20110708000502_6.gz, but inode
> 1000000a5ec.head v238 already exists at
> /dcvolia/amanda/state/servers/index/iprit.dcv/_/20110708000502_6.gz.tmp
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.588392 mds0
> 10.5.51.230:6801/23511 8 : [ERR] loaded dup inode 1000000a5e8 [2,head] v244 at
> /dcvolia/amanda/state/servers/index/butan.dcv/_/20110708000502_7.gz, but inode
> 1000000a5e8.head v238 already exists at
> /dcvolia/amanda/state/servers/index/butan.dcv/_/20110708000502_7.gz.tmp
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.588509 mds0
> 10.5.51.230:6801/23511 9 : [ERR] loaded dup inode 1000000a5f2 [2,head] v274 at
> /dcvolia/amanda/state/servers/index/tmg.net.ua/_/20110708000502_6.gz, but
> inode 1000000a5f2.head v270 already exists at
> /dcvolia/amanda/state/servers/index/tmg.net.ua/_/20110708000502_6.gz.tmp
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.592042 mds0
> 10.5.51.230:6801/23511 10 : [ERR] loaded dup inode 1000000a5e7 [2,head] v244
> at /dcvolia/amanda/state/servers/index/zoman.dcv/_/20110708000502_7.gz, but
> inode 1000000a5e7.head v238 already exists at
> /dcvolia/amanda/state/servers/index/zoman.dcv/_/20110708000502_7.gz.tmp
> 2011-07-10 13:41:42.950622   log 2011-07-10 13:41:41.592998 mds0
> 10.5.51.230:6801/23511 11 : [ERR] loaded dup inode 1000000a5f1 [2,head] v204
> at /dcvolia/amanda/state/servers/index/ns4.dc.volia.com/_/20110708000502_0.gz,
> but inode 1000000a5f1.head v198 already exists at
> /dcvolia/amanda/state/servers/index/ns4.dc.volia.com/_/20110708000502_0.gz.tmp
> 
> I can not pay attention or do I need start to fear?
> 
> WBR,
>     Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
