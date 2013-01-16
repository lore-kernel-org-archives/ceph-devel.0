From: Sage Weil <sage@inktank.com>
Subject: Re: flashcache
Date: Wed, 16 Jan 2013 13:29:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49259 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204Ab3APV3r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 16:29:47 -0500
In-Reply-To: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 16 Jan 2013, Gandalf Corvotempesta wrote:
> In a ceph cluster, flashcache with writeback is considered safe?
> In case of SSD failure, the flashcache contents should be already been
> replicated (by ceph) in other servers, right?

This sort of configuration effectively bundles the disk and SSD into a 
single unit, where the failure of either results in the loss of both.  
From Ceph's perspective, it doesn't matter if the thing it is sitting on 
is a single disk, an SSD+disk flashcache thing, or a big RAID array.  All 
that changes is the probability of failure.

The thing to watch out for *knowing* that the whole is lost when one part 
fails (vs plowing ahead with a corrupt fs).

> I'm planning to use this configuration: Supermicro with 12 spinning
> disks e 2 SSD.
> 6 spinning disks will have ceph journal on SSD1, the other 6 disks
> will have ceph journal on disks2.
> 
> One OSD for each spinning disk (a single XFS filesystem for the whole disk).
> XFS metadata to a parition of SSD1
> XFS flashcache to another partition of SSD1
> 
> So, 3 partitions for each OSD on the SSD.
> How big should be these partitions? Any advice?
> 
> No raid at all, except for 1 RAID-1 volume made with a 10GB partitions
> on each SSD, for the OS. Log files will be replicated to a remote
> server, so writes on OS partitions are very very low.
> 
> Any hint? Adivice? Critics?

I would worry that there is a lot of stuff piling onto the SSD and it may 
become your bottleneck.  My guess is that another 1-2 SSDs will be a 
better 'balance', but only experiementation will really tell us that.

Otherwise, those seem to all be good things to put on teh SSD!

sage
