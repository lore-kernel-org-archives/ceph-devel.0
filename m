From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Integration work
Date: Tue, 4 Sep 2012 08:52:43 -0700
Message-ID: <CADvuQRH+2V=vMHTyoeEnVydyYe5Js=eqs6g0+CETEiAK+Re8vw@mail.gmail.com>
References: <503D0A00.2080905@inktank.com> <F5955DC568F9AF4DB00BE0F7E950BE0C26036BDA@BLUPRD0411MB438.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49804 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab2IDPxE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 11:53:04 -0400
Received: by yenl14 with SMTP id l14so1259152yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 08:53:04 -0700 (PDT)
In-Reply-To: <F5955DC568F9AF4DB00BE0F7E950BE0C26036BDA@BLUPRD0411MB438.namprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Cc: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 31, 2012 at 11:02 PM, Ryan Nicholson
<Ryan.Nicholson@kcrg.com> wrote:
> Secondly: Through some trials, I've found that if one loses all of his Monitors in a way that they also lose their disks, one basically loses their cluster. I would like to recommend a lower priority shift in design that allows for "recovery of the entire monitor set from data/snapshots automatically stored at the osd's".
>
> For example, a monitor boots:
>         -keyring file and ceph.conf are available
>         -monitor sees that it is missing its local copy of maps, etc.
>         -goes onto the first OSD's it sees and pulls down a snapshot of the same
>         -checks for another running monitor, syncs with it, if not,
>         -boots at quorum 0, verifying OSD states
>         -life continues.

Monitor fetching initial information from an OSD is full of
challenges. The monitor won't know what IP addresses and ports the
OSDs are, the OSDs won't trust the monitor to talk to them, etc (it
lost its crypto keys, after all). It wouldn't even know which OSD to
talk to, and I highly doubt having the backup on every OSD would be a
good idea.

> The big deal here, is that while the entire cluster is able to recover from failures using one storage philosophy, the monitors are using an entirely different, and more legacy storage philosophy - basically local RAID/power in numbers. Perhaps this has already been considered, and I would be interested in knowing what people think here, as well. Or perhaps I missed something and this is already done?

That's why you run multiple monitors: they provide High Availability
to the monitor service, as a whole. Losing all of your monitors at all
disrupts operation of the cluster. Losing all of their stable storage
really is disastrous. This is why you are supposed to deploy them in
different failure domains, e.g. in different rows or rooms.

If a monitor has its mon. keyring and ceph.conf, it should be able to
join an existing monitor cluster as a new member, no special-case
recovery needed.

I'm not sure what kind of architecture you have that makes losing all
the of the monitor disks somehow likely, but perhaps you should just
take backups of their disks, with plain-old backup tools? Don't try to
store that backup in the same Ceph cluster, though. It would be
interesting to hear more about what you're thinking of, here.
