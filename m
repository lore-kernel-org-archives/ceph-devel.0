From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rbd image
Date: Sat, 11 Oct 2014 10:00:48 +0200 (CEST)
Message-ID: <c22b3e6d-2fbc-4de9-8bfd-d3eb39ea8fe2@mailpro>
References: <20141011070118.GB4965@fam-t430.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38612 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaJKIAz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Oct 2014 04:00:55 -0400
In-Reply-To: <20141011070118.GB4965@fam-t430.nay.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ceph Devel <ceph-devel@vger.kernel.org>

>>What is the source format? If the zero clusters are actually unalloca=
ted in the
>>source image, drive-mirror will not write those clusters either. I.e.=
 with
>>"drive-mirror sync=3Dtop", both source and target should have the sam=
e "qemu-img
>>map" output.

Thanks for your reply,

I had tried drive mirror (sync=3Dfull) with

raw file (sparse) -> rbd  (no sparse)
rbd (sparse) -> rbd (no sparse)
raw file (sparse) -> qcow2 on ext4  (sparse)
rbd (sparse) -> raw on ext4 (sparse)

Also I see that I have the same problem with target file format on xfs.

raw file (sparse) -> qcow2 on xfs  (no sparse)
rbd (sparse) -> raw on xfs (no sparse)


I only have this problem with drive-mirror, qemu-img convert seem to si=
mply skip zero blocks.


Or maybe this is because I'm using sync=3Dfull ?

What is the difference between full and top ?

""sync": what parts of the disk image should be copied to the destinati=
on;
  possibilities include "full" for all the disk, "top" for only the sec=
tors
  allocated in the topmost image".

(what is topmost image ?)


----- Mail original -----=20

De: "Fam Zheng" <famz@redhat.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "qemu-devel" <qemu-devel@nongnu.org>, "Ceph Devel" <ceph-devel@vger=
=2Ekernel.org>=20
Envoy=C3=A9: Samedi 11 Octobre 2014 09:01:18=20
Objet: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rb=
d image=20

On Wed, 10/08 13:15, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I'm currently planning to migrate our storage to ceph/rbd through qem=
u drive-mirror=20
>=20
> and It seem that drive-mirror with rbd block driver, don't create a s=
parse image. (all zeros are copied to the target rbd).=20
>=20
> Also note, that it's working fine with "qemu-img convert" , the rbd v=
olume is sparse after conversion.=20

What is the source format? If the zero clusters are actually unallocate=
d in the=20
source image, drive-mirror will not write those clusters either. I.e. w=
ith=20
"drive-mirror sync=3Dtop", both source and target should have the same =
"qemu-img=20
map" output.=20

=46am=20

>=20
>=20
> Could it be related to the "bdrv_co_write_zeroes" missing features in=
 block/rbd.c ?=20
>=20
> (It's available in other block drivers (scsi,gluster,raw-aio) , and I=
 don't have this problem with theses block drivers).=20
>=20
>=20
>=20
> Regards,=20
>=20
> Alexandre Derumier=20
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
