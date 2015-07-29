From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: systemd status
Date: Wed, 29 Jul 2015 07:30:20 -0700
Message-ID: <mpao1u$pe2$1@ger.gmane.org>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com> <mpad83$pu4$1@ger.gmane.org> <alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net> <mpampk$1pq$1@ger.gmane.org> <alpine.DEB.2.00.1507290715450.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54350 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbbG2Oaf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 10:30:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZKSNK-0002cT-59
	for ceph-devel@vger.kernel.org; Wed, 29 Jul 2015 16:30:30 +0200
Received: from 66-87-138-120.pools.spcsdns.net ([66-87-138-120.pools.spcsdns.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 16:30:30 +0200
Received: from eternaleye by 66-87-138-120.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 16:30:30 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

> On Wed, 29 Jul 2015, Alex Elsayed wrote:
>> Sage Weil wrote:
>> 
>> > On Wed, 29 Jul 2015, Alex Elsayed wrote:
<snip some>
>> 
>> Does it?
>> 
>> If the mount point is (say) /var/ceph/$UUID, and ceph-osd can take a --
>> datadir parameter from which it _reads_ the cluster and ID if they aren't
>> passed on the command line, I think that'd resolve the issue rather
>> tidily _without_ requring that be known prior to mount.
>> 
>> And if I understand correctly, that data is _already in there_ for
>> ceph-disk to mount it in the "final location" - it's just shuffling
>> around who reads it.
> 
> So, we could do this.  It would mean either futzing with the ceph-osd
> config variables so that they take a $uuid substitution (passed at
> startup) -or- have ceph-disk set up a symlink from the current
> /var/lib/ceph/osd/$cluster-$id location (instead of doing the bind mount
> it currently does).

My thinking is more that the "osd data = " key makes a lot less sense in the 
systemd world overall - passing the OSD the full path on the commandline via 
some --datadir would mean you could trivially use systemd's instance 
templating, and just do

ExecStart=/usr/bin/ceph-osd -f --datadir=/var/lib/ceph/osd/%i

and be done with it. Could even do RequiresMountsFor=/var/lib/ceph/osd/%i 
too, which would order it after (and make it depend on) any systemd.mount 
units for that path.

If the path comes from ceph.conf, then the systemd unit can't do 
RequiresMountsFor, because it just plain doesn't have that information, and 
so forth. You wind up giving up various systemd capabilities because ceph's 
got its own custom-built wheel.

> But, it'll come at some cost to operators, who won't be able to 'df' or
> 'mount' and see which OSD mounts are which... they'll have to poke around
> in each directory to see what mount is which.

This is a fair point, though - however, if the symlinks just are for human 
inspection rather than critical to the operation of the system, it takes 
them out of the hot path and reduces the opportunities for failure due to 
unusual usage / extra middle steps.

Maybe put the UUID mounts in a uuid/ subdir, with $cluster-$id symlinks 
pointing into it.

>> > If the mounting and binding to the final location is done in a systemd
>> > job identified by the uuid, it seems like systemd would effectively
>> > handle the mutual exclusion and avoid races?
>> 
>> What I object to is the idea of a "final location" that depends on the
>> contents of the filesystem - it's bass-ackwards IMO.
> 
> It's unusual, but I think it can be made to work reliably.
> 
> Are there any other opinions here?


