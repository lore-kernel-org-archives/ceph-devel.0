From: Sage Weil <sage@inktank.com>
Subject: Re: flashcache
Date: Wed, 16 Jan 2013 13:46:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301161342580.27925@cobra.newdream.net>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com> <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net> <CAJH6TXhCFvA6UF7e+wYOJAxuHi5Q1ug=TQao24Uxd7_AV_ppkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49546 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240Ab3APVqJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 16:46:09 -0500
In-Reply-To: <CAJH6TXhCFvA6UF7e+wYOJAxuHi5Q1ug=TQao24Uxd7_AV_ppkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 16 Jan 2013, Gandalf Corvotempesta wrote:
> 2013/1/16 Sage Weil <sage@inktank.com>:
> > This sort of configuration effectively bundles the disk and SSD into a
> > single unit, where the failure of either results in the loss of both.
> > From Ceph's perspective, it doesn't matter if the thing it is sitting on
> > is a single disk, an SSD+disk flashcache thing, or a big RAID array.  All
> > that changes is the probability of failure.
> 
> Ok, it will fail, but this should not be an issue, in a cluster like
> ceph, right?
> With or without flashcache or SSD, ceph should be able to handle
> disks/nodes/osds failures on its own by replicating in real time to
> multiple server.

Exactly.

> Should I worry about loosing data in case of failure? It should
> rebalance automatically in case of failure with no data loss.

You should not worry, except to the extent that 2 might fail 
simultaneously, and failures in general are not good things.

> > I would worry that there is a lot of stuff piling onto the SSD and it may
> > become your bottleneck.  My guess is that another 1-2 SSDs will be a
> > better 'balance', but only experiementation will really tell us that.
> >
> > Otherwise, those seem to all be good things to put on teh SSD!
> 
> I can't add more than 2 SSD, I don't have enough space.
> I can move OS to the first 2 spinning disks in raid1 software, if this
> will improve performance of SSD
> 
> What about swap? I'm thinking to no use swap at all and start with 
> 16/32GB RAM

You could use the first (single) disk for os and logs.  You might not even 
bother with raid1, since you will presumably be replicating across hosts.  
When the OSD disk dies, you can re-run your chef/juju/puppet rule or 
whatever provisioning tool is at work to reinstall/configure the OS disk.  
The data on the SSDs and data disks will all be intact.

sage
