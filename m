From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Is rbd_discard enough to wipe an RBD image?
Date: Mon, 21 Dec 2015 10:09:44 -0500 (EST)
Message-ID: <1795864225.1459105.1450710584514.JavaMail.zimbra@redhat.com>
References: <56771BEE.4050705@42on.com> <1255550760.10644674.1450707915260.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:52659 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbbLUPJx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 10:09:53 -0500
In-Reply-To: <1255550760.10644674.1450707915260.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

You will have to ensure that your writes are properly aligned with the =
object size (or object set if fancy striping is used on the RBD volume)=
=2E  In that case, the discard is translated to remove operations on ea=
ch individual backing object.  The only time zeros are written to disk =
is if you specify an offset somewhere in the middle of an object (i.e. =
the whole object cannot be deleted nor can it be truncated) -- this is =
the partial discard case controlled by that configuration param. =20

--=20

Jason Dillaman=20


----- Original Message -----
> From: "Alexandre DERUMIER" <aderumier@odiso.com>
> To: "Wido den Hollander" <wido@42on.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Monday, December 21, 2015 9:25:15 AM
> Subject: Re: Is rbd_discard enough to wipe an RBD image?
>=20
> >>I just want to know if this is sufficient to wipe a RBD image?
>=20
> AFAIK, ceph write zeroes in the rados objects with discard is used.
>=20
> They are an option for skip zeroes write if needed
>=20
> OPTION(rbd_skip_partial_discard, OPT_BOOL, false) // when trying to d=
iscard a
> range inside an object, set to true to skip zeroing the range.
> ----- Mail original -----
> De: "Wido den Hollander" <wido@42on.com>
> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Dimanche 20 D=C3=A9cembre 2015 22:21:50
> Objet: Is rbd_discard enough to wipe an RBD image?
>=20
> Hi,
>=20
> I'm busy implementing the volume wiping method of the libvirt storage
> pool backend and instead of writing to the whole RBD image with zeroe=
s
> I'm using rbd_discard.
>=20
> Using a 4MB length I'm starting at offset 0 and work my way through t=
he
> whole RBD image.
>=20
> A quick try shows me that my partition table + filesystem are gone on
> the RBD image after I've run rbd_discard.
>=20
> I just want to know if this is sufficient to wipe a RBD image? Or wou=
ld
> it be better to fully fill the image with zeroes?
>=20
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
>=20
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
