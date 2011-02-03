From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: cmon: PGMonitor::encode_pending() assert failure
Date: Fri, 4 Feb 2011 09:02:45 +1100
Message-ID: <20110203220245.GA6179@onthe.net.au>
References: <slrnikk2hd.jh1.chris@chris.onthe.net.au>
 <AANLkTi=SyqVD8MyCt+ybYrhoSHunYrchcdZUvW-nzOgw@mail.gmail.com>
 <Pine.LNX.4.64.1102031301550.19855@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:49670 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab1BCWJX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 17:09:23 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1102031301550.19855@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 03, 2011 at 01:03:17PM -0800, Sage Weil wrote:
> Hi Chris,
> 
> This is an interesting one.  Would it be possible for you to
> tar up your mondata directory on the failed node and post it
> somewhere I can get at it?  From the looks of things the pgmap
> incremental state file is truncated, but I'd like to confirm.
> 
> http://tracker.newdream.net/issues/762

Aw crap, sorry, I blew that fs away installing the latest master
to see what happened there ...whereupon overnight I've promptly
hit the "WARNING: at fs/btrfs/inode.c:2143" problem*.

I can revert back to my previous install and run the same
workload to see if it crops up again if that's useful (it took
about 12 hours of rsync'ing files into the fs to get there), or
I can try the workload using latest ceph with Josef Bacik's
btrfs-work** to see if either problem crops up again. Any
preference?

* http://article.gmane.org/gmane.comp.file-systems.ceph.devel/1726
** http://article.gmane.org/gmane.comp.file-systems.ceph.devel/1719

Cheers,

Chris
