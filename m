From: Sage Weil <sage@newdream.net>
Subject: Re: "VFS: Busy inodes after unmount of ceph" kernel-message after
 umount
Date: Sun, 6 Jun 2010 21:10:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006062109410.14891@cobra.newdream.net>
References: <hudfmd$kjm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47356 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab0FGEKD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jun 2010 00:10:03 -0400
In-Reply-To: <hudfmd$kjm$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Sat, 5 Jun 2010, Thomas Mueller wrote:
> hi
> 
> since running an new snapshot test* that creates some(many?) snapshots I 
> get this kernel message on umount:
> 
> VFS: Busy inodes after unmount of ceph. Self-destruct in 5 seconds.  Have 
> a nice day...
> 
> this is with kernel 2.6.34 and ceph-client-standalone

This one is new.  Can you say a bit more about what workload induced the 
crash?  Or better yet, are you able to reproduce it?

thanks-
sage

