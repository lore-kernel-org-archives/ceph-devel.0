From: Sage Weil <sage@newdream.net>
Subject: Re: Correct proceedure for removing ceph nodes
Date: Fri, 4 Jun 2010 09:52:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006040951210.2384@cobra.newdream.net>
References: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com>
 <Pine.LNX.4.64.1006021122300.1269@cobra.newdream.net> <20100604130359.GT1211@skl-net.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43811 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab0FDQwh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jun 2010 12:52:37 -0400
In-Reply-To: <20100604130359.GT1211@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Paul <paul_chiang@tcloudcomputing.com>, ceph-devel@vger.kernel.org

On Fri, 4 Jun 2010, Andre Noll wrote:
> On Wed, Jun 02, 11:30, Sage Weil Wrote
> > > 3. OSD:
> > >    Again, I suppose we could just kill the daemon, but that'd leave
> > > holes in the data placement which doesn't seem to be very elegant.
> > > Setting the device weight to 0 in the crushmap works, but trying to
> > > remove a device entriely produces strange results. Could you shed some
> > > light on this?
> > 
> > There are a few ways to go about it.  Simply marking the osd 'out' ('ceph 
> > osd out #') will work, but may not be optimal depending on how the crush 
> > map is set up.  The default crush maps use the 'straw' bucket type 
> > everywhere, which deals with addition/removal optimally, so taking the 
> > additional step of removing the item from the crush map will keep things 
> > tidy and erase all trace of the osd.
> 
> BTW: It would be nice to be able to _replace_ an OSD without having
> a time window during which there is less redundancy.
> 
> IOW, something like the "clone failing disk" feature of some hardware
> raids or LVM's pvmove. The idea is to first mirror all data on two
> disks/PVs/OSDs and to kick out one only after mirroring is complete.

You basically get this by marking the osd 'out' but not 'down', e.g.,

 $ ceph osd out 23   # mark out osd23

The data on osd23 isn't removed until the pg is fully replicated/migrated 
to it's new location.

sage
