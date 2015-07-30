From: Sage Weil <sage@newdream.net>
Subject: Re: systemd status
Date: Thu, 30 Jul 2015 05:45:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507300538210.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com> <mpad83$pu4$1@ger.gmane.org> <alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net> <mpampk$1pq$1@ger.gmane.org>
 <alpine.DEB.2.00.1507290715450.22099@cobra.newdream.net> <mpao1u$pe2$1@ger.gmane.org> <alpine.DEB.2.00.1507290748290.22099@cobra.newdream.net> <mpaqqd$blm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43176 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbG3MpG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 08:45:06 -0400
In-Reply-To: <mpaqqd$blm$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 29 Jul 2015, Alex Elsayed wrote:
> Sage Weil wrote:
> 
> > On Wed, 29 Jul 2015, Alex Elsayed wrote:
> <snip for gmane>
> >> My thinking is more that the "osd data = " key makes a lot less sense in
> >> the systemd world overall - passing the OSD the full path on the
> >> commandline via some --datadir would mean you could trivially use
> >> systemd's instance templating, and just do
> >> 
> >> ExecStart=/usr/bin/ceph-osd -f --datadir=/var/lib/ceph/osd/%i
> >> 
> >> and be done with it. Could even do RequiresMountsFor=/var/lib/ceph/osd/%i
> >> too, which would order it after (and make it depend on) any systemd.mount
> >> units for that path.
> > 
> > Note that there is a 1:1 equivalence between command line options and
> > config options, so osd data = /foo and --osd-data foo are the same thing.
> > Not that I think that matters here--although it's possible to manually
> > specify paths in ceph.conf users can't do that if they want the udev magic
> > to work (that's already true today, without systemd).
> 
> Sure, though my thought was that the udev magic would work more sanely _via_ 
> this. The missing part is loading the cluster and ID from the OSD data dir.
> 
> > In any case, though, if your %i above is supposed to be the uuid, that's
> > much less friendly than what we have now, where users can do
> > 
> >  systemctl stop ceph-osd@12
> > 
> > to stop osd.12.
> > 
> > I'm not sure it's worth giving up the bind mount complexity unless it
> > really becomes painful to support, given how much nicer the admin
> > experience is...
> 
> Well, that does presuppose that they've either SSHed into the machine 
> manually, or are using systemctl -H to do so via systemctl. That's already 
> not an especially nice user experience, since they need to manually consider 
> the cluster's structure.
> 
> Something more like 'ceph tell osd.N die' or similar could work, and 
> SuccessExitStatus= could be used to make it even nicer (that even if it 
> gives a different exit status for "die" as opposed to other successes, 
> systemd can say "any of these exit codes are okay, don't autorestart")
> 
> However, neither of those handles unmounting, and it still doesn't handle 
> starting. All of the above are still partial solutions; hopefully iteration 
> can result in something better in all ways.
> 
> Also, note that if RequiresMountsFor= is used, unmounting the filesystem - 
> by device or by mountpoint - will stop the unit due to proper dependency 
> handling. (If RMF doesn't, BindsTo does - BindsTo will additionally do so if 
> the device is unmounted or suddenly unplugged without systemd intervention)
> 
> systemctl stop dev-sdc.device # all OSDs running off of sdc stop
> systemctl stop dev-sdd1.device # Just one partition this time
> 
> Nice and tidy.

So, it seems like plan B would be something like:

- mounts on /var/lib/ceph/osd/data/$uuid.  For new backends that have 
multiple mounts (newstore likely will), we may also have something like 
/var/lib/ceph/osd/data-fast/$uuid as an SSD partition or something.

- systemd ceph-osd@$uuid task runs
    ceph-osd --cluster ceph --id 123 --osd-uuid $uuid

- simpler udev rules

- simpler ceph-disk behavior

- The 'one cluster per host' restriction would go away.  This is currently 
there because we only have a single systemd parameter for the @ services 
and we're using the osd id (which is not unique across clusters).  The 
uuid would be, so that's a win.

But,

- admin can't tell from 'systemctl | grep ceph' or from 'df' or 'mount' 
which OSD is which, but they could from 'ps ax | grep ceph-osd'.

- stopping an individual osd would be done by $uuid instead of osd id:

 systemctl stop ceph-osd@66f354f2-752e-409f-8194-be05f6b071d9

For an admin this is probably a cut&paste from ps ax output?

- we could perhaps make a 'ceph-disk stop' and 'ceph-disk umount' commands 
to make this a bit simpler?

What do people think?  I like simple, but I don't want to make life too 
hard on the admin.

sage
