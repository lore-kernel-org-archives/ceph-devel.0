From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 10:09:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005201004040.4397@cobra.newdream.net>
References: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56712 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab0ETRGR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 13:06:17 -0400
In-Reply-To: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fred Ar <ar.fred@yahoo.com>
Cc: ceph-devel@vger.kernel.org

> > I'd prefer the situation where i'd stripe over all 4 disks, giving me 
> > and extra pro. In this situation i could configure my node to panic 
> > whenever a disk is starting to give errors, so my cluster can take 
> > over immediately.
> > 
> > Am i right? Is this "the way to go"?
> 
> I don't know the way to go. But I think that in the 1st case (1 OSD per 
> hard disk) when a hard disk fails, it gets replicated elsewhere. During 
> that time the other 3 OSDs on the same machine are still working fine 
> and serving requests. And then some time later, you've got a brand new 
> disk, you shutdown the machnie, that's 3 more OSDs down. In the 2nd 
> case, as soon as 1 disk starts failing, your OSD (which is 4 disks) gets 
> taken down, that's approximately equivalent to 4 OSDs going down at the 
> same time if we compare to your 1st case.

The other 3 osds don't have to rereplicate if you swap the failed disk 
quickly, or otherwise inform the system that the failure is temporary.  By 
default there is a 5 minute timeout.  That can be adjusted, or we can add 
other administrative hooks to 'suspend' any declarations of permanent 
failure for this sort of case.

> About your 2nd case: as cheap as the hardware may be, having 3 perfectly 
> operational disks not working has a cost...
> 
> What I don't know, in both cases, is: when the machines gets back 
> online, will it hold the same data as before being shutdown, or will 
> they get entirely new data? I can remember that crush was quite stable 
> and designed to avoid that kind of full cluster rebalance on failing/new 
> OSD...

For independent disks, the the old data will still be there on the 3 that 
weren't replaced.  If the 4 are striped without redundancy, all will be 
lost due to the singel failure.  If they are striped with redudancy (btrfs 
mirroring, DM/MD or hardware raid, etc.), all 4 disks' data will be there 
(tho there will be some internal rebuild load in the raid).

> I don't understand how - in the 2nd case - the btrfs pool of 4 disks 
> would "repair" its missing data, so that the data on the 3 good disks 
> does not need to get replicated over the network.

Currently it won't, unless you enable data mirroring (off by default).  
The problem is that costs you 2x the storage space, which combined with 
ceph mirroring means you're buying 4x the disk.

I lean toward a cosd per disk in this situation.  The downside is there is 
a bit more work in setting up the CRUSH hierarchy and rules properly.  
User friendly tools to do this would certainly be nice.

sage
