From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: QCOW2 to RBD format 2 in one step
Date: Tue, 14 May 2013 16:36:18 +0200 (CEST)
Message-ID: <a7a591d3-713b-43dc-a427-2d0b0c8e42a7@mailpro>
References: <20130514121521.GA23960@apia.perrit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:44382 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427Ab3ENOpp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 10:45:45 -0400
In-Reply-To: <20130514121521.GA23960@apia.perrit.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: leen@consolejunkie.net
Cc: ceph-devel@vger.kernel.org

Hi,

we do it with proxmox,

we create the target rbd volume at format v2 with "rbd .." commands,

then, we use qemu-img convert to copy from qcow2 to rbd.

We have patched qemu-img to be able to write to an existing volume.
(By default qemu-img convert try to create the volume)
https://git.proxmox.com/?p=3Dpve-qemu-kvm.git;a=3Dcommit;h=3Dc0cf085da9=
b6b1d21791dd88c34f7ad7f0b83359


If you want to test, you can try the coming proxmox 3.0 release here:
http://forum.proxmox.com/threads/13733-Proxmox-VE-3-0-RC1-released!?p=3D=
73897#post73897

support vm cloning full clone, from any storage (raw,qcow2,lvm,rbd,shee=
pdog,iscsi) to any storage.
Linked clones are also implemented for rbd :)

Hope It can help.

----- Mail original -----=20

De: "Leen Besselink" <leen@consolejunkie.net>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 14 Mai 2013 14:15:21=20
Objet: Re: QCOW2 to RBD format 2 in one step=20

On Tue, May 14, 2013 at 01:52:28PM +0200, Wido den Hollander wrote:=20
> On 05/14/2013 12:34 PM, Leen Besselink wrote:=20
> >On Tue, May 14, 2013 at 12:16:32PM +0200, Wido den Hollander wrote:=20
> >>Hi,=20
> >>=20
>=20
> Hi Leen,=20
>=20
> >=20
> >Hi Wido,=20
> >=20
> >>While working on the CloudStack code for 4.2 I'm running into some=20
> >>problems with QCOW2 and RBD format 2.=20
> >>=20
> >>A quick cap of the problem:=20
> >>=20
> >>CloudStack stores all the templates on "Secondary Storage" as QCOW2=
 files.=20
> >>=20
> >>When a VM is deployed, this image will be copied (once) from=20
> >>Secondary Storage to Primary Storage, this is done by qemu-img whic=
h=20
> >>does the conversion.=20
> >>=20
> >>When the image is on Primary Storage it will be copied to the=20
> >>destination volume and the Instance/VM is started.=20
> >>=20
> >>In that last step I want to use layering, but the problem is that m=
y=20
> >>image is RBD format 1 due to the qemu-img copy.=20
> >>=20
> >>I can skip the qemu-img copy, but I have to find a way to go from=20
> >>QCOW2 to RBD format 2 in preferably one step. There is a issue abou=
t=20
> >>this in the tracker [0], but that won't be finished on time.=20
> >>=20
> >>Another idea would be to do QCOW2 -> RAW -> RBD format 2, but that=20
> >>extra step will take a lot of time. It would also require some=20
> >>temporary storage on the hypervisor.=20
> >>=20
> >>I also thought of creating the RBD image prior to converting to it,=
=20
> >>but that fails, since qemu-img won't let you convert to a already=20
> >>existing image.=20
> >>=20
> >>Any brights ideas? Maybe even doing the QCOW2 -> RAW format in=20
> >>memory? In Java?=20
> >>=20
> >=20
> >I'm no expert, but would it be possible to change qemu-img to suppor=
t writing RAW to standard out ?=20
> >=20
>=20
> No, qemu-img can't write to stdout. Due to various formats it support=
s.=20
>=20

I meant extending qemu-img to support that, it would probably be less=20
work than the work needed for the issue below. But the longer I think=20
about it. It would only be able to do that for RAW. And RAW isn't very=20
efficient anyway.=20

> >So you can run qemu-img convert and pipe that drectly to the rbd imp=
ort command ?=20
> >=20
>=20
> If qemu-img would support writing to stdout there is the problem=20
> that I'm not using the rbd tool, but Java bindings for librbd and=20
> librados. I'm trying to avoid executing from Java.=20
>=20
> >rbd import already supports standard in I believe.=20
> >=20
> >Then you don't need any temporary storage.=20
> >=20
> >Maybe something more efficient than RAW is possible as well ?=20
> >=20
> >>The goal is to go from QCOW2 to RBD format 2 in one step.=20
> >>=20
> >>[0]: http://tracker.ceph.com/issues/4897=20
> >>=20
> >>--=20
> >>Wido den Hollander=20
> >>42on B.V.=20
> >>=20
> >>Phone: +31 (0)20 700 9902=20
> >>Skype: contact42on=20
> >>--=20
> >>To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
> >>the body of a message to majordomo@vger.kernel.org=20
> >>More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> >--=20
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
> >the body of a message to majordomo@vger.kernel.org=20
> >More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> >=20
>=20
>=20
> --=20
> Wido den Hollander=20
> 42on B.V.=20
>=20
> Phone: +31 (0)20 700 9902=20
> Skype: contact42on=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
