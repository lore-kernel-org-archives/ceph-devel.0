From: Sage Weil <sage@newdream.net>
Subject: Re: systemd status
Date: Wed, 29 Jul 2015 07:53:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507290748290.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com> <mpad83$pu4$1@ger.gmane.org> <alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net> <mpampk$1pq$1@ger.gmane.org>
 <alpine.DEB.2.00.1507290715450.22099@cobra.newdream.net> <mpao1u$pe2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37331 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbG2OxO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 10:53:14 -0400
In-Reply-To: <mpao1u$pe2$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 29 Jul 2015, Alex Elsayed wrote:
> Sage Weil wrote:
> 
> > On Wed, 29 Jul 2015, Alex Elsayed wrote:
> >> Sage Weil wrote:
> >> 
> >> > On Wed, 29 Jul 2015, Alex Elsayed wrote:
> <snip some>
> >> 
> >> Does it?
> >> 
> >> If the mount point is (say) /var/ceph/$UUID, and ceph-osd can take a --
> >> datadir parameter from which it _reads_ the cluster and ID if they aren't
> >> passed on the command line, I think that'd resolve the issue rather
> >> tidily _without_ requring that be known prior to mount.
> >> 
> >> And if I understand correctly, that data is _already in there_ for
> >> ceph-disk to mount it in the "final location" - it's just shuffling
> >> around who reads it.
> > 
> > So, we could do this.  It would mean either futzing with the ceph-osd
> > config variables so that they take a $uuid substitution (passed at
> > startup) -or- have ceph-disk set up a symlink from the current
> > /var/lib/ceph/osd/$cluster-$id location (instead of doing the bind mount
> > it currently does).
> 
> My thinking is more that the "osd data = " key makes a lot less sense in the 
> systemd world overall - passing the OSD the full path on the commandline via 
> some --datadir would mean you could trivially use systemd's instance 
> templating, and just do
> 
> ExecStart=/usr/bin/ceph-osd -f --datadir=/var/lib/ceph/osd/%i
> 
> and be done with it. Could even do RequiresMountsFor=/var/lib/ceph/osd/%i 
> too, which would order it after (and make it depend on) any systemd.mount 
> units for that path.

Note that there is a 1:1 equivalence between command line options and 
config options, so osd data = /foo and --osd-data foo are the same thing.  
Not that I think that matters here--although it's possible to manually 
specify paths in ceph.conf users can't do that if they want the udev magic 
to work (that's already true today, without systemd).

In any case, though, if your %i above is supposed to be the uuid, that's 
much less friendly than what we have now, where users can do

 systemctl stop ceph-osd@12

to stop osd.12.

I'm not sure it's worth giving up the bind mount complexity unless it 
really becomes painful to support, given how much nicer the admin 
experience is...

sage

> If the path comes from ceph.conf, then the systemd unit can't do 
> RequiresMountsFor, because it just plain doesn't have that information, and 
> so forth. You wind up giving up various systemd capabilities because ceph's 
> got its own custom-built wheel.
> 
> > But, it'll come at some cost to operators, who won't be able to 'df' or
> > 'mount' and see which OSD mounts are which... they'll have to poke around
> > in each directory to see what mount is which.
> 
> This is a fair point, though - however, if the symlinks just are for human 
> inspection rather than critical to the operation of the system, it takes 
> them out of the hot path and reduces the opportunities for failure due to 
> unusual usage / extra middle steps.
> 
> Maybe put the UUID mounts in a uuid/ subdir, with $cluster-$id symlinks 
> pointing into it.
> 
> >> > If the mounting and binding to the final location is done in a systemd
> >> > job identified by the uuid, it seems like systemd would effectively
> >> > handle the mutual exclusion and avoid races?
> >> 
> >> What I object to is the idea of a "final location" that depends on the
> >> contents of the filesystem - it's bass-ackwards IMO.
> > 
> > It's unusual, but I think it can be made to work reliably.
> > 
> > Are there any other opinions here?
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
