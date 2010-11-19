From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Fri, 19 Nov 2010 09:50:12 +0000
Message-ID: <20101119095012.GB5215@redhat.com>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net> <20101103135900.GQ29893@redhat.com> <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net> <20101108131634.GJ26714@redhat.com> <4CE47443.4000503@hq.newdream.net> <20101118104214.GW15851@redhat.com> <Pine.LNX.4.64.1011180905001.2270@cobra.newdream.net> <AANLkTinNqTJ-BBvQTwD+1b5dTKHn2W8o-FEXASk4kgPj@mail.gmail.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6883 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab0KSJuW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Nov 2010 04:50:22 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinNqTJ-BBvQTwD+1b5dTKHn2W8o-FEXASk4kgPj@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Sage Weil <sage@newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Fri, Nov 19, 2010 at 09:27:40AM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 18, 2010 at 5:13 PM, Sage Weil <sage@newdream.net> wrote:
> > On Thu, 18 Nov 2010, Daniel P. Berrange wrote:
> >> On Wed, Nov 17, 2010 at 04:33:07PM -0800, Josh Durgin wrote:
> >> > Hi Daniel,
> >> >
> >> > On 11/08/2010 05:16 AM, Daniel P. Berrange wrote:
> >> > >>>>In any case, before someone goes off and implements somethin=
g, does this
> >> > >>>>look like the right general approach to adding rbd support t=
o libvirt?
> >> > >>>
> >> > >>>I think this looks reasonable. I'd be inclined to get the sto=
rage pool
> >> > >>>stuff working with the kernel RBD driver& =C2=A0UDEV rules fo=
r stable path
> >> > >>>names, since that avoids needing to make any changes to guest=
 XML
> >> > >>>format. Support for QEMU with the native librados CEPH driver=
 could
> >> > >>>be added as a second patch.
> >> > >>
> >> > >>Okay, that sounds reasonable. =C2=A0Supporting the QEMU librad=
os driver is
> >> > >>definitely something we want to target, though, and seems to b=
e route that
> >> > >>more users are interested in. =C2=A0Is defining the XML syntax=
 for a guest VM
> >> > >>something we can discuss now as well?
> >> > >>
> >> > >>(BTW this is biting NBD users too. =C2=A0Presumably the guest =
VM XML should
> >> > >>look similar?
> >> > >
> >> > >And also Sheepdog storage volumes. To define a syntax for all t=
hese we need
> >> > >to determine what configuration metadata is required at a per-V=
M level for
> >> > >each of them. Then try and decide how to represent that in the =
guest XML.
> >> > >It looks like at a VM level we'd need a hostname, port number a=
nd a volume
> >> > >name (or path).
> >> >
> >> > It looks like that's what Sheepdog needs from the patch that was
> >> > submitted earlier today. For RBD, we would want to allow multipl=
e hosts,
> >> > and specify the pool and image name when the QEMU librados drive=
r is
> >> > used, e.g.:
> >> >
> >> > =C2=A0 =C2=A0 <disk type=3D"rbd" device=3D"disk">
> >> > =C2=A0 =C2=A0 =C2=A0 <driver name=3D"qemu" type=3D"raw" />
> >> > =C2=A0 =C2=A0 =C2=A0 <source vdi=3D"image_name" pool=3D"pool_nam=
e">
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 <host name=3D"mon1.example.org" port=
=3D"6000">
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 <host name=3D"mon2.example.org" port=
=3D"6000">
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 <host name=3D"mon3.example.org" port=
=3D"6000">
> >> > =C2=A0 =C2=A0 =C2=A0 </source>
> >> > =C2=A0 =C2=A0 =C2=A0 <target dev=3D"vda" bus=3D"virtio" />
> >> > =C2=A0 =C2=A0 </disk>
> >> >
> >> > Does this seem like a reasonable format for the VM XML? Any sugg=
estions?
> >>
> >> I'm basically wondering whether we should be going for separate ty=
pes for
> >> each of NBD, RBD & Sheepdog, as per your proposal & the sheepdog o=
ne earlier
> >> today. Or type to merge them into one type 'nework' which covers a=
ny kind of
> >> network block device, and list a protocol on the =C2=A0source elem=
ent, eg
> >>
> >> =C2=A0 =C2=A0 =C2=A0<disk type=3D"network" device=3D"disk">
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0<driver name=3D"qemu" type=3D"raw" />
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0<source protocol=3D'rbd|sheepdog|nbd' n=
ame=3D"...some image identifier...">
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<host name=3D"mon1.example.org" =
port=3D"6000">
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<host name=3D"mon2.example.org" =
port=3D"6000">
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<host name=3D"mon3.example.org" =
port=3D"6000">
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0</source>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0<target dev=3D"vda" bus=3D"virtio" />
> >> =C2=A0 =C2=A0 =C2=A0</disk>
> >
> > That would work...
> >
> > One thing that I think should be considered, though, is that both R=
BD and
> > NBD can be used for non-qemu instances by mapping a regular block d=
evice
> > via the host's kernel. =C2=A0And in that case, there's some sysfs-f=
u (at least
> > in the rbd case; I'm not familiar with how the nbd client works) re=
quired
> > to set up/tear down the block device.
>=20
> An nbd block device is attached using the nbd-client(1) userspace too=
l:
> $ nbd-client my-server 1234 /dev/nbd0 # <host> <port> <nbd-device>
>=20
> That program will open the socket, grab /dev/nbd0, and poke it with a
> few ioctls so the kernel has the socket and can take it from there.

We don't need to worry about this for libvirt/QEMU. Since QEMU has nati=
ve
NBD client support there's no need to do anything with nbd client tools
to setup the device for use with a VM.

Regards,
Daniel
--=20
|: Red Hat, Engineering, London    -o-   http://people.redhat.com/berra=
nge/ :|
|: http://libvirt.org -o- http://virt-manager.org -o- http://deltacloud=
=2Eorg :|
|: http://autobuild.org        -o-         http://search.cpan.org/~danb=
err/ :|
|: GnuPG: 7D3B9505  -o-   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B =
9505 :|
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
