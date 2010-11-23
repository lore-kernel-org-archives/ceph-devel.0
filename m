From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] rbd: replace the rbd sysfs interface
Date: Mon, 22 Nov 2010 16:14:10 -0800
Message-ID: <20101123001410.GA31294@kroah.com>
References: <1289953929-30896-1-git-send-email-yehuda@hq.newdream.net>
 <20101117171924.GC12050@kroah.com>
 <AANLkTims_MjBS1SdHkOjOWvGqg1aRABH23MWk8J-E+-Y@mail.gmail.com>
 <20101118013002.GC8558@kroah.com>
 <AANLkTi=7z40CNBUmfVUEa68J+1R=7nbn9d8vM7ETpajA@mail.gmail.com>
 <20101119020820.GB18767@kroah.com>
 <AANLkTim4p=tpaQG_XDE5Vk0YAypYCegAguYNKRg-LeDF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39759 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932465Ab0KWAOx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Nov 2010 19:14:53 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim4p=tpaQG_XDE5Vk0YAypYCegAguYNKRg-LeDF@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 19, 2010 at 12:42:51PM -0800, Yehuda Sadeh Weinraub wrote:
> On Thu, Nov 18, 2010 at 6:08 PM, Greg KH <greg@kroah.com> wrote:
> > On Thu, Nov 18, 2010 at 02:53:35PM -0800, Yehuda Sadeh Weinraub wro=
te:
> >> Yes, pretty much. One problem that I do see is that if we define t=
he
> >> snaps/ as a device (and not just as a kobj) as you suggested befor=
e,
> >> it'll automatically create a 'uevent' entry under it which can be =
a
> >> real issue in the case we have a snapshot named like that. Shouldn=
't
> >> we just create it as a kobj in that case?
> >
> > No. =A0Just use the subdirectory option of an attribute group to ha=
ndle
> > that and you will not need to create any device or kobject with tha=
t
> > name, the driver core will handle it all automatically for you.
> >
>=20
> One issue with using the groups name, is that it's not nested (unless
> I'm missing something), so we can't have it done for the entire
> planned hierarchy without holding a kobject on the way. Just a
> reminder, the device-specific hierarchy would look like this:
>=20
> 1. /sys/bus/rbd/devices/<id>/
> 2. /sys/bus/rbd/devices/<id>/<device_attrs>
> 3. /sys/bus/rbd/devices/<id>/snaps/
> 4. /sys/bus/rbd/devices/<id>/snaps/<snap_name>/
> 5. /sys/bus/rbd/devices/<id>/snaps/<snap_name>/<snap_attrs>
>=20
> One solution would be to create kobjects for (3) and for (4), without
> using a group name.

Ick, no.

> Another way, we can create groups for (2), and (3)
> under (1), but that's about it,

attribute group for 2 is fine.

> you can't create the snap specific directory this way without
> resorting to some internal sysfs directory creation, which will be
> horribly wrong. At that point we don't have anything for 'snaps', and
> we don't really need to do any operations under that directory, we
> just need it to exist so that it contains the snapshot-specific
> directories.

But you need to do something with those snapshots, right?  So, why even
have "snaps" be a subdir?  Why not just make <snap_name> a struct devic=
e
with <id> being the parent, and it living on the same bus_type, but
being a different device_type (like partitions and block devices are),=20

> Another way would be to create a group for (2) under (1) and create a
> kobject for (3), for which you can create group per snapshot.
>=20
> Am I missing something? We already have the first solution (kobjects
> only) implemented, is there some real benefit for using the third
> method? We'll have to manually add remove groups anyway, as snapshots
> can be removed and new snapshots can be added.

Never add kobjects to a struct device, that is showing you that
something is wrong, and that userspace really will want to get that
create/destroy event of the sub child.

sorry for the delay, was gone last weekend.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
