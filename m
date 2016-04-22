From: Sage Weil <sweil@redhat.com>
Subject: Re: Bluestore cluster example
Date: Fri, 22 Apr 2016 10:57:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604221054320.8831@cpach.fuggernut.com>
References: <5710D936.9040507@redhat.com> <CABZ+qqnnOta_Y4rCV8y=v8KKstr==OWa34ryBAOcEH56xSk4tA@mail.gmail.com> <alpine.DEB.2.11.1604221006350.8831@cpach.fuggernut.com> <CABZ+qqn38cPHwQ-X0d7FjdYtCgwObdUWsZysx3debMR7fi0t0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35483 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407AbcDVO52 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Apr 2016 10:57:28 -0400
In-Reply-To: <CABZ+qqn38cPHwQ-X0d7FjdYtCgwObdUWsZysx3debMR7fi0t0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Mark Nelson <mnelson@redhat.com>, cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 22 Apr 2016, Dan van der Ster wrote:
> On Fri, Apr 22, 2016 at 4:09 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Fri, 22 Apr 2016, Dan van der Ster wrote:
> >> Hi Mark,
> >>
> >> On Fri, Apr 15, 2016 at 2:06 PM, Mark Nelson <mnelson@redhat.com> wrote:
> >> > Hi all,
> >> >
> >> > A couple of folks have asked me how to setup bluestore clusters for
> >> > performance testing.  I personally am using cbt for this, but you should be
> >> > able to use ceph-disk with some other cluster creation method as well.
> >> >
> >> > For CBT, you really don't need to do much.  In the old newstore days, a
> >> > "block" symlink needed to be created in the osd data dir to link to the new
> >> > block device.  CBT did this when the "newstore_block: True" option was set
> >> > in the cluster section of the cbt yaml file.  This isn't really needed
> >> > anymore, as you can now specify the block, db, and wal devices directly in
> >> > your ceph.conf file.  If your partitions are setup properly you can create
> >> > bluestore clusters without having to do anything beyond changing the
> >> > ceph.conf file (with cbt at least).
> >> >
> >> > Here's a very basic example:
> >> >
> >> > [global]
> >> >         enable experimental unrecoverable data corrupting features =
> >> > bluestore rocksdb
> >> >         osd objectstore = bluestore
> >> >
> >> > [osd.0]
> >> >         host = incerta01.front.sepia.ceph.com
> >> >         osd data = /tmp/cbt/mnt/osd-device-0-data
> >> >         bluestore block path = /dev/disk/by-partlabel/osd-device-0-block
> >> >         bluestore block db path = /dev/disk/by-partlabel/osd-device-0-db
> >> >         bluestore block wal path = /dev/disk/by-partlabel/osd-device-0-wal
> >>
> >> The db and wal paths are optional perf boosting things, right?
> >
> > Yeah.
> >
> >> If I do ceph-disk prepare --bluestore /dev/sdae, I get:
> >>
> >> /dev/sdae :
> >>  /dev/sdae2 ceph block, for /dev/sdae1
> >>  /dev/sdae1 ceph data, active, cluster ceph, osd.413, block /dev/sdae2
> >
> > Looks right!  ceph-disk isn't smart enough to set up the wal or db devices
> > yet.
> >
> > The wal device should default to something like 128 MB.
> >
> > The db device would be whatever portion of an SSD you want to allocate to
> > storing the bluestore metadata.  My guess is that we'll get further than
> > we did with FileStore, so the old 1:4 or 1:5 rule of thumb might be more
> > like 1:10, but who knows--this'll require some testing.
> 
> Cool, I'll start testing wal/db on SSDs with some new machines ~next week.
> 
> Just to clarify, if we give no wal, there is no wal, right?
> But if we don't give a dedicated db device, where does the db go?

There are always wal and db "files" from rocksdb, but if there aren't 
separate devices they just end up on the main block device.

> Also, bluestore being experimental in jewel -- I guess that means you
> don't promise to support the current on disk format in kraken and
> beyond?

Correct.

It's *possible* we will include upgrade/conversion code, but it'll sort of 
depend on how much effort it is when it a format change comes along.

The goal is that by kraken it will be stable.

sage
