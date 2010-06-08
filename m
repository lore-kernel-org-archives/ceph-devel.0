From: Sage Weil <sage@newdream.net>
Subject: Re: "VFS: Busy inodes after unmount of ceph" kernel-message after
 umount
Date: Mon, 7 Jun 2010 22:21:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006072209280.3013@cobra.newdream.net>
References: <hudfmd$kjm$1@dough.gmane.org> <Pine.LNX.4.64.1006062109410.14891@cobra.newdream.net>
 <huias5$pf4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53757 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0FHFVE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jun 2010 01:21:04 -0400
In-Reply-To: <huias5$pf4$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

> > On Sat, 5 Jun 2010, Thomas Mueller wrote:
> >> hi
> >> 
> >> since running an new snapshot test* that creates some(many?) snapshots
> >> I get this kernel message on umount:
> >> 
> >> VFS: Busy inodes after unmount of ceph. Self-destruct in 5 seconds. 
> >> Have a nice day...
> >> 
> >> this is with kernel 2.6.34 and ceph-client-standalone

This turned out to be an MDS bug (not replying to snap flush messages, 
leaving the inodes pinned).  The server side is fixed in the unstable 
and testing branches.  The client should still be fixed to make some 
noise about such problems.

Thanks for that test script... being able to reliably reproduce the 
problem made fixing it so much easier!

sage
