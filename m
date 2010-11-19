From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Fri, 19 Nov 2010 12:55:07 +0000
Message-ID: <AANLkTi=+mfEXHPV33Tqvrh+i6YqsGU1uCDfFc-L0URut@mail.gmail.com>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
	<20101103135900.GQ29893@redhat.com>
	<Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net>
	<20101108131634.GJ26714@redhat.com>
	<4CE47443.4000503@hq.newdream.net>
	<20101118104214.GW15851@redhat.com>
	<Pine.LNX.4.64.1011180905001.2270@cobra.newdream.net>
	<AANLkTinNqTJ-BBvQTwD+1b5dTKHn2W8o-FEXASk4kgPj@mail.gmail.com>
	<20101119095012.GB5215@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48860 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab0KSMzJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Nov 2010 07:55:09 -0500
Received: by wyb28 with SMTP id 28so4421312wyb.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Nov 2010 04:55:08 -0800 (PST)
In-Reply-To: <20101119095012.GB5215@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Sage Weil <sage@newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Fri, Nov 19, 2010 at 9:50 AM, Daniel P. Berrange <berrange@redhat.co=
m> wrote:
> On Fri, Nov 19, 2010 at 09:27:40AM +0000, Stefan Hajnoczi wrote:
>> On Thu, Nov 18, 2010 at 5:13 PM, Sage Weil <sage@newdream.net> wrote=
:
>> > On Thu, 18 Nov 2010, Daniel P. Berrange wrote:
>> >> On Wed, Nov 17, 2010 at 04:33:07PM -0800, Josh Durgin wrote:
>> >> > Hi Daniel,
>> >> >
>> >> > On 11/08/2010 05:16 AM, Daniel P. Berrange wrote:
>> >> > >>>>In any case, before someone goes off and implements somethi=
ng, does this
>> >> > >>>>look like the right general approach to adding rbd support =
to libvirt?
>> >> > >>>
>> >> > >>>I think this looks reasonable. I'd be inclined to get the st=
orage pool
>> >> > >>>stuff working with the kernel RBD driver& =A0UDEV rules for =
stable path
>> >> > >>>names, since that avoids needing to make any changes to gues=
t XML
>> >> > >>>format. Support for QEMU with the native librados CEPH drive=
r could
>> >> > >>>be added as a second patch.
>> >> > >>
>> >> > >>Okay, that sounds reasonable. =A0Supporting the QEMU librados=
 driver is
>> >> > >>definitely something we want to target, though, and seems to =
be route that
>> >> > >>more users are interested in. =A0Is defining the XML syntax f=
or a guest VM
>> >> > >>something we can discuss now as well?
>> >> > >>
>> >> > >>(BTW this is biting NBD users too. =A0Presumably the guest VM=
 XML should
>> >> > >>look similar?
>> >> > >
>> >> > >And also Sheepdog storage volumes. To define a syntax for all =
these we need
>> >> > >to determine what configuration metadata is required at a per-=
VM level for
>> >> > >each of them. Then try and decide how to represent that in the=
 guest XML.
>> >> > >It looks like at a VM level we'd need a hostname, port number =
and a volume
>> >> > >name (or path).
>> >> >
>> >> > It looks like that's what Sheepdog needs from the patch that wa=
s
>> >> > submitted earlier today. For RBD, we would want to allow multip=
le hosts,
>> >> > and specify the pool and image name when the QEMU librados driv=
er is
>> >> > used, e.g.:
>> >> >
>> >> > =A0 =A0 <disk type=3D"rbd" device=3D"disk">
>> >> > =A0 =A0 =A0 <driver name=3D"qemu" type=3D"raw" />
>> >> > =A0 =A0 =A0 <source vdi=3D"image_name" pool=3D"pool_name">
>> >> > =A0 =A0 =A0 =A0 <host name=3D"mon1.example.org" port=3D"6000">
>> >> > =A0 =A0 =A0 =A0 <host name=3D"mon2.example.org" port=3D"6000">
>> >> > =A0 =A0 =A0 =A0 <host name=3D"mon3.example.org" port=3D"6000">
>> >> > =A0 =A0 =A0 </source>
>> >> > =A0 =A0 =A0 <target dev=3D"vda" bus=3D"virtio" />
>> >> > =A0 =A0 </disk>
>> >> >
>> >> > Does this seem like a reasonable format for the VM XML? Any sug=
gestions?
>> >>
>> >> I'm basically wondering whether we should be going for separate t=
ypes for
>> >> each of NBD, RBD & Sheepdog, as per your proposal & the sheepdog =
one earlier
>> >> today. Or type to merge them into one type 'nework' which covers =
any kind of
>> >> network block device, and list a protocol on the =A0source elemen=
t, eg
>> >>
>> >> =A0 =A0 =A0<disk type=3D"network" device=3D"disk">
>> >> =A0 =A0 =A0 =A0<driver name=3D"qemu" type=3D"raw" />
>> >> =A0 =A0 =A0 =A0<source protocol=3D'rbd|sheepdog|nbd' name=3D"...s=
ome image identifier...">
>> >> =A0 =A0 =A0 =A0 =A0<host name=3D"mon1.example.org" port=3D"6000">
>> >> =A0 =A0 =A0 =A0 =A0<host name=3D"mon2.example.org" port=3D"6000">
>> >> =A0 =A0 =A0 =A0 =A0<host name=3D"mon3.example.org" port=3D"6000">
>> >> =A0 =A0 =A0 =A0</source>
>> >> =A0 =A0 =A0 =A0<target dev=3D"vda" bus=3D"virtio" />
>> >> =A0 =A0 =A0</disk>
>> >
>> > That would work...
>> >
>> > One thing that I think should be considered, though, is that both =
RBD and
>> > NBD can be used for non-qemu instances by mapping a regular block =
device
>> > via the host's kernel. =A0And in that case, there's some sysfs-fu =
(at least
>> > in the rbd case; I'm not familiar with how the nbd client works) r=
equired
>> > to set up/tear down the block device.
>>
>> An nbd block device is attached using the nbd-client(1) userspace to=
ol:
>> $ nbd-client my-server 1234 /dev/nbd0 # <host> <port> <nbd-device>
>>
>> That program will open the socket, grab /dev/nbd0, and poke it with =
a
>> few ioctls so the kernel has the socket and can take it from there.
>
> We don't need to worry about this for libvirt/QEMU. Since QEMU has na=
tive
> NBD client support there's no need to do anything with nbd client too=
ls
> to setup the device for use with a VM.

I agree it's easier to use the built-in NBD support.  Just wanted to
provide the background on how NBD client works when using the kernel
implementation.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
