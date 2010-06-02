From: Sage Weil <sage@newdream.net>
Subject: Re: Correct proceedure for removing ceph nodes
Date: Wed, 2 Jun 2010 11:30:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006021122300.1269@cobra.newdream.net>
References: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39817 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab0FBSaU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jun 2010 14:30:20 -0400
In-Reply-To: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul <paul_chiang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Paul,

On Wed, 2 Jun 2010, Paul wrote:
> We're having trouble figuring out what the correct proceedure for
> (permanently) removing nodes from a ceph cluster is.
> 1. Mon:
>     I see that the MonMap class has a remove operation, but is not
> exposed through the MonmapMonitor. Any reason why not?

No reason.. I think it's just something we haven't tried to do yet.  It 
should be trivial to add a remove function to the MonmapMonitor.  There 
may be some tweaks to make the removed monitor takes itself out of the 
cluster gracefully.

One thing we did change in unstable (for v0.21) is remove the 'whoami' 
stuff from the mon data directory.  Those repositories are now identical 
between monitors, so new monitors can be brought online by copying that 
data around, and monitors can be stopped and restarted as a different rank 
without changing anything on disk.  That will simplify things for removal, 
where taking out a monitor may shift everyone's rank.  It will probably be 
simplest to require that the monitors be restarted to make that work.

> 2. MDS:
>     I guess we just kill the daemon and let the recovery mechanism do
> its job. We notcied however, that decreasing the active mds count
> using set max mds doesn't seem to have any effect: i.e. no MDSes are
> moved back to standby.

You need to tell the mds to shut itself down cleanly by migrating it's 
metadata to other nodes.  After reducing the max_mds value, do something 
like

 $ ceph mds stop 2     # to stop mds2

> 3. OSD:
>    Again, I suppose we could just kill the daemon, but that'd leave
> holes in the data placement which doesn't seem to be very elegant.
> Setting the device weight to 0 in the crushmap works, but trying to
> remove a device entriely produces strange results. Could you shed some
> light on this?

There are a few ways to go about it.  Simply marking the osd 'out' ('ceph 
osd out #') will work, but may not be optimal depending on how the crush 
map is set up.  The default crush maps use the 'straw' bucket type 
everywhere, which deals with addition/removal optimally, so taking the 
additional step of removing the item from the crush map will keep things 
tidy and erase all trace of the osd.

What kind of strange results were you seeing?

sage
