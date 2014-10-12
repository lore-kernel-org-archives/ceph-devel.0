From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rbd image
Date: Sun, 12 Oct 2014 12:33:45 +0200 (CEST)
Message-ID: <c466d530-dfb1-40a0-846d-e0c6911b2f1e@mailpro>
References: <20141011082535.GC4965@fam-t430.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39935 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaJLKdy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Oct 2014 06:33:54 -0400
In-Reply-To: <20141011082535.GC4965@fam-t430.nay.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ceph Devel <ceph-devel@vger.kernel.org>

>>These don't tell me much. Maybe it's better to show the actual comman=
ds and how=20
>>you tell sparse from no sparse?=20


Well,

I create 2 empty source images files of 10G. (source.qcow2 and source.r=
aw)

then:

du -sh source.qcow2  : 2M
du -sh source.raw  : 0M


then I convert them with qemu-img convert : (source.qcow2 -> target.qco=
w2 , source.raw -> target.raw)

du -sh target.qcow2  : 2M
du -sh target.raw  : 0M

(So it's ok here)

But If I convert them with drive-mirror:

du -sh target.qcow2  : 11G
du -sh target.raw  : 11G



I have also double check with #df, and I see space allocated on filesys=
tem when using drive-mirror.

I have the same behavior if target is a rbd storage.

Also I have done test again ext3,ext4, and I see the same problem than =
with xfs.=20


I'm pretty sure that drive-mirror copy zero block, qemu-img convert tak=
e around 2s to convert the empty file
(because it's skipping zero block), and drive mirror take around 5min.

----- Mail original -----=20

De: "Fam Zheng" <famz@redhat.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "qemu-devel" <qemu-devel@nongnu.org>, "Ceph Devel" <ceph-devel@vger=
=2Ekernel.org>=20
Envoy=C3=A9: Samedi 11 Octobre 2014 10:25:35=20
Objet: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rb=
d image=20

On Sat, 10/11 10:00, Alexandre DERUMIER wrote:=20
> >>What is the source format? If the zero clusters are actually unallo=
cated in the=20
> >>source image, drive-mirror will not write those clusters either. I.=
e. with=20
> >>"drive-mirror sync=3Dtop", both source and target should have the s=
ame "qemu-img=20
> >>map" output.=20
>=20
> Thanks for your reply,=20
>=20
> I had tried drive mirror (sync=3Dfull) with=20
>=20
> raw file (sparse) -> rbd (no sparse)=20
> rbd (sparse) -> rbd (no sparse)=20
> raw file (sparse) -> qcow2 on ext4 (sparse)=20
> rbd (sparse) -> raw on ext4 (sparse)=20
>=20
> Also I see that I have the same problem with target file format on xf=
s.=20
>=20
> raw file (sparse) -> qcow2 on xfs (no sparse)=20
> rbd (sparse) -> raw on xfs (no sparse)=20
>=20

These don't tell me much. Maybe it's better to show the actual commands=
 and how=20
you tell sparse from no sparse?=20

Does "qcow2 -> qcow2" work for you on xfs?=20

>=20
> I only have this problem with drive-mirror, qemu-img convert seem to =
simply skip zero blocks.=20
>=20
>=20
> Or maybe this is because I'm using sync=3Dfull ?=20
>=20
> What is the difference between full and top ?=20
>=20
> ""sync": what parts of the disk image should be copied to the destina=
tion;=20
> possibilities include "full" for all the disk, "top" for only the sec=
tors=20
> allocated in the topmost image".=20
>=20
> (what is topmost image ?)=20

=46or "sync=3Dtop", only the clusters allocated in the image itself is =
copied; for=20
"full", all those clusters allocated in the image itself, and its backi=
ng=20
image, and it's backing's backing image, ..., are copied.=20

The image itself, having a backing image or not, is called the topmost =
image.=20

=46am=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
