From: Sage Weil <sage@newdream.net>
Subject: killing ceph-disk [was Re: ceph-volume: migration and disk partition
 support]
Date: Mon, 9 Oct 2017 15:09:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710091448500.26711@piezo.us.to>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:34636 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdJIPJc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Oct 2017 11:09:32 -0400
In-Reply-To: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

To put this in context, the goal here is to kill ceph-disk in mimic.  

One proposal is to make it so new OSDs can *only* be deployed with LVM, 
and old OSDs with the ceph-disk GPT partitions would be started via 
ceph-volume support that can only start (but not deploy new) OSDs in that 
style.

Is the LVM-only-ness concerning to anyone?

Looking further forward, NVMe OSDs will probably be handled a bit 
differently, as they'll eventually be using SPDK and kernel-bypass (hence, 
no LVM).  For the time being, though, they would use LVM.


On Fri, 6 Oct 2017, Alfredo Deza wrote:
> Now that ceph-volume is part of the Luminous release, we've been able
> to provide filestore support for LVM-based OSDs. We are making use of
> LVM's powerful mechanisms to store metadata which allows the process
> to no longer rely on UDEV and GPT labels (unlike ceph-disk).
> 
> Bluestore support should be the next step for `ceph-volume lvm`, and
> while that is planned we are thinking of ways to improve the current
> caveats (like OSDs not coming up) for clusters that have deployed OSDs
> with ceph-disk.
> 
> --- New clusters ---
> The `ceph-volume lvm` deployment is straightforward (currently
> supported in ceph-ansible), but there isn't support for plain disks
> (with partitions) currently, like there is with ceph-disk.
> 
> Is there a pressing interest in supporting plain disks with
> partitions? Or only supporting LVM-based OSDs fine?

Perhaps the "out" here is to support a "dir" option where the user can 
manually provision and mount an OSD on /var/lib/ceph/osd/*, with 'journal' 
or 'block' symlinks, and ceph-volume will do the last bits that initialize 
the filestore or bluestore OSD from there.  Then if someone has a scenario 
that isn't captured by LVM (or whatever else we support) they can always 
do it manually?

> --- Existing clusters ---
> Migration to ceph-volume, even with plain disk support means
> re-creating the OSD from scratch, which would end up moving data.
> There is no way to make a GPT/ceph-disk OSD become a ceph-volume one
> without starting from scratch.
> 
> A temporary workaround would be to provide a way for existing OSDs to
> be brought up without UDEV and ceph-disk, by creating logic in
> ceph-volume that could load them with systemd directly. This wouldn't
> make them lvm-based, nor it would mean there is direct support for
> them, just a temporary workaround to make them start without UDEV and
> ceph-disk.
> 
> I'm interested in what current users might look for here,: is it fine
> to provide this workaround if the issues are that problematic? Or is
> it OK to plan a migration towards ceph-volume OSDs?

IMO we can't require any kind of data migration in order to upgrade, which 
means we either have to (1) keep ceph-disk around indefinitely, or (2) 
teach ceph-volume to start existing GPT-style OSDs.  Given all of the 
flakiness around udev, I'm partial to #2.  The big question for me is 
whether #2 alone is sufficient, or whether ceph-volume should also know 
how to provision new OSDs using partitions and no LVM.  Hopefully not?

sage
