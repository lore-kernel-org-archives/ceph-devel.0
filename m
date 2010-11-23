From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] rbd: replace the rbd sysfs interface
Date: Mon, 22 Nov 2010 16:58:38 -0800
Message-ID: <20101123005838.GB29289@kroah.com>
References: <1289953929-30896-1-git-send-email-yehuda@hq.newdream.net>
 <20101117171924.GC12050@kroah.com>
 <AANLkTims_MjBS1SdHkOjOWvGqg1aRABH23MWk8J-E+-Y@mail.gmail.com>
 <20101118013002.GC8558@kroah.com>
 <AANLkTi=7z40CNBUmfVUEa68J+1R=7nbn9d8vM7ETpajA@mail.gmail.com>
 <20101119020820.GB18767@kroah.com>
 <AANLkTim4p=tpaQG_XDE5Vk0YAypYCegAguYNKRg-LeDF@mail.gmail.com>
 <20101123001410.GA31294@kroah.com>
 <AANLkTi=n9aJ_8VAcyOXQxxeprWzerZLf0H+ryHZs7O04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:42601 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab0KWA6l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Nov 2010 19:58:41 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=n9aJ_8VAcyOXQxxeprWzerZLf0H+ryHZs7O04@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 22, 2010 at 04:48:54PM -0800, Yehuda Sadeh Weinraub wrote:
> On Mon, Nov 22, 2010 at 4:14 PM, Greg KH <greg@kroah.com> wrote:
> > On Fri, Nov 19, 2010 at 12:42:51PM -0800, Yehuda Sadeh Weinraub wro=
te:
> >> On Thu, Nov 18, 2010 at 6:08 PM, Greg KH <greg@kroah.com> wrote:
> >> > On Thu, Nov 18, 2010 at 02:53:35PM -0800, Yehuda Sadeh Weinraub =
wrote:
> >> >> Yes, pretty much. One problem that I do see is that if we defin=
e the
> >> >> snaps/ as a device (and not just as a kobj) as you suggested be=
fore,
> >> >> it'll automatically create a 'uevent' entry under it which can =
be a
> >> >> real issue in the case we have a snapshot named like that. Shou=
ldn't
> >> >> we just create it as a kobj in that case?
> >> >
> >> > No. =A0Just use the subdirectory option of an attribute group to=
 handle
> >> > that and you will not need to create any device or kobject with =
that
> >> > name, the driver core will handle it all automatically for you.
> >> >
> >>
> >> One issue with using the groups name, is that it's not nested (unl=
ess
> >> I'm missing something), so we can't have it done for the entire
> >> planned hierarchy without holding a kobject on the way. Just a
> >> reminder, the device-specific hierarchy would look like this:
> >>
> >> 1. /sys/bus/rbd/devices/<id>/
> >> 2. /sys/bus/rbd/devices/<id>/<device_attrs>
> >> 3. /sys/bus/rbd/devices/<id>/snaps/
> >> 4. /sys/bus/rbd/devices/<id>/snaps/<snap_name>/
> >> 5. /sys/bus/rbd/devices/<id>/snaps/<snap_name>/<snap_attrs>
> >>
> >> One solution would be to create kobjects for (3) and for (4), with=
out
> >> using a group name.
> >
> > Ick, no.
> >
> >> Another way, we can create groups for (2), and (3)
> >> under (1), but that's about it,
> >
> > attribute group for 2 is fine.
> >
> >> you can't create the snap specific directory this way without
> >> resorting to some internal sysfs directory creation, which will be
> >> horribly wrong. At that point we don't have anything for 'snaps', =
and
> >> we don't really need to do any operations under that directory, we
> >> just need it to exist so that it contains the snapshot-specific
> >> directories.
> >
> > But you need to do something with those snapshots, right? =A0So, wh=
y even
> > have "snaps" be a subdir? =A0Why not just make <snap_name> a struct=
 device
> > with <id> being the parent, and it living on the same bus_type, but
> > being a different device_type (like partitions and block devices ar=
e),
>=20
> The reason we keep snapshots in a separate subdirectory is that they
> can have arbitrary name. So either we prefix them and put them in a
> common namespace with the devices, or we put them down the hierarchy.

Do either one.  I would suggest a prefix.

> In any case we don't do any operations on them, we just have them for
> informational use and we put them there so that we don't have one big
> file that lists them all.

But something cares about them, so treat them properly.

> >> Another way would be to create a group for (2) under (1) and creat=
e a
> >> kobject for (3), for which you can create group per snapshot.
> >>
> >> Am I missing something? We already have the first solution (kobjec=
ts
> >> only) implemented, is there some real benefit for using the third
> >> method? We'll have to manually add remove groups anyway, as snapsh=
ots
> >> can be removed and new snapshots can be added.
> >
> > Never add kobjects to a struct device, that is showing you that
> > something is wrong, and that userspace really will want to get that
> > create/destroy event of the sub child.
> >
>=20
> But they're there as information device attributes, it's nothing like
> partitions in block devices. So we want to just be able to list them
> and their attributes easily (and nicely), without having to put them
> in one big file.

Then use a prefix and put everything in the same subdirectory underneat=
h
the id and you should be fine, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
