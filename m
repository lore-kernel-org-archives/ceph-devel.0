From: Sage Weil <sage@newdream.net>
Subject: Re: cmon: PGMonitor::encode_pending() assert failure
Date: Thu, 3 Feb 2011 14:24:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102031424000.19855@cobra.newdream.net>
References: <slrnikk2hd.jh1.chris@chris.onthe.net.au>
 <AANLkTi=SyqVD8MyCt+ybYrhoSHunYrchcdZUvW-nzOgw@mail.gmail.com>
 <Pine.LNX.4.64.1102031301550.19855@cobra.newdream.net> <20110203220245.GA6179@onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36519 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab1BCWXz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 17:23:55 -0500
In-Reply-To: <20110203220245.GA6179@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On Fri, 4 Feb 2011, Chris Dunlop wrote:
> On Thu, Feb 03, 2011 at 01:03:17PM -0800, Sage Weil wrote:
> > Hi Chris,
> > 
> > This is an interesting one.  Would it be possible for you to
> > tar up your mondata directory on the failed node and post it
> > somewhere I can get at it?  From the looks of things the pgmap
> > incremental state file is truncated, but I'd like to confirm.
> > 
> > http://tracker.newdream.net/issues/762
> 
> Aw crap, sorry, I blew that fs away installing the latest master
> to see what happened there ...whereupon overnight I've promptly
> hit the "WARNING: at fs/btrfs/inode.c:2143" problem*.
> 
> I can revert back to my previous install and run the same
> workload to see if it crops up again if that's useful (it took
> about 12 hours of rsync'ing files into the fs to get there), or
> I can try the workload using latest ceph with Josef Bacik's
> btrfs-work** to see if either problem crops up again. Any
> preference?

Let's go with latest master and latest bits from Josef.  It's the future!

Thanks!
sage

