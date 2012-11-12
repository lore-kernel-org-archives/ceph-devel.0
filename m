From: Sage Weil <sage@inktank.com>
Subject: Re: Disabling journal
Date: Mon, 12 Nov 2012 06:59:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211120654370.28418@cobra.newdream.net>
References: <F905E0C9-46B6-4DD7-A57D-072CD4ADDFEE@profihost.ag> <alpine.DEB.2.00.1211110722100.28418@cobra.newdream.net> <50A019BE.9030002@profihost.ag> <alpine.DEB.2.00.1211120639540.28418@cobra.newdream.net> <50A10C40.9090909@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36831 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2KLO7B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 09:59:01 -0500
In-Reply-To: <50A10C40.9090909@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Mon, 12 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Am 12.11.2012 15:42, schrieb Sage Weil:
> > On Sun, 11 Nov 2012, Stefan Priebe wrote:
> > > Hi Sage,
> > > 
> > > > With btrfs, yes, although this isn't something we have tested in a
> > > > while.
> > > I'm not using btrfs as long as the devs claim it is not ready for prod.
> > 
> > In that case, the journal is needed for consistency of the fs; we rely on
> > writeahead journaling.  It can't be turned off.
> > 
> > Putting it on a ramdisk in this case is interesting for performance, but
> > it means that a crash/reboot/powerloss event leaves the fs in an
> > inconsistent and unusable state.
> 
> But only if for replicas 2 both nodes crash / have a powerloss?

Then you're okay.. but the one that lost the journal effectively also lost 
the contents of the SSD.  Also, manual intervention is currently needed to 
reinitialize the osd (since this is not a normal failure mode).

> > The only time tmpfs is potentially useful in production is when you're
> > using btrfs *and* have independent backup power sources for replicas (and
> > can thus avoid worrying about a site-wide power failure and loss of
> > journal).  (Or have relaxed requirements for the durability of recent
> > writes.)
> What happens for XFS and replicas two and ONE host has a power loss? The other
> replica / journal should be still there.
> 
> I've no idea where to put the journal on.
> 
> I mean i've 8 SSDs per Host one per osd each with a write IOP/s speed of
> 45.000 iops to whole IOP/s write speed of 360.000 IOP/s per Node.
> 
> Which journal device can handle this? And if i put the journal on the same
> disk as the OSD it has to copy the data around.

I think you have two choices.  Either put the journal SSDs (perhaps a 
journal on an existing one), or use a higher-end NVRAM-based device.  
There are several of these out there, although I'm blanking on product 
names at the moment.  The best are probably the battery-backed DRAM ones 
with a bit of flash for when the battery gets low.  Lots of RAID 
controllers also have some onboard NVRAM that can often be finagled into 
being useful, at least with spinning disks; I'm not sure how they perform 
with SSDs.

sage
