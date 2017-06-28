From: Sage Weil <sage@newdream.net>
Subject: Re: crush devices class types
Date: Wed, 28 Jun 2017 13:46:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706281343230.3424@piezo.novalocal>
References: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org> <1971303930.7861.1485178720341@ox.pcextreme.nl> <alpine.DEB.2.11.1701231428190.3654@piezo.novalocal> <372c7fcb-8697-28ea-0d7c-1efc29fc21cf@dachary.org> <alpine.DEB.2.11.1702022047070.3654@piezo.novalocal>
 <2e591b25-3db2-2dd2-03af-2c1ef40292ac@dachary.org> <CALe9h7ds0PpqX-QJ0Usb-OLggPMCE2KF0tLurGfKFmms89nDiA@mail.gmail.com> <83ad191e-933f-83a4-c6d4-c831c1ac893f@dachary.org> <CALe9h7e-uOvQdO1GqNo6xpJ=QgoLyJ_ycgyP9c_Z_sXptHUJjg@mail.gmail.com>
 <8bf1e90e-20ca-e4e9-d3dd-3535b6a7d781@dachary.org> <CABZ+qqkNb8rAr27oKL3txJfY-OFjpF5vKXFCyRywEVvkzNXbgg@mail.gmail.com> <alpine.DEB.2.11.1703081432150.1727@piezo.novalocal> <CAFMfnwqOUnmV2w2kuhaboo9nzKVoFbrsxP2Sy7N1sO6xWvgGHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57139 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdF1Nqk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 09:46:40 -0400
In-Reply-To: <CAFMfnwqOUnmV2w2kuhaboo9nzKVoFbrsxP2Sy7N1sO6xWvgGHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: Dan van der Ster <dan@vanderster.com>, Loic Dachary <loic@dachary.org>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 27 Jun 2017, Kyle Bader wrote:
> On Wed, Mar 8, 2017 at 6:39 AM, Sage Weil <sage@newdream.net> wrote:
> > On Wed, 8 Mar 2017, Dan van der Ster wrote:
> >> Hi Loic,
> >>
> >> Did you already have a plan for how an operator would declare the
> >> device class of each OSD?
> >> Would this be a new --device-class option to ceph-disk prepare, which
> >> would perhaps create a device-class file in the root of the OSD's xfs
> >> dir?
> >> Then osd crush create-or-move in ceph-osd-prestart.sh would be a
> >> combination of ceph.conf's "crush location" and this per-OSD file.
> >
> > Hmm we haven't talked about this part yet.  I see a few options...
> >
> > 1) explicit ceph-disk argument, recorded as a file in osd_data
> >
> > 2) osd can autodetect this based on the 'rotational' flag in sysfs.  The
> > trick here, I think, is to come up with suitable defaults.  We might have
> > NVMe, SATA/SAS SSDs, HDD, or a combination (with journal and data (and
> > db) spread across multiple types).   Perhaps those could break down into
> > classes like
> >
> >         hdd
> >         ssd
> >         nvme
> >         hdd+ssd-journal
> >         hdd+nvme-jouranl
> >         hdd+ssd-db+nvme-jouranl
> >
> > which is probably sufficient for most users.  And if the admin likes they
> > can override.
> >
> > - Then the osd adjusts device-class on startup, just like it does with the
> > crush map position.  (Note that this will have no real effect until the
> > CRUSH rule(s) are changed to use device class.)
> >
> > - We'll need an 'osd crush set-device-class <osd.NNN> <class>' command.
> > The only danger I see here is that if you set it to something other than
> > what the OSD autodetects above, it'll get clobbered on the next OSD
> > restart.  Maybe the autodetection *only* sets the device class if it isn't
> > already set?
> 
> one of the classes could be "autodetect" and it could be the default,
> kinda like auto negotiation on nic / switch ports?

Yes!  I think we already have osd_crush_update_on_start (default: yes) 
which controls whether we update the crush location on OSD start.  We can 
do the same with the device class if it not already set via an option like 
osd_crush_update_class_on_start.  I'm thinking just a simple 'hdd' and 
'ssd' class...

sage

