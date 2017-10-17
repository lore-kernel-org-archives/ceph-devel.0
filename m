From: Sage Weil <sage@newdream.net>
Subject: Re: Wish list : automatic rebuild with hot swap osd ?
Date: Tue, 17 Oct 2017 21:22:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710172118210.26702@piezo.us.to>
References: <06c8570a-415c-b830-3102-476a0d85cbdf@epfl.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:40922 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934645AbdJQVWf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Oct 2017 17:22:35 -0400
In-Reply-To: <06c8570a-415c-b830-3102-476a0d85cbdf@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yoann Moulin <yoann.moulin@epfl.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 17 Oct 2017, Yoann Moulin wrote:
> Hello,
> 
> I wonder if it's possible to add to ceph the ability to rebuild a new disk automatically freshly added to a slot in replacement of a failed osd
> disk.
> 
> I imagine something like adding a flag on disks (identified by-path for example or a way to have a deterministic access to the device) to be
> auto-reconfigured if detected with no data after the same slot was marked as failed. Only disks identified "by-path" with an auto-rebuild flag
> activated, and previously marked as failed, can run the auto-reconfiguration.
> 
> I know it should take some time to find the best way to implement that feature to avoid zapping a disk with data but that would be great to
> improve maintainability.

The way that we approached this before with ceph-disk was that you would 
prelabel replacement disks as "blank ceph" or similar.  That way if we saw 
a ceph labeled disk that hadn't been used yet we would know it was fair 
game.  This is a lot more work for the admin (you have to attached each of 
your replacement disks to mark them and then put them in the replacement 
pile) but it is safer.

An alternative model would be to have a reasonably reliable way to 
identify a fresh disk from the factory.  I'm honest not sure what new 
disks look like these days (zero? empty NTFS partition?) but we could try 
to recognized "blank" and go from there.

Unfortunately we can't assume blank if we see garbage because the disk 
might be encrypted.

Anyway, assuming that part was sorted out, I think a complete solution 
would query the mons to see what OSD id used to live in that particular 
by-path location/slot and try to re-use that OSD ID.  We have still built 
in a manual task here of marking the failed osd "destroyed" since reusing 
the ID means the cluster may make assumptions about PG copies on the OSD 
being lost.

sage
