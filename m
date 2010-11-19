From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Fri, 19 Nov 2010 09:27:40 +0000
Message-ID: <AANLkTinNqTJ-BBvQTwD+1b5dTKHn2W8o-FEXASk4kgPj@mail.gmail.com>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
	<20101103135900.GQ29893@redhat.com>
	<Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net>
	<20101108131634.GJ26714@redhat.com>
	<4CE47443.4000503@hq.newdream.net>
	<20101118104214.GW15851@redhat.com>
	<Pine.LNX.4.64.1011180905001.2270@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <libvir-list-bounces@redhat.com>
In-Reply-To: <Pine.LNX.4.64.1011180905001.2270@cobra.newdream.net>
List-Unsubscribe: <https://www.redhat.com/mailman/options/libvir-list>,
	<mailto:libvir-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/libvir-list>
List-Post: <mailto:libvir-list@redhat.com>
List-Help: <mailto:libvir-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/libvir-list>,
	<mailto:libvir-list-request@redhat.com?subject=subscribe>
Sender: libvir-list-bounces@redhat.com
Errors-To: libvir-list-bounces@redhat.com
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Nov 18, 2010 at 5:13 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 18 Nov 2010, Daniel P. Berrange wrote:
>> On Wed, Nov 17, 2010 at 04:33:07PM -0800, Josh Durgin wrote:
>> > Hi Daniel,
>> >
>> > On 11/08/2010 05:16 AM, Daniel P. Berrange wrote:
>> > >>>>In any case, before someone goes off and implements something, doe=
s this
>> > >>>>look like the right general approach to adding rbd support to libv=
irt?
>> > >>>
>> > >>>I think this looks reasonable. I'd be inclined to get the storage p=
ool
>> > >>>stuff working with the kernel RBD driver& =A0UDEV rules for stable =
path
>> > >>>names, since that avoids needing to make any changes to guest XML
>> > >>>format. Support for QEMU with the native librados CEPH driver could
>> > >>>be added as a second patch.
>> > >>
>> > >>Okay, that sounds reasonable. =A0Supporting the QEMU librados driver=
 is
>> > >>definitely something we want to target, though, and seems to be rout=
e that
>> > >>more users are interested in. =A0Is defining the XML syntax for a gu=
est VM
>> > >>something we can discuss now as well?
>> > >>
>> > >>(BTW this is biting NBD users too. =A0Presumably the guest VM XML sh=
ould
>> > >>look similar?
>> > >
>> > >And also Sheepdog storage volumes. To define a syntax for all these w=
e need
>> > >to determine what configuration metadata is required at a per-VM leve=
l for
>> > >each of them. Then try and decide how to represent that in the guest =
XML.
>> > >It looks like at a VM level we'd need a hostname, port number and a v=
olume
>> > >name (or path).
>> >
>> > It looks like that's what Sheepdog needs from the patch that was
>> > submitted earlier today. For RBD, we would want to allow multiple host=
s,
>> > and specify the pool and image name when the QEMU librados driver is
>> > used, e.g.:
>> >
>> > =A0 =A0 <disk type=3D"rbd" device=3D"disk">
>> > =A0 =A0 =A0 <driver name=3D"qemu" type=3D"raw" />
>> > =A0 =A0 =A0 <source vdi=3D"image_name" pool=3D"pool_name">
>> > =A0 =A0 =A0 =A0 <host name=3D"mon1.example.org" port=3D"6000">
>> > =A0 =A0 =A0 =A0 <host name=3D"mon2.example.org" port=3D"6000">
>> > =A0 =A0 =A0 =A0 <host name=3D"mon3.example.org" port=3D"6000">
>> > =A0 =A0 =A0 </source>
>> > =A0 =A0 =A0 <target dev=3D"vda" bus=3D"virtio" />
>> > =A0 =A0 </disk>
>> >
>> > Does this seem like a reasonable format for the VM XML? Any suggestion=
s?
>>
>> I'm basically wondering whether we should be going for separate types for
>> each of NBD, RBD & Sheepdog, as per your proposal & the sheepdog one ear=
lier
>> today. Or type to merge them into one type 'nework' which covers any kin=
d of
>> network block device, and list a protocol on the =A0source element, eg
>>
>> =A0 =A0 =A0<disk type=3D"network" device=3D"disk">
>> =A0 =A0 =A0 =A0<driver name=3D"qemu" type=3D"raw" />
>> =A0 =A0 =A0 =A0<source protocol=3D'rbd|sheepdog|nbd' name=3D"...some ima=
ge identifier...">
>> =A0 =A0 =A0 =A0 =A0<host name=3D"mon1.example.org" port=3D"6000">
>> =A0 =A0 =A0 =A0 =A0<host name=3D"mon2.example.org" port=3D"6000">
>> =A0 =A0 =A0 =A0 =A0<host name=3D"mon3.example.org" port=3D"6000">
>> =A0 =A0 =A0 =A0</source>
>> =A0 =A0 =A0 =A0<target dev=3D"vda" bus=3D"virtio" />
>> =A0 =A0 =A0</disk>
>
> That would work...
>
> One thing that I think should be considered, though, is that both RBD and
> NBD can be used for non-qemu instances by mapping a regular block device
> via the host's kernel. =A0And in that case, there's some sysfs-fu (at lea=
st
> in the rbd case; I'm not familiar with how the nbd client works) required
> to set up/tear down the block device.

An nbd block device is attached using the nbd-client(1) userspace tool:
$ nbd-client my-server 1234 /dev/nbd0 # <host> <port> <nbd-device>

That program will open the socket, grab /dev/nbd0, and poke it with a
few ioctls so the kernel has the socket and can take it from there.

Stefan
